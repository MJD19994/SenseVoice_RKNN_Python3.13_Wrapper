# Contributing to SenseVoice RKNN Python 3.13+ Wrapper

Thank you for your interest in contributing to the SenseVoice RKNN Python 3.13+ Wrapper! This document provides guidelines and instructions for contributing to this project.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [How to Contribute](#how-to-contribute)
- [Reporting Bugs](#reporting-bugs)
- [Suggesting Features](#suggesting-features)
- [Pull Request Process](#pull-request-process)
- [Code Standards](#code-standards)
- [Development Setup](#development-setup)
- [Testing Guidelines](#testing-guidelines)
- [Documentation](#documentation)
- [Community](#community)

## Code of Conduct

By participating in this project, you agree to maintain a respectful and inclusive environment. We expect all contributors to:

- Be respectful and considerate of others
- Accept constructive criticism gracefully
- Focus on what is best for the community
- Show empathy towards other community members
- Use welcoming and inclusive language

## Getting Started

Before you begin contributing:

1. **Read the documentation**: Familiarize yourself with the project by reading:
   - [README.md](README.md) - Project overview
   - [INSTALLATION_STEPS.md](INSTALLATION_STEPS.md) - Setup instructions
   - [API.md](API.md) - API documentation
   - [CONFIGURATION.md](CONFIGURATION.md) - Configuration guide

2. **Set up your development environment**: Follow the [Development Setup](#development-setup) section below

3. **Check existing issues**: Look at open issues to see if your bug or feature is already being discussed

4. **Start small**: If you're new to the project, look for issues tagged with `good-first-issue` or `help-wanted`

## How to Contribute

There are many ways to contribute to this project:

- **Report bugs**: Help us identify and fix issues
- **Suggest features**: Propose new functionality or improvements
- **Write documentation**: Improve or expand our documentation
- **Submit code**: Fix bugs or implement new features
- **Review pull requests**: Help review and test others' contributions
- **Answer questions**: Help other users in issues and discussions
- **Share the project**: Star the repository and spread the word

## Reporting Bugs

### Before Submitting a Bug Report

- **Check existing issues**: Search the [issue tracker](https://github.com/MJD19994/SenseVoice_RKNN_Python3.13_Wrapper/issues) to see if the bug has already been reported
- **Verify it's a bug**: Ensure the behavior is actually a bug and not a configuration issue
- **Test with latest version**: Confirm the bug exists in the latest version
- **Isolate the problem**: Try to identify the minimal steps to reproduce the issue

### How to Submit a Bug Report

Create a new issue with the following information:

**Title**: Brief, descriptive summary of the bug

**Description**: Include:

1. **Environment Information**:
   ```
   - OS: [e.g., Ubuntu 22.04]
   - Python Version: [e.g., 3.13.0]
   - RKNN Version: [e.g., 2.0.0]
   - Hardware: [e.g., RK3588]
   ```

2. **Expected Behavior**: What you expected to happen

3. **Actual Behavior**: What actually happened

4. **Steps to Reproduce**:
   ```
   1. Start the server with...
   2. Send a request to...
   3. Observe the error...
   ```

5. **Error Messages/Logs**: Include relevant error messages or log output
   ```
   [Paste error messages or logs here]
   ```

6. **Additional Context**: Screenshots, configuration files, or other relevant information

**Bug Report Template**:

```markdown
## Bug Description
[Clear description of the bug]

## Environment
- OS: 
- Python Version: 
- RKNN Version: 
- Hardware: 

## Expected Behavior
[What should happen]

## Actual Behavior
[What actually happens]

## Steps to Reproduce
1. 
2. 
3. 

## Error Messages
```
[Error output]
```

## Additional Context
[Any other relevant information]
```

## Suggesting Features

### Before Submitting a Feature Request

- **Check existing issues**: See if someone has already suggested the feature
- **Consider the scope**: Ensure the feature aligns with the project's goals
- **Think about implementation**: Consider how the feature might be implemented

### How to Submit a Feature Request

Create a new issue with:

**Title**: Concise description of the feature

**Description**: Include:

1. **Problem Statement**: What problem does this feature solve?

2. **Proposed Solution**: Describe your proposed implementation

3. **Alternatives Considered**: What other approaches did you consider?

4. **Use Cases**: Provide examples of how the feature would be used

5. **Additional Context**: Mockups, examples, or references to similar features

**Feature Request Template**:

```markdown
## Feature Description
[Clear description of the proposed feature]

## Problem Statement
[What problem does this solve?]

## Proposed Solution
[How should this be implemented?]

## Alternatives Considered
[What other approaches could work?]

## Use Cases
1. [Use case 1]
2. [Use case 2]

## Additional Context
[Mockups, examples, references]
```

## Pull Request Process

### Before Submitting a Pull Request

1. **Create or comment on an issue**: Discuss your changes before implementing them
2. **Fork the repository**: Create your own fork to work in
3. **Create a branch**: Use a descriptive branch name
   ```bash
   git checkout -b feature/add-new-endpoint
   git checkout -b fix/memory-leak
   git checkout -b docs/update-api-guide
   ```

### Submitting a Pull Request

1. **Ensure your code follows our standards**: See [Code Standards](#code-standards)

2. **Write or update tests**: Include tests for your changes

3. **Update documentation**: Update relevant documentation files

4. **Commit your changes**: Use clear, descriptive commit messages
   ```bash
   git commit -m "Add: New endpoint for batch processing"
   git commit -m "Fix: Memory leak in audio processing"
   git commit -m "Docs: Update API examples for Python 3.13"
   ```

5. **Push to your fork**:
   ```bash
   git push origin feature/add-new-endpoint
   ```

6. **Open a pull request**: Fill out the PR template with:
   - Description of changes
   - Related issue(s)
   - Type of change (bug fix, feature, documentation, etc.)
   - Testing done
   - Checklist completion

### Pull Request Template

```markdown
## Description
[Describe what this PR does]

## Related Issues
Fixes #[issue number]
Closes #[issue number]
Related to #[issue number]

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Performance improvement
- [ ] Code refactoring

## Changes Made
- [Change 1]
- [Change 2]
- [Change 3]

## Testing
- [ ] Tested locally
- [ ] Added/updated unit tests
- [ ] Added/updated integration tests
- [ ] All tests pass

## Documentation
- [ ] Updated relevant documentation
- [ ] Added docstrings to new functions
- [ ] Updated API.md (if applicable)
- [ ] Updated README.md (if applicable)

## Checklist
- [ ] Code follows the project's style guidelines
- [ ] Self-review of code completed
- [ ] Comments added for complex code
- [ ] No new warnings generated
- [ ] Dependent changes have been merged

## Screenshots (if applicable)
[Add screenshots here]

## Additional Notes
[Any additional information]
```

### Pull Request Review Process

1. **Automated checks**: CI will run automated tests and checks
2. **Code review**: Maintainers will review your code
3. **Feedback**: Address any requested changes
4. **Approval**: Once approved, your PR will be merged
5. **Thank you!**: Your contribution will be acknowledged

## Code Standards

### Python Style Guide

Follow [PEP 8](https://www.python.org/dev/peps/pep-0008/) with these specific guidelines:

**Formatting**:
- Use 4 spaces for indentation (no tabs)
- Maximum line length: 100 characters
- Use blank lines to separate functions and classes

**Naming Conventions**:
- `snake_case` for functions and variables
- `PascalCase` for classes
- `UPPER_CASE` for constants
- Descriptive names that explain purpose

**Example**:
```python
# Good
def process_audio_file(file_path: str, sampling_rate: int = 16000) -> dict:
    """Process an audio file and return recognition results.
    
    Args:
        file_path: Path to the audio file
        sampling_rate: Audio sampling rate in Hz
        
    Returns:
        Dictionary containing recognition results
    """
    MAX_DURATION = 300  # seconds
    audio_data = load_audio(file_path)
    return recognize_speech(audio_data)

# Bad
def paf(fp, sr=16000):
    md = 300
    ad = la(fp)
    return rs(ad)
```

### Code Quality

**Type Hints**: Use type hints for function parameters and return values
```python
from typing import Optional, List, Dict

def recognize(audio: bytes, language: Optional[str] = None) -> Dict[str, any]:
    pass
```

**Docstrings**: Document all public functions, classes, and modules
```python
def process_audio(audio_data: bytes, config: dict) -> dict:
    """
    Process audio data and return recognition results.
    
    Args:
        audio_data: Raw audio data in bytes
        config: Configuration dictionary with processing options
        
    Returns:
        Dictionary with keys: 'text', 'confidence', 'duration'
        
    Raises:
        ValueError: If audio_data is empty or invalid
        RuntimeError: If processing fails
    """
    pass
```

**Error Handling**: Use appropriate exception handling
```python
# Good
try:
    result = process_audio(audio_data)
except ValueError as e:
    logger.error(f"Invalid audio data: {e}")
    raise
except Exception as e:
    logger.error(f"Unexpected error: {e}")
    raise RuntimeError("Audio processing failed") from e

# Bad
try:
    result = process_audio(audio_data)
except:
    pass
```

**Logging**: Use appropriate log levels
```python
import logging

logger = logging.getLogger(__name__)

logger.debug("Processing started")  # Detailed diagnostic info
logger.info("Request received")     # General informational messages
logger.warning("Cache full")        # Warning about potential issues
logger.error("Processing failed")   # Error that needs attention
logger.critical("System failure")   # Critical errors
```

### Shell Script Standards

For bash scripts (like `start_server.sh`):

```bash
#!/bin/bash
# Description of what this script does

set -e  # Exit on error
set -u  # Exit on undefined variable

# Use descriptive variable names
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
MODEL_PATH="${SCRIPT_DIR}/models"

# Check prerequisites
if [ ! -f "${MODEL_PATH}/model.rknn" ]; then
    echo "Error: Model file not found" >&2
    exit 1
fi

# Main execution
main() {
    echo "Starting server..."
    exec python3 server.py
}

main "$@"
```

## Development Setup

### Prerequisites

- Python 3.13 or higher
- Git
- RKNN-compatible hardware (for testing NPU features)

### Setup Steps

1. **Fork and clone the repository**:
   ```bash
   git clone https://github.com/YOUR_USERNAME/SenseVoice_RKNN_Python3.13_Wrapper.git
   cd SenseVoice_RKNN_Python3.13_Wrapper
   ```

2. **Create a virtual environment**:
   ```bash
   python3.13 -m venv dev-env
   source dev-env/bin/activate
   ```

3. **Install dependencies**:
   ```bash
   pip install -r requirements.txt
   pip install -r requirements-dev.txt  # If available
   ```

4. **Install development tools**:
   ```bash
   pip install pytest black flake8 mypy
   ```

5. **Set up pre-commit hooks** (optional but recommended):
   ```bash
   pip install pre-commit
   pre-commit install
   ```

### Running Locally

```bash
# Set up environment
export PYTHONPATH="$(pwd)/lib/rknnlite_wrapper:$(pwd)/lib:$PYTHONPATH"

# Run the server
python3 sensevoice_server.py

# Or use the startup script
./start_server.sh
```

## Testing Guidelines

### Running Tests

```bash
# Run all tests
pytest

# Run specific test file
pytest tests/test_audio.py

# Run with coverage
pytest --cov=. --cov-report=html

# Run with verbose output
pytest -v
```

### Writing Tests

**Test Structure**:
```python
import pytest
from sensevoice import AudioProcessor

class TestAudioProcessor:
    """Tests for AudioProcessor class."""
    
    def test_process_valid_audio(self):
        """Test processing of valid audio data."""
        processor = AudioProcessor()
        result = processor.process(valid_audio_data)
        assert result['status'] == 'success'
        assert 'text' in result
    
    def test_process_invalid_audio(self):
        """Test handling of invalid audio data."""
        processor = AudioProcessor()
        with pytest.raises(ValueError):
            processor.process(invalid_audio_data)
    
    @pytest.mark.slow
    def test_process_large_file(self):
        """Test processing of large audio files."""
        processor = AudioProcessor()
        result = processor.process(large_audio_data)
        assert result['duration'] > 60
```

**Test Coverage**: Aim for at least 80% code coverage

**Test Types**:
- Unit tests: Test individual functions and classes
- Integration tests: Test component interactions
- End-to-end tests: Test complete workflows

## Documentation

### Documentation Standards

- Keep documentation up-to-date with code changes
- Use clear, concise language
- Include examples for complex features
- Add diagrams or screenshots where helpful

### Documentation Files

When updating documentation:

- **README.md**: Overview and quick start
- **INSTALLATION_STEPS.md**: Detailed installation instructions
- **API.md**: API endpoint documentation
- **CONFIGURATION.md**: Configuration options
- **CONTRIBUTING.md**: This file

### Code Documentation

```python
def complex_function(param1: int, param2: str) -> dict:
    """
    One-line summary of what the function does.
    
    More detailed explanation if needed. Describe the algorithm,
    any important considerations, or links to relevant resources.
    
    Args:
        param1: Description of param1
        param2: Description of param2
        
    Returns:
        Dictionary containing:
            - key1: Description of key1
            - key2: Description of key2
            
    Raises:
        ValueError: When param1 is negative
        TypeError: When param2 is not a string
        
    Example:
        >>> result = complex_function(42, "test")
        >>> print(result['key1'])
        'expected output'
    """
    pass
```

## Community

### Getting Help

- **Documentation**: Check the docs first
- **Issues**: Search existing issues or create a new one
- **Discussions**: Use GitHub Discussions for questions
- **Email**: Contact maintainers for private concerns

### Communication Channels

- **GitHub Issues**: Bug reports and feature requests
- **GitHub Discussions**: Questions and general discussion
- **Pull Requests**: Code contributions and reviews

### Recognition

Contributors will be recognized in:
- README.md contributors section
- Release notes
- Git commit history

## Development Workflow Example

Here's a complete workflow for contributing a new feature:

```bash
# 1. Fork and clone
git clone https://github.com/YOUR_USERNAME/SenseVoice_RKNN_Python3.13_Wrapper.git
cd SenseVoice_RKNN_Python3.13_Wrapper

# 2. Set up development environment
python3.13 -m venv dev-env
source dev-env/bin/activate
pip install -r requirements.txt

# 3. Create a feature branch
git checkout -b feature/add-batch-processing

# 4. Make your changes
# ... edit files ...

# 5. Test your changes
pytest
python3 sensevoice_server.py  # Manual testing

# 6. Format your code
black .
flake8 .

# 7. Commit your changes
git add .
git commit -m "Add: Batch processing endpoint"

# 8. Push to your fork
git push origin feature/add-batch-processing

# 9. Open a pull request on GitHub
# Fill out the PR template

# 10. Address review feedback
# Make changes, commit, and push again

# 11. Celebrate when merged! 🎉
```

## Questions?

If you have questions about contributing:

1. Check this guide and other documentation
2. Search existing issues and discussions
3. Create a new issue with your question
4. Tag it with `question` label

## Thank You!

Thank you for contributing to SenseVoice RKNN Python 3.13+ Wrapper! Every contribution, no matter how small, helps make this project better for everyone.

---

**License**: By contributing, you agree that your contributions will be licensed under the same license as the project (MIT License).

**Attribution**: Contributors will be acknowledged in the project documentation and release notes.
