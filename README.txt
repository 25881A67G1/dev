DEVAKI FOODS - NAVIGATION FIX v2

Replace index.html, script.js and style.css in the GitHub project.
Keep the existing images/ folder.

Fixes:
- Shop Now uses normal hash navigation
- Header Shop uses normal hash navigation
- Sweets / Pickles / Snacks category links use normal hash navigation
- Dashboard / owner login uses normal hash navigation
- Search remains handled by the search form and routes to /shop
- URL/hash is now the single source of truth for routing
- Category parsing no longer double-decodes the URL
- Added cache-busting version to index.html so Render/browser does not keep an older script

After pushing to GitHub, wait for Render deployment and test in a private/incognito window first.
