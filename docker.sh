#!/bin/bash

# Adobe Hackathon Challenge 1B - Docker Execution Script

echo "🚀 Adobe India Hackathon 2025 - Round 1B: Persona-Driven Document Intelligence"
echo "=================================================================="
echo ""

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker and try again."
    exit 1
fi

echo "📦 Building Docker image..."
docker build -t adobe-challenge-1b .

if [ $? -ne 0 ]; then
    echo "❌ Docker build failed!"
    exit 1
fi

echo ""
echo "🔄 Running persona-driven document analysis..."
echo ""

# Run the container
docker run --rm \
    -v "$(pwd)/Collection 1:/app/Collection 1" \
    -v "$(pwd)/Collection 2:/app/Collection 2" \
    -v "$(pwd)/Collection 3:/app/Collection 3" \
    -v "$(pwd)/Collection 4:/app/Collection 4" \
    -v "$(pwd)/Collection 5:/app/Collection 5" \
    -v "$(pwd)/output:/app/output" \
    --memory=4g \
    --cpus=2 \
    adobe-challenge-1b

echo ""
echo "✅ Processing completed!"
echo "📄 Check the output.json files in each Collection folder for results."
