# E-Invite Database Setup Scripts

This directory contains scripts to set up the database for the E-Invite application in any deployment environment.

## Files Overview

### 1. `setup-database.sql`
- **Purpose**: Creates all necessary database tables and indexes
- **Usage**: Run this script in your PostgreSQL database before deploying the application
- **Features**:
  - Creates all required tables (sessions, users, events, couples, gifts, site_content, contact_info)
  - Sets up indexes for better performance
  - Includes default site content
  - Uses `IF NOT EXISTS` clauses for safe re-running

### 2. `seed-data.sql`
- **Purpose**: Populates the database with sample data for testing
- **Usage**: Run after `setup-database.sql` to add sample content
- **Includes**:
  - Sample wedding events (Haldi, Mehndi, Sangam, Wedding, Reception)
  - Sample couples data
  - Sample gifts/donations
  - Sample contact information

### 3. `deploy-database.sh` (Linux/macOS)
- **Purpose**: Automated deployment script for Unix-based systems
- **Features**:
  - Validates environment variables
  - Checks for PostgreSQL client
  - Runs setup scripts automatically
  - Interactive prompt for sample data

### 4. `deploy-database.bat` (Windows)
- **Purpose**: Automated deployment script for Windows systems
- **Features**: Same as the shell script but for Windows Command Prompt

## Quick Start

### For New Deployments

#### Option 1: Using Automated Scripts

**Linux/macOS:**
```bash
# Set your database URL
export DATABASE_URL="postgresql://username:password@host:port/database_name"

# Run the deployment script
chmod +x scripts/deploy-database.sh
./scripts/deploy-database.sh
```

**Windows:**
```cmd
# Set your database URL
set DATABASE_URL=postgresql://username:password@host:port/database_name

# Run the deployment script
scripts\deploy-database.bat
```

#### Option 2: Manual Setup

**Step 1: Create Tables**
```bash
psql "your_database_url" -f scripts/setup-database.sql
```

**Step 2: Add Sample Data (Optional)**
```bash
psql "your_database_url" -f scripts/seed-data.sql
```

### For Development

If you're using Drizzle Kit (as in this project):
```bash
npm run db:push
```

## Deployment Environments

### Local Development
- Use the automated scripts or Drizzle Kit
- DATABASE_URL should point to your local PostgreSQL instance

### Production Deployment
1. Set up your production PostgreSQL database
2. Set the DATABASE_URL environment variable
3. Run the deployment script
4. Skip sample data insertion for production

### Cloud Platforms

#### Heroku
```bash
# Get your database URL
heroku config:get DATABASE_URL

# Run setup locally pointing to Heroku DB
psql "$(heroku config:get DATABASE_URL)" -f scripts/setup-database.sql
```

#### Vercel with Neon/Supabase
```bash
# Set your Neon/Supabase URL
export DATABASE_URL="postgresql://..."

# Run setup
./scripts/deploy-database.sh
```

#### Railway/Render
```bash
# Use the provided DATABASE_URL from your platform
export DATABASE_URL="your_platform_database_url"
./scripts/deploy-database.sh
```

## Environment Variables Required

- `DATABASE_URL`: PostgreSQL connection string
  - Format: `postgresql://username:password@host:port/database_name`
  - Example: `postgresql://postgres:password@localhost:5432/e_invite`

## Database Schema Overview

The setup creates these tables:
- **sessions**: Authentication session storage
- **users**: User information for Replit Auth
- **events**: Wedding events with bilingual support
- **couples**: Bride and groom information
- **gifts**: Donation and gift tracking
- **site_content**: Editable site content
- **contact_info**: Contact information management

## Troubleshooting

### Common Issues

1. **"psql command not found"**
   - Install PostgreSQL client tools
   - Add PostgreSQL bin directory to PATH

2. **"Permission denied"**
   - Make script executable: `chmod +x scripts/deploy-database.sh`

3. **"Database connection failed"**
   - Verify DATABASE_URL is correct
   - Check if database server is running
   - Verify credentials and database name

4. **"Table already exists"**
   - Scripts use `IF NOT EXISTS` - this is safe to ignore
   - Scripts can be run multiple times safely

### Getting Help

If you encounter issues:
1. Check the database connection manually: `psql "your_database_url" -c "\dt"`
2. Verify environment variables: `echo $DATABASE_URL`
3. Check PostgreSQL logs for detailed error messages

## Security Notes

- Change default admin credentials after first login
- Use strong DATABASE_URL with proper authentication
- Don't commit actual database URLs to version control
- Use environment variables for sensitive configuration
