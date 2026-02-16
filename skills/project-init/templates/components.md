# Component Style Guide

> DSA customizes this for the project.
> AI references this guide when generating UI.

## 1. Button

### Variants
| Variant | Usage | Background | Text |
|---------|-------|------------|------|
| Primary | Main actions (Save, Confirm) | `--color-primary-600` | `--color-text-inverse` |
| Secondary | Secondary actions (Cancel, Go back) | transparent, border | `--color-text-primary` |
| Danger | Delete, dangerous actions | `--color-error-600` | `--color-text-inverse` |
| Ghost | Text button | transparent | `--color-primary-600` |

### Sizes
| Size | Height | Padding | Font Size |
|------|--------|---------|-----------|
| sm | 32px | `--spacing-2` `--spacing-3` | `--font-size-sm` |
| md | 40px | `--spacing-2` `--spacing-4` | `--font-size-base` |
| lg | 48px | `--spacing-3` `--spacing-6` | `--font-size-lg` |

### States
- **Hover**: Background color one shade darker (e.g., 600 → 700)
- **Active**: Background color two shades darker (e.g., 600 → 800)
- **Disabled**: opacity 0.5, cursor: not-allowed
- **Loading**: Spinner icon + text preserved

### Icons
- Icons are placed to the left of text (default)
- Spacing between icon and text: `--spacing-2`
- Icon-only button: Square, same height/width

## 2. Input Field

### Base Style
- Height: 40px (md)
- Padding: `--spacing-2` `--spacing-3`
- Border: `--border-width-default` `--color-border-default`
- Border radius: `--radius-md`
- Focus: `--color-primary-500` border + ring

### Label
- Position: Above the input field
- Spacing: `--spacing-1`
- Font: `--font-size-sm` `--font-weight-medium`

### Error State
- Border: `--color-error-500`
- Error message: `--font-size-sm` `--color-error-500`
- Error message spacing: `--spacing-1`

### Helper Text
- Font: `--font-size-sm` `--color-text-tertiary`
- Spacing: `--spacing-1`

## 3. Card

### Base Style
- Background: `--color-bg-primary`
- Border: `--border-width-default` `--color-border-default`
- Border radius: `--radius-lg`
- Shadow: `--shadow-sm`
- Padding: `--spacing-6`

### Variants
| Variant | Shadow | Hover |
|---------|--------|-------|
| Default | `--shadow-sm` | None |
| Elevated | `--shadow-md` | `--shadow-lg` |
| Outlined | None, border only | Border highlighted |
| Interactive | `--shadow-sm` | `--shadow-md` + translateY(-1px) |

## 4. Modal

### Base Style
- Backdrop: rgba(0, 0, 0, 0.5)
- Modal: `--color-bg-primary`, `--radius-xl`, `--shadow-xl`
- Max width: 480px (sm), 640px (md), 800px (lg)
- Padding: `--spacing-6`

### Structure
```
┌─────────────────────────────┐
│ Header (Title + Close button) │
├─────────────────────────────┤
│                             │
│ Body (Scrollable)           │
│                             │
├─────────────────────────────┤
│ Footer (Action buttons)     │
└─────────────────────────────┘
```

- Header: `--font-size-xl` `--font-weight-semibold`
- Section dividers: `--color-border-default`
- Footer buttons: Right-aligned, spacing `--spacing-3`

## 5. Table

### Base Style
- Header: `--color-bg-secondary`, `--font-weight-semibold`, `--font-size-sm`
- Row: `--color-bg-primary`, on hover `--color-bg-secondary`
- Cell padding: `--spacing-3` `--spacing-4`
- Border: Bottom only, `--color-border-default`

### Responsive
- Mobile: Horizontal scroll or convert to card layout
- Tablet+: Default table layout

## 6. Navigation

### GNB (Global Navigation Bar)
- Height: 64px
- Background: `--color-bg-primary`
- Bottom border: `--color-border-default`
- z-index: `--z-sticky`
- Logo: Left, Menu: Center or Left, User menu: Right

### Sidebar
- Width: 240px (expanded), 64px (collapsed)
- Background: `--color-bg-secondary`
- Menu item height: 40px
- Active state: `--color-primary-50` background + `--color-primary-600` text

### Tabs
- Bottom indicator: `--color-primary-600`, 2px
- Tab spacing: `--spacing-6`
- Inactive: `--color-text-tertiary`
- Active: `--color-text-primary`

## 7. Toast/Alert

### Variants
| Variant | Left Color | Icon |
|---------|-----------|------|
| Success | `--color-success-500` | Checkmark |
| Warning | `--color-warning-500` | Warning triangle |
| Error | `--color-error-500` | X circle |
| Info | `--color-info-500` | i circle |

### Toast Position
- Default: Top-right
- z-index: `--z-toast`
- Auto-dismiss: 5 seconds

## 8. Badge/Tag

### Sizes
| Size | Height | Font Size | Padding |
|------|--------|-----------|---------|
| sm | 20px | `--font-size-xs` | `--spacing-1` `--spacing-2` |
| md | 24px | `--font-size-sm` | `--spacing-1` `--spacing-2` |

### Colors
- Status badges: Use Semantic colors
- Category tags: Use Primary color variants

---

> **DSA Checkpoint**: Verify that each component in this guide aligns with the project branding.
> If needed, adjust the token values in design-tokens.css first, then update this guide.
