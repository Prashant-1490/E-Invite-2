@echo off
REM Database deployment script for E-Invite application (Windows)
REM This script sets up the database for deployment

echo 🚀 Starting E-Invite Database Setup...

REM Check if DATABASE_URL is set
if "%DATABASE_URL%"=="" (
    echo ❌ ERROR: DATABASE_URL environment variable is not set
    echo Please set DATABASE_URL before running this script
    echo Example: set DATABASE_URL=postgresql://username:password@localhost:5432/database_name
    pause
    exit /b 1
)

echo ✅ DATABASE_URL is set

REM Check if psql is available
where psql >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ❌ ERROR: psql command not found
    echo Please install PostgreSQL client tools and add to PATH
    pause
    exit /b 1
)

echo ✅ PostgreSQL client found

REM Run database setup script
echo 📦 Creating database tables...
psql "%DATABASE_URL%" -f "%~dp0setup-database.sql"

if %ERRORLEVEL% EQU 0 (
    echo ✅ Database tables created successfully
) else (
    echo ❌ ERROR: Failed to create database tables
    pause
    exit /b 1
)

REM Ask if user wants to insert sample data
set /p choice="Do you want to insert sample data? (y/n): "
if /i "%choice%"=="y" (
    echo 📦 Inserting sample data...
    psql "%DATABASE_URL%" -f "%~dp0seed-data.sql"
    
    if %ERRORLEVEL% EQU 0 (
        echo ✅ Sample data inserted successfully
    ) else (
        echo ❌ ERROR: Failed to insert sample data
        pause
        exit /b 1
    )
) else (
    echo ⏭️  Skipping sample data insertion
)

echo 🎉 Database setup completed successfully!
echo.
echo Next steps:
echo 1. Start your application
echo 2. Access admin panel at: http://your-domain/admin-login
echo 3. Login with username: admin, password: admin3010
echo 4. Add your wedding events, couples, and other information
echo.
echo Happy coding! 💍✨
pause
