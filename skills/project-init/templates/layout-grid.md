# Layout Grid System

> DSA customizes this for the project.
> AI references this guide when generating layouts.

## 1. Breakpoints

| Name | Range | Environment |
|------|-------|-------------|
| Mobile | ~767px | Smartphones |
| Tablet | 768px ~ 1023px | Tablets, small laptops |
| Desktop | 1024px ~ | Desktops, large laptops |

```css
/* Media query usage (Mobile First) */
/* Default: Mobile */
@media (min-width: 768px) { /* Tablet+ */ }
@media (min-width: 1024px) { /* Desktop+ */ }
```

## 2. Container

| Breakpoint | Max Width | Horizontal Padding |
|------------|-----------|-------------------|
| Mobile | 100% | `--spacing-4` (16px) |
| Tablet | 100% | `--spacing-6` (24px) |
| Desktop | 1200px | `--spacing-8` (32px) |

```css
.container {
  width: 100%;
  max-width: 1200px;
  margin: 0 auto;
  padding-left: var(--spacing-4);
  padding-right: var(--spacing-4);
}

@media (min-width: 768px) {
  .container {
    padding-left: var(--spacing-6);
    padding-right: var(--spacing-6);
  }
}

@media (min-width: 1024px) {
  .container {
    padding-left: var(--spacing-8);
    padding-right: var(--spacing-8);
  }
}
```

## 3. Grid System

### 12-Column Grid

| Breakpoint | Columns | Gutter |
|------------|---------|--------|
| Mobile | 4 | `--spacing-4` (16px) |
| Tablet | 8 | `--spacing-6` (24px) |
| Desktop | 12 | `--spacing-6` (24px) |

### Common Layout Patterns

```
[Desktop 12-column]

1. Full width
┌──────────────────────────────────────────────────┐
│                    12 columns                     │
└──────────────────────────────────────────────────┘

2. Two-panel (Sidebar + Content)
┌────────────┬─────────────────────────────────────┐
│  3 columns │              9 columns               │
│  Sidebar   │              Main Content             │
└────────────┴─────────────────────────────────────┘

3. Three-panel
┌──────────────┬──────────────┬──────────────┐
│   4 columns  │   4 columns  │   4 columns  │
└──────────────┴──────────────┴──────────────┘

4. Dashboard (3+3+6)
┌───────┬───────┬──────────────────────────────┐
│ 3 col │ 3 col │          6 columns            │
└───────┴───────┴──────────────────────────────┘

[Tablet 8-column]
- Sidebar: Collapsed (64px) or overlay
- Cards: 2 columns (4 columns each)

[Mobile 4-column]
- All elements: Full width (4 columns)
- Sidebar: Hamburger menu → overlay
- Cards: 1 column (4 columns)
```

## 4. Page Layout

### Base Page Structure

```
┌─────────────────────────────────────────────┐
│                  GNB (64px)                  │
├──────────┬──────────────────────────────────┤
│          │         Page Header              │
│  Sidebar │──────────────────────────────────│
│  (240px) │                                  │
│          │         Main Content             │
│          │                                  │
│          │                                  │
│          │──────────────────────────────────│
│          │         Footer (Optional)         │
├──────────┴──────────────────────────────────┤
```

### Spacing Rules

| Element | Spacing |
|---------|---------|
| GNB ↔ Content | 0 (padding-top: 64px when GNB is fixed) |
| Page Header ↔ Main Content | `--spacing-6` |
| Section ↔ Section | `--spacing-8` ~ `--spacing-12` |
| Card ↔ Card | `--spacing-4` ~ `--spacing-6` |
| Label ↔ Input field | `--spacing-1` |
| Form field ↔ Form field | `--spacing-4` |

## 5. Responsive Behavior Summary

| Element | Mobile | Tablet | Desktop |
|---------|--------|--------|---------|
| GNB | Hamburger menu | Icon + text | Full |
| Sidebar | Overlay | Collapsed (64px) | Expanded (240px) |
| Card grid | 1 column | 2 columns | 3~4 columns |
| Table | Card conversion | Horizontal scroll | Full |
| Modal | Full screen | 640px centered | 640px centered |
| Form | 1 column | 2 columns | 2 columns |

---

> **DSA Checkpoint**: Verify that this grid system is suitable for the project's page composition.
> Dashboard-centric projects may require a more flexible grid.
