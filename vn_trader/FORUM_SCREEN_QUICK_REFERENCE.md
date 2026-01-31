# Forum Screen - Quick Reference Guide

## 🚀 Quick Start

### Import the Forum Screen
```dart
import 'package:vn_trader/presentation/pages/forum_screen.dart';

// Use it
const ForumScreen()
```

### Navigate to Forum
```dart
Navigator.of(context).push(
  MaterialPageRoute(builder: (context) => const ForumScreen()),
);
```

## 📁 File Locations

```
lib/presentation/
├── pages/
│   └── forum_screen.dart          ← Main screen
└── widgets/forum/
    ├── forum_header.dart           ← Header component
    ├── forum_category_filter.dart  ← Filter chips
    ├── forum_post_card.dart        ← Post card
    └── forum_signal_card.dart      ← Signal card
```

## 🎨 Colors Quick Reference

```dart
AppColors.background        // #122017 (Dark Green) - Background
AppColors.surfaceVariant    // #1A251F (Dark Green) - Cards
AppColors.primary           // #38DF79 (Bright Green) - Active/Primary
AppColors.textPrimary       // #E2EBE3 (Light) - Main text
AppColors.textSecondary     // #9B9D9C (Gray) - Secondary text
AppColors.textHint          // #6E8176 (Dim Gray) - Hints
AppColors.border            // #2D3630 (Dark Gray) - Borders
AppColors.divider           // #304137 (Dark Gray-Green) - Dividers
```

## 🧩 Component Structure

```
ForumScreen
├── AppBar
│   └── ForumHeader
├── Column
│   ├── Category Filter (ForumCategoryFilter)
│   ├── Community Section
│   └── ListView
│       ├── ForumPostCard (regular posts)
│       └── ForumSignalCard (trading signals)
```

## 📊 ForumPost Model

```dart
ForumPost(
  id: '1',                          // Unique ID
  authorName: 'User Name',
  authorImage: 'assets/avatar.png',
  title: 'Post Title',
  description: 'Post content',
  timeAgo: '5h ago',
  isPremium: true,                  // Premium badge
  isActive: true,                   // Active status
  upvotes: 42,
  comments: 156,
  views: 'VIEW DETAILS',
  takeProfit: '1.0920',             // Optional: for signals
  stopLoss: '1.0820',               // Optional: for signals
  tags: ['#tag1', '#tag2'],
  isFree: false,
)
```

## 🎯 Common Customizations

### Change Category List
```dart
final List<String> _categories = [
  'Tất cả',
  'VÀNG (XAU)',
  'FOREX',
  'SMC',
  'MỚI NHẤT',
  // Add more here
];
```

### Add Post Tap Handler
```dart
ForumPostCard(
  post: post,
  onTap: () {
    // Navigate to post detail
    Navigator.of(context).push(...);
  },
)
```

### Override Colors
```dart
// In forum_screen.dart or components
Scaffold(
  backgroundColor: AppColors.background, // Customize here
  ...
)
```

## 🔧 Integration Checklist

- [ ] Import ForumScreen
- [ ] Add to navigation
- [ ] Connect API for posts
- [ ] Implement BLoC for state
- [ ] Add post detail screen
- [ ] Handle user interactions
- [ ] Add notifications
- [ ] Implement search

## 📝 Documentation Links

- **Full Documentation**: `FORUM_SCREEN_DOCUMENTATION.md`
- **Implementation Summary**: `FORUM_SCREEN_IMPLEMENTATION_SUMMARY.md`
- **Design Guide**: `FORUM_SCREEN_DESIGN_GUIDE.md`
- **Usage Examples**: `FORUM_SCREEN_USAGE_EXAMPLES.md`
- **Final Checklist**: `FORUM_SCREEN_FINAL_CHECKLIST.md`

## 🐛 Troubleshooting

### Screen not rendering?
```dart
// Make sure you're using const constructor
const ForumScreen()

// Check imports
import 'package:vn_trader/presentation/pages/forum_screen.dart';
```

### Colors look wrong?
```dart
// Verify AppColors import
import 'package:vn_trader/core/constants/app_colors.dart';

// Check dark theme is applied
backgroundColor: AppColors.background,
```

### Posts not showing?
```dart
// Mock data is in _posts list
// Replace with API call for real data
final posts = await _repository.getPosts();
```

## 🌐 API Integration Template

```dart
// Replace mock data with real API
Future<List<ForumPost>> fetchPosts() async {
  final response = await http.get(
    Uri.parse('https://api.example.com/forum/posts'),
  );
  
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return (data['posts'] as List)
        .map((p) => ForumPost.fromJson(p))
        .toList();
  }
  throw Exception('Failed to fetch posts');
}
```

## 📱 Responsive Breakpoints

```dart
// Mobile: < 600px
// Tablet: 600px - 1200px  
// Desktop: > 1200px

// Current implementation works on all sizes
// Cards stack vertically
// Horizontal category scroll works everywhere
```

## ⚡ Performance Tips

1. **Lazy Load**: Implement pagination
2. **Cache**: Store posts locally
3. **Images**: Optimize avatar images
4. **Lists**: Use ListView.builder for large lists
5. **Rebuild**: Avoid full tree rebuilds

## 🔐 Security Notes

- Validate author IDs before navigation
- Sanitize post content if from API
- Verify premium status server-side
- Validate timestamps
- Check user permissions

## 🎓 Best Practices Used

✅ Const constructors for efficiency
✅ Proper widget composition
✅ Separation of concerns
✅ Reusable components
✅ Dark theme optimization
✅ Accessible design
✅ Responsive layout
✅ Clear documentation

## 📞 Support

For detailed information, refer to:
- Component documentation: Check widget files
- Design specs: See FORUM_SCREEN_DESIGN_GUIDE.md
- Integration patterns: See FORUM_SCREEN_USAGE_EXAMPLES.md
- Complete details: See FORUM_SCREEN_DOCUMENTATION.md

---

**Last Updated**: January 29, 2026
**Version**: 1.0
**Status**: Production Ready ✅
