import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:writing_helper/app_states/nav_states/nav_states.dart';

class NavNotifier extends StateNotifier<NavStates> {
  NavNotifier() : super(const NavStates());

  void onIndexChanged(int index) {
    state = state.copyWith(index: index);
  }
}

final navProvider =
    StateNotifierProvider<NavNotifier, NavStates>((ref) => NavNotifier());
