# CSS/SCSS Coding Convention

> **Based on CSS Guidelines (Harry Roberts) + Sass Guidelines (Kitty Giraudel)**
>
> - Official documentation: https://cssguidelin.es/ , https://sass-guidelin.es/
> - References: https://google.github.io/styleguide/htmlcssguide.html , https://github.com/airbnb/css
> - Tool: https://stylelint.io/ (stylelint-config-standard-scss)
> - Maintained by: Harry Roberts (CSS Wizardry) / Kitty Giraudel

---

## 1. Selection Rationale

| Criteria | CSS Guidelines + Sass Guidelines | Google HTML/CSS | Airbnb CSS/Sass | SMACSS |
|---|---|---|---|---|
| Comprehensiveness | Very high (covers both CSS + SCSS) | CSS basics only | Medium (includes SCSS) | Architecture-focused |
| Community adoption | Global standard level | Google internal focus | React ecosystem | Limited |
| Up-to-date | Actively maintained | Maintained | Stalled since 2023 | Legacy |
| SCSS support | Native | None | Partial | None |
| Tooling support | Full Stylelint integration | None | Partial | None |
| Architecture guide | ITCSS-based | None | BEM variant | SMACSS itself |

CSS Guidelines is the most detailed CSS guide covering selectors, specificity, and architecture, while Sass Guidelines is the only comprehensive guide specialized for SCSS. The combination of these two guides is widely recognized as an industry standard.

---

## 2. Source File Basic Rules

### 2.1 File Names

| Rule | Details |
|---|---|
| Case | `kebab-case` lowercase hyphen-separated |
| SCSS partials | Underscore prefix: `_variables.scss`, `_mixins.scss` |
| Component files | Match the component name: `_button.scss`, `_card.scss` |

```
# Correct
_variables.scss
_button.scss
_header.scss
main.scss

# Incorrect
Variables.scss
Button.SCSS
myStyles.css
```

### 2.2 File Encoding

- UTF-8 required
- `@charset "UTF-8";` declaration (in SCSS main file)

### 2.3 Indentation

| Rule | Details |
|---|---|
| Method | Spaces (tabs prohibited) |
| Size | **2 spaces** |

### 2.4 Line Length

- **80 characters** or less recommended
- Exceptions for non-splittable values such as URLs

---

## 3. Formatting

### 3.1 Declaration Blocks

```scss
// Correct
.selector-a,
.selector-b,
.selector-c {
  display: block;
  color: #333;
}

// Incorrect — selectors listed on one line
.selector-a, .selector-b, .selector-c {
  display: block;
}

// Incorrect — no space before opening brace
.selector{
  display: block;
}
```

| Rule | Details |
|---|---|
| Opening brace | On the same line as the selector, preceded by one space |
| Closing brace | On its own line, at the same indent level as the selector |
| Multiple selectors | Each selector on its own line |
| Semicolons | **Required for all declarations**, including the last one |
| Space after colon | Required (`color: red`), no space before the colon |
| Between rulesets | One blank line |

### 3.2 Property Declaration Order

Properties are ordered by **type group**:

```scss
.selector {
  // 1. Positioning
  position: absolute;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
  z-index: z('default');

  // 2. Display & Box Model
  display: flex;
  flex-direction: column;
  align-items: center;
  overflow: hidden;
  box-sizing: border-box;
  width: 100px;
  height: 100px;
  padding: 10px;
  border: 1px solid #333;
  margin: 10px;

  // 3. Typography
  font-family: sans-serif;
  font-size: 1rem;
  font-weight: 700;
  line-height: 1.5;
  color: #333;
  text-align: center;
  text-transform: uppercase;

  // 4. Visual / Decorative
  background-color: #fff;
  border-radius: 0.25rem;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  opacity: 1;

  // 5. Animation
  transition: transform 0.3s ease;
  animation: fade-in 0.5s ease;

  // 6. Misc
  cursor: pointer;
  pointer-events: auto;
}
```

| Group Order | Property Category |
|---|---|
| 1 | Positioning: `position`, `top`, `right`, `bottom`, `left`, `z-index` |
| 2 | Box Model: `display`, `flex-*`, `grid-*`, `overflow`, `box-sizing`, `width`, `height`, `padding`, `border`, `margin` |
| 3 | Typography: `font-*`, `line-height`, `color`, `text-*`, `letter-spacing` |
| 4 | Visual: `background-*`, `border-radius`, `box-shadow`, `opacity` |
| 5 | Animation: `transition`, `animation`, `transform` |
| 6 | Misc: `cursor`, `pointer-events`, `user-select`, `will-change` |

### 3.3 Value Notation

| Rule | Correct | Incorrect |
|---|---|---|
| Leading zero required | `opacity: 0.5;` | `opacity: .5;` |
| No units for zero | `margin: 0;` | `margin: 0px;` |
| Lowercase hex | `color: #aabbcc;` | `color: #AABBCC;` |
| Use shorthand hex | `color: #fff;` | `color: #ffffff;` |
| Quotes | Use single quotes (`'`) | Double quotes (`"`) |
| URL quotes | `url('path/to/file')` | `url(path/to/file)` |
| Border removal | `border: 0;` | `border: none;` |

---

## 4. Selector Rules

### 4.1 Selector Fundamental Principles

| Rule | Details |
|---|---|
| No ID selectors | Do not use `#id` for styling. Use classes only |
| No type qualification | `div.container` prohibited -> use `.container` |
| Selector depth | Maximum **3 levels** (ideally 1-2 levels) |
| Universal selector | Avoid using `*` alone |

```scss
// Correct
.site-nav { }
.site-nav__item { }

// Incorrect — ID selectors
#header { }
#navigation { }

// Incorrect — type qualification
ul.nav { }
div.container { }
input.btn { }

// Incorrect — excessive depth
body .page .content .article .title { }
```

### 4.2 Selector Intent

Selectors should **clearly express the target**:

```scss
// Incorrect — too broad, targets all ul inside header
header ul { }

// Correct — explicit intent
.site-nav { }
```

### 4.3 Location Independence

Components should **not depend on location**:

```scss
// Incorrect — location dependent
.sidebar .widget { }
.footer .widget { }

// Correct — can be placed anywhere
.widget { }
.widget--compact { }
```

### 4.4 JavaScript Binding Classes

```html
<!-- Separate style and behavior -->
<button class="btn btn--primary js-submit-form">Submit</button>
```

- `.js-` prefixed classes must **never be styled**
- Used exclusively for JavaScript bindings

---

## 5. Naming Conventions

### 5.1 BEM (Block Element Modifier)

| Component | Pattern | Example |
|---|---|---|
| Block | `.block-name` | `.search-form` |
| Element | `.block-name__element` | `.search-form__input` |
| Modifier | `.block-name--modifier` | `.search-form--dark` |
| Element + Modifier | `.block-name__element--modifier` | `.search-form__input--disabled` |

```scss
// Correct
.card { }
.card__header { }
.card__body { }
.card__footer { }
.card--featured { }
.card__header--highlighted { }

// Incorrect — nested element of element
.card__header__title { }    // -> use .card__title

// Incorrect — modifier used alone
<div class="card--featured">  // -> <div class="card card--featured">
```

**Key rules:**
- All class names are **lowercase + hyphens** (kebab-case)
- Block and Element are separated by `__` (double underscore)
- Block/Element and Modifier are separated by `--` (double hyphen)
- No nesting elements within elements: `.block__elem1__elem2` -> `.block__elem2`
- Modifiers are always used alongside the original class

### 5.2 State Classes

```scss
// SMACSS-style state prefix
.is-active { }
.is-hidden { }
.is-disabled { }
.is-loading { }
.has-error { }
.has-children { }
```

### 5.3 Utility Classes

```scss
// u- prefix usage
.u-hidden { display: none !important; }
.u-text-center { text-align: center !important; }
.u-sr-only {
  position: absolute !important;
  width: 1px !important;
  height: 1px !important;
  overflow: hidden !important;
  clip: rect(0, 0, 0, 0) !important;
}
```

---

## 6. Color and Value Rules

### 6.1 Colors

| Rule | Details |
|---|---|
| Notation priority | HSL > RGB > Hex |
| Hex format | Lowercase, use shorthand when possible |
| No color keywords | `red`, `blue`, and other CSS keyword colors prohibited |
| Semantic variables | Map raw colors to semantic variables |

```scss
// Step 1: Define raw colors
$blue-500: hsl(210, 100%, 50%);
$gray-900: #1a1a1a;

// Step 2: Semantic mapping
$color-primary: $blue-500;
$color-text: $gray-900;
$color-background: #fff;
$color-border: #ddd;

// Incorrect — color keywords
color: red;
background: white;

// Correct
color: #f00;
background-color: #fff;
```

### 6.2 Color Manipulation

```scss
// Use mix() instead of lighten()/darken()
@function tint($color, $percentage) {
  @return mix(white, $color, $percentage);
}

@function shade($color, $percentage) {
  @return mix(black, $color, $percentage);
}

// Usage
.button:hover {
  background-color: tint($color-primary, 20%);
}
```

---

## 7. Unit Rules

| Purpose | Recommended Unit | Reason |
|---|---|---|
| Font size | `rem` | Respects user browser settings, accessibility |
| Spacing (padding/margin) | `rem` or `em` | Scales proportionally to font size |
| Container width | `%`, `px` or `rem` for `max-width` | Fluid, responsive |
| Borders | `px` | Fixed, precise |
| Media queries | `em` | Cross-browser consistency |
| Line height | **Unitless number** | Prevents compound effects |
| Zero values | **No units** | `margin: 0` (not `0px`) |

```scss
// Correct
html {
  font-size: 100%; // 16px default
}

body {
  font-size: 1rem;
  line-height: 1.5; // unitless
}

h1 {
  font-size: 2.5rem;
  margin-bottom: 1rem;
}

.container {
  max-width: 1200px;
  width: 90%;
  padding: 0 1.5rem;
  margin: 0 auto;
}

// Incorrect — px for fonts (accessibility issue)
body {
  font-size: 16px;
}
```

### 7.1 SCSS Number Handling

```scss
// Adding units: multiplication
$value: 42;
$length: $value * 1px; // 42px

// Removing units: division
$raw-value: $length / 1px; // 42

// Wrap calculations in parentheses
.element {
  width: (100% / 3);
}
```

---

## 8. SCSS Nesting Rules

### 8.1 Maximum Depth

**Maximum 3 levels** (ideally 1-2 levels):

```scss
// Correct — 2 levels
.block {
  .block__element {
    color: #333;
  }
}

// Incorrect — 4 levels or more
.page {
  .content {
    .article {
      .title {
        color: #333;
      }
    }
  }
}
```

### 8.2 Allowed Nesting

```scss
.button {
  // Pseudo-classes/elements — allowed
  &:hover { }
  &:focus { }
  &::before { }
  &::after { }

  // State classes — allowed
  &.is-active { }
  &.is-disabled { }

  // Context overrides — allowed
  .no-js & { }
}
```

### 8.3 SCSS Ruleset Declaration Order

```scss
.component {
  // 1. Local variables
  $local-var: 10px;

  // 2. @extend statements (placeholders only)
  @extend %clearfix;

  // 3. @include statements (without @content)
  @include ellipsis;
  @include box-sizing(border-box);

  // 4. Standard CSS properties (in type group order)
  display: block;
  overflow: hidden;
  padding: $local-var;
  color: #333;

  // 5. Nested selectors (preceded by blank line)

  &:hover {
    color: #000;
  }

  &::before {
    content: '';
  }

  // 6. @include with @content (media queries)
  @include respond-to('medium') {
    overflow: visible;
  }
}
```

---

## 9. SCSS Variables

### 9.1 Naming

| Type | Pattern | Example |
|---|---|---|
| General variables | `$kebab-case` | `$font-size-base`, `$color-primary` |
| Constants | `$UPPER_SNAKE_CASE` | `$MAX_WIDTH`, `$CSS_POSITIONS` |
| Private variables | `$_kebab-case` | `$_column-width` |
| Flags/defaults | Use `!default` | `$baseline: 1em !default;` |

### 9.2 Variable Creation Criteria

Create variables only when **all** of the following conditions are met:
1. The value is repeated **at least 2 times**
2. The value is **likely to be updated**
3. All uses are **intentionally linked**

### 9.3 Map Usage

```scss
// Manage related values with Maps
$breakpoints: (
  'small': 576px,
  'medium': 768px,
  'large': 992px,
  'xlarge': 1200px,
);

$z-indexes: (
  'below': -1,
  'default': 1,
  'dropdown': 100,
  'sticky': 200,
  'header': 300,
  'overlay': 400,
  'modal': 500,
  'popover': 600,
  'tooltip': 700,
  'toast': 800,
);

// Getter function
@function z($layer) {
  @if not map-has-key($z-indexes, $layer) {
    @error 'No z-index found for `#{$layer}`.';
  }
  @return map-get($z-indexes, $layer);
}

// Usage
.modal {
  z-index: z('modal'); // 500
}
```

### 9.4 Map Formatting

```scss
// Trailing comma on the last item
$map: (
  'key1': value1,
  'key2': value2,
  'key3': value3,
);
```

---

## 10. Mixin / Function / Extend

### 10.1 Mixin

**Use for dynamic values or repeating patterns:**

```scss
@mixin respond-to($breakpoint) {
  $query: map-get($breakpoints, $breakpoint);
  @if $query {
    @media (min-width: $query) {
      @content;
    }
  } @else {
    @error 'No breakpoint found for `#{$breakpoint}`.';
  }
}

@mixin truncate {
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

@mixin size($width, $height: $width) {
  width: $width;
  height: $height;
}
```

### 10.2 Function

**Use when a computed return value is needed:**

```scss
@function em($pixels, $context: 16px) {
  @return ($pixels / $context) * 1em;
}

// Project prefix recommended
@function acme-grid-unit($n) {
  @return $n * $acme-column-width;
}
```

### 10.3 @extend

**Use sparingly.** Issues include unpredictable behavior, inability to cross media query boundaries, and source order disruption.

When you must use it, **only use `%placeholder`**:

```scss
// Correct — placeholder extend
%clearfix {
  &::after {
    content: '';
    display: table;
    clear: both;
  }
}

.container {
  @extend %clearfix;
}

// Incorrect — class extend
.foo {
  @extend .bar;
}
```

---

## 11. Media Queries

### 11.1 Mobile First

**Use `min-width` (mobile first) as the default approach:**

```scss
// Mobile base styles
.container {
  padding: 1rem;
}

// Progressive enhancement
@media (min-width: 768px) {
  .container {
    padding: 2rem;
  }
}

@media (min-width: 1024px) {
  .container {
    padding: 3rem;
    max-width: 1200px;
  }
}
```

### 11.2 Breakpoint Naming

```scss
// Correct — size-based names
$breakpoints: (
  'small': 576px,
  'medium': 768px,
  'large': 992px,
  'xlarge': 1200px,
);

// Incorrect — device-based names
$breakpoints: (
  'ipad': 768px,
  'iphone': 375px,
);
```

### 11.3 Inline Media Queries

**Write media queries inline alongside their components:**

```scss
// Correct — alongside component
.card {
  padding: 1rem;

  @include respond-to('medium') {
    padding: 2rem;
    display: flex;
  }
}

// Not recommended — separate media query blocks at the bottom of the file
@media (min-width: 768px) {
  .card { padding: 2rem; display: flex; }
  .header { height: 80px; }
}
```

---

## 12. Specificity Management

| Rule | Details |
|---|---|
| No ID selectors | Never use `#id` for styling |
| No unnecessary nesting | Minimize selector depth |
| No type qualification | Do not add tag selectors to classes |
| Specificity graph | Specificity should **gradually increase** toward the end of the stylesheet |

```scss
// Safely increasing specificity (when needed)
.site-nav.site-nav { } // double class usage

// When you must target an ID (e.g., third-party)
[id="third-party-widget"] { } // class-level specificity

// Zero-specificity selector (Modern CSS)
:where(.card) {
  padding: 1rem; // specificity: 0,0,0 — easily overridable
}
```

---

## 13. `!important` Rules

**Only proactive use is allowed, reactive use is prohibited:**

```scss
// Correct — utility classes (must always win)
.u-hidden {
  display: none !important;
}

.u-text-center {
  text-align: center !important;
}

// Incorrect — patching specificity issues
.header .nav .nav-item .link {
  color: blue;
}
// ... elsewhere:
.link {
  color: red !important; // Prohibited — fix the root cause instead
}
```

---

## 14. Shorthand Properties

### 14.1 Intentional Use

**Use shorthand only when setting all values:**

```scss
// Correct — intentionally setting all sides
padding: 0 1em 2em;
margin: 0 auto;
border: 1px solid #ddd;

// Incorrect — unintentionally resetting other properties
.foo {
  background: red; // resets background-image, background-position, etc.
}

// Correct — setting only the needed property
.foo {
  background-color: red;
}
```

### 14.2 Avoid font Shorthand

```scss
// Incorrect — resets font-style, font-variant, etc.
.bar {
  font: bold 16px/1.5 sans-serif;
}

// Correct — explicit
.bar {
  font-weight: 700;
  font-size: 1rem;
  line-height: 1.5;
}
```

---

## 15. Z-Index Management

**Use a centralized z-index scale** (refer to Section 9 Maps):

| Rule | Details |
|---|---|
| No arbitrary values | `z-index: 9999` and similar arbitrary values prohibited |
| Use Maps | Manage with `$z-indexes` Map + `z()` function |
| Consistent intervals | Increment by 100 |
| Documentation | Document all z-index usage locations |
| Stacking context | z-index is relative to the nearest stacking context — not global |

```scss
// Correct
.modal {
  z-index: z('modal');
}

// Incorrect
.modal {
  z-index: 99999;
}
```

---

## 16. Animation / Transition

### 16.1 Performance-Safe Properties

**Only animate GPU-accelerated properties:**

```scss
// Correct — compositor-only properties
.element {
  transition: transform 0.3s ease, opacity 0.3s ease;
}

.element:hover {
  transform: translateY(-4px) scale(1.02);
  opacity: 0.9;
}

// Incorrect — triggers layout recalculation
.element {
  transition: width 0.3s, height 0.3s, top 0.3s, left 0.3s;
}
```

### 16.2 `transition: all` Prohibited

```scss
// Incorrect
.element {
  transition: all 0.3s ease;
}

// Correct — specify properties
.element {
  transition: transform 0.3s ease, opacity 0.3s ease;
}
```

### 16.3 Easing Functions

| Purpose | Easing | Description |
|---|---|---|
| Entrance | `ease-out` | Deceleration |
| Exit | `ease-in` | Acceleration |
| State change | `ease-in-out` | Accelerate then decelerate |
| UI elements | `cubic-bezier(0.4, 0, 0.2, 1)` | Material Design standard |
| Prohibited | `linear` | Do not use for UI elements (mechanical feel) |

### 16.4 Accessibility: Reduced Motion Support

```scss
// Required: prefers-reduced-motion support
@media (prefers-reduced-motion: reduce) {
  *,
  *::before,
  *::after {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
    scroll-behavior: auto !important;
  }
}
```

### 16.5 will-change

```scss
// Use only on elements that will definitely animate
.element-about-to-animate {
  will-change: transform;
}

// Do not overuse — consumes memory
```

---

## 17. Comments

### 17.1 Section Comments

```scss
/* ==========================================================================
   Section Title
   ========================================================================== */

/* Sub-section
   ========================================================================== */
```

Or CSS Guidelines style:

```scss
/*------------------------------------*\
  #SECTION-TITLE
\*------------------------------------*/
```

### 17.2 SCSS Comments

```scss
// In SCSS, prefer line comments (//) — removed during compilation
// Block comments (/* */) are included in CSS output

// Write comments on a separate line above the target
// Avoid end-of-line comments

// Comments are required for non-obvious code:
// - Reason for z-index values
// - Browser-specific workarounds
// - Magic numbers
```

### 17.3 Documentation Comments (SassDoc)

```scss
/// Mixin to set the size of an element.
/// @param {Length} $width - Element width
/// @param {Length} $height [$width] - Element height
/// @example scss - Usage
///   .foo {
///     @include size(10em);
///   }
@mixin size($width, $height: $width) {
  width: $width;
  height: $height;
}
```

### 17.4 Numbered Comments

```scss
/**
 * 1. The masthead requires special contrast treatment.
 * 2. Reset white-space inherited from parent.
 */
.masthead {
  color: $color-masthead; /* [1] */
  white-space: normal; /* [2] */
}
```

---

## 18. File Structure (7-1 Pattern)

```
scss/
|-- abstracts/           # No CSS output
|   |-- _variables.scss
|   |-- _functions.scss
|   |-- _mixins.scss
|   |-- _placeholders.scss
|
|-- base/                # Reset, typography, base element styles
|   |-- _reset.scss
|   |-- _typography.scss
|   |-- _base.scss
|
|-- components/          # Micro level: buttons, cards, modals
|   |-- _button.scss
|   |-- _card.scss
|   |-- _dropdown.scss
|   |-- _modal.scss
|
|-- layout/              # Macro level: header, footer, grid
|   |-- _header.scss
|   |-- _footer.scss
|   |-- _sidebar.scss
|   |-- _grid.scss
|
|-- pages/               # Page-specific overrides
|   |-- _home.scss
|   |-- _contact.scss
|
|-- themes/              # Theme variations
|   |-- _default.scss
|   |-- _dark.scss
|
|-- vendors/             # Third-party CSS
|   |-- _normalize.scss
|
|-- main.scss            # Single entry point, imports only
```

### 18.1 main.scss Import Order

```scss
// abstracts (no output)
@import 'abstracts/variables';
@import 'abstracts/functions';
@import 'abstracts/mixins';

// vendors
@import 'vendors/normalize';

// base
@import 'base/reset';
@import 'base/typography';

// layout
@import 'layout/grid';
@import 'layout/header';
@import 'layout/footer';

// components
@import 'components/button';
@import 'components/card';
@import 'components/modal';

// pages
@import 'pages/home';

// themes
@import 'themes/default';
```

---

## 19. Prohibited Patterns

| Pattern | Reason | Alternative |
|---|---|---|
| `#id` selector | Excessive specificity | Use class selectors |
| `!important` (reactive) | Causes specificity wars | Improve selector structure |
| `transition: all` | Performance degradation, unintended property transitions | Specify individual properties |
| `@extend .class` | Unpredictable, disrupts source order | Use mixin or `%placeholder` |
| Color keywords | Non-standard, unclear | hex / hsl / rgb |
| `z-index: 9999` | Unmanageable | Map + getter function |
| 4+ level nesting | Increases specificity, reduces readability | Flatten with BEM |
| `font-size: px` | Accessibility issue | Use `rem` |
| `div.class` | Unnecessary specificity, reduces reusability | Use `.class` only |
| `*` overuse | Performance degradation | Explicit selectors |
| Magic numbers | Unmaintainable | Variables + comments |
| `width`/`height` animation | Triggers layout recalculation | Use `transform` |
| `.5em` (omitted leading zero) | Reduced readability | `0.5em` |

---

## 20. Stylelint Recommended Configuration

```json
{
  "extends": ["stylelint-config-standard-scss"],
  "plugins": ["stylelint-order"],
  "rules": {
    "color-no-invalid-hex": true,
    "declaration-block-no-duplicate-properties": true,
    "no-duplicate-selectors": true,
    "block-no-empty": true,
    "color-hex-length": "short",
    "max-nesting-depth": 3,
    "selector-max-specificity": "0,3,0",
    "selector-max-id": 0,
    "number-max-precision": 4,
    "property-no-vendor-prefix": true,
    "selector-no-vendor-prefix": true,
    "value-no-vendor-prefix": true,
    "no-descending-specificity": true,
    "declaration-no-important": true,
    "selector-no-qualifying-type": true,
    "order/properties-order": [
      "position", "top", "right", "bottom", "left", "z-index",
      "display", "flex-direction", "flex-wrap", "justify-content", "align-items",
      "overflow", "box-sizing", "width", "height", "padding", "border", "margin",
      "font-family", "font-size", "font-weight", "line-height", "color", "text-align",
      "background", "background-color", "border-radius", "box-shadow", "opacity",
      "transition", "animation", "cursor"
    ]
  }
}
```

---

## Key Metrics Summary

| Category | Rule | Value |
|---|---|---|
| Indentation | Space size | 2 |
| Line length | Maximum characters | 80 |
| Nesting | Maximum depth | 3 |
| Specificity | Maximum allowed | 0,3,0 |
| ID selectors | Maximum count | 0 |
| Decimal | Maximum digits | 4 |
| z-index | Base interval | 100 |
| Color hex | Format | Lowercase, shorthand |
| Zero value | Units | None |
| Leading zero | Notation | Required (`0.5`) |
| Font size | Unit | rem |
| Line height | Unit | None (number only) |
| Naming | Pattern | BEM (kebab-case) |
| File names | Pattern | kebab-case |
| Variables | Pattern | $kebab-case |
| Constants | Pattern | $UPPER_SNAKE_CASE |

---

## References

- [CSS Guidelines - Harry Roberts](https://cssguidelin.es/)
- [Sass Guidelines - Kitty Giraudel](https://sass-guidelin.es/)
- [Google HTML/CSS Style Guide](https://google.github.io/styleguide/htmlcssguide.html)
- [Airbnb CSS/Sass Styleguide](https://github.com/airbnb/css)
- [BEM Official](https://getbem.com/naming/)
- [SMACSS - Jonathan Snook](https://smacss.com/)
- [ITCSS - Harry Roberts](https://www.xfive.co/blog/itcss-scalable-maintainable-css-architecture/)
- [Idiomatic CSS - Nicolas Gallagher](https://github.com/necolas/idiomatic-css)
- [Stylelint](https://stylelint.io/)
- [stylelint-config-standard-scss](https://github.com/stylelint-scss/stylelint-config-standard-scss)
