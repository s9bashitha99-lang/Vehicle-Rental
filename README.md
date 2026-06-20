# RentMyRide website update

## What’s included
- `rentmyride.html` — the website with Supabase database sync already wired in.
- `supabase_setup.sql` — table, RLS, and grants for the listings database.
- `logo.png` and `logo-full-clean.png` — branding assets.

## What you still need to add
Supabase needs your **project URL** and **anon/public key**. The org dashboard link alone is not enough to connect the site.

## How to connect it
1. Open your Supabase project.
2. Go to **Project Settings → API**.
3. Copy:
   - **Project URL**
   - **anon / public key**
4. Open `rentmyride.html` and replace:
   - `YOUR_SUPABASE_URL`
   - `YOUR_SUPABASE_ANON_KEY`
5. Run `supabase_setup.sql` in the SQL editor.
6. Host the HTML file on your website.

## Notes
- The site will still work in demo mode if Supabase is not configured yet.
- Vehicle listings are stored in the `public.vehicle_listings` table.
- Images are currently stored as text data URLs in the `photos` JSONB column, which is fine for small demo uploads. For production, a Supabase Storage bucket is better for larger images.


## Booking flow
- Clicking **Request to book** opens the owner contact details and booking form.
- Save bookings in `booking_requests`.
- Owner listings now require `owner_email`.

## Automatic email sending
- The booking button now sends requests through EmailJS instead of opening the user's mail app.
- Connect the EmailJS service to `sl.rentmyride@gmail.com` in your EmailJS dashboard.
- Replace `YOUR_EMAILJS_SERVICE_ID`, `YOUR_EMAILJS_TEMPLATE_ID`, and `YOUR_EMAILJS_PUBLIC_KEY` in `rentmyride.html` with your real values.
- Update the EmailJS template so it uses the `to_email`, `subject`, and `message` fields.
