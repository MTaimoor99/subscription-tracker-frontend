import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:subscription_tracker_frontend/core/features/authentication/presentation/views/register_page.dart';
import 'package:subscription_tracker_frontend/core/features/subscription_listing/presentation/views/subscription_listing_page.dart';

final routerProvider = Provider((ref){
return GoRouter(
  initialLocation: "/register",
  routes:[
    GoRoute(
    path: "/",
    name:'home',
    builder: (context, state) {
      return SubscriptionListingPage();
    },
    ),
    GoRoute(
    path: "/register",
    name:'register',
    builder: (context, state) {
    return RegisterPage();
    },
    ),
  ]
);
});
