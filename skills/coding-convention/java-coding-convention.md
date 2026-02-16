# Java Coding Convention

> **Based on Google Java Style Guide**
>
> - Official documentation: https://google.github.io/styleguide/javaguide.html
> - Tool: https://github.com/google/google-java-format
> - Maintained by: Google Engineering
> - GitHub Stars: ~38,900+ (google/styleguide repository)

---

## 1. Selection Rationale

| Criteria | Google Java | Oracle/Sun | Alibaba | Spring |
|---|---|---|---|---|
| Community adoption | Most widely adopted worldwide | Historical foundation (legacy) | China ecosystem focused | Spring contributions only |
| Up-to-date | Actively maintained (records, sealed classes, etc.) | Not updated since 1999 | Active | Spring-specific |
| Comprehensiveness | File structure, formatting, naming, programming practices, Javadoc | Basic | Very broad (includes DB/security) | Narrow |
| Tooling support | google-java-format, Checkstyle, IDE settings | None | PMD plugin, IDE plugin | None |
| Clarity | Prescriptive, minimal ambiguity | Some ambiguity | High | Basic |

Google Java Style Guide covers modern Java features and is the most widely adopted Java style guide worldwide. Spring Framework's code style is also based on Google Java Style.

---

## 2. Source File Basic Rules

### 2.1 File Name

- Case-sensitive name of the top-level class + `.java`
- Exactly one top-level class per file

### 2.2 File Encoding

- UTF-8 required

### 2.3 Special Characters

| Rule | Details |
|---|---|
| Whitespace character | Only ASCII horizontal space (0x20) is allowed. **Tab characters are prohibited** |
| Escape sequences | Use `\b`, `\t`, `\n`, `\f`, `\r`, `\s`, `\"`, `\'`, `\\`. Preferred over octal/Unicode escapes |
| Non-ASCII characters | Use whichever of the actual Unicode character or Unicode escape is **more readable**. Add explanatory comment when using Unicode escapes |

---

## 3. Source File Structure

Files are organized in the following order, with **exactly one blank line** between each section:

1. License/copyright information (if applicable)
2. Package statement (no line wrapping, column limit does not apply)
3. Import statements
4. Exactly one top-level class

---

## 4. Import Rules

| Rule | Details |
|---|---|
| No wildcard imports | `import java.util.*` prohibited (both static and non-static) |
| No line wrapping | Import statements are not line-wrapped; column limit does not apply |
| Ordering | All static imports in one block, all non-static imports in one block |
| Block separation | One blank line between static/non-static blocks |
| Ordering within blocks | ASCII sort order |
| Static nested classes | Use regular (non-static) imports |

---

## 5. Class Declaration

| Rule | Details |
|---|---|
| One per file | Exactly one top-level class |
| Member ordering | **Logical ordering** (explainable by the maintainer). Not chronological by addition time |
| No overload separation | Multiple constructors/methods with the same name are placed sequentially, with no other code between them |

---

## 6. Formatting

### 6.1 Braces

**Required braces**: Use braces with `if`, `else`, `for`, `do`, `while` statements even when the body is empty or contains a single statement. Exception: lambda expressions.

**Non-empty blocks (K&R style)**:
- No line break before the opening brace
- Line break after the opening brace
- Line break before the closing brace
- Line break after the closing brace (only when it terminates a statement/method/constructor/class body). No line break before `else`, `catch`, or comma

**Empty blocks**: Concise `{}` is allowed (no characters or line breaks inside). Exception: not allowed in multi-block statements (`if/else`, `try/catch/finally`).

### 6.2 Block Indentation

- **+2 spaces** for each new block
- Applies to both code and comments within the block

### 6.3 One Statement Per Line

Line break after each statement.

### 6.4 Column Limit

- **100 characters** per line
- Each Unicode code point counts as one character

**Exceptions** (may exceed 100 characters):
- Lines where compliance is impossible (e.g., long URLs in Javadoc)
- Package and import statements
- Text block content
- Command lines in comments that can be copied to a shell
- Very long identifiers (rare)

### 6.5 Line Wrapping

**Core principle**: Prefer line breaks at a **higher syntactic level**.

| Context | Break position |
|---|---|
| Non-assignment operators (`.`, `::`, `&`, `\|`) | **Before** the operator |
| Assignment operators (including colon in enhanced `for`) | **After** the operator (either direction allowed) |
| Method/constructor/record name | Attached to the opening `(` |
| Comma | Attached to the preceding token |
| Lambda arrow (`->`) | No adjacent line breaks |
| Switch rule arrow (`->`) | No adjacent line breaks |

**Continuation indent**: At least **+4 spaces** from the original line.

### 6.6 Whitespace

#### Vertical Whitespace (Blank Lines)

- Single blank line between consecutive members/initializers of a class
- Blank lines between consecutive fields are optional (for logical grouping)
- Additional blank lines are allowed anywhere for improved readability
- Multiple consecutive blank lines are allowed but not recommended

#### Horizontal Whitespace (Single Space)

The **only** places where a single ASCII space appears:

1. Between reserved words (`if`, `for`, `catch`, etc.) and the following `(`
2. Between reserved words (`else`, `catch`) and the preceding `}`
3. Before all opening braces `{` (exceptions: `@SomeAnnotation({a, b})`, `String[][] x = {{"foo"}}`)
4. On both sides of all binary/ternary operators:
   - `&` in conjunctive type bounds: `<T extends Foo & Bar>`
   - `|` in multi-catch: `catch (FooException | BarException e)`
   - `:` in enhanced for: `for (String s : list)`
   - Lambda `->`: `(String str) -> str.length()`
   - **Exceptions**: `::` (method reference), `.` (member access) have no spaces
5. After `,` `:` `;` or the closing `)` of a cast
6. Between content and `//` (multiple spaces allowed)
7. Between `//` and comment text (multiple spaces allowed)
8. Between type and variable declaration: `List<String> list`
9. Inside array initializer braces (optional): both `{5, 6}` and `{ 5, 6 }` are valid

**Horizontal alignment**: Not required. Maintaining alignment is not recommended.

### 6.7 Grouping Parentheses

- Optional parentheses may be omitted only when the author and reviewer agree there is no chance of misunderstanding the code
- Do not assume every reader has memorized the Java operator precedence table

### 6.8 Specific Constructs

#### Enum Classes

- Line breaks after enum constants are optional
- Enums without methods or documentation may be formatted as array initializers: `enum Suit { CLUBS, HEARTS, SPADES, DIAMONDS }`

#### Variable Declarations

- **One variable per declaration**: `int a, b;` prohibited. Exception: `for` loop headers
- Local variables are declared **close to the point of first use** (not at the beginning of a block)

#### Arrays

- C-style array declaration prohibited: `String[] args` (correct), `String args[]` (incorrect)

#### Switch Statements

- Block content indented +2 from the switch keyword
- Legacy-style switch: each statement group ends with `break`, `continue`, `return`, `throw`, or a fall-through comment (e.g., `// fall through`)
- Arrow-style switch: no fall-through
- All switches must be **exhaustive** (cover all possible values)
- Switch expressions must use arrow-style syntax

#### Annotations

- Type-use annotations: immediately before the annotated type: `final @Nullable String name;`
- Class/package/module annotations: each on its own line
- Method/constructor annotations: same as class. However, a single annotation without parameters may share the first line with the signature: `@Override public int hashCode() { ... }`
- Field annotations: multiple annotations may share one line: `@Partial @Mock DataLoader loader;`

#### Comments

- Block comments: same indentation level as the surrounding code
- No decorative boxes (do not wrap with asterisks/characters)
- TODO comments: `TODO:` + resource link/context + hyphen + description text

#### Modifier Order (JLS Recommended)

```
public protected private abstract default static final sealed non-sealed
transient volatile synchronized native strictfp
```

#### Numeric Literals

- `long` integer literals: uppercase `L` suffix (lowercase `l` prohibited — confusion with digit `1`)

#### Text Blocks

- Opening `"""` is always on a new line
- Closing `"""` is on a new line at the same indentation as the opening/closing delimiter
- Text block content may exceed the 100-character column limit

---

## 7. Naming

### 7.1 General Rules

- Identifiers use only ASCII letters, digits, and in certain cases underscores
- No special prefixes/suffixes: `name_`, `mName`, `s_name`, `kName` prohibited

### 7.2 Rules by Identifier Type

| Identifier | Case style | Additional rules |
|---|---|---|
| Package | `com.example.deepspace` | All lowercase, no underscores, concatenated words |
| Class | `UpperCamelCase` | Usually noun/noun phrase. Test classes end with `Test` |
| Method | `lowerCamelCase` | Usually verb/verb phrase. Test methods may use `_` separators |
| Constant | `UPPER_SNAKE_CASE` | Must be `static final` + deeply immutable value + no side effects |
| Non-constant field | `lowerCamelCase` | Usually noun/noun phrase |
| Parameter | `lowerCamelCase` | Avoid single-character names in public methods |
| Local variable | `lowerCamelCase` | Never use constant style even if `final` and immutable |
| Type variable | Single uppercase letter (+digit) or class name + `T` | `E`, `T`, `T2`, `RequestT`, `FooBarT` |

### 7.3 Constants vs Non-constants (Important Distinction)

**Constants** (`UPPER_SNAKE_CASE`):
```java
static final int NUMBER = 5;
static final ImmutableList<String> NAMES = ImmutableList.of("Ed", "Ann");
static final Joiner COMMA_JOINER = Joiner.on(',');
static final SomeMutableType[] EMPTY_ARRAY = {};
```

**Non-constants** (`lowerCamelCase`):
```java
static String nonFinal = "non-final";              // not final
final String nonStatic = "non-static";              // not static
static final Set<String> mutableCollection = new HashSet<>();  // mutable
static final Logger logger = Logger.getLogger(...); // side effects
static final String[] nonEmptyArray = {"these", "can", "change"};  // mutable contents
```

### 7.4 CamelCase Conversion Algorithm

1. Convert to pure ASCII, remove apostrophes
2. Split into words by spaces and remaining punctuation. Also recommended to split existing camelCase
3. Lowercase everything, then capitalize the first letter of each word (UpperCamelCase) or all except the first (lowerCamelCase)
4. Join all words

| Prose form | Correct | Incorrect |
|---|---|---|
| "XML HTTP request" | `XmlHttpRequest` | `XMLHTTPRequest` |
| "new customer ID" | `newCustomerId` | `newCustomerID` |
| "supports IPv6 on iOS?" | `supportsIpv6OnIos` | `supportsIPv6OnIOS` |
| "YouTube importer" | `YouTubeImporter` or `YoutubeImporter` | -- |

---

## 8. Programming Practices

### 8.1 @Override

- Always use `@Override` wherever legally permitted: overriding superclass methods, implementing interface methods, re-specifying superinterface methods, explicit record component accessors
- Exception: may be omitted when the parent method is `@Deprecated`

### 8.2 Caught Exceptions

- Never silently ignore. Response: logging, rethrowing, wrapping (`AssertionError`), or appropriate handling
- When legitimately taking no action: justify with a comment

```java
try {
  int i = Integer.parseInt(response);
  return handleNumericResponse(i);
} catch (NumberFormatException ok) {
  // it's not numeric; that's fine, just continue
}
return handleTextResponse(response);
```

### 8.3 Static Members

- Always qualify with **class name**. No access through instance references
- Correct: `Foo.aStaticMethod()`
- Incorrect: `someFooInstance.aStaticMethod()`

### 8.4 Finalizer

- **Never** override `Object.finalize()`. Scheduled for removal from the JDK.

---

## 9. Javadoc

### 9.1 General Format

**Multi-line form**:
```java
/**
 * Multiple lines of Javadoc text,
 * wrapped normally...
 */
```

**Single-line form** (when the entire Javadoc fits on one line and has no block tags):
```java
/** An especially short bit of Javadoc. */
```

### 9.2 Paragraphs

- Separate paragraphs with a blank line containing only the aligned leading `*`
- Each paragraph after the first has `<p>` immediately before the first word (no space after `<p>`)
- Block-level HTML elements (`<ul>`, `<table>`) are not preceded by `<p>`

### 9.3 Block Tags

- Standard order: `@param`, `@return`, `@throws`, `@deprecated`
- Block tags must not have empty descriptions
- Continuation lines of block tags: indent at least 4 spaces from the `@` position

### 9.4 Summary Fragment

- The first sentence/fragment of every Javadoc block
- Noun phrase or verb phrase, **not a complete sentence**
- Capitalize and punctuate as if it were a complete sentence
- Do not start with `"A {@code Foo} is a..."`
- Do not start with `"This method returns..."`
- For `@return`-only methods: prefer `/** Returns the customer ID. */`

### 9.5 Where Javadoc Is Required

**Required**: All visible classes, members, and record components (`public` or `protected`).

**Exceptions**:
- Self-explanatory members (e.g., `getFoo()` — no additional explanation needed). Do not abuse
- Methods that override a supertype method

**Not required but recommended**: Other classes/members. Prefer Javadoc (`/** */`) over implementation comments.

---

## 10. Key Metrics Summary

| Category | Rule | Value |
|---|---|---|
| Encoding | Source file encoding | UTF-8 |
| Indentation | Block indentation | 2 spaces |
| Indentation | Continuation indentation | +4 spaces minimum |
| Column limit | Maximum line length | 100 characters |
| Braces | Style | K&R (Egyptian) |
| Braces | Single-statement body | Always required |
| Import | Wildcard imports | Prohibited |
| Import | Ordering | Static block, blank line, non-static block; ASCII sort within |
| Class | Per file | Exactly one |
| Variable | Per declaration | Exactly one |
| Variable | Declaration position | Close to point of first use |
| Array | Declaration style | `String[] args` (not `String args[]`) |
| Switch | Exhaustiveness | Required for all switches |
| Switch expression | Style | Arrow syntax required |
| `@Override` | Usage | Always when legal |
| Exception | Caught exceptions | Never silently ignore |
| Static members | Access | By class name only |
| `finalize()` | Override | Prohibited |
| `long` literal | Suffix | Uppercase `L` |
| Naming: package | Style | `alllowercase` |
| Naming: class | Style | `UpperCamelCase` |
| Naming: method | Style | `lowerCamelCase` |
| Naming: constant | Style | `UPPER_SNAKE_CASE` |
| Naming: field/parameter/local variable | Style | `lowerCamelCase` |
| Naming: type variable | Style | `T`, `E`, `T2`, or `RequestT` |
| Javadoc | Required for | All visible members |
| Javadoc | Summary fragment | Noun/verb phrase, not a sentence |
| Javadoc | Block tag order | `@param`, `@return`, `@throws`, `@deprecated` |

---

## References

- [Google Java Style Guide](https://google.github.io/styleguide/javaguide.html)
- [Google Styleguide GitHub Repository](https://github.com/google/styleguide)
- [google-java-format Tool](https://github.com/google/google-java-format)
- [Oracle Java Code Conventions](https://www.oracle.com/java/technologies/javase/codeconventions-contents.html)
- [Alibaba Java Coding Guidelines](https://github.com/alibaba/Alibaba-Java-Coding-Guidelines)
- [Spring Framework Code Style](https://github.com/spring-projects/spring-framework/wiki/Code-Style)
