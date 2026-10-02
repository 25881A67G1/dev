-- =====================================================================
-- Devaki Foods — customer accounts (run ONCE in Supabase → SQL Editor)
-- Creates: profiles, customer_orders, customer_wishlist (+ RLS policies)
-- Every table is locked so a signed-in customer can only touch THEIR rows.
-- Your existing products / product_variants tables are not touched.
-- =====================================================================

-- ---------- profiles ----------
create table if not exists public.profiles (
  id          uuid primary key references auth.users(id) on delete cascade,
  full_name   text,
  phone       text,
  address     text,
  landmark    text,
  city        text,
  state       text,
  pin         text,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
alter table public.profiles enable row level security;

drop policy if exists "profiles select own" on public.profiles;
drop policy if exists "profiles insert own" on public.profiles;
drop policy if exists "profiles update own" on public.profiles;
create policy "profiles select own" on public.profiles for select to authenticated using (id = (select auth.uid()));
create policy "profiles insert own" on public.profiles for insert to authenticated with check (id = (select auth.uid()));
create policy "profiles update own" on public.profiles for update to authenticated using (id = (select auth.uid())) with check (id = (select auth.uid()));

-- auto-create a profile row (with the name from sign-up) for every new user
create or replace function public.handle_new_user()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  insert into public.profiles (id, full_name)
  values (new.id, coalesce(new.raw_user_meta_data->>'full_name', ''))
  on conflict (id) do nothing;
  return new;
end $$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- ---------- customer_orders ----------
create table if not exists public.customer_orders (
  id          uuid primary key default gen_random_uuid(),
  order_code  text not null unique,
  user_id     uuid not null default auth.uid() references auth.users(id) on delete cascade,
  status      text not null default 'Pending',
  payment     text,
  subtotal    numeric,
  discount    numeric,
  shipping    numeric,
  total       numeric,
  customer    jsonb,
  items       jsonb,
  created_at  timestamptz not null default now()
);
create index if not exists customer_orders_user_idx on public.customer_orders (user_id, created_at desc);
alter table public.customer_orders enable row level security;

drop policy if exists "orders select own" on public.customer_orders;
drop policy if exists "orders insert own" on public.customer_orders;
create policy "orders select own" on public.customer_orders for select to authenticated using (user_id = (select auth.uid()));
-- customers can place orders only as themselves and only as 'Pending'; they cannot edit/delete orders
create policy "orders insert own" on public.customer_orders for insert to authenticated
  with check (user_id = (select auth.uid()) and status = 'Pending');

-- ---------- customer_wishlist ----------
create table if not exists public.customer_wishlist (
  user_id     uuid not null default auth.uid() references auth.users(id) on delete cascade,
  product_id  text not null,
  created_at  timestamptz not null default now(),
  primary key (user_id, product_id)
);
alter table public.customer_wishlist enable row level security;

drop policy if exists "wishlist select own" on public.customer_wishlist;
drop policy if exists "wishlist insert own" on public.customer_wishlist;
drop policy if exists "wishlist delete own" on public.customer_wishlist;
create policy "wishlist select own" on public.customer_wishlist for select to authenticated using (user_id = (select auth.uid()));
create policy "wishlist insert own" on public.customer_wishlist for insert to authenticated with check (user_id = (select auth.uid()));
create policy "wishlist delete own" on public.customer_wishlist for delete to authenticated using (user_id = (select auth.uid()));
