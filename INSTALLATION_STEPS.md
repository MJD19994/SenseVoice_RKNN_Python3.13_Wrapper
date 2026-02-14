# Installation Steps for SenseVoice RKNN Python 3.13+ Wrapper

This guide provides detailed step-by-step instructions for installing and setting up the SenseVoice RKNN Python 3.13+ Wrapper on your system.

## Prerequisites

Before you begin, ensure you have the following:

- **Hardware**: Rockchip SoC with NPU support (RK3588, RK3568, etc.)
- **Operating System**: Linux (Debian/Ubuntu recommended)
- **Python**: Python 3.13 or higher
- **Git**: For cloning the repository
- **System Libraries**: Build essentials and development libraries

### Install System Dependencies

```bash
# Update system packages
sudo apt update && sudo apt upgrade -y

# Install Python 3.13+ (if not already installed)
sudo apt install python3.13 python3.13-dev python3-pip -y

# Install build essentials
sudo apt install build-essential cmake git -y

# Install required system libraries
sudo apt install libopenblas-dev liblapack-dev -y
```

## Step 1: Clone the Repository

Clone the SenseVoice RKNN Python 3.13+ Wrapper repository from GitHub:

```bash
git clone https://github.com/MJD19994/SenseVoice_RKNN_Python3.13_Wrapper.git
cd SenseVoice_RKNN_Python3.13_Wrapper
```

## Step 2: Set Up Python Virtual Environment (Recommended)

Creating a virtual environment helps isolate project dependencies:

```bash
# Create a virtual environment
python3.13 -m venv rkllama-env

# Activate the virtual environment
source rkllama-env/bin/activate

# Upgrade pip
pip install --upgrade pip
```

## Step 3: Install Python Dependencies

Install the required Python packages listed in `requirements.txt`:

```bash
pip install -r requirements.txt
```

The main dependencies include:
- `numpy>=1.24.0` - Numerical computing library
- `scipy>=1.10.0` - Scientific computing library

## Step 4: Directory Structure Setup

Ensure the following directory structure is in place:

```
SenseVoice_RKNN_Python3.13_Wrapper/
├── lib/
│   ├── rknnlite_wrapper/
│   │   └── rknnlite/
│   └── utils/
├── models/
│   └── models--happyme531--SenseVoiceSmall-RKNN2/
│       └── snapshots/
│           └── 2b134bc175c5bc16ec315613d183eb34b0748043/
├── start_server.sh
├── sensevoice_server.py
└── requirements.txt
```

## Step 5: Download RKNN Model

Download the pre-converted RKNN model for SenseVoice:

```bash
# Create models directory
mkdir -p models

# Download the model (adjust URL as needed)
# The model should be placed in:
# models/models--happyme531--SenseVoiceSmall-RKNN2/snapshots/2b134bc175c5bc16ec315613d183eb34b0748043/
```

**Note**: Contact the repository maintainer or check the releases page for the actual model download link.

## Step 6: Configure PYTHONPATH

The `start_server.sh` script automatically sets up the PYTHONPATH. Verify it contains:

```bash
export PYTHONPATH="${SCRIPT_DIR}/lib/rknnlite_wrapper:${SCRIPT_DIR}/lib:${MODEL_PATH}:$PYTHONPATH"
```

## Step 7: Make Startup Script Executable

Grant execute permissions to the startup script:

```bash
chmod +x start_server.sh
```

## Step 8: Verify Installation

Run a quick verification to ensure everything is set up correctly:

```bash
# Check Python version
python3 --version

# Verify numpy installation
python3 -c "import numpy; print(f'NumPy version: {numpy.__version__}')"

# Verify scipy installation
python3 -c "import scipy; print(f'SciPy version: {scipy.__version__}')"

# Check RKNN wrapper (if available)
python3 -c "from rknnlite.api import RKNNLite; print('RKNN wrapper loaded successfully')"
```

## Step 9: Start the Server

Start the SenseVoice server using the startup script:

```bash
./start_server.sh
```

Or manually with proper PYTHONPATH:

```bash
export PYTHONPATH="$(pwd)/lib/rknnlite_wrapper:$(pwd)/lib:$PYTHONPATH"
python3 sensevoice_server.py
```

## Step 10: Verify Server is Running

Test if the server is running correctly:

```bash
# Check health endpoint
curl http://localhost:8000/health

# Expected response: {"status": "healthy"}
```

## Troubleshooting

### Python Version Issues

If you encounter Python version errors:
```bash
# Check available Python versions
ls /usr/bin/python*

# Use specific Python version
python3.13 -m venv rkllama-env
```

### Missing Dependencies

If you get import errors:
```bash
# Reinstall dependencies
pip install --force-reinstall -r requirements.txt
```

### RKNN Library Not Found

If RKNN library cannot be loaded:
```bash
# Verify PYTHONPATH
echo $PYTHONPATH

# Ensure rknnlite_wrapper is in the path
export PYTHONPATH="$(pwd)/lib/rknnlite_wrapper:$PYTHONPATH"
```

### Permission Denied Errors

If you cannot execute scripts:
```bash
# Add execute permission
chmod +x start_server.sh

# Verify permissions
ls -l start_server.sh
```

### Port Already in Use

If the server cannot bind to the port:
```bash
# Check what's using the port
sudo lsof -i :8000

# Kill the process or use a different port
```

## Next Steps

- Review [API.md](API.md) for API endpoint documentation
- Check [CONFIGURATION.md](CONFIGURATION.md) for advanced configuration options
- See [SYSTEMD_SETUP.md](SYSTEMD_SETUP.md) for auto-start setup
- Read [CONTRIBUTING.md](CONTRIBUTING.md) if you want to contribute

## Getting Help

If you encounter issues not covered in this guide:

1. Check the [GitHub Issues](https://github.com/MJD19994/SenseVoice_RKNN_Python3.13_Wrapper/issues) page
2. Review existing documentation in the repository
3. Open a new issue with detailed information about your problem

## Conclusion

You have successfully installed the SenseVoice RKNN Python 3.13+ Wrapper! The system is now ready to process speech recognition requests using the RKNN accelerated model.
