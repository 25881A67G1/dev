DEVAKI FOODS - CATEGORY NAVIGATION FIX

This version fixes category navigation/filter matching between the URL, UI and Supabase data.

Changes:
- Normalizes Sweets/Pickles/Snacks category names (case and surrounding spaces).
- Uses the URL category as the source of truth when opening a category.
- Normalizes Supabase product categories before filtering.
- Normalizes the category dropdown selection.
- Keeps the existing Lemon Pickle and Mango Pickle image mappings unchanged.

Replace the existing index.html, script.js and style.css in your project with these files.
Keep your existing images/ folder unchanged.

After pushing to GitHub, Render should auto-deploy the changes.
