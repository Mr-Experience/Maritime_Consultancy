-- 1. Create the newsletter_subscriptions table
create table public.newsletter_subscriptions (
  id uuid not null default gen_random_uuid (),
  created_at timestamp with time zone not null default now(),
  email text not null,
  constraint newsletter_subscriptions_pkey primary key (id)
);

-- 2. Enable Row Level Security (RLS)
alter table public.newsletter_subscriptions enable row level security;

-- 3. Create Policy: Allow anyone (Anon) to INSERT emails (Subscribe)
create policy "Allow public to subscribe"
on public.newsletter_subscriptions
for insert
to anon
with check (true);

-- 4. Create Policy: Allow Admins to SELECT (Read) subscriptions
-- Allows authenticated users (Admins) to view the list.
create policy "Allow authenticated users to view subscriptions"
on public.newsletter_subscriptions
for select
to authenticated
using (true);
