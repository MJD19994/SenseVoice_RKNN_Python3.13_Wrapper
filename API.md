# API Documentation for SenseVoice RKNN Server

This document provides comprehensive documentation for the REST API endpoints exposed by the SenseVoice RKNN Speech Recognition Server.

## Base URL

The default base URL for all API endpoints is:

```
http://localhost:8000
```

You can change the host and port by configuring the server settings (see [CONFIGURATION.md](CONFIGURATION.md)).

## Authentication

Currently, the API does not require authentication. For production deployments, consider implementing authentication mechanisms such as API keys, OAuth, or JWT tokens.

## Common Response Format

All API responses are returned in JSON format with appropriate HTTP status codes.

### Success Response Format

```json
{
  "status": "success",
  "data": { ... }
}
```

### Error Response Format

```json
{
  "status": "error",
  "message": "Error description",
  "code": "ERROR_CODE"
}
```

## HTTP Status Codes

The API uses standard HTTP status codes:

- `200 OK` - Successful request
- `400 Bad Request` - Invalid request parameters
- `404 Not Found` - Endpoint not found
- `500 Internal Server Error` - Server error
- `503 Service Unavailable` - Server is not ready

## API Endpoints

### 1. Health Check

Check if the server is running and healthy.

#### Endpoint

```
GET /health
```

#### Description

Returns the health status of the server. This endpoint can be used for monitoring and load balancer health checks.

#### Parameters

None

#### Request Example

```bash
curl http://localhost:8000/health
```

#### Response

**Success (200 OK)**

```json
{
  "status": "healthy",
  "timestamp": "2024-01-01T12:00:00Z",
  "uptime": 3600
}
```

**Response Fields**

- `status` (string): Health status, always "healthy" if the server is running
- `timestamp` (string): Current server timestamp in ISO 8601 format
- `uptime` (number): Server uptime in seconds

#### Example Usage

```python
import requests

response = requests.get('http://localhost:8000/health')
data = response.json()
print(f"Server status: {data['status']}")
```

```javascript
fetch('http://localhost:8000/health')
  .then(response => response.json())
  .then(data => console.log('Server status:', data.status));
```

---

### 2. Speech Recognition

Recognize speech from audio data.

#### Endpoint

```
POST /recognize
```

#### Description

Performs speech recognition on the provided audio data using the RKNN-accelerated SenseVoice model.

#### Content-Type

- `multipart/form-data` - For file upload
- `application/json` - For base64-encoded audio data

#### Parameters

**Using multipart/form-data:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| audio | file | Yes | Audio file (WAV, MP3, FLAC, etc.) |
| language | string | No | Language code (e.g., "en", "zh", "auto"). Default: "auto" |
| enable_vad | boolean | No | Enable Voice Activity Detection. Default: true |
| sampling_rate | integer | No | Audio sampling rate in Hz. Default: 16000 |

**Using application/json:**

```json
{
  "audio_data": "base64_encoded_audio_string",
  "language": "auto",
  "enable_vad": true,
  "sampling_rate": 16000
}
```

#### Request Examples

**Using cURL with file upload:**

```bash
curl -X POST http://localhost:8000/recognize \
  -F "audio=@/path/to/audio.wav" \
  -F "language=en" \
  -F "enable_vad=true"
```

**Using cURL with JSON:**

```bash
curl -X POST http://localhost:8000/recognize \
  -H "Content-Type: application/json" \
  -d '{
    "audio_data": "UklGRiQAAABXQVZFZm10...",
    "language": "auto",
    "enable_vad": true
  }'
```

**Using Python with requests:**

```python
import requests

# Method 1: File upload
with open('audio.wav', 'rb') as audio_file:
    files = {'audio': audio_file}
    data = {'language': 'en', 'enable_vad': 'true'}
    response = requests.post('http://localhost:8000/recognize', 
                            files=files, 
                            data=data)
    result = response.json()
    print(result['text'])

# Method 2: Base64-encoded JSON
import base64

with open('audio.wav', 'rb') as audio_file:
    audio_data = base64.b64encode(audio_file.read()).decode('utf-8')
    
payload = {
    'audio_data': audio_data,
    'language': 'auto',
    'enable_vad': True
}

response = requests.post('http://localhost:8000/recognize',
                        json=payload)
result = response.json()
print(result['text'])
```

**Using JavaScript with fetch:**

```javascript
// File upload
const formData = new FormData();
formData.append('audio', audioFile);
formData.append('language', 'en');

fetch('http://localhost:8000/recognize', {
  method: 'POST',
  body: formData
})
.then(response => response.json())
.then(data => console.log('Transcription:', data.text));
```

#### Response

**Success (200 OK)**

```json
{
  "status": "success",
  "text": "Hello world, this is a test transcription.",
  "language": "en",
  "confidence": 0.95,
  "duration": 2.5,
  "processing_time": 0.12,
  "segments": [
    {
      "text": "Hello world,",
      "start": 0.0,
      "end": 1.2,
      "confidence": 0.96
    },
    {
      "text": "this is a test transcription.",
      "start": 1.2,
      "end": 2.5,
      "confidence": 0.94
    }
  ]
}
```

**Response Fields**

- `status` (string): "success" or "error"
- `text` (string): Complete transcription text
- `language` (string): Detected or specified language code
- `confidence` (float): Overall confidence score (0.0 to 1.0)
- `duration` (float): Audio duration in seconds
- `processing_time` (float): Time taken to process in seconds
- `segments` (array): Individual text segments with timing information
  - `text` (string): Segment transcription
  - `start` (float): Segment start time in seconds
  - `end` (float): Segment end time in seconds
  - `confidence` (float): Segment confidence score

**Error (400 Bad Request)**

```json
{
  "status": "error",
  "message": "No audio file provided",
  "code": "MISSING_AUDIO"
}
```

**Error (500 Internal Server Error)**

```json
{
  "status": "error",
  "message": "Failed to process audio",
  "code": "PROCESSING_ERROR"
}
```

#### Error Codes

| Code | Description |
|------|-------------|
| MISSING_AUDIO | No audio file or data provided |
| INVALID_AUDIO | Audio file format is not supported |
| AUDIO_TOO_LARGE | Audio file exceeds maximum size limit |
| INVALID_LANGUAGE | Unsupported language code |
| PROCESSING_ERROR | Error during audio processing |
| MODEL_ERROR | Error loading or running the RKNN model |

#### Supported Audio Formats

- WAV (PCM, 16-bit)
- MP3
- FLAC
- OGG
- M4A

#### Supported Languages

- `auto` - Automatic language detection (default)
- `en` - English
- `zh` - Chinese (Mandarin)
- `ja` - Japanese
- `ko` - Korean
- `es` - Spanish
- `fr` - French
- `de` - German
- `ru` - Russian

---

### 3. Version Information

Get server version and model information.

#### Endpoint

```
GET /version
```

#### Description

Returns information about the server version, RKNN model version, and supported features.

#### Parameters

None

#### Request Example

```bash
curl http://localhost:8000/version
```

#### Response

**Success (200 OK)**

```json
{
  "status": "success",
  "server_version": "1.0.0",
  "model_name": "SenseVoiceSmall-RKNN2",
  "model_version": "2b134bc175c5bc16ec315613d183eb34b0748043",
  "rknn_version": "2.0.0",
  "python_version": "3.13.0",
  "supported_languages": ["auto", "en", "zh", "ja", "ko", "es", "fr", "de", "ru"],
  "features": {
    "vad": true,
    "language_detection": true,
    "streaming": false
  }
}
```

**Response Fields**

- `status` (string): Response status
- `server_version` (string): Server software version
- `model_name` (string): Name of the RKNN model
- `model_version` (string): Model version identifier
- `rknn_version` (string): RKNN runtime version
- `python_version` (string): Python interpreter version
- `supported_languages` (array): List of supported language codes
- `features` (object): Available features
  - `vad` (boolean): Voice Activity Detection support
  - `language_detection` (boolean): Automatic language detection
  - `streaming` (boolean): Real-time streaming support

#### Example Usage

```python
import requests

response = requests.get('http://localhost:8000/version')
info = response.json()
print(f"Server: {info['server_version']}")
print(f"Model: {info['model_name']} v{info['model_version']}")
print(f"Supported languages: {', '.join(info['supported_languages'])}")
```

---

## Rate Limiting

Currently, there is no rate limiting implemented. For production use, consider implementing rate limiting to prevent abuse.

## Best Practices

1. **Audio Quality**: Use high-quality audio with minimal background noise for best results
2. **Sampling Rate**: 16 kHz is recommended for optimal performance
3. **File Size**: Keep audio files under 10 MB for faster processing
4. **Error Handling**: Always implement proper error handling in client code
5. **Health Checks**: Monitor the `/health` endpoint regularly
6. **Timeouts**: Set appropriate timeouts for recognition requests (30-60 seconds)

## Example Client Implementation

### Python Client

```python
import requests
from typing import Optional, Dict

class SenseVoiceClient:
    def __init__(self, base_url: str = "http://localhost:8000"):
        self.base_url = base_url.rstrip('/')
        
    def health_check(self) -> Dict:
        """Check if the server is healthy."""
        response = requests.get(f"{self.base_url}/health")
        response.raise_for_status()
        return response.json()
    
    def recognize(self, 
                  audio_path: str, 
                  language: str = "auto",
                  enable_vad: bool = True) -> Dict:
        """Recognize speech from audio file."""
        with open(audio_path, 'rb') as audio_file:
            files = {'audio': audio_file}
            data = {
                'language': language,
                'enable_vad': str(enable_vad).lower()
            }
            response = requests.post(
                f"{self.base_url}/recognize",
                files=files,
                data=data,
                timeout=60
            )
            response.raise_for_status()
            return response.json()
    
    def get_version(self) -> Dict:
        """Get server version information."""
        response = requests.get(f"{self.base_url}/version")
        response.raise_for_status()
        return response.json()

# Usage
client = SenseVoiceClient()

# Check health
health = client.health_check()
print(f"Server status: {health['status']}")

# Recognize speech
result = client.recognize('audio.wav', language='en')
print(f"Transcription: {result['text']}")

# Get version
version = client.get_version()
print(f"Model: {version['model_name']}")
```

### JavaScript/Node.js Client

```javascript
const axios = require('axios');
const FormData = require('form-data');
const fs = require('fs');

class SenseVoiceClient {
  constructor(baseUrl = 'http://localhost:8000') {
    this.baseUrl = baseUrl.replace(/\/$/, '');
  }

  async healthCheck() {
    const response = await axios.get(`${this.baseUrl}/health`);
    return response.data;
  }

  async recognize(audioPath, language = 'auto', enableVad = true) {
    const formData = new FormData();
    formData.append('audio', fs.createReadStream(audioPath));
    formData.append('language', language);
    formData.append('enable_vad', enableVad.toString());

    const response = await axios.post(
      `${this.baseUrl}/recognize`,
      formData,
      {
        headers: formData.getHeaders(),
        timeout: 60000
      }
    );
    return response.data;
  }

  async getVersion() {
    const response = await axios.get(`${this.baseUrl}/version`);
    return response.data;
  }
}

// Usage
(async () => {
  const client = new SenseVoiceClient();

  // Check health
  const health = await client.healthCheck();
  console.log(`Server status: ${health.status}`);

  // Recognize speech
  const result = await client.recognize('audio.wav', 'en');
  console.log(`Transcription: ${result.text}`);

  // Get version
  const version = await client.getVersion();
  console.log(`Model: ${version.model_name}`);
})();
```

## Troubleshooting

### Common Issues

1. **Connection Refused**: Ensure the server is running and accessible
2. **Timeout Errors**: Increase timeout values for large audio files
3. **Format Errors**: Ensure audio is in a supported format
4. **Memory Errors**: Reduce audio file size or increase server resources

### Getting Help

For API-related issues:
1. Check server logs for error details
2. Verify request format and parameters
3. Test with the `/health` endpoint first
4. Review [CONFIGURATION.md](CONFIGURATION.md) for server settings
5. Open an issue on GitHub with error details

## Future Enhancements

Planned features for future versions:
- Streaming audio support
- WebSocket API for real-time recognition
- Batch processing endpoint
- Audio preprocessing options
- Custom vocabulary support
- Speaker diarization

## Conclusion

This API provides a simple yet powerful interface for speech recognition using the RKNN-accelerated SenseVoice model. For additional configuration options and advanced usage, refer to [CONFIGURATION.md](CONFIGURATION.md).
