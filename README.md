# Python to C/C++/Java Code Converter

A powerful and efficient code converter that translates Python code into C, C++, and Java using Lex and Yacc. This tool helps developers seamlessly convert Python programs to other popular programming languages while maintaining code logic and structure.

## Features

- Converts basic Python syntax to C, C++, and Java
- Supports:
  - Variable assignments
  - Arithmetic operations
  - If-else statements
  - For loops with range
  - Print statements
- Maintains code readability and structure
- Handles basic data types and expressions
- Provides proper syntax conversion for each target language

## Requirements

- Flex (Lex)
- Bison (Yacc)
- GCC compiler

## Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/python-code-converter.git
cd python-code-converter
```

2. Compile the code:
```bash
make
```

## Usage

To convert Python code to another language:

```bash
# For C output
./code_converter c < input.py

# For C++ output
./code_converter cpp < input.py

# For Java output
./code_converter java < input.py
```

## Example

Input (Python):
```python
x = 10
y = 20
z = x + y

if z > 25:
    print(z)
else:
    print("Small number")

for i in range(0, 5):
    print(i)
```

Output (C):
```c
int x = 10;
int y = 20;
int z = (x + y);

if (z > 25) {
    printf("%d\n", z);
} else {
    printf("Small number\n");
}

for(int i = 0; i < 5; i++) {
    printf("%d\n", i);
}
```

## Project Structure

```
python-code-converter/
├── SimpleLang.l      # Lex file for token definitions
├── SimpleLang.y      # Yacc file for grammar rules
├── Makefile         # Build configuration
├── test.py          # Example Python code
└── README.md        # Project documentation
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

## Future Enhancements

- [ ] Support for functions and classes
- [ ] Array and list operations
- [ ] String formatting and f-strings
- [ ] Error handling and reporting
- [ ] Support for more Python features

## License

This project is licensed under the MIT License - see the LICENSE file for details. 