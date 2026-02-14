# Systemd Service Setup for SenseVoice RKNN Server

This guide explains how to set up the SenseVoice RKNN server as a systemd service, allowing it to start automatically on boot and be managed like other system services.

## Overview

Setting up systemd service provides:
- **Automatic startup** on system boot
- **Service management** using standard systemd commands
- **Automatic restart** on failure
- **Logging** through journald
- **Resource control** and monitoring

## Prerequisites

- Completed installation as per [INSTALLATION_STEPS.md](INSTALLATION_STEPS.md)
- Root or sudo access
- Systemd-based Linux distribution (Ubuntu, Debian, etc.)

## Step 1: Create Service File

Create a systemd service file for the SenseVoice server:

```bash
sudo nano /etc/systemd/system/sensevoice.service
```

### Service File Configuration

Add the following content to the service file:

```ini
[Unit]
Description=SenseVoice RKNN Speech Recognition Server
Documentation=https://github.com/MJD19994/SenseVoice_RKNN_Python3.13_Wrapper
After=network.target

[Service]
Type=simple
User=root
WorkingDirectory=/root/SenseVoice_RKNN_Python3.13_Wrapper
Environment="PYTHONPATH=/root/SenseVoice_RKNN_Python3.13_Wrapper/lib/rknnlite_wrapper:/root/SenseVoice_RKNN_Python3.13_Wrapper/lib:/root/SenseVoice_RKNN_Python3.13_Wrapper/models/models--happyme531--SenseVoiceSmall-RKNN2/snapshots/2b134bc175c5bc16ec315613d183eb34b0748043"
ExecStart=/root/rkllama-env/bin/python3 /root/SenseVoice_RKNN_Python3.13_Wrapper/sensevoice_server.py
Restart=on-failure
RestartSec=10
StandardOutput=journal
StandardError=journal
SyslogIdentifier=sensevoice

# Resource limits (optional)
LimitNOFILE=65536
LimitNPROC=4096

[Install]
WantedBy=multi-user.target
```

### Configuration Options Explained

- **Type=simple**: The service runs in the foreground
- **User=root**: Run as root user (adjust as needed for your setup)
- **WorkingDirectory**: Path to your installation directory
- **Environment**: Sets PYTHONPATH for the service
- **ExecStart**: Command to start the server
- **Restart=on-failure**: Automatically restart if the service crashes
- **RestartSec=10**: Wait 10 seconds before restarting
- **StandardOutput/StandardError=journal**: Log to systemd journal

### Customizing for Your Setup

**Important**: Adjust the following paths in the service file to match your installation:

1. **WorkingDirectory**: Replace `/root/SenseVoice_RKNN_Python3.13_Wrapper` with your actual installation path
2. **PYTHONPATH**: Update all paths in the Environment variable
3. **ExecStart**: Update both the Python interpreter path and server script path
4. **User**: Change if not running as root

Example for a different user:

```ini
[Service]
User=myuser
WorkingDirectory=/home/myuser/SenseVoice_RKNN_Python3.13_Wrapper
Environment="PYTHONPATH=/home/myuser/SenseVoice_RKNN_Python3.13_Wrapper/lib/rknnlite_wrapper:/home/myuser/SenseVoice_RKNN_Python3.13_Wrapper/lib"
ExecStart=/home/myuser/rkllama-env/bin/python3 /home/myuser/SenseVoice_RKNN_Python3.13_Wrapper/sensevoice_server.py
```

## Step 2: Alternative - Using start_server.sh Script

You can also use the `start_server.sh` script in the service file:

```ini
[Service]
Type=simple
User=root
WorkingDirectory=/root/SenseVoice_RKNN_Python3.13_Wrapper
ExecStart=/root/SenseVoice_RKNN_Python3.13_Wrapper/start_server.sh
Restart=on-failure
RestartSec=10
StandardOutput=journal
StandardError=journal
SyslogIdentifier=sensevoice
```

This is simpler as the script already handles PYTHONPATH setup.

## Step 3: Reload Systemd

After creating or modifying the service file, reload systemd:

```bash
sudo systemctl daemon-reload
```

## Step 4: Enable and Start the Service

### Enable Service (Auto-start on Boot)

```bash
sudo systemctl enable sensevoice.service
```

This creates a symbolic link to enable the service at boot.

### Start the Service

```bash
sudo systemctl start sensevoice.service
```

### Verify Service is Running

```bash
sudo systemctl status sensevoice.service
```

Expected output:
```
● sensevoice.service - SenseVoice RKNN Speech Recognition Server
   Loaded: loaded (/etc/systemd/system/sensevoice.service; enabled; vendor preset: enabled)
   Active: active (running) since Fri 2024-01-01 10:00:00 UTC; 5s ago
   ...
```

## Step 5: Service Management Commands

### Basic Commands

```bash
# Start the service
sudo systemctl start sensevoice.service

# Stop the service
sudo systemctl stop sensevoice.service

# Restart the service
sudo systemctl restart sensevoice.service

# Reload service configuration (without restart)
sudo systemctl reload sensevoice.service

# Check service status
sudo systemctl status sensevoice.service

# Disable auto-start on boot
sudo systemctl disable sensevoice.service

# Enable auto-start on boot
sudo systemctl enable sensevoice.service
```

### Service Status Check

```bash
# Check if service is active
sudo systemctl is-active sensevoice.service

# Check if service is enabled
sudo systemctl is-enabled sensevoice.service

# Check if service failed
sudo systemctl is-failed sensevoice.service
```

## Step 6: Viewing Logs

### View Service Logs

```bash
# View all logs
sudo journalctl -u sensevoice.service

# View logs from today
sudo journalctl -u sensevoice.service --since today

# View last 50 lines
sudo journalctl -u sensevoice.service -n 50

# Follow logs in real-time
sudo journalctl -u sensevoice.service -f

# View logs with timestamps
sudo journalctl -u sensevoice.service -o verbose
```

### Filtering Logs by Time

```bash
# Since specific time
sudo journalctl -u sensevoice.service --since "2024-01-01 10:00:00"

# Between time range
sudo journalctl -u sensevoice.service --since "2024-01-01" --until "2024-01-02"

# Last hour
sudo journalctl -u sensevoice.service --since "1 hour ago"
```

## Step 7: Advanced Configuration

### Resource Limits

Add to the `[Service]` section:

```ini
# Memory limits
MemoryLimit=2G
MemoryMax=4G

# CPU limits
CPUQuota=200%

# File descriptor limits
LimitNOFILE=65536

# Process limits
LimitNPROC=4096
```

### Environment Variables

Add additional environment variables:

```ini
Environment="LOG_LEVEL=INFO"
Environment="RKNN_DEVICE=/dev/rknpu0"
Environment="MAX_WORKERS=4"
```

Or use an environment file:

```ini
EnvironmentFile=/etc/sensevoice/environment
```

Then create `/etc/sensevoice/environment`:
```bash
LOG_LEVEL=INFO
RKNN_DEVICE=/dev/rknpu0
MAX_WORKERS=4
```

### Security Hardening

Add security options to the `[Service]` section:

```ini
# Run with minimal privileges
NoNewPrivileges=true

# Use private /tmp
PrivateTmp=true

# Protect system directories
ProtectSystem=strict
ProtectHome=true

# Restrict network access (if not needed)
# RestrictAddressFamilies=AF_UNIX AF_INET AF_INET6
```

## Troubleshooting

### Service Fails to Start

1. Check service status:
   ```bash
   sudo systemctl status sensevoice.service
   ```

2. View detailed logs:
   ```bash
   sudo journalctl -u sensevoice.service -n 100
   ```

3. Verify paths in service file are correct

4. Check file permissions:
   ```bash
   ls -l /root/SenseVoice_RKNN_Python3.13_Wrapper/start_server.sh
   ```

### Permission Errors

If you see permission errors:

1. Ensure the User in service file has access to required files
2. Check RKNN device permissions:
   ```bash
   ls -l /dev/rknpu*
   ```
3. Add user to required groups if needed

### Service Keeps Restarting

If the service keeps restarting:

1. Check logs for errors:
   ```bash
   sudo journalctl -u sensevoice.service -f
   ```

2. Increase RestartSec to allow more time between restarts
3. Change Restart policy to `on-abnormal` instead of `on-failure`

### Service Won't Stop

If the service doesn't stop properly:

1. Add a timeout to service file:
   ```ini
   TimeoutStopSec=30
   ```

2. Force kill if necessary:
   ```bash
   sudo systemctl kill sensevoice.service
   ```

## Uninstalling the Service

To remove the systemd service:

```bash
# Stop the service
sudo systemctl stop sensevoice.service

# Disable auto-start
sudo systemctl disable sensevoice.service

# Remove service file
sudo rm /etc/systemd/system/sensevoice.service

# Reload systemd
sudo systemctl daemon-reload

# Reset failed state (if any)
sudo systemctl reset-failed
```

## Best Practices

1. **Always test manually first**: Ensure the server runs correctly before setting up systemd
2. **Use absolute paths**: Always use absolute paths in service files
3. **Monitor logs**: Regularly check logs for errors or warnings
4. **Set resource limits**: Prevent the service from consuming too many resources
5. **Use environment files**: Keep configuration separate from service file
6. **Document changes**: Keep notes of any customizations you make

## Additional Resources

- [systemd.service man page](https://www.freedesktop.org/software/systemd/man/systemd.service.html)
- [systemd.exec man page](https://www.freedesktop.org/software/systemd/man/systemd.exec.html)
- [Systemd for Administrators](https://www.freedesktop.org/wiki/Software/systemd/)

## Next Steps

After setting up the systemd service:

1. Test the service with a reboot to ensure auto-start works
2. Set up log rotation if generating large log files
3. Configure monitoring and alerting for the service
4. Review [CONFIGURATION.md](CONFIGURATION.md) for additional settings
5. Check [API.md](API.md) for API usage

## Conclusion

Your SenseVoice RKNN server is now configured as a systemd service and will start automatically on boot. You can manage it using standard systemd commands and monitor its logs through journald.
