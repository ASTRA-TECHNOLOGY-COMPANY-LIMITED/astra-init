# Python Coding Convention

> **Based on PEP 8 (Python Enhancement Proposal 8)**
>
> - Official documentation: https://peps.python.org/pep-0008/
> - Maintained by: Python Software Foundation (Guido van Rossum, Barry Warsaw, Alyssa Coghlan)
> - Related tools: Flake8, Pylint, pycodestyle, Ruff, Black, autopep8

---

## 1. Selection Rationale

| Criteria | PEP 8 | Google Python | Black | Ruff |
|---|---|---|---|---|
| Official standard | Official Python style guide | PEP 8 extension | PEP 8 compliant formatter | Linter/formatter |
| Comprehensiveness | Covers naming, formatting, imports, comments, and programming practices | High (adds enterprise-specific rules) | Formatting only | Lint rules only |
| Community adoption | Universal | High in enterprise environments | Very high (django, pytest, etc.) | Rapidly growing |
| Tool ecosystem | All major tools are PEP 8 based | Pylint-based | Own formatter | Own linter + formatter |

PEP 8 is the official Python style guide and the foundation for all other guides (Google, Black, Ruff). It is the only universally applied standard for writing Python code.

---

## 2. Code Layout

### 2.1 Indentation

- Use **4 spaces** (tabs prohibited)
- Python 3 prohibits mixing tabs and spaces
- Continuation line alignment methods:

```python
# (1) Vertically align with the opening delimiter
foo = long_function_name(var_one, var_two,
                         var_three, var_four)

# (2) Hanging indent (no arguments on first line, extra indentation to distinguish from body)
def long_function_name(
        var_one, var_two, var_three,
        var_four):
    print(var_one)
```

- Closing bracket/brace/parenthesis position:
  - Below the first non-whitespace character of the last item
  - Below the first character of the line that starts the construct

### 2.2 Maximum Line Length

| Target | Limit |
|---|---|
| Code | **79 characters** |
| Docstrings/comments | **72 characters** |
| With team agreement for code | Up to 99 characters |

- Preferred line wrapping: implicit continuation inside parentheses, brackets, and braces
- Backslash: allowed in `with` and `assert` statements when implicit continuation is not possible

### 2.3 Line Wrapping Around Binary Operators

```python
# Recommended: line break before binary operator (Knuth style)
income = (gross_wages
          + taxable_interest
          + (dividends - qualified_dividends))
```

### 2.4 Blank Lines

| Location | Number of blank lines |
|---|---|
| Before and after top-level function/class definitions | **2 lines** |
| Before and after method definitions within a class | **1 line** |
| Within functions for logical sections | As needed (use sparingly) |

### 2.5 Source File Encoding

- UTF-8 (Python 3 default), no encoding declaration needed
- Use non-ASCII characters sparingly
- Standard library identifiers must be ASCII-only, using English words

---

## 3. Imports

### 3.1 Import Formatting

```python
# Correct:
import os
import sys

# Incorrect:
import sys, os

# Allowed:
from subprocess import Popen, PIPE
```

### 3.2 Import Placement

At the top of the file, after module comments and docstrings, before module globals and constants.

### 3.3 Import Groups (in order, with blank line between each group)

1. **Standard library** imports
2. **Related third-party** imports
3. **Local application/library** imports

### 3.4 Import Styles

```python
# Absolute imports (recommended)
import mypkg.sibling
from mypkg import sibling
from mypkg.sibling import example

# Explicit relative imports (allowed)
from . import sibling
from .sibling import example
```

- **Wildcard imports prohibited**: Avoid `from module import *` (makes namespace unclear)

### 3.5 Module-Level Dunder Names

`__all__`, `__author__`, `__version__`, etc. are placed after the module docstring, before imports. `from __future__` imports must appear before all code except the docstring.

---

## 4. String Quotes

- Single quotes and double quotes are equivalent. Choose one and maintain consistency
- When the string contains a quote character, use the other style (avoid backslash)
- **Triple-quoted strings**: Always use double quotes (`"""`) (PEP 257 consistency)

---

## 5. Whitespace

### 5.1 Avoid Unnecessary Whitespace

```python
# Correct:
spam(ham[1], {eggs: 2})
foo = (0,)
if x == 4: print(x, y); x, y = y, x
spam(1)
dct['key'] = lst[index]

# Incorrect:
spam( ham[ 1 ], { eggs: 2 } )
foo = (0, )
if x == 4 : print(x , y) ; x , y = y , x
spam (1)
dct ['key'] = lst [index]
```

### 5.2 No Extra Whitespace for Alignment

```python
# Correct:
x = 1
y = 2
long_variable = 3

# Incorrect:
x             = 1
y             = 2
long_variable = 3
```

### 5.3 Slice Whitespace

```python
# Correct:
ham[1:9], ham[1:9:3], ham[:9:3], ham[1::3]
ham[lower::2], ham[:upper]
ham[lower+offset : upper+offset]

# Incorrect:
ham[lower + offset:upper + offset]
ham[1: 9], ham[1 :9]
```

### 5.4 Binary Operator Whitespace

- **One space** on each side: assignment (`=`, `+=`), comparison (`==`, `!=`, `<`), boolean (`and`, `or`, `not`)
- Mixed precedence: space only around the **lowest** precedence:
  ```python
  hypot2 = x*x + y*y
  c = (a+b) * (a-b)
  ```

### 5.5 Function Annotations

```python
def munge(input: AnyStr): ...
def munge() -> PosInt: ...
```

### 5.6 Keyword Arguments and Default Values

```python
# Without annotation: no space around =
def complex(real, imag=0.0):
    return magic(r=real, i=imag)

# With annotation and default value combined: space around =
def munge(sep: AnyStr = None): ...
```

### 5.7 Compound Statements

- Generally not recommended (multiple statements on one line)
- Do not place the body of multi-clause `if`/`for`/`while` on the same line

### 5.8 Trailing Whitespace

Avoid trailing whitespace everywhere.

---

## 6. Trailing Commas

- **Required** in single-element tuples: `FILES = ('setup.cfg',)`
- Place each value on its own line with a trailing comma for lists expected to be extended:

```python
FILES = [
    'setup.cfg',
    'tox.ini',
]
initialize(
    FILES,
    error=True,
)
```

---

## 7. Comments

### 7.1 General Rules

- Comments that contradict the code are **worse** than no comments
- Write comments as **complete sentences**
- Capitalize the first word (unless it is a lowercase identifier)
- Write in English (unless you are 120% certain that only speakers of that language will read the code)

### 7.2 Block Comments

- Apply to the code that follows
- Indented to the same level as the code
- Each line starts with `#` + one space
- Paragraph separation: a line containing only `#`

### 7.3 Inline Comments

- Use **sparingly**
- Place at least **2 spaces** after the statement
- Start with `#` + space
- Do not state the obvious

### 7.4 Docstrings (PEP 257)

- Write for all **public** modules, functions, classes, and methods
- Use `"""triple double quotes"""`
- **One-liner**: closing `"""` on the same line:
  ```python
  """Return the pathname of the KOS root directory."""
  ```
- **Multi-line**: closing `"""` on its own line:
  ```python
  """Summary line.

  Extended description of function.

  """
  ```
- Summary line: a phrase ending with a period. Write in imperative form ("Return X", "Do X" — not "Returns X")
- Blank line after class docstring (before the first method)

---

## 8. Naming Rules

### 8.1 Quick Reference Table

| Type | Rule | Example |
|---|---|---|
| Package | Short all-lowercase, underscores not preferred | `mypackage` |
| Module | Short all-lowercase, underscores allowed | `my_module` |
| Class | CapWords (CamelCase) | `MyClass`, `HTTPServer` |
| Exception | CapWords + "Error" suffix | `ValueError`, `ConnectionError` |
| Function | lowercase_with_underscores | `calculate_total()` |
| Method | lowercase_with_underscores | `get_name()` |
| Instance variable | lowercase_with_underscores | `first_name` |
| Constant | UPPER_CASE_WITH_UNDERSCORES | `MAX_OVERFLOW`, `PI` |
| Type variable | CapWords, short | `T`, `AnyStr`, `Num` |
| Global variable | Same as functions | `current_user` |

### 8.2 Special Prefix/Suffix Rules

| Pattern | Meaning | Example |
|---|---|---|
| `_single_leading_underscore` | Indicates "internal use" | `_internal_helper` |
| `single_trailing_underscore_` | Avoid conflict with Python keywords | `class_`, `type_` |
| `__double_leading_underscore` | Name mangling (class private) | `__private_attr` |
| `__dunder__` | Magic/special methods (do not create your own) | `__init__`, `__str__` |

### 8.3 Names to Avoid

Never use `l` (lowercase L), `O` (uppercase O), or `I` (uppercase I) as single-character variable names — many fonts confuse them with `1` and `0`.

### 8.4 Method Arguments

- Instance method first argument: always `self`
- Class method first argument: always `cls`
- When conflicting with reserved words: add trailing underscore (`class_`)

### 8.5 Abbreviations

- In CapWords, capitalize all letters of abbreviations: `HTTPServerError` (correct), `HttpServerError` (incorrect)

### 8.6 Public vs Private Interfaces

- Public attributes: no leading underscore
- Explicitly declare the module's public API with `__all__`
- Internal interfaces: use leading underscore
- When in doubt, make it **private** (easier to make public later)

### 8.7 Inheritance Design

- For attributes you don't want subclasses to use: consider double leading underscore (name mangling)
- Simple public data attributes: do not write getter/setter methods, expose directly
- Use `@property` when functional behavior is needed later
- `@property` should have no side effects (caching is allowed)

---

## 9. Programming Recommendations

### 9.1 Singleton Comparison

```python
# Correct:
if foo is not None:
if foo is None:

# Incorrect:
if foo != None:
if foo == None:
```

Use `is` / `is not`, not `==` / `!=`.

### 9.2 Boolean Comparison

```python
# Correct:
if greeting:

# Incorrect:
if greeting == True:

# Even worse:
if greeting is True:
```

### 9.3 Sequence Truthiness

```python
# Correct (empty sequences are falsy):
if not seq:
if seq:

# Incorrect:
if len(seq):
if not len(seq):
```

### 9.4 Type Checking

```python
# Correct:
if isinstance(obj, int):

# Incorrect:
if type(obj) is type(1):
```

### 9.5 String Prefix/Suffix Checking

```python
# Correct:
if foo.startswith('bar'):
if foo.endswith('baz'):

# Incorrect:
if foo[:3] == 'bar':
if foo[-3:] == 'baz':
```

### 9.6 Function Definition vs Lambda Assignment

```python
# Correct:
def f(x): return 2*x

# Incorrect:
f = lambda x: 2*x
```

Assigning a lambda to a name negates the sole advantage of lambda (expression embedding).

### 9.7 Exception Handling

- Derive from `Exception` (not `BaseException`)
- Exception class names with `Error` suffix
- Use specific exception types in `except` clauses — bare `except:` prohibited

```python
# Correct:
try:
    ...
except ValueError:
    ...

# Incorrect:
try:
    ...
except:
    ...
```

- When catching all program errors: use `except Exception:`
- Keep the `try` clause body to the **minimum** amount of code
- Exception chaining: `raise X from Y`
- Intentional exception replacement: `raise X from None`

### 9.8 Return Statement Consistency

```python
# Correct: all return statements either return an expression, or none do
def foo(x):
    if x >= 0:
        return math.sqrt(x)
    else:
        return None

# Incorrect:
def foo(x):
    if x >= 0:
        return math.sqrt(x)
```

### 9.9 String Concatenation

- Do not rely on CPython's `a += b` string optimization
- For performance-sensitive string building: use `''.join()` (guarantees linear time)

### 9.10 Resource Management

```python
# Correct:
with open('file.txt') as f:
    data = f.read()
```

Use `with` statements for resource acquisition/release.

### 9.11 Ordering Operations

When implementing ordering operations, implement all 6: `__eq__`, `__ne__`, `__lt__`, `__le__`, `__gt__`, `__ge__`. Alternatively, use `@functools.total_ordering`.

### 9.12 Flow Control in `finally`

Do not use `return`, `break`, `continue` inside `finally` blocks — they silently cancel active exceptions.

---

## 10. Type Annotations (PEP 484 / PEP 526)

### 10.1 Function Annotations

```python
def greeting(name: str) -> str:
    return 'Hello ' + name
```

### 10.2 Variable Annotations

```python
# Correct:
code: int
label: str = '<unknown>'

# Incorrect:
code:int
code : int
label: str='<unknown>'
```

### 10.3 Modern Patterns (Python 3.9+/3.10+)

- Prefer built-in generics: `list[str]` > `List[str]`, `dict[str, int]` > `Dict[str, int]`
- `X | None` (3.10+) > `Optional[X]`

### 10.4 Type Checkers

- Type checkers (mypy, pytype, pyright) are **optional separate tools**
- The Python interpreter does not check/enforce annotations at runtime
- Suppress type checker warnings with `# type: ignore` when necessary

---

## 11. Docstring Rules (PEP 257)

### 11.1 One-Line Docstrings

```python
def kos_root():
    """Return the pathname of the KOS root directory."""
    global _kos_root
    ...
```

- Closing `"""` on the same line, no blank lines before/after, phrase ending with a period, imperative form

### 11.2 Multi-Line Docstrings

```python
def complex_function(real=0.0, imag=0.0):
    """Form a complex number.

    Keyword arguments:
    real -- the real part (default 0.0)
    imag -- the imaginary part (default 0.0)

    """
    ...
```

- Summary on the first line, blank line, detailed description
- Closing `"""` on its own line
- Blank line after class docstring (before the first method)

### 11.3 Module/Class/Script Docstrings

- **Module**: list exported classes, exceptions, functions, and other objects with one-line summaries
- **Class**: summarize behavior, list public methods/instance variables, `__init__` has its own docstring
- **Script**: serves as "usage" message, documents functions/command-line syntax/environment variables/files

---

## 12. Key Metrics Summary

| Rule | Value |
|---|---|
| Indentation | 4 spaces |
| Maximum line length (code) | 79 characters |
| Maximum line length (comments/docstrings) | 72 characters |
| Optional team line length | Up to 99 characters |
| Blank lines before/after top-level definitions | 2 lines |
| Blank lines before/after methods within class | 1 line |
| Space around binary operators | 1 space |
| Space before function call parenthesis | 0 |
| Import group separation | 1 blank line |

---

## References

- [PEP 8 -- Style Guide for Python Code (Official)](https://peps.python.org/pep-0008/)
- [PEP 257 -- Docstring Conventions](https://peps.python.org/pep-0257/)
- [Google Python Style Guide](https://google.github.io/styleguide/pyguide.html)
- [Black -- The Uncompromising Code Formatter](https://github.com/psf/black)
- [Ruff -- Python Linter and Formatter](https://github.com/astral-sh/ruff)
- [How to Write Beautiful Python Code With PEP 8 -- Real Python](https://realpython.com/python-pep8/)
