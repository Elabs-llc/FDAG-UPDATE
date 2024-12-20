import 'package:fdag/commons/widgets/designer_grid_card.dart';
import 'package:fdag/elabs/auth/app_model.dart';
import 'package:fdag/features/appbar/silver_app_bar_delegate.dart';
import 'package:fdag/utils/providers/items_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class ViewAllPage extends ConsumerStatefulWidget {
  final String title;
  final String collection;

  const ViewAllPage({
    super.key,
    required this.title,
    required this.collection,
  });

  @override
  ConsumerState<ViewAllPage> createState() => _ViewAllPageState();
}

class _ViewAllPageState extends ConsumerState<ViewAllPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);
    // Defer the reset to avoid modifying providers during widget build lifecycle
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _resetState();
      _loadData();
    });
  }

  // Scroll handler for pagination
  void _onScroll() {
    // Check if we're 80% through the list
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      if (ref.read(hasMoreDataProvider)) {
        _loadData();
      }
    }
  }

  // Data loading function
  Future<void> _loadData() async {
    // Prevent multiple simultaneous loads
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final currentPage = ref.read(currentPageProvider);
      final itemsPerPage = ref.read(itemsPerPageProvider);

      final hasMore =
          await ref.read(paginatedItemsProvider.notifier).loadMoreItems(
                currentPage,
                itemsPerPage,
                collection: widget.collection,
              );

      if (mounted) {
        ref.read(hasMoreDataProvider.notifier).state = hasMore;
        ref.read(currentPageProvider.notifier).state = currentPage + 1;
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading data: ${e.toString()}'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Optional: Add refresh functionality
  Future<void> _refresh() async {
    ref.read(currentPageProvider.notifier).state = 0;
    ref.read(hasMoreDataProvider.notifier).state = true;
    ref.read(paginatedItemsProvider.notifier).reset();
    await _loadData();
  }

  // Reset all related states
  void _resetState() {
    ref.read(currentPageProvider.notifier).state = 0;
    ref.read(hasMoreDataProvider.notifier).state = true;
    ref.read(paginatedItemsProvider.notifier).reset();
  }

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(paginatedItemsProvider);
    final hasMore = ref.watch(hasMoreDataProvider);
    final size = MediaQuery.of(context).size;
    final padding = size.width * 0.04; // 4% of screen width
    final crossAxisCount = size.width > 600 ? 3 : 2; // Adapt grid for tablets

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Calculate item width based on available space
              final itemWidth = (constraints.maxWidth -
                      (padding * 2) -
                      (crossAxisCount - 1) * padding) /
                  crossAxisCount;
              // Set aspect ratio based on available height
              final aspectRatio = itemWidth / (itemWidth * 1.4);

              return CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverPersistentHeader(
                    delegate: SliverAppBarDelegate(
                      minHeight: 60,
                      maxHeight: 60,
                      child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: padding),
                          child: Row(
                            children: [
                              IconButton(
                                constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                                icon: const Icon(Icons.arrow_back_ios_new),
                                onPressed: () => Navigator.pop(context),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  widget.title,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    pinned: true,
                  ),
                  SliverPadding(
                    padding: EdgeInsets.all(padding),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: itemWidth,
                            maxHeight: itemWidth * 1.4,
                          ),
                          child: DesignerGridCard(
                              designer: items[index],
                              onTap: () {
                                AppModel()
                                    .handleDiscoverTap(context, items[index]);
                              }),
                        ),
                        childCount: items.length,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        mainAxisSpacing: padding,
                        crossAxisSpacing: padding,
                        childAspectRatio: aspectRatio,
                      ),
                    ),
                  ),
                  if (_isLoading)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(padding),
                        child: const Center(
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                      ),
                    ),
                  if (!hasMore && items.isNotEmpty)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(padding),
                        child: const Center(
                          child: Text(
                            'No more items to load',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (items.isEmpty && !_isLoading)
                    SliverFillRemaining(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset('assets/icons/empty-data.svg'),
                            const SizedBox(height: 5),
                            Text(
                              'No items found',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
