import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../pages/login_page.dart';
import '../pages/profile_page.dart';
import '../pages/register_page.dart';
import '../pages/about_page.dart';
import '../pages/forgot_password_page.dart';
import '../pages/dashboard_page.dart';

import '../pages/erp_modules/inventory_page.dart';
import '../pages/erp_modules/warehouses_page.dart';
import '../pages/erp_modules/stock_movements_page.dart';
import '../pages/erp_modules/procurement_page.dart';
import '../pages/erp_modules/vendors_page.dart';
import '../pages/erp_modules/sales_orders_page.dart';
import '../pages/erp_modules/dispatch_page.dart';

import '../providers/user_provider.dart';
import '../widgets/app_layout.dart';

class AppRoutes {
  static const String login = '/';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';

  static const String dashboard = '/dashboard';
  static const String about = '/about';
  static const String profile = '/profile';

  static const String inventory = '/inventory';
  static const String warehouses = '/warehouses';
  static const String stockMovements = '/stock-movements';
  static const String procurement = '/procurement';
  static const String vendors = '/vendors';
  static const String salesOrders = '/sales-orders';
  static const String dispatch = '/dispatch';

  static final GoRouter router = GoRouter(
    initialLocation: login,

    redirect: (context, state) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      final loggedIn = userProvider.isLoggedIn;
      final location = state.uri.path;

      final isLoginPage = location == login;

      final isAuthPage = location == register || location == forgotPassword;

      if (loggedIn && isLoginPage) {
        return dashboard;
      }

      if (!loggedIn && !isLoginPage && !isAuthPage) {
        return login;
      }

      return null;
    },

    routes: [
      // ---------------------------------------------------------
      // AUTHENTICATION PAGES
      // These pages do NOT use AppLayout
      // ---------------------------------------------------------

      GoRoute(
        path: login,
        builder: (context, state) {
          return const LoginPage();
        },
      ),

      GoRoute(
        path: register,
        builder: (context, state) {
          return const RegisterPage();
        },
      ),

      GoRoute(
        path: forgotPassword,
        builder: (context, state) {
          return const ForgotPasswordPage();
        },
      ),

      // ---------------------------------------------------------
      // MAIN APPLICATION
      // AppLayout provides:
      // Header
      // Sidebar
      // Footer
      // ---------------------------------------------------------
      ShellRoute(
        builder: (context, state, child) {
          return AppLayout(child: child);
        },

        routes: [
          GoRoute(
            path: dashboard,
            builder: (context, state) {
              return const DashboardPage();
            },
          ),

          GoRoute(
            path: about,
            builder: (context, state) {
              return const AboutPage();
            },
          ),

          GoRoute(
            path: profile,
            builder: (context, state) {
              return const ProfilePage();
            },
          ),

          GoRoute(
            path: inventory,
            builder: (context, state) {
              return const InventoryPage();
            },
          ),

          GoRoute(
            path: warehouses,
            builder: (context, state) {
              return const WarehousesPage();
            },
          ),

          GoRoute(
            path: stockMovements,
            builder: (context, state) {
              return const StockMovementsPage();
            },
          ),

          GoRoute(
            path: procurement,
            builder: (context, state) {
              return const ProcurementPage();
            },
          ),

          GoRoute(
            path: vendors,
            builder: (context, state) {
              return const VendorsPage();
            },
          ),

          GoRoute(
            path: salesOrders,
            builder: (context, state) {
              return const SalesOrdersPage();
            },
          ),

          GoRoute(
            path: dispatch,
            builder: (context, state) {
              return const DispatchPage();
            },
          ),
        ],
      ),
    ],
  );
}
