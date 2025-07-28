@echo off
REM Adobe Hackathon Challenge 1B - Docker Execution Script for Windows

echo 🚀 Adobe India Hackathon 2025 - Round 1B: Persona-Driven Document Intelligence
echo ==================================================================
echo.

REM Check if Docker is running
docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Docker is not running. Please start Docker and try again.
    exit /b 1
)

echo 📦 Building Docker image...
docker build -t adobe-challenge-1b .

if %errorlevel% neq 0 (
    echo ❌ Docker build failed!
    exit /b 1
)

echo.
echo 🔄 Running persona-driven document analysis...
echo.

REM Run the container
docker run --rm ^
    -v "%cd%\Collection 1:/app/Collection 1" ^
    -v "%cd%\Collection 2:/app/Collection 2" ^
    -v "%cd%\Collection 3:/app/Collection 3" ^
    -v "%cd%\Collection 4:/app/Collection 4" ^
    -v "%cd%\Collection 5:/app/Collection 5" ^
    -v "%cd%\output:/app/output" ^
    --memory=4g ^
    --cpus=2 ^
    adobe-challenge-1b

echo.
echo ✅ Processing completed!
echo 📄 Check the output.json files in each Collection folder for results.
