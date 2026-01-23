import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';

class UserProvider with ChangeNotifier {
  List<User> _allUsers = [];
  List<User> _filteredUsers = [];
  bool _isInitialLoading = false;
  bool _isLoadingMore = false;
  String? _error;
  int _currentPage = 1;
  bool _hasReachedEnd = false;
  static const int _pageSize = 12;
  String _searchQuery = '';

  List<User> get displayedUsers =>
      _searchQuery.isEmpty ? _allUsers : _filteredUsers;

  bool get isInitialLoading => _isInitialLoading;
  bool get isLoadingMore => _isLoadingMore;
  String? get error => _error;
  bool get hasMore => !_hasReachedEnd && _searchQuery.isEmpty;

  String get currentSearch => _searchQuery;

  Future<void> loadFirstPage() async {
    if (_allUsers.isNotEmpty) return;

    _isInitialLoading = true;
    _error = null;
    _hasReachedEnd = false;
    _currentPage = 1;
    notifyListeners();

    await _fetchNextPage(refresh: true);
  }

  Future<void> refresh() async {
    _allUsers.clear();
    _filteredUsers.clear();
    _searchQuery = '';
    _currentPage = 1;
    _hasReachedEnd = false;
    _error = null;
    _isInitialLoading = true;
    notifyListeners();

    await _fetchNextPage(refresh: true);
  }

  Future<void> loadMore() async {
    if (_isLoadingMore || _isInitialLoading || _hasReachedEnd || _searchQuery.isNotEmpty) {
      return;
    }

    _isLoadingMore = true;
    notifyListeners();

    await _fetchNextPage();
  }

  Future<void> _fetchNextPage({bool refresh = false}) async {
    try {
      final newUsers = await ApiService().fetchUsers(
        page: _currentPage,
        results: _pageSize,
      );

      if (newUsers.isEmpty) {
        _hasReachedEnd = true;
      } else {
        if (refresh) {
          _allUsers = newUsers;
        } else {
          _allUsers.addAll(newUsers);
        }
        _applyFilter();
        _currentPage++;
      }

      _error = null;
    } catch (e) {
      _error = e.toString();
      _hasReachedEnd = true;
    }

    _isInitialLoading = false;
    _isLoadingMore = false;
    notifyListeners();
  }

  void setSearch(String value) {
    _searchQuery = value.trim().toLowerCase();
    _applyFilter();
    notifyListeners();
  }

  void _applyFilter() {
    if (_searchQuery.isEmpty) {
      _filteredUsers = [];
    } else {
      _filteredUsers = _allUsers.where((user) {
        return user.fullName.toLowerCase().contains(_searchQuery);
      }).toList();
    }
  }
}