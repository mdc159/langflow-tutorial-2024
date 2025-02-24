@echo off
setlocal EnableDelayedExpansion

REM Check Python installation
python --version > nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo Python is not installed or not in PATH
    echo Please install Python 3.8 or higher
    pause
    exit /b 1
)

REM Check if the venv folder exists
IF NOT EXIST "venv\Scripts\activate" (
    echo Creating virtual environment...
    python -m venv venv
    IF !ERRORLEVEL! NEQ 0 (
        echo Failed to create virtual environment
        pause
        exit /b 1
    )
)

REM Activate the virtual environment
call venv\Scripts\activate
IF %ERRORLEVEL% NEQ 0 (
    echo Failed to activate virtual environment
    pause
    exit /b 1
)

REM Upgrade pip first
python -m pip install --upgrade pip

REM Check if langflow is installed
pip show langflow >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo Installing langflow version 1.1.1...
    python -m pip install --no-cache-dir langflow==1.1.1
    IF !ERRORLEVEL! NEQ 0 (
        echo Failed to install langflow. Trying alternative method...
        python -m pip install --no-cache-dir --timeout 100 langflow==1.1.1
    )
) ELSE (
    echo Updating langflow...
    python -m pip install --no-cache-dir --upgrade langflow==1.1.1
)

REM Start langflow
echo Starting Langflow...
langflow run

REM Keep the window open
pause
