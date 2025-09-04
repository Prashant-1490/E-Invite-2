# E-Invite Deployment Guide

## Database Setup for Deployment

I've created comprehensive database setup scripts for you. Here's how to use them:

### 📁 Scripts Created

1. **`scripts/setup-database.sql`** - Creates all database tables
2. **`scripts/seed-data.sql`** - Adds sample data for testing
3. **`scripts/deploy-database.sh`** - Automated setup for Linux/macOS
4. **`scripts/deploy-database.bat`** - Automated setup for Windows
5. **`scripts/README.md`** - Detailed documentation

### 🚀 Quick Deployment

#### For Any New Environment:

**Step 1: Set Database URL**
```bash
# Linux/macOS/Git Bash
export DATABASE_URL="postgresql://username:password@host:port/database_name"

# Windows CMD
set DATABASE_URL=postgresql://username:password@host:port/database_name

# Windows PowerShell
$env:DATABASE_URL="postgresql://username:password@host:port/database_name"
```

**Step 2: Run Setup Script**
```bash
# Linux/macOS
npm run db:setup

# Or manually:
./scripts/deploy-database.sh

# Windows
scripts\deploy-database.bat
```

### 🏗️ Manual Setup (if automated scripts don't work)

```bash
# 1. Create tables
psql "your_database_url" -f scripts/setup-database.sql

# 2. Add sample data (optional)
psql "your_database_url" -f scripts/seed-data.sql
```

### 🌐 Platform-Specific Instructions

#### Heroku
```bash
# Get your database URL
heroku config:get DATABASE_URL

# Set it locally and run setup
export DATABASE_URL="$(heroku config:get DATABASE_URL)"
./scripts/deploy-database.sh
```

#### Vercel + Neon/Supabase
```bash
# Copy DATABASE_URL from your platform dashboard
export DATABASE_URL="postgresql://..."
npm run db:setup
```

#### Railway/Render
```bash
# Use the DATABASE_URL from your platform
export DATABASE_URL="your_platform_database_url"
npm run db:setup
```

### 📦 What Gets Created

The scripts create these tables:
- `sessions` - Authentication storage
- `users` - User information
- `events` - Wedding events (bilingual)
- `couples` - Bride/groom information
- `gifts` - Donations and gifts
- `site_content` - Editable content
- `contact_info` - Contact information

### 🔧 NPM Scripts Added

- `npm run db:setup` - Run database setup script
- `npm run db:generate` - Generate migration files
- `npm run db:migrate` - Run migrations
- `npm run db:push` - Push schema changes (existing)

### ⚠️ Important Notes

1. **Change Admin Password**: After deployment, change the default admin credentials in `client/src/pages/admin-login.tsx`
2. **Environment Variables**: Always use environment variables for DATABASE_URL
3. **Backup**: Always backup your database before running scripts in production
4. **Safe Re-runs**: All scripts can be run multiple times safely

### 🔒 Security Checklist

- [ ] Change default admin password
- [ ] Set strong DATABASE_URL with proper authentication
- [ ] Don't commit actual database URLs to version control
- [ ] Use HTTPS in production
- [ ] Set proper CORS origins for production

### 🆘 Troubleshooting

**"psql command not found"**
- Install PostgreSQL client tools

**"Permission denied"**
- Make script executable: `chmod +x scripts/deploy-database.sh`

**"Database connection failed"**
- Verify DATABASE_URL format and credentials
- Check if database server is running

Now you're ready to deploy your E-Invite application anywhere! 🎉
