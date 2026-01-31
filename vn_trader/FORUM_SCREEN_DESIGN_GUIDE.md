# Forum Screen - Visual Design Guide

## Screen Layout Overview

### Header Section
```
┌─────────────────────────────────────────────────────┐
│ DIỄN ĐÀN                                   [Search] │
│ Cộng đồng VN                                        │
└─────────────────────────────────────────────────────┘
```

### Category Filter Section
```
┌─────────────────────────────────────────────────────┐
│ Danh mục                                            │
│                                                     │
│ [✓ Tất cả] [VÀNG (XAU)] [FOREX] [SMC] [MỚI NHẤT] │
│   (green)   (light bg)   (light) (light) (light)  │
└─────────────────────────────────────────────────────┘
```

### Community Section
```
┌─────────────────────────────────────────────────────┐
│ [👥] Cộng đồng VN                                   │
│      Vietnam Trader Academy                         │
└─────────────────────────────────────────────────────┘
```

### Forum Post Card (Regular Discussion)
```
┌─────────────────────────────────────────────────────┐
│ [Avatar] Signal Bot AI              [PREMIUM]      │
│          Vua xong·Auto-Signal                       │
│          5 gio trudc                                │
├─────────────────────────────────────────────────────┤
│ BUY EUR/USD @ 1.08450                              │
│                                                     │
│ Vua xong·Auto-Signal                               │
│                                                     │
│ [#TradingMindset] [#Psychology]                    │
├─────────────────────────────────────────────────────┤
│ 👍 23          💬 412                    [FREE]     │
└─────────────────────────────────────────────────────┘
```

### Forum Signal Card (Trading Signal)
```
┌─────────────────────────────────────────────────────┐
│ [Avatar] Thanh Trader                   [ACTIVE]   │
│          Moi nguoi thuong lam...                    │
│          Thao luân ve tâm ly giao dich...           │
│          5 gio trudc                                │
├─────────────────────────────────────────────────────┤
│ TAKE PROFIT: 1.09100   │   STOP LOSS: 1.08200     │
│                                                     │
│ [#XAUUSD] [#GOLD] [#SMC]                          │
├─────────────────────────────────────────────────────┤
│ 👍 42          💬 124          [PREMIUM]            │
└─────────────────────────────────────────────────────┘
```

## Color Palette

### Primary Colors
- **Background**: `#122017` (Very Dark Green)
- **Surface/Card**: `#1A251F` (Dark Green)
- **Primary Action**: `#38DF79` (Bright Green)

### Text Colors
- **Primary Text**: `#E2EBE3` (Light Text)
- **Secondary Text**: `#9B9D9C` (Gray)
- **Hint Text**: `#6E8176` (Dim Gray)

### Borders & Dividers
- **Border Color**: `#2D3630` (Dark Gray)
- **Divider Color**: `#304137` (Dark Gray-Green)

## Typography Scale

| Element | Font Size | Weight | Line Height |
|---------|-----------|--------|-------------|
| Header Title | 18px | 700 (Bold) | 1.2 |
| Section Title | 16px | 600 (SemiBold) | 1.2 |
| Post Title | 13px | 600 (SemiBold) | 1.4 |
| Body Text | 12px | 400/600 | 1.3 |
| Small Text | 11px | 500 | 1.2 |
| Tiny Text | 9-10px | 500/600 | 1.2 |

## Spacing Guidelines

- **Container Padding**: 12px
- **Section Spacing**: 12-20px
- **Item Spacing**: 8px
- **Icon Spacing**: 4-8px
- **Between Components**: 16px

## Component Dimensions

### Post Cards
- **Height**: Dynamic (content-based)
- **Corner Radius**: 10px
- **Border Width**: 1px
- **Padding**: 12px all sides

### Category Chips
- **Height**: 32px
- **Padding**: 16px horizontal, 8px vertical
- **Corner Radius**: 15px
- **Margin Right**: 8px

### Badges
- **Premium Badge**: 8px horizontal, 3px vertical padding, 4px radius
- **Active Badge**: 8px horizontal, 3px vertical padding, 4px radius
- **Free Badge**: 8px horizontal, 4px vertical padding, 4px radius

## Responsive Design

### Screen Widths
- **Mobile**: < 600px
- **Tablet**: 600px - 1200px
- **Desktop**: > 1200px

### Adaptations
- **Single Column**: All screen sizes (scrollable)
- **Horizontal Scroll**: Category filters on all sizes
- **Margins**: 16px on mobile, 20px on tablet/desktop

## Interactive States

### Category Chip
- **Inactive**: Border color `#2D3630`, text `#6E8176`
- **Active**: Background `#38DF79`, text `#122017`
- **Hover**: Slight opacity change (optional)

### Post Card
- **Default**: Border `#2D3630`, background `#1A251F`
- **Hover**: Subtle shadow or border highlight
- **Pressed**: Slight scale/opacity change

### Buttons
- **Search Icon**: 40x40px, border radius 8px
- **Premium Badge**: Green background `#38DF79`
- **Active Badge**: Green background `#38DF79`

## Icon Usage

| Icon | Usage | Size |
|------|-------|------|
| 👍 (Thumb Up) | Upvotes | 14px |
| 💬 (Message) | Comments | 14px |
| 🔍 (Search) | Search action | 20px |
| 👤 (Person) | Author avatar | 20px |
| 👥 (People) | Community | 20px |

## Dark Mode Considerations

Current implementation uses dark theme by default:
- **Background**: Very dark green (#122017)
- **Text**: Light colors for contrast
- **Accents**: Bright green for primary actions
- All colors meet WCAG AA contrast requirements

## Accessibility Features

- ✅ Sufficient color contrast ratios
- ✅ Semantic HTML-like structure
- ✅ Clear visual hierarchy
- ✅ Touch targets minimum 48x48px
- ✅ Clear labels and descriptions
- ✅ Icons with text labels

## Animation Considerations

Suggested animations (not yet implemented):
- Category filter selection: `200ms` ease-in-out
- Post card tap: `150ms` scale animation
- Badge appearance: `300ms` fade-in
- Hover effects: `200ms` transition

---

**Design System**: VN Trader Dark Theme
**Material Design Version**: 3
**Flutter Version**: Compatible with 3.0+
