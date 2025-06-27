import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toktok/presentation/providers/discover_provider.dart';
import 'package:toktok/presentation/widgets/shared/search_widget/search_widget.dart';
import 'package:toktok/presentation/widgets/shared/video_scrollable_view.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final FocusNode searchFocusNode = FocusNode();
  bool showSearch = false;

  @override
  void dispose() {
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final discoverProvider = context.watch<DiscoverProvider>();

    return Scaffold(
      body: Stack(
        children: [
          discoverProvider.initialLoading
            ? const Center(
                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
              )
            : discoverProvider.errorMessage != null
              ? Center(child: Text(discoverProvider.errorMessage!))
              : VideoScrollableView(videos: discoverProvider.videos),

          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: () {
                setState(() {
                  showSearch = !showSearch;
                });
                if (showSearch) {
                  searchFocusNode.requestFocus();
                }
              },
            ),
          ),

          if (showSearch)
            Positioned(
              bottom: 0,
              left: 20,
              right: 20,
              child: TapRegion(
                onTapOutside: (_) {
                  setState(() {
                    showSearch = false;
                  });
                },
                child: SizedBox(
                  width: double.infinity,
                  child: SearchWidget(
                    onValue: (String value) {
                      discoverProvider.loadNextPage(search: value);
                      setState(() {
                        showSearch = false;
                      });
                    },
                    focusNode: searchFocusNode,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}