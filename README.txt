DEVAKI FOODS - CUSTOMER ACCOUNTS (Supabase Auth)

FILES: script.js, style.css (changed) + supabase_customer_auth.sql (new). index.html unchanged.

SETUP (one time, ~5 minutes)
1. Supabase -> SQL Editor -> paste supabase_customer_auth.sql -> Run.
2. Supabase -> Authentication -> URL Configuration:
   - Site URL = your live Render URL (https://YOUR-SITE.onrender.com)
   - Redirect URLs: add the same URL (and http://localhost:PORT if you test locally).
   Without this, the password-reset and confirmation links will not work.
3. Supabase -> Authentication -> Sign In / Providers -> Email: choose whether
   "Confirm email" is on. Both modes are supported.
4. For real customers, set up a custom SMTP sender (Authentication -> Emails -> SMTP).
   Supabase's built-in email is limited to a few emails per hour.
5. Replace script.js and style.css, push to GitHub, hard-refresh after Render deploys.

WHAT CUSTOMERS GET
- Sign up (name + email + password), Log in, Log out, Forgot/reset password
- #/account  profile + default delivery address (pre-fills checkout) + change password
- #/orders   order history (orders placed while logged in are saved to the account)
- #/wishlist saved to the account; guest wishlist is merged in at login
- Session stays active after refresh (Supabase stores/renews the session token)
- Passwords are handled only by Supabase Auth; nothing is stored in JavaScript/localStorage.

OWNER / ADMIN
- Unchanged and separate (password check in CFG.adminPass). Its link moved from the header
  person icon to a small "Owner login" link in the footer; the header icon is now customer login.

NOTES
- Password reset / email links use PKCE: open them in the same browser that requested them.
- Guests can still check out; their orders are not tied to an account.
- Orders are priced in the browser (as before). Real security for prices/stock needs a server
  or Supabase database function; the owner admin panel still only sees orders stored in its own browser.
