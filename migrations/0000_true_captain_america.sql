CREATE TABLE "contact_info" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"organization_gujarati" text NOT NULL,
	"organization_english" text NOT NULL,
	"address_gujarati" text NOT NULL,
	"address_english" text NOT NULL,
	"phone_number" varchar NOT NULL,
	"whatsapp_number" varchar,
	"email" varchar,
	"is_primary" boolean DEFAULT false NOT NULL,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "couples" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"groom_name_gujarati" text NOT NULL,
	"groom_name_english" text NOT NULL,
	"bride_name_gujarati" text NOT NULL,
	"bride_name_english" text NOT NULL,
	"image_url" text,
	"couple_slug" varchar NOT NULL,
	"created_at" timestamp DEFAULT now(),
	CONSTRAINT "couples_couple_slug_unique" UNIQUE("couple_slug")
);
--> statement-breakpoint
CREATE TABLE "events" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"name_gujarati" text NOT NULL,
	"name_english" text NOT NULL,
	"time_gujarati" text NOT NULL,
	"time_english" text NOT NULL,
	"datetime" timestamp NOT NULL,
	"icon" varchar NOT NULL,
	"image_url" text,
	"color_scheme" varchar DEFAULT 'primary' NOT NULL,
	"sort_order" integer DEFAULT 0 NOT NULL,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "gifts" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"donor_name_gujarati" text NOT NULL,
	"donor_name_english" text,
	"organization_gujarati" text,
	"organization_english" text,
	"gift_description_gujarati" text NOT NULL,
	"gift_description_english" text,
	"gift_icon" varchar DEFAULT 'gift' NOT NULL,
	"amount" integer,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "sessions" (
	"sid" varchar PRIMARY KEY NOT NULL,
	"sess" jsonb NOT NULL,
	"expire" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE "site_content" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"key" varchar NOT NULL,
	"title_gujarati" text,
	"title_english" text,
	"content_gujarati" text,
	"content_english" text,
	"image_url" text,
	"updated_at" timestamp DEFAULT now(),
	CONSTRAINT "site_content_key_unique" UNIQUE("key")
);
--> statement-breakpoint
CREATE TABLE "users" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"email" varchar,
	"first_name" varchar,
	"last_name" varchar,
	"profile_image_url" varchar,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now(),
	CONSTRAINT "users_email_unique" UNIQUE("email")
);
--> statement-breakpoint
CREATE INDEX "IDX_session_expire" ON "sessions" USING btree ("expire");