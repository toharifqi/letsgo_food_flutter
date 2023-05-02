import 'package:flutter/material.dart';
import 'package:letsgo_food/theme/style.dart';
import 'package:letsgo_food/widget/list_item.dart';
import 'package:provider/provider.dart';

import '../provider/restaurant_list_provider.dart';
import '../provider/result_state.dart';

class ListPage extends StatefulWidget {
  static const routeName = "/list_page";

  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  bool _isSearchFieldEmpty = false;
  final _searchFieldController = TextEditingController();
  final _scrollController = ScrollController();

  void _onSearchFieldChange() {
    setState(() {
      if (_searchFieldController.text.trim() != "") {
        _isSearchFieldEmpty = false;
      } else {
        _isSearchFieldEmpty = true;
      }
    });
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0.0,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(seconds: 1),
    );
  }

  void _hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  void initState() {
    super.initState();
    _searchFieldController.addListener(_onSearchFieldChange);
  }

  @override
  void dispose() {
    _searchFieldController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, isScrolled) {
          return [
            SliverAppBar(
              elevation: 0,
              pinned: true,
              backgroundColor: Colors.transparent,
              expandedHeight: 160,
              flexibleSpace: _buildCustomAppBar(),
              bottom: const PreferredSize(
                preferredSize: Size.fromHeight(60.0),
                child: Text(""),
              ),
            )
          ];
        },
        body: _buildList(context),
      ),
    );
  }

  Widget _buildCustomAppBar() {
    return SafeArea(
      child: Padding(
        padding:  const EdgeInsets.all(12),
        child: Card(
            color: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: _buildSearchBar(),
                  ),
                  Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: secondaryColor
                        ),
                        child: Image.asset(
                            "assets/icon_no_text.png"
                        ),
                      )
                  )
                ],
              ),
            )
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextField(
        controller: _searchFieldController,
        onSubmitted: (query) {
          context
              .read<RestaurantListProvider>()
              .searchRestaurants(query);
          _scrollToTop();
        },
        decoration: InputDecoration(
          fillColor: Colors.white,
          hintText: "Search restaurant...",
          filled: true,
          suffixIcon: InkWell(
            child: _isSearchFieldEmpty
                ? Icon(Icons.search, color: Colors.grey[500])
                : Icon(Icons.close, color: Colors.grey[500]),
            onTap: () {
              if (!_isSearchFieldEmpty) {
                _searchFieldController.clear();
                context
                    .read<RestaurantListProvider>()
                    .fetchAllRestaurants();
                _scrollToTop();
                _hideKeyboard();
              }
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<RestaurantListProvider>(
      builder: (context, listProvider, _) {
        switch (listProvider.state) {
          case ResultState.loading:
            return const Center(
                child: CircularProgressIndicator(
                  color: secondaryColor,
                )
            );

          case ResultState.error:
          case ResultState.noData:
            return Center(
              child: Material(
                child: Text(
                  listProvider.message,
                  style: const TextStyle(
                    fontSize: 18
                  ),
                ),
              ),
            );

          case ResultState.hasData:
            return MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: listProvider.result.length,
                  itemBuilder: (context, index) => RestaurantItem(
                      restaurant: listProvider.result[index],
                      context: context
                  ),
                )
            );
        }
      },
    );
  }
}
