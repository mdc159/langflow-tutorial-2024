#!/bin/bash

# Check Python installation
if ! command -v python3 &> /dev/null; then
    echo "Python is not installed"
    echo "Please install Python 3.8 or higher"
    exit 1
fi

# Check if the venv folder exists
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv venv
    if [ $? -ne 0 ]; then
        echo "Failed to create virtual environment"
        exit 1
    fi
fi

# Activate the virtual environment
source venv/bin/activate
if [ $? -ne 0 ]; then
    echo "Failed to activate virtual environment"
    exit 1
fi

# Upgrade pip first
python -m pip install --upgrade pip

# Check if langflow is installed
if ! pip show langflow &> /dev/null; then
    echo "Installing langflow..."
    python -m pip install --no-cache-dir langflow
    if [ $? -ne 0 ]; then
        echo "Failed to install langflow. Trying alternative method..."
        python -m pip install --no-cache-dir --timeout 100 langflow
    fi
else
    echo "Updating langflow..."
    python -m pip install --no-cache-dir --upgrade langflow
fi

# Start langflow
echo "Starting Langflow..."
langflow run
