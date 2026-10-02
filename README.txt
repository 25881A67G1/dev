DEVAKI FOODS - CRASH FIX (Shop Now / Pickles / Search / sidebar / dashboard)

Root cause: products with no size/variants (e.g. Mango Pickle, unavailable) crashed the
Shop page ("Cannot read properties of undefined (reading 'p')"), so Shop Now, Pickles,
Search and the filter sidebar never rendered.

Changes in script.js only (index.html and style.css are unchanged):
- Shop/list/card/product/quick-view no longer crash on products without sizes
  (they show "Currently unavailable").
- Product ids are always strings, so Edit/Delete/Add to cart/wishlist work with Supabase ids.
- If Supabase returns no rows, the saved catalog is kept instead of being wiped.
- Supabase refresh no longer scrolls to top, resets filters or closes the search bar.
- Removed the "Products loaded from Supabase" toast.
- Dashboard shows a note that product edits are saved only in this browser.
- Image mappings (Lemon/Mango Pickle) left unchanged as before.

Replace script.js in your project, push to GitHub, Render will redeploy.
Tip: hard refresh (Ctrl+Shift+R) once after deploy.
