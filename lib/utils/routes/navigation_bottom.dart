// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:voting_app/src/localization/string_hardcoded.dart';

// // Stateful navigation based on:
// // https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
// class ScaffoldWithNestedNavigation extends StatelessWidget {
//   const ScaffoldWithNestedNavigation({
//     Key? key,
//     required this.navigationShell,
//   }) : super(key: key ?? const ValueKey('ScaffoldWithNestedNavigation'));
//   final StatefulNavigationShell navigationShell;

//   void _goBranch(int index) {
//     navigationShell.goBranch(
//       index,
//       // A common pattern when using bottom navigation bars is to support
//       // navigating to the initial location when tapping the item that is
//       // already active. This example demonstrates how to support this behavior,
//       // using the initialLocation parameter of goBranch.
//       initialLocation: index == navigationShell.currentIndex,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.sizeOf(context);
//     if (true) {
//       return ScaffoldWithNavigationBar(
//         body: navigationShell,
//         currentIndex: navigationShell.currentIndex,
//         onDestinationSelected: _goBranch,
//       );
//     }
//     // else {
//     //   return ScaffoldWithNavigationRail(
//     //     body: navigationShell,
//     //     currentIndex: navigationShell.currentIndex,
//     //     onDestinationSelected: _goBranch,
//     //   );
//     // }
//   }
// }

// class ScaffoldWithNavigationBar extends StatelessWidget {
//   const ScaffoldWithNavigationBar({
//     super.key,
//     required this.body,
//     required this.currentIndex,
//     required this.onDestinationSelected,
//   });
//   final Widget body;
//   final int currentIndex;
//   final ValueChanged<int> onDestinationSelected;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: body,
//       bottomNavigationBar: NavigationBar(
//         selectedIndex: currentIndex,
//         destinations: [
//           NavigationDestination(
//             icon: const Icon(Icons.house_outlined),
//             selectedIcon: const Icon(Icons.house),
//             label: 'Home'.hardcoded,
//           ),
//           // products
//           NavigationDestination(
//             icon: const Icon(Icons.add_outlined),
//             selectedIcon: const Icon(Icons.add),
//             label: 'Create'.hardcoded,
//           ),

//           NavigationDestination(
//             icon: const Icon(Icons.how_to_vote_outlined),
//             selectedIcon: const Icon(Icons.how_to_vote),
//             label: 'My Election'.hardcoded,
//           ),
//           NavigationDestination(
//             icon: const Icon(Icons.history_outlined),
//             selectedIcon: const Icon(Icons.history),
//             label: 'History'.hardcoded,
//           ),
//           NavigationDestination(
//             icon: const Icon(Icons.info_outlined),
//             selectedIcon: const Icon(Icons.info),
//             label: 'Info'.hardcoded,
//           ),

//           NavigationDestination(
//             icon: const Icon(Icons.person_outline),
//             selectedIcon: const Icon(Icons.person),
//             label: 'Account'.hardcoded,
//           ),
//         ],
//         onDestinationSelected: onDestinationSelected,
//       ),
//     );
//   }
// }

