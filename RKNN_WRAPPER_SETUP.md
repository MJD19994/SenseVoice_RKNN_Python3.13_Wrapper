# RKNN Wrapper Setup Guide

This document provides a comprehensive guide on how to set up RKNN Wrapper for the SenseVoice project using Python 3.13.

## Prerequisites
Before you start, ensure you have the following installed:
- Python 3.13 or higher
- Git
- Virtual Environment (optional, but recommended)

## Installation Steps

1. **Clone the Repository**  
   Open your terminal and run:
   ```bash
   git clone https://github.com/MJD19994/SenseVoice_RKNN_Python3.13_Wrapper.git
   cd SenseVoice_RKNN_Python3.13_Wrapper
   ```

2. **Set Up a Virtual Environment (Optional)**  
   To create an isolated environment, run:
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows, use `venv\Scripts\activate`
   ```

3. **Install Dependencies**  
   Use pip to install the required packages:
   ```bash
   pip install -r requirements.txt
   ```

4. **Configure Environment Variables**  
   Set any necessary environment variables (if applicable):
   ```bash
   export RKNN_HOME=/path/to/rknn  # Adjust according to your setup
   ```

5. **Running the Setup**  
   You can now run the setup script using:
   ```bash
   python setup.py
   ```

6. **Testing the Installation**  
   After setup, test if everything is working properly:
   ```bash
   python test.py
   ```

## Troubleshooting
- If you run into issues, check the following:
  - Ensure all dependencies are properly installed.
  - Verify that your Python version is correct.
  - Check if relevant environment variables are set.

## Conclusion
Congratulations! You have successfully set up the RKNN Wrapper for the SenseVoice project. Feel free to explore the repository and contribute to it.