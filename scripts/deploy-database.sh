#!/bin/bash

# Database deployment script for E-Invite application
# This script sets up the database for deployment

set -e  # Exit on any error

echo "🚀 Starting E-Invite Database Setup..."

# Check if required environment variables are set
if [ -z "$DATABASE_URL" ]; then
    echo "❌ ERROR: DATABASE_URL environment variable is not set"
    echo "Please set DATABASE_URL before running this script"
    echo "Example: export DATABASE_URL='postgresql://username:password@localhost:5432/database_name'"
    exit 1
fi

echo "✅ DATABASE_URL is set"

# Check if psql is available
if ! command -v psql &> /dev/null; then
    echo "❌ ERROR: psql command not found"
    echo "Please install PostgreSQL client tools"
    exit 1
fi

echo "✅ PostgreSQL client found"

# Run database setup script
echo "📦 Creating database tables..."
psql "$DATABASE_URL" -f "$(dirname "$0")/setup-database.sql"

if [ $? -eq 0 ]; then
    echo "✅ Database tables created successfully"
else
    echo "❌ ERROR: Failed to create database tables"
    exit 1
fi

# Ask if user wants to insert sample data
read -p "Do you want to insert sample data? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "📦 Inserting sample data..."
    psql "$DATABASE_URL" -f "$(dirname "$0")/seed-data.sql"
    
    if [ $? -eq 0 ]; then
        echo "✅ Sample data inserted successfully"
    else
        echo "❌ ERROR: Failed to insert sample data"
        exit 1
    fi
else
    echo "⏭️  Skipping sample data insertion"
fi

echo "🎉 Database setup completed successfully!"
echo ""
echo "Next steps:"
echo "1. Start your application"
echo "2. Access admin panel at: http://your-domain/admin-login"
echo "3. Login with username: admin, password: admin3010"
echo "4. Add your wedding events, couples, and other information"
echo ""
echo "Happy coding! 💍✨"
