# Admin Dashboard - Implementation Guide

## Overview
The Admin Dashboard provides a comprehensive overview of the application's metrics, user activities, and quick access to administrative functions. It features a modern dark-themed UI with statistics cards, revenue charts, quick action buttons, and recent activity logs.

## Screenshots Reference
The dashboard design is based on the provided screenshot featuring:
- Dark green background theme
- Stats cards showing Total Users and Premium subscriptions
- Weekly revenue chart with trend visualization
- Quick action cards for common admin tasks
- Recent activity feed

## File Structure

```
lib/
├── presentation/
│   ├── pages/
│   │   └── admin_dashboard.dart          # Main dashboard page
│   └── widgets/
│       └── admin/
│           ├── stats_card_widget.dart    # Stat card component
│           ├── revenue_chart_widget.dart # Revenue chart with line graph
│           ├── quick_action_card.dart    # Quick action button cards
│           └── activity_item.dart        # Activity list item
```

## Components

### 1. AdminDashboard (Main Page)
**Location:** `lib/presentation/pages/admin_dashboard.dart`

The main dashboard page that orchestrates all components.

**Features:**
- Custom AppBar with logo, title, and notification bell
- Responsive layout with SingleChildScrollView
- Dark theme with gradient backgrounds
- Four main sections: Stats, Revenue, Quick Actions, Recent Activity

**Usage:**
```dart
// Navigate to admin dashboard
context.push('/admin-dashboard');
```

### 2. StatsCardWidget
**Location:** `lib/presentation/widgets/admin/stats_card_widget.dart`

Displays key metrics with an icon, value, and percentage change.

**Properties:**
- `title` (String): Card title (e.g., "Total Users")
- `value` (String): Main metric value (e.g., "12,450")
- `percentage` (String): Change percentage (e.g., "+6.2%")
- `icon` (IconData): Display icon
- `isPositive` (bool): Determines arrow direction (default: true)

**Example:**
```dart
StatsCardWidget(
  title: 'Total Users',
  value: '12,450',
  percentage: '+6.2%',
  icon: Icons.people,
  isPositive: true,
)
```

### 3. RevenueChartWidget
**Location:** `lib/presentation/widgets/admin/revenue_chart_widget.dart`

Displays a weekly revenue chart with a custom-painted line graph.

**Features:**
- Smooth curved line graph
- Gradient fill under the curve
- Weekly day labels (M, T, W, T, F, S, S)
- Revenue value and percentage change display
- Custom painter for dynamic rendering

**Example:**
```dart
const RevenueChartWidget()
```

**Customization:**
To modify the chart data, edit the `points` array in the `_ChartPainter` class:
```dart
final points = [
  Offset(0, size.height * 0.6),
  Offset(size.width * 0.14, size.height * 0.3),
  // ... more points
];
```

### 4. QuickActionCard
**Location:** `lib/presentation/widgets/admin/quick_action_card.dart`

Interactive card for quick access to admin functions.

**Properties:**
- `icon` (IconData): Action icon
- `iconColor` (Color): Icon color
- `iconBgColor` (Color): Icon background color
- `title` (String): Action title
- `subtitle` (String): Action description
- `onTap` (VoidCallback?): Tap handler

**Example:**
```dart
QuickActionCard(
  icon: Icons.people_outline,
  iconColor: const Color(0xFF5B8CFF),
  iconBgColor: const Color(0xFF5B8CFF).withValues(alpha: 0.15),
  title: 'Manage Users',
  subtitle: 'Add & Permissions',
  onTap: () {
    // Navigate to user management
    context.push('/manage-users');
  },
)
```

### 5. ActivityItem
**Location:** `lib/presentation/widgets/admin/activity_item.dart`

Displays a recent activity log entry.

**Properties:**
- `icon` (IconData): Activity icon
- `iconBgColor` (Color): Icon background color
- `iconColor` (Color): Icon color
- `title` (String): Activity title
- `subtitle` (String): Activity description
- `timeAgo` (String): Time since activity (e.g., "2m ago")

**Example:**
```dart
ActivityItem(
  icon: Icons.shopping_cart,
  iconBgColor: AppColors.primary.withValues(alpha: 0.15),
  iconColor: AppColors.primary,
  title: 'New Premium Subscription',
  subtitle: 'user@email.com subscribed',
  timeAgo: '2m ago',
)
```

## Color Scheme

The dashboard uses the app's existing color palette from `AppColors`:

```dart
// Primary colors
AppColors.primary         // #38DF79 (Green)
AppColors.background      // #122017 (Dark green background)
AppColors.backgroundDark  // #0F1A14 (Darker green)

// Text colors
AppColors.textPrimary     // #E2EBE3 (Light text)
AppColors.textSecondary   // #9B9D9C (Secondary text)
AppColors.textHint        // #6E8176 (Hint text)

// Surface colors
AppColors.surfaceVariant  // #1B251F (Card background)
AppColors.border          // #2D3630 (Border color)

// Additional colors for Quick Actions
Color(0xFF5B8CFF)        // Blue (Manage Users)
Color(0xFFFFAB40)        // Orange (Content)
Color(0xFFAB7AFF)        // Purple (Reports)
```

## Routing

The admin dashboard is accessible via the `/admin-dashboard` route.

**Configuration:** `lib/core/router/app_router.dart`

```dart
GoRoute(
  path: '/admin-dashboard',
  builder: (context, state) => const AdminDashboard(),
),
```

## Customization Guide

### Adding New Stats Cards
1. Add a new `StatsCardWidget` in the Row:
```dart
Expanded(
  child: StatsCardWidget(
    title: 'Active Sessions',
    value: '842',
    percentage: '+15.3%',
    icon: Icons.online_prediction,
    isPositive: true,
  ),
)
```

### Adding New Quick Actions
1. Add a new `QuickActionCard` in the GridView:
```dart
QuickActionCard(
  icon: Icons.settings,
  iconColor: const Color(0xFFFF6B6B),
  iconBgColor: const Color(0xFFFF6B6B).withValues(alpha: 0.15),
  title: 'Settings',
  subtitle: 'App Configuration',
  onTap: () => context.push('/settings'),
)
```

### Updating Chart Data
To connect real data to the revenue chart:
1. Create a state management solution (BLoC recommended)
2. Pass data points to `RevenueChartWidget`
3. Modify `_ChartPainter` to accept dynamic data

Example with dynamic data:
```dart
class RevenueChartWidget extends StatelessWidget {
  final List<double> dataPoints;
  final String revenue;
  final String percentage;
  
  const RevenueChartWidget({
    super.key,
    required this.dataPoints,
    required this.revenue,
    required this.percentage,
  });
  
  // ... rest of implementation
}
```

### Adding Activity Logs
To display real-time activities:
1. Create an activity stream/list in your BLoC
2. Use `ListView.builder` instead of fixed ActivityItem widgets:

```dart
BlocBuilder<AdminBloc, AdminState>(
  builder: (context, state) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: state.activities.length,
      itemBuilder: (context, index) {
        final activity = state.activities[index];
        return ActivityItem(
          icon: activity.icon,
          iconBgColor: activity.iconBgColor,
          iconColor: activity.iconColor,
          title: activity.title,
          subtitle: activity.subtitle,
          timeAgo: activity.timeAgo,
        );
      },
    );
  },
)
```

## BLoC Integration (Recommended)

For dynamic data and state management, create an AdminDashboardBloc:

```dart
// lib/presentation/bloc/admin_dashboard/admin_dashboard_bloc.dart

class AdminDashboardBloc extends Bloc<AdminDashboardEvent, AdminDashboardState> {
  AdminDashboardBloc() : super(AdminDashboardInitial()) {
    on<LoadDashboardData>(_onLoadDashboardData);
    on<RefreshDashboard>(_onRefreshDashboard);
  }

  Future<void> _onLoadDashboardData(
    LoadDashboardData event,
    Emitter<AdminDashboardState> emit,
  ) async {
    emit(AdminDashboardLoading());
    try {
      // Fetch data from repository
      final stats = await _repository.getStats();
      final revenue = await _repository.getRevenueData();
      final activities = await _repository.getRecentActivities();
      
      emit(AdminDashboardLoaded(
        stats: stats,
        revenue: revenue,
        activities: activities,
      ));
    } catch (e) {
      emit(AdminDashboardError(e.toString()));
    }
  }
}
```

## Best Practices

1. **Use BLoC for State Management**: Keep the UI pure and move data fetching to BLoC
2. **Responsive Design**: Test on different screen sizes
3. **Loading States**: Show loading indicators while fetching data
4. **Error Handling**: Display error messages gracefully
5. **Refresh Mechanism**: Implement pull-to-refresh for live data
6. **Caching**: Cache dashboard data to reduce API calls
7. **Permissions**: Check admin privileges before showing the dashboard

## Testing

Create widget tests for dashboard components:

```dart
// test/presentation/widgets/admin/stats_card_widget_test.dart

void main() {
  testWidgets('StatsCardWidget displays correct information', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StatsCardWidget(
            title: 'Test Users',
            value: '100',
            percentage: '+5%',
            icon: Icons.people,
            isPositive: true,
          ),
        ),
      ),
    );

    expect(find.text('Test Users'), findsOneWidget);
    expect(find.text('100'), findsOneWidget);
    expect(find.text('+5%'), findsOneWidget);
  });
}
```

## Navigation Examples

### From Profile Screen (Admin Only)
```dart
if (userProfile?.isAdmin ?? false) {
  ActionTile(
    icon: Icons.dashboard,
    title: 'Admin Dashboard',
    onTap: () => context.push('/admin-dashboard'),
  ),
}
```

### From Bottom Navigation
```dart
NavigationDestination(
  icon: const Icon(Icons.admin_panel_settings),
  label: 'Admin',
  onTap: () => context.push('/admin-dashboard'),
)
```

## Future Enhancements

Potential features to add:
- [ ] Real-time data updates via WebSocket
- [ ] Interactive chart with zoom/pan
- [ ] Export data to CSV/PDF
- [ ] Customizable dashboard layouts
- [ ] Dark/Light theme toggle
- [ ] Advanced filtering options
- [ ] Push notifications for critical events
- [ ] User analytics and insights
- [ ] Revenue forecasting
- [ ] Comparison with previous periods

## Troubleshooting

### Chart not displaying correctly
- Ensure CustomPaint has a defined size
- Check that data points are within valid range (0-1)

### Cards not responsive
- Verify Expanded/Flexible widgets are used correctly
- Check padding and constraints

### Navigation not working
- Ensure route is registered in `app_router.dart`
- Verify AdminDashboard is exported in pages index

## Support

For issues or questions, refer to:
- Project documentation in `PROJECT_STRUCTURE.md`
- BLoC guide in `BLOC_GUIDE.md`
- Color constants in `lib/core/constants/app_colors.dart`
