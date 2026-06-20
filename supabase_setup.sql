-- RentMyRide listings table for Supabase
-- Run this in the Supabase SQL editor.

create extension if not exists pgcrypto;

create table if not exists public.vehicle_listings (
  id uuid primary key default gen_random_uuid(),
  type text not null,
  model text not null,
  owner text not null,
  owner_contact text,
  owner_email text not null,
  plate text not null,
  rate numeric not null,
  location text not null,
  seats integer,
  mileage integer,
  photos jsonb not null default '[]'::jsonb,
  status text not null default 'available',
  notes text,
  created_at timestamptz not null default now()
);

alter table public.vehicle_listings enable row level security;

-- Allow the browser client to read and add listings.
-- These grants are required in addition to RLS policies for Data API access.
grant select, insert on table public.vehicle_listings to anon, authenticated;

-- Public read access
drop policy if exists "Public can read vehicle listings" on public.vehicle_listings;
create policy "Public can read vehicle listings"
on public.vehicle_listings
for select
to anon, authenticated
using (true);

-- Public insert access
drop policy if exists "Public can insert vehicle listings" on public.vehicle_listings;
create policy "Public can insert vehicle listings"
on public.vehicle_listings
for insert
to anon, authenticated
with check (true);

-- Optional: keep defaults open for future app tables in this schema
-- You can remove these if you prefer tighter control and manage grants per table.


-- Booking requests table
create table if not exists public.booking_requests (
  id uuid primary key default gen_random_uuid(),
  vehicle_id text,
  vehicle_model text not null,
  owner text not null,
  owner_contact text,
  owner_email text,
  customer_name text not null,
  customer_id text not null,
  customer_contact text not null,
  customer_email text not null,
  rental_days integer not null,
  pickup_date date not null,
  notes text,
  created_at timestamptz not null default now()
);

alter table public.booking_requests enable row level security;

grant select, insert on table public.booking_requests to anon, authenticated;

drop policy if exists "Public can read booking requests" on public.booking_requests;
create policy "Public can read booking requests"
on public.booking_requests
for select
to anon, authenticated
using (true);

drop policy if exists "Public can insert booking requests" on public.booking_requests;
create policy "Public can insert booking requests"
on public.booking_requests
for insert
to anon, authenticated
with check (true);
