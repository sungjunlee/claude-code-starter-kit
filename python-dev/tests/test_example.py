"""Example tests to demonstrate the testing setup.

This shows:
- Basic pytest usage
- Type hints in tests
- Parametrized tests

Replace this with your actual tests!
"""

import pytest

from src.example import hello


def test_hello_default() -> None:
    """Test hello with default parameter."""
    result = hello()
    assert result == "Hello, World!"


def test_hello_with_name() -> None:
    """Test hello with custom name."""
    result = hello("Alice")
    assert result == "Hello, Alice!"


@pytest.mark.parametrize("name,expected", [
    ("Bob", "Hello, Bob!"),
    ("Charlie", "Hello, Charlie!"),
    ("", "Hello, !"),
])
def test_hello_parametrized(name: str, expected: str) -> None:
    """Test hello function with various inputs."""
    assert hello(name) == expected