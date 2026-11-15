-- Initial relational model. Apply only after reviewing privacy, retention and access policies.
create extension if not exists pgcrypto;
create type public.app_role as enum ('parent','coach','admin','child');
create type public.enrollment_status as enum ('pending','active','cancelled','completed');
create table public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  role public.app_role not null default 'parent',
  display_name text not null,
  created_at timestamptz not null default now()
);
create table public.children (
  id uuid primary key default gen_random_uuid(),
  parent_id uuid not null references public.profiles(id) on delete restrict,
  display_name text not null,
  birth_date date,
  created_at timestamptz not null default now()
);
create table public.classes (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  coach_id uuid references public.profiles(id) on delete set null,
  starts_at timestamptz not null,
  capacity integer not null check (capacity > 0),
  is_active boolean not null default true
);
create table public.enrollments (
  id uuid primary key default gen_random_uuid(),
  child_id uuid not null references public.children(id) on delete restrict,
  class_id uuid not null references public.classes(id) on delete restrict,
  status public.enrollment_status not null default 'pending',
  created_at timestamptz not null default now(),
  unique(child_id,class_id)
);
create table public.attendance (
  id uuid primary key default gen_random_uuid(),
  enrollment_id uuid not null references public.enrollments(id) on delete cascade,
  session_date date not null,
  present boolean not null,
  recorded_by uuid not null references public.profiles(id),
  unique(enrollment_id,session_date)
);
create table public.assessments (
  id uuid primary key default gen_random_uuid(),
  child_id uuid not null references public.children(id) on delete cascade,
  assessor_id uuid not null references public.profiles(id),
  domain text not null,
  observation jsonb not null default '{}'::jsonb,
  notes text,
  assessed_at timestamptz not null default now()
);
create table public.payments (
  id uuid primary key default gen_random_uuid(),
  enrollment_id uuid not null references public.enrollments(id) on delete restrict,
  amount_minor bigint not null check (amount_minor > 0),
  currency text not null,
  provider_reference text unique,
  status text not null check (status in ('pending','paid','failed','refunded')) default 'pending',
  created_at timestamptz not null default now()
);
-- IMPORTANT: enable RLS and add role-aware policies before exposing any table to clients.
-- Do not store medical diagnoses or unnecessary identifying information in free-text fields.
