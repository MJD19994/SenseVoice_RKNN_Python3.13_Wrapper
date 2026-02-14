# Configuration Guide for SenseVoice RKNN Server

This document describes all configuration options available for the SenseVoice RKNN Speech Recognition Server, including environment variables, server settings, and advanced RKNN-specific configurations.

## Table of Contents

- [Environment Variables](#environment-variables)
- [Server Configuration](#server-configuration)
- [RKNN Configuration](#rknn-configuration)
- [Model Configuration](#model-configuration)
- [Performance Tuning](#performance-tuning)
- [Memory Management](#memory-management)
- [Logging Configuration](#logging-configuration)
- [Security Settings](#security-settings)

## Environment Variables

Environment variables can be set in your shell, added to `.env` file, or configured in systemd service file.

### Core Environment Variables

#### PYTHONPATH

Sets the Python module search path to include RKNN libraries.

```bash
export PYTHONPATH="/path/to/lib/rknnlite_wrapper:/path/to/lib:/path/to/models:$PYTHONPATH"
```

**Default**: Configured in `start_server.sh`

**Usage in systemd**:
```ini
Environment="PYTHONPATH=/root/SenseVoice_RKNN_Python3.13_Wrapper/lib/rknnlite_wrapper:/root/SenseVoice_RKNN_Python3.13_Wrapper/lib"
```

#### MODEL_PATH

Path to the RKNN model directory.

```bash
export MODEL_PATH="/path/to/models/models--happyme531--SenseVoiceSmall-RKNN2/snapshots/2b134bc175c5bc16ec315613d183eb34b0748043"
```

**Default**: `${SCRIPT_DIR}/models/models--happyme531--SenseVoiceSmall-RKNN2/snapshots/2b134bc175c5bc16ec315613d183eb34b0748043`

#### SERVER_HOST

The host address the server binds to.

```bash
export SERVER_HOST="0.0.0.0"
```

**Default**: `localhost` or `0.0.0.0`

**Values**:
- `localhost` - Only accessible from the local machine
- `0.0.0.0` - Accessible from any network interface
- Specific IP address - Bind to a specific interface

#### SERVER_PORT

The port number the server listens on.

```bash
export SERVER_PORT=8000
```

**Default**: `8000`

**Range**: 1024-65535 (use ports above 1024 for non-root users)

#### LOG_LEVEL

Controls the verbosity of logging.

```bash
export LOG_LEVEL="INFO"
```

**Default**: `INFO`

**Values**: `DEBUG`, `INFO`, `WARNING`, `ERROR`, `CRITICAL`

### RKNN-Specific Environment Variables

#### RKNN_DEVICE

Specifies which RKNN NPU device to use.

```bash
export RKNN_DEVICE="/dev/rknpu0"
```

**Default**: `/dev/rknpu0` (first NPU)

**Options**:
- `/dev/rknpu0` - First NPU core
- `/dev/rknpu1` - Second NPU core (if available)
- `/dev/rknpu2` - Third NPU core (if available)

#### RKNN_CORE_MASK

Bit mask for selecting which NPU cores to use.

```bash
export RKNN_CORE_MASK="0x3"
```

**Default**: `0x1` (use first core)

**Values**:
- `0x1` - Core 0 only
- `0x2` - Core 1 only
- `0x3` - Cores 0 and 1
- `0x7` - Cores 0, 1, and 2

#### RKNN_VERBOSE

Enable verbose RKNN logging for debugging.

```bash
export RKNN_VERBOSE=1
```

**Default**: `0` (disabled)

**Values**: `0` (off), `1` (on)

### Audio Processing Variables

#### MAX_AUDIO_LENGTH

Maximum audio duration in seconds.

```bash
export MAX_AUDIO_LENGTH=300
```

**Default**: `300` (5 minutes)

#### SAMPLING_RATE

Default audio sampling rate in Hz.

```bash
export SAMPLING_RATE=16000
```

**Default**: `16000`

**Recommended**: `16000` or `44100`

#### ENABLE_VAD

Enable Voice Activity Detection by default.

```bash
export ENABLE_VAD=true
```

**Default**: `true`

**Values**: `true`, `false`

#### VAD_THRESHOLD

Voice Activity Detection threshold (0.0 to 1.0).

```bash
export VAD_THRESHOLD=0.5
```

**Default**: `0.5`

**Range**: 0.0 (more sensitive) to 1.0 (less sensitive)

### Performance Variables

#### MAX_WORKERS

Number of worker threads for processing requests.

```bash
export MAX_WORKERS=4
```

**Default**: Number of CPU cores

**Recommendation**: Set to number of NPU cores available

#### BATCH_SIZE

Batch size for inference.

```bash
export BATCH_SIZE=1
```

**Default**: `1`

**Note**: Higher values may improve throughput but increase latency

#### TIMEOUT

Request timeout in seconds.

```bash
export TIMEOUT=60
```

**Default**: `60`

### Memory Management Variables

#### MAX_MEMORY

Maximum memory usage in MB.

```bash
export MAX_MEMORY=2048
```

**Default**: System dependent

#### CACHE_SIZE

Size of model cache in MB.

```bash
export CACHE_SIZE=512
```

**Default**: `512`

#### ENABLE_MEMORY_POOL

Enable memory pooling for better performance.

```bash
export ENABLE_MEMORY_POOL=true
```

**Default**: `true`

## Server Configuration

### Configuration File

Create a `config.yaml` or `config.json` file in the project root:

**config.yaml example:**

```yaml
server:
  host: "0.0.0.0"
  port: 8000
  workers: 4
  timeout: 60

model:
  path: "./models/models--happyme531--SenseVoiceSmall-RKNN2/snapshots/2b134bc175c5bc16ec315613d183eb34b0748043"
  cache_size: 512

rknn:
  device: "/dev/rknpu0"
  core_mask: 0x3
  verbose: false

audio:
  sampling_rate: 16000
  max_length: 300
  enable_vad: true
  vad_threshold: 0.5

logging:
  level: "INFO"
  file: "./logs/sensevoice.log"
  max_size: 10485760  # 10MB
  backup_count: 5
```

**config.json example:**

```json
{
  "server": {
    "host": "0.0.0.0",
    "port": 8000,
    "workers": 4,
    "timeout": 60
  },
  "model": {
    "path": "./models/models--happyme531--SenseVoiceSmall-RKNN2/snapshots/2b134bc175c5bc16ec315613d183eb34b0748043",
    "cache_size": 512
  },
  "rknn": {
    "device": "/dev/rknpu0",
    "core_mask": "0x3",
    "verbose": false
  },
  "audio": {
    "sampling_rate": 16000,
    "max_length": 300,
    "enable_vad": true,
    "vad_threshold": 0.5
  },
  "logging": {
    "level": "INFO",
    "file": "./logs/sensevoice.log",
    "max_size": 10485760,
    "backup_count": 5
  }
}
```

## RKNN Configuration

### NPU Core Selection

For multi-core NPU systems (e.g., RK3588 with 3 cores):

```bash
# Use all available cores for maximum performance
export RKNN_CORE_MASK=0x7

# Use only core 0 for power efficiency
export RKNN_CORE_MASK=0x1

# Use cores 0 and 1 for balanced performance
export RKNN_CORE_MASK=0x3
```

### RKNN Runtime Options

Configure RKNN-specific runtime parameters:

```python
# In your server code or config
rknn_config = {
    'target_platform': 'rk3588',
    'device_id': None,  # Auto-detect
    'perf_debug': False,
    'eval_mem': False,
    'async_mode': True
}
```

### Device Detection

Check available RKNN devices:

```bash
# List RKNN devices
ls -l /dev/rknpu*

# Check NPU driver version
cat /sys/kernel/debug/rknpu/version
```

## Model Configuration

### Model Path Structure

Ensure the model directory follows this structure:

```
models/
└── models--happyme531--SenseVoiceSmall-RKNN2/
    └── snapshots/
        └── 2b134bc175c5bc16ec315613d183eb34b0748043/
            ├── model.rknn
            ├── config.json
            └── vocab.txt
```

### Model Loading Options

```python
model_config = {
    'model_path': '/path/to/model.rknn',
    'warm_up': True,  # Run warm-up inference
    'quantization': 'int8',  # or 'float16', 'mixed'
    'optimization_level': 3  # 0-3, higher = more optimization
}
```

## Performance Tuning

### For Low Latency

Optimize for minimal response time:

```bash
export MAX_WORKERS=1
export BATCH_SIZE=1
export RKNN_CORE_MASK=0x7  # Use all cores
export ENABLE_MEMORY_POOL=true
export CACHE_SIZE=1024
```

### For High Throughput

Optimize for maximum requests per second:

```bash
export MAX_WORKERS=8
export BATCH_SIZE=4
export RKNN_CORE_MASK=0x7
export ENABLE_MEMORY_POOL=true
export TIMEOUT=120
```

### For Low Power

Optimize for power efficiency:

```bash
export MAX_WORKERS=2
export BATCH_SIZE=1
export RKNN_CORE_MASK=0x1  # Use single core
export CACHE_SIZE=256
```

### CPU Affinity

Pin workers to specific CPU cores:

```bash
# In systemd service file
[Service]
CPUAffinity=0-3
```

### NPU Frequency Scaling

Adjust NPU frequency for performance or power:

```bash
# Maximum performance
echo performance | sudo tee /sys/class/devfreq/fdab0000.npu/governor

# Power saving
echo powersave | sudo tee /sys/class/devfreq/fdab0000.npu/governor

# On-demand scaling
echo simple_ondemand | sudo tee /sys/class/devfreq/fdab0000.npu/governor
```

## Memory Management

### Memory Limits

Set memory limits to prevent OOM errors:

```bash
# Using ulimit
ulimit -m 2097152  # 2GB memory limit

# In systemd service
[Service]
MemoryLimit=2G
MemoryMax=4G
```

### Swap Configuration

Configure swap for handling memory spikes:

```bash
# Check current swap
free -h

# Add swap file if needed
sudo fallocate -l 2G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
```

### Memory Monitoring

Monitor memory usage:

```bash
# Real-time monitoring
watch -n 1 'cat /proc/meminfo | grep -E "MemTotal|MemFree|MemAvailable"'

# Check RKNN memory usage
cat /sys/kernel/debug/rknpu/memory
```

## Logging Configuration

### Log Levels

Configure logging verbosity:

```python
import logging

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('sensevoice.log'),
        logging.StreamHandler()
    ]
)
```

### Log Rotation

Configure log rotation to manage disk space:

```bash
# Using logrotate
sudo nano /etc/logrotate.d/sensevoice
```

```
/var/log/sensevoice/*.log {
    daily
    rotate 7
    compress
    delaycompress
    missingok
    notifempty
    create 0644 root root
}
```

### Structured Logging

Use JSON logging for better parsing:

```python
import json
import logging

class JsonFormatter(logging.Formatter):
    def format(self, record):
        log_data = {
            'timestamp': self.formatTime(record),
            'level': record.levelname,
            'message': record.getMessage(),
            'module': record.module,
            'function': record.funcName
        }
        return json.dumps(log_data)
```

## Security Settings

### Network Security

```bash
# Bind to localhost only for local access
export SERVER_HOST="localhost"

# Or bind to specific interface
export SERVER_HOST="192.168.1.100"
```

### File Permissions

Set appropriate file permissions:

```bash
# Restrict access to configuration files
chmod 600 config.yaml

# Make scripts executable by owner only
chmod 700 start_server.sh
```

### Firewall Configuration

Configure firewall rules:

```bash
# Allow access only from specific IP
sudo ufw allow from 192.168.1.0/24 to any port 8000

# Or allow from anywhere (use with caution)
sudo ufw allow 8000/tcp
```

## Environment File Template

Create a `.env` file for easy configuration:

```bash
# .env file
# Copy this file to .env and customize values

# Server Configuration
SERVER_HOST=0.0.0.0
SERVER_PORT=8000
MAX_WORKERS=4
TIMEOUT=60

# RKNN Configuration
RKNN_DEVICE=/dev/rknpu0
RKNN_CORE_MASK=0x3
RKNN_VERBOSE=0

# Model Configuration
MODEL_PATH=./models/models--happyme531--SenseVoiceSmall-RKNN2/snapshots/2b134bc175c5bc16ec315613d183eb34b0748043

# Audio Settings
SAMPLING_RATE=16000
MAX_AUDIO_LENGTH=300
ENABLE_VAD=true
VAD_THRESHOLD=0.5

# Performance
BATCH_SIZE=1
CACHE_SIZE=512
ENABLE_MEMORY_POOL=true

# Logging
LOG_LEVEL=INFO
LOG_FILE=./logs/sensevoice.log

# Memory Management
MAX_MEMORY=2048
```

Load the `.env` file:

```bash
# In start_server.sh
set -a
source .env
set +a
```

## Validation and Testing

### Verify Configuration

Test your configuration:

```bash
# Check environment variables
env | grep -E "SERVER_|RKNN_|MODEL_"

# Verify PYTHONPATH
python3 -c "import sys; print('\n'.join(sys.path))"

# Test RKNN device access
ls -l /dev/rknpu*
```

### Configuration Best Practices

1. **Use environment files**: Keep configuration separate from code
2. **Document changes**: Comment your customizations
3. **Test incrementally**: Change one setting at a time
4. **Monitor performance**: Use logs to validate settings
5. **Backup configurations**: Keep copies of working configurations

## Troubleshooting Configuration

### Common Issues

**Issue**: Server won't start
- Check all paths are absolute and correct
- Verify PYTHONPATH includes all required directories
- Ensure Python version is 3.13+

**Issue**: RKNN device not found
- Check device permissions: `ls -l /dev/rknpu*`
- Verify driver is loaded: `lsmod | grep rknpu`
- Check dmesg for NPU errors: `dmesg | grep -i npu`

**Issue**: Out of memory errors
- Reduce CACHE_SIZE
- Decrease MAX_WORKERS
- Enable swap space
- Lower BATCH_SIZE

**Issue**: Poor performance
- Increase RKNN_CORE_MASK to use more cores
- Adjust NPU frequency scaling
- Enable ENABLE_MEMORY_POOL
- Increase CACHE_SIZE

## Advanced Configuration

### Custom Model Loading

```python
# Load custom model with specific options
from rknnlite.api import RKNNLite

rknn = RKNNLite()
rknn.load_rknn(model_path)
rknn.init_runtime(core_mask=RKNNLite.NPU_CORE_AUTO)
```

### Dynamic Configuration

Reload configuration without restart:

```python
import signal
import json

def reload_config(signum, frame):
    with open('config.json', 'r') as f:
        global config
        config = json.load(f)
    print("Configuration reloaded")

signal.signal(signal.SIGHUP, reload_config)
```

### Multi-Model Support

Run multiple models simultaneously:

```yaml
models:
  - name: "sensevoice-small"
    path: "./models/small/"
    cores: [0]
  - name: "sensevoice-large"
    path: "./models/large/"
    cores: [1, 2]
```

## Conclusion

Proper configuration is essential for optimal performance and stability of the SenseVoice RKNN server. Start with the default settings and adjust based on your specific requirements and hardware capabilities.

For more information:
- [INSTALLATION_STEPS.md](INSTALLATION_STEPS.md) - Installation guide
- [API.md](API.md) - API documentation
- [SYSTEMD_SETUP.md](SYSTEMD_SETUP.md) - Service setup

## Additional Resources

- RKNN Toolkit Documentation
- Rockchip NPU Performance Guide
- Linux System Administration Guide
