# Forum Screen - Usage Examples

## Basic Navigation

### From a Navigation Menu
```dart
// In your navigation or tab bar
void navigateToForum(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => const ForumScreen(),
    ),
  );
}
```

### In a Bottom Navigation Bar
```dart
import 'package:vn_trader/presentation/pages/forum_screen.dart';

class MainApp extends StatefulWidget {
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomePage(),
    const ForumScreen(), // Add here
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() => _selectedIndex = index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum),
            label: 'Forum', // Add this
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
```

## Customization Examples

### Custom Theme Adaptation
```dart
// If you want to override colors in the forum screen
class ThemedForumScreen extends StatelessWidget {
  final Color primaryColor;
  final Color backgroundColor;

  const ThemedForumScreen({
    this.primaryColor = AppColors.primary,
    this.backgroundColor = AppColors.background,
  });

  @override
  Widget build(BuildContext context) {
    // You can theme the ForumScreen by wrapping it
    // or modifying AppColors
    return const ForumScreen();
  }
}
```

### Extended Forum Screen with Additional Features
```dart
class ExtendedForumScreen extends ForumScreen {
  const ExtendedForumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Forum'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showNewPostDialog(context),
          ),
        ],
      ),
      body: super.build(context),
    );
  }

  void _showNewPostDialog(BuildContext context) {
    // Implement new post creation
  }
}
```

## Integration with BLoC Pattern

### Setting up BLoC for Forum
```dart
// Create a ForumBloc
class ForumBloc extends Bloc<ForumEvent, ForumState> {
  final ForumRepository _repository;

  ForumBloc(this._repository) : super(const ForumInitial()) {
    on<FetchForumPostsEvent>(_onFetchPosts);
    on<FilterForumPostsEvent>(_onFilterPosts);
    on<SelectCategoryEvent>(_onSelectCategory);
  }

  Future<void> _onFetchPosts(
    FetchForumPostsEvent event,
    Emitter<ForumState> emit,
  ) async {
    emit(const ForumLoading());
    try {
      final posts = await _repository.getPosts();
      emit(ForumLoaded(posts));
    } catch (e) {
      emit(ForumError(e.toString()));
    }
  }
}

// Use in screen
class ForumScreenWithBLoC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForumBloc(repository)
        ..add(const FetchForumPostsEvent()),
      child: const ForumScreen(),
    );
  }
}
```

## Data Fetching Example

### Repository Pattern
```dart
class ForumRepository {
  final ForumRemoteDataSource remoteDataSource;
  final ForumLocalDataSource localDataSource;

  ForumRepository({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  Future<List<ForumPost>> getPosts({
    String? category,
    int page = 1,
  }) async {
    try {
      // Try remote first
      final remotePosts = await remoteDataSource.getPosts(
        category: category,
        page: page,
      );

      // Cache locally
      await localDataSource.cachePosts(remotePosts);

      return remotePosts;
    } catch (e) {
      // Fall back to local
      return await localDataSource.getCachedPosts();
    }
  }
}
```

### API Service Example
```dart
class ForumApiService {
  final Dio _dio;

  ForumApiService(this._dio);

  Future<List<Map<String, dynamic>>> fetchPosts({
    String? category,
    int page = 1,
    int pageSize = 10,
  }) async {
    try {
      final response = await _dio.get(
        '/forum/posts',
        queryParameters: {
          if (category != null) 'category': category,
          'page': page,
          'pageSize': pageSize,
        },
      );

      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(response.data['posts']);
      }
      throw Exception('Failed to fetch posts');
    } on DioException catch (e) {
      throw Exception('API Error: ${e.message}');
    }
  }
}
```

## Handling Post Actions

### Like/Upvote Implementation
```dart
Future<void> _likePost(String postId) async {
  try {
    await _forumRepository.likePost(postId);
    // Update UI
    setState(() {
      // Update post likes count
    });
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  }
}
```

### Post Navigation
```dart
void _navigateToPostDetail(ForumPost post) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => ForumPostDetailScreen(post: post),
    ),
  );
}
```

### Author Profile Navigation
```dart
void _navigateToAuthorProfile(String authorId) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => UserProfileScreen(userId: authorId),
    ),
  );
}
```

## Testing Examples

### Unit Test for ForumPost Model
```dart
void main() {
  group('ForumPost', () {
    test('ForumPost equality', () {
      final post1 = ForumPost(
        id: '1',
        authorName: 'Test User',
        authorImage: 'avatar.png',
        title: 'Test Post',
        description: 'Test Description',
        timeAgo: '1h ago',
        isPremium: false,
        isActive: true,
        upvotes: 10,
        comments: 5,
        views: 'View Details',
        tags: ['#test'],
        isFree: true,
      );

      final post2 = ForumPost(
        id: '1',
        authorName: 'Test User',
        authorImage: 'avatar.png',
        title: 'Test Post',
        description: 'Test Description',
        timeAgo: '1h ago',
        isPremium: false,
        isActive: true,
        upvotes: 10,
        comments: 5,
        views: 'View Details',
        tags: ['#test'],
        isFree: true,
      );

      expect(post1.id, equals(post2.id));
    });
  });
}
```

### Widget Test
```dart
void main() {
  testWidgets('ForumScreen renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ForumScreen(),
      ),
    );

    // Verify header is displayed
    expect(find.byType(ForumHeader), findsOneWidget);

    // Verify category filter is displayed
    expect(find.byType(ForumCategoryFilter), findsOneWidget);

    // Verify posts are displayed
    expect(find.byType(ForumPostCard), findsWidgets);
  });
}
```

## Performance Optimization

### Lazy Loading Implementation
```dart
class ForumScreenOptimized extends StatefulWidget {
  const ForumScreenOptimized();

  @override
  State<ForumScreenOptimized> createState() => _ForumScreenOptimizedState();
}

class _ForumScreenOptimizedState extends State<ForumScreenOptimized> {
  late ScrollController _scrollController;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMorePosts();
    }
  }

  Future<void> _loadMorePosts() async {
    if (_isLoadingMore) return;

    setState(() => _isLoadingMore = true);
    try {
      // Fetch more posts
      await _repository.getMorePosts();
    } finally {
      setState(() => _isLoadingMore = false);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const ForumScreen();
  }
}
```

## Error Handling

### Try-Catch Wrapper
```dart
Future<void> _safeOperation(Future<void> Function() operation) async {
  try {
    await operation();
  } on NetworkException catch (e) {
    _showErrorSnackBar('Network Error: ${e.message}');
  } on ServerException catch (e) {
    _showErrorSnackBar('Server Error: ${e.message}');
  } catch (e) {
    _showErrorSnackBar('Unexpected Error: $e');
  }
}

void _showErrorSnackBar(String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ),
  );
}
```

---

These examples cover common patterns and integrations for the Forum Screen. Adapt them to your specific project needs!
