import 'dart:async';

import 'package:fdag/features/search/search_card.dart';
import 'package:fdag/utils/providers/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounceTimer;

  @override
  void dispose() {
    _searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      ref.read(searchQueryProvider.notifier).state = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                Expanded(
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.search,
                          color: Color(0xFF9E9E9E),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            autofocus: true,
                            onChanged: _onSearchChanged,
                            decoration: const InputDecoration(
                              hintText: 'Search designers, styles...',
                              hintStyle: TextStyle(
                                color: Color(0xFF9E9E9E),
                                fontSize: 14,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              isDense: true,
                            ),
                          ),
                        ),
                        if (_searchController.text.isNotEmpty)
                          GestureDetector(
                            onTap: () {
                              _searchController.clear();
                              _onSearchChanged('');
                            },
                            child: const Icon(
                              Icons.close,
                              color: Color(0xFF9E9E9E),
                              size: 20,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final searchResults = ref.watch(searchResultsProvider);

          return searchResults.when(
            data: (designers) {
              if (designers.isEmpty) {
                return const Center(
                  child: Text('No results found'),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: designers.length,
                itemBuilder: (context, index) {
                  final designer = designers[index];
                  return SearchCard(
                    designer: designer,
                    onTap: () {
                      if (designer.subcollection == 'events' ||
                          designer.subcollection == 'spotlights') {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => EventDetailsPage(
                        //       data: designer,
                        //     ),
                        //   ),
                        // );
                      } else if (designer.subcollection == 'newsUpdates') {
                      } else {}
                    },
                  );
                },
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (error, stack) => Center(
              child: Text('Error: $error'),
            ),
          );
        },
      ),
    );
  }
}
