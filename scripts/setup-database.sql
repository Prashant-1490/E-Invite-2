-- E-Invite Database Setup Script
-- This script creates all necessary tables for the E-Invite application
-- Run this script in your PostgreSQL database before deploying the application

-- Enable UUID extension for generating unique IDs
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create sessions table for authentication
CREATE TABLE IF NOT EXISTS "sessions" (
    "sid" VARCHAR PRIMARY KEY,
    "sess" JSONB NOT NULL,
    "expire" TIMESTAMP NOT NULL
);

CREATE INDEX IF NOT EXISTS "IDX_session_expire" ON "sessions"("expire");

-- Create users table for Replit Auth
CREATE TABLE IF NOT EXISTS "users" (
    "id" VARCHAR PRIMARY KEY DEFAULT gen_random_uuid(),
    "email" VARCHAR UNIQUE,
    "first_name" VARCHAR,
    "last_name" VARCHAR,
    "profile_image_url" VARCHAR,
    "created_at" TIMESTAMP DEFAULT NOW(),
    "updated_at" TIMESTAMP DEFAULT NOW()
);

-- Create events table for wedding events
CREATE TABLE IF NOT EXISTS "events" (
    "id" VARCHAR PRIMARY KEY DEFAULT gen_random_uuid(),
    "name_gujarati" TEXT NOT NULL,
    "name_english" TEXT NOT NULL,
    "time_gujarati" TEXT NOT NULL,
    "time_english" TEXT NOT NULL,
    "datetime" TIMESTAMP NOT NULL,
    "icon" VARCHAR NOT NULL,
    "image_url" TEXT,
    "color_scheme" VARCHAR NOT NULL DEFAULT 'primary',
    "sort_order" INTEGER NOT NULL DEFAULT 0,
    "created_at" TIMESTAMP DEFAULT NOW()
);

-- Create couples table for bride and groom information
CREATE TABLE IF NOT EXISTS "couples" (
    "id" VARCHAR PRIMARY KEY DEFAULT gen_random_uuid(),
    "groom_name_gujarati" TEXT NOT NULL,
    "groom_name_english" TEXT NOT NULL,
    "bride_name_gujarati" TEXT NOT NULL,
    "bride_name_english" TEXT NOT NULL,
    "image_url" TEXT,
    "couple_slug" VARCHAR NOT NULL UNIQUE,
    "created_at" TIMESTAMP DEFAULT NOW()
);

-- Create gifts table for donations and gifts
CREATE TABLE IF NOT EXISTS "gifts" (
    "id" VARCHAR PRIMARY KEY DEFAULT gen_random_uuid(),
    "donor_name_gujarati" TEXT NOT NULL,
    "donor_name_english" TEXT,
    "organization_gujarati" TEXT,
    "organization_english" TEXT,
    "gift_description_gujarati" TEXT NOT NULL,
    "gift_description_english" TEXT,
    "gift_icon" VARCHAR NOT NULL DEFAULT 'gift',
    "amount" INTEGER,
    "created_at" TIMESTAMP DEFAULT NOW()
);

-- Create site_content table for managing editable content
CREATE TABLE IF NOT EXISTS "site_content" (
    "id" VARCHAR PRIMARY KEY DEFAULT gen_random_uuid(),
    "key" VARCHAR NOT NULL UNIQUE,
    "title_gujarati" TEXT,
    "title_english" TEXT,
    "content_gujarati" TEXT,
    "content_english" TEXT,
    "image_url" TEXT,
    "updated_at" TIMESTAMP DEFAULT NOW()
);

-- Create contact_info table for contact information
CREATE TABLE IF NOT EXISTS "contact_info" (
    "id" VARCHAR PRIMARY KEY DEFAULT gen_random_uuid(),
    "organization_gujarati" TEXT NOT NULL,
    "organization_english" TEXT NOT NULL,
    "address_gujarati" TEXT NOT NULL,
    "address_english" TEXT NOT NULL,
    "phone_number" VARCHAR NOT NULL,
    "whatsapp_number" VARCHAR,
    "email" VARCHAR,
    "is_primary" BOOLEAN NOT NULL DEFAULT FALSE,
    "created_at" TIMESTAMP DEFAULT NOW()
);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS "idx_events_datetime" ON "events"("datetime");
CREATE INDEX IF NOT EXISTS "idx_events_sort_order" ON "events"("sort_order");
CREATE INDEX IF NOT EXISTS "idx_couples_slug" ON "couples"("couple_slug");
CREATE INDEX IF NOT EXISTS "idx_gifts_created_at" ON "gifts"("created_at");
CREATE INDEX IF NOT EXISTS "idx_site_content_key" ON "site_content"("key");
CREATE INDEX IF NOT EXISTS "idx_contact_info_primary" ON "contact_info"("is_primary");

-- Insert default site content
INSERT INTO "site_content" ("key", "title_gujarati", "title_english", "content_gujarati", "content_english") 
VALUES 
    ('welcome_message', 'સ્વાગત છે', 'Welcome', 'આપનું સ્વાગત છે', 'Welcome to our wedding celebration'),
    ('venue_info', 'સ્થળ માહિતી', 'Venue Information', 'લગ્ન સ્થળની માહિતી', 'Wedding venue information'),
    ('contact_us', 'અમારો સંપર્ક કરો', 'Contact Us', 'અમારો સંપર્ક કરો', 'Contact us for more information')
ON CONFLICT ("key") DO NOTHING;

-- Print success message
DO $$
BEGIN
    RAISE NOTICE 'Database setup completed successfully! All tables and initial data have been created.';
END $$;
