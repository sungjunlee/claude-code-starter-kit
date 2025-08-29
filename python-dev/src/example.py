"""Example module to demonstrate the development setup.

This is a minimal example that shows:
- Type hints
- Docstrings
- Basic functionality

Feel free to replace this with your actual project code!
"""


def hello(name: str = "World") -> str:
    """Return a greeting message.

    Args:
        name: The name to greet

    Returns:
        A greeting string
    """
    return f"Hello, {name}!"


def add_numbers(a: int, b: int) -> int:
    """Add two numbers."""
    result = a + b
    return result


if __name__ == "__main__":
    print(hello())
    print(add_numbers(2, 3))
