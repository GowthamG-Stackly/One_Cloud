// import 'dart:async';
// import 'dart:math' as math;

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../app_theme.dart';

// /// App-wide Riverpod settings. Keep the application's ProviderScope above
// /// MaterialApp/GoRouter (normally in main.dart), not inside individual routes,
// /// so values remain available when navigating away and returning.
// /// These in-memory values survive route changes, not a full browser restart.
// class TenantDatabaseSettings {
//   final String selectedTenant;
//   final String maintenanceWindow;
//   final bool autoBackup;

//   const TenantDatabaseSettings({
//     this.selectedTenant = 'ABX Technologies Pvt.Ltd',
//     this.maintenanceWindow = 'Sunday 02.00 AM',
//     this.autoBackup = true,
//   });

//   TenantDatabaseSettings copyWith({
//     String? selectedTenant,
//     String? maintenanceWindow,
//     bool? autoBackup,
//   }) => TenantDatabaseSettings(
//     selectedTenant: selectedTenant ?? this.selectedTenant,
//     maintenanceWindow: maintenanceWindow ?? this.maintenanceWindow,
//     autoBackup: autoBackup ?? this.autoBackup,
//   );
// }

// class TenantDatabaseSettingsNotifier extends Notifier<TenantDatabaseSettings> {
//   @override
//   TenantDatabaseSettings build() => const TenantDatabaseSettings();

//   void selectTenant(String value) =>
//       state = state.copyWith(selectedTenant: value);
//   void setMaintenanceWindow(String value) =>
//       state = state.copyWith(maintenanceWindow: value);
//   void setAutoBackup(bool value) => state = state.copyWith(autoBackup: value);
// }

// final tenantDatabaseSettingsProvider =
//     NotifierProvider<TenantDatabaseSettingsNotifier, TenantDatabaseSettings>(
//       TenantDatabaseSettingsNotifier.new,
//     );

// /// Tenant Database page for the Tenant Management module.
// /// This page is a child route inside AppLayout and does not create a Scaffold.
// class TenantDatabasePage extends ConsumerStatefulWidget {
//   const TenantDatabasePage({super.key});

//   @override
//   ConsumerState<TenantDatabasePage> createState() => _TenantDatabasePageState();
// }

// class _TenantDatabasePageState extends ConsumerState<TenantDatabasePage> {
//   static const List<String> _tenants = [
//     'ABX Technologies Pvt.Ltd',
//     'Stackly Technologies',
//     'Nexa Solutions Pvt.Ltd',
//     'Vertex Global Systems',
//   ];

//   static const List<String> _maintenanceWindows = [
//     'Sunday 02.00 AM',
//     'Sunday 03.00 AM',
//     'Saturday 01.00 AM',
//     'Saturday 02.00 AM',
//     'Monday 02.00 AM',
//   ];

//   bool _showSavedBanner = false;
//   bool _showConnectionToast = false;
//   bool _isRefreshing = false;
//   Timer? _bannerTimer;
//   Timer? _toastTimer;

//   @override
//   void dispose() {
//     _bannerTimer?.cancel();
//     _toastTimer?.cancel();
//     super.dispose();
//   }

//   void _saveChanges() {
//     setState(() => _showSavedBanner = true);
//     _bannerTimer?.cancel();
//     _bannerTimer = Timer(const Duration(seconds: 4), () {
//       if (mounted) setState(() => _showSavedBanner = false);
//     });
//   }

//   Future<void> _refresh() async {
//     if (_isRefreshing) return;
//     setState(() {
//       _isRefreshing = true;
//       _showSavedBanner = false;
//     });
//     await Future<void>.delayed(const Duration(milliseconds: 1400));
//     if (mounted) setState(() => _isRefreshing = false);
//   }

//   void _testConnection() {
//     setState(() => _showConnectionToast = true);
//     _toastTimer?.cancel();
//     _toastTimer = Timer(const Duration(seconds: 3), () {
//       if (mounted) setState(() => _showConnectionToast = false);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final width = constraints.hasBoundedWidth
//             ? constraints.maxWidth
//             : MediaQuery.sizeOf(context).width;
//         final isNarrow = width < 1180;
//         final settings = ref.watch(tenantDatabaseSettingsProvider);
//         final horizontalPadding = width < 500 ? 14.0 : 20.0;

//         return Stack(
//           children: [
//             SingleChildScrollView(
//               physics: const ClampingScrollPhysics(),
//               padding: EdgeInsets.fromLTRB(
//                 horizontalPadding,
//                 18,
//                 horizontalPadding,
//                 24,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildPageHeader(isNarrow),
//                   if (_showSavedBanner) ...[
//                     const SizedBox(height: 16),
//                     _SavedBanner(),
//                   ],
//                   const SizedBox(height: 18),
//                   _buildTenantSelector(isNarrow, settings.selectedTenant),
//                   const SizedBox(height: 16),
//                   if (width < 960)
//                     Column(
//                       children: [
//                         _DatabaseDetailsCard(),
//                         const SizedBox(height: 16),
//                         const _StorageInformationCard(),
//                         const SizedBox(height: 16),
//                         const _DatabaseHealthCard(),
//                         const SizedBox(height: 16),
//                         _MaintenanceSettingsCard(
//                           selectedWindow: settings.maintenanceWindow,
//                           windows: _maintenanceWindows,
//                           autoBackup: settings.autoBackup,
//                           onWindowChanged: (value) => ref
//                               .read(tenantDatabaseSettingsProvider.notifier)
//                               .setMaintenanceWindow(value),
//                           onBackupChanged: (value) => ref
//                               .read(tenantDatabaseSettingsProvider.notifier)
//                               .setAutoBackup(value),
//                         ),
//                       ],
//                     )
//                   else
//                     Column(
//                       children: [
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(child: _DatabaseDetailsCard()),
//                             const SizedBox(width: 16),
//                             const Expanded(child: _StorageInformationCard()),
//                           ],
//                         ),
//                         const SizedBox(height: 16),
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Expanded(child: _DatabaseHealthCard()),
//                             const SizedBox(width: 16),
//                             Expanded(
//                               child: _MaintenanceSettingsCard(
//                                 selectedWindow: settings.maintenanceWindow,
//                                 windows: _maintenanceWindows,
//                                 autoBackup: settings.autoBackup,
//                                 onWindowChanged: (value) => ref
//                                     .read(
//                                       tenantDatabaseSettingsProvider.notifier,
//                                     )
//                                     .setMaintenanceWindow(value),
//                                 onBackupChanged: (value) => ref
//                                     .read(
//                                       tenantDatabaseSettingsProvider.notifier,
//                                     )
//                                     .setAutoBackup(value),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                 ],
//               ),
//             ),
//             if (_isRefreshing)
//               Positioned.fill(
//                 child: ColoredBox(
//                   color: Colors.black.withValues(alpha: 0.28),
//                   child: Center(
//                     child: Container(
//                       width: 200,
//                       padding: const EdgeInsets.symmetric(
//                         vertical: 28,
//                         horizontal: 24,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(9),
//                       ),
//                       child: const Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           SizedBox(
//                             width: 42,
//                             height: 42,
//                             child: CircularProgressIndicator(
//                               strokeWidth: 2.4,
//                               color: AppTheme.ink,
//                             ),
//                           ),
//                           SizedBox(height: 12),
//                           Text(
//                             'Refreshing...',
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: AppTheme.text,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             if (_showConnectionToast)
//               Positioned(
//                 top: 12,
//                 left: 16,
//                 right: 16,
//                 child: Align(
//                   alignment: Alignment.topRight,
//                   child: LayoutBuilder(
//                     builder: (context, toastConstraints) {
//                       return _ConnectionToast(
//                         maxWidth: math.min(330.0, toastConstraints.maxWidth),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//           ],
//         );
//       },
//     );
//   }

//   Widget _buildPageHeader(bool isNarrow) {
//     final actions = Wrap(
//       spacing: 10,
//       runSpacing: 8,
//       children: [
//         OutlinedButton.icon(
//           onPressed: _refresh,
//           icon: const Icon(Icons.refresh, size: 17),
//           label: const Text('Refresh'),
//           style: _actionButtonStyle(),
//         ),
//         OutlinedButton.icon(
//           onPressed: _saveChanges,
//           icon: const Icon(Icons.save_outlined, size: 17),
//           label: const Text('Save'),
//           style: _actionButtonStyle(),
//         ),
//         ElevatedButton.icon(
//           onPressed: _testConnection,
//           icon: const Icon(Icons.link, size: 17),
//           label: const Text('Test Connection'),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: const Color(0xFF3047F5),
//             foregroundColor: Colors.white,
//             elevation: 0,
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(7),
//             ),
//             textStyle: const TextStyle(
//               fontSize: 13,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//       ],
//     );

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (isNarrow) ...[
//           const Text(
//             'Tenant Database',
//             style: TextStyle(
//               color: Color(0xFF1B2936),
//               fontSize: 25,
//               fontWeight: FontWeight.w700,
//               letterSpacing: -0.5,
//             ),
//           ),
//           const SizedBox(height: 4),
//           const Text(
//             'Manage tenant databases, monitor health, storage, and backup configurations',
//             style: TextStyle(fontSize: 12.5, color: Colors.black87),
//           ),
//           const SizedBox(height: 14),
//           actions,
//         ] else
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Tenant Database',
//                       style: TextStyle(
//                         color: Color(0xFF1B2936),
//                         fontSize: 25,
//                         fontWeight: FontWeight.w700,
//                         letterSpacing: -0.5,
//                       ),
//                     ),
//                     SizedBox(height: 4),
//                     Text(
//                       'Manage tenant databases, monitor health, storage, and backup configurations',
//                       style: TextStyle(fontSize: 12.5, color: Colors.black87),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(width: 12),
//               actions,
//             ],
//           ),
//       ],
//     );
//   }

//   ButtonStyle _actionButtonStyle() {
//     return OutlinedButton.styleFrom(
//       foregroundColor: const Color(0xFF1C2935),
//       side: const BorderSide(color: Color(0xFFDCE3EA)),
//       backgroundColor: Colors.white,
//       elevation: 0,
//       padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
//       textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
//     );
//   }

//   Widget _buildTenantSelector(bool isNarrow, String selectedTenant) {
//     final selector = SizedBox(
//       width: 256,
//       height: 41,
//       child: DropdownButtonFormField<String>(
//         value: selectedTenant,
//         isExpanded: true,
//         icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF111827)),
//         decoration: InputDecoration(
//           filled: true,
//           fillColor: Colors.white,
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 13,
//             vertical: 9,
//           ),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8),
//             borderSide: const BorderSide(color: Color(0xFFDCE3EA)),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8),
//             borderSide: const BorderSide(color: Color(0xFFDCE3EA)),
//           ),
//         ),
//         items: _tenants
//             .map(
//               (tenant) => DropdownMenuItem(
//                 value: tenant,
//                 child: Text(
//                   tenant,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(fontSize: 13.5),
//                 ),
//               ),
//             )
//             .toList(),
//         onChanged: (value) {
//           if (value != null) {
//             ref
//                 .read(tenantDatabaseSettingsProvider.notifier)
//                 .selectTenant(value);
//           }
//         },
//       ),
//     );

//     return isNarrow
//         ? Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Select Tenant',
//                 style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
//               ),
//               const SizedBox(height: 8),
//               SizedBox(width: double.infinity, child: selector),
//             ],
//           )
//         : Row(
//             children: [
//               const SizedBox(
//                 width: 106,
//                 child: Text(
//                   'Select Tenant',
//                   style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
//                 ),
//               ),
//               selector,
//             ],
//           );
//   }
// }

// class _DatabaseDetailsCard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return _Panel(
//       title: 'Database Details',
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: const [
//           _ReadOnlyField(label: 'Database Name', value: 'tenant_abc_db'),
//           SizedBox(height: 14),
//           _ReadOnlyField(label: 'Database Type', value: 'PosgreSQL'),
//           SizedBox(height: 14),
//           _ReadOnlyField(label: 'Server Name', value: 'db-server-01'),
//           SizedBox(height: 15),
//           _ConnectionStatus(),
//         ],
//       ),
//     );
//   }
// }

// class _ReadOnlyField extends StatelessWidget {
//   final String label;
//   final String value;

//   const _ReadOnlyField({required this.label, required this.value});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(fontSize: 13.5, color: Color(0xFF343B4B)),
//         ),
//         const SizedBox(height: 4),
//         Container(
//           width: double.infinity,
//           height: 40,
//           alignment: Alignment.centerLeft,
//           padding: const EdgeInsets.symmetric(horizontal: 12),
//           decoration: BoxDecoration(
//             color: const Color(0xFFF9F9FA),
//             border: Border.all(color: const Color(0xFFDCE3EA)),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Text(
//             value,
//             style: const TextStyle(fontSize: 13.5, color: Color(0xFF17191D)),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _ConnectionStatus extends StatelessWidget {
//   const _ConnectionStatus();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 40,
//       padding: const EdgeInsets.symmetric(horizontal: 15),
//       decoration: BoxDecoration(
//         color: const Color(0xFFE2FCE8),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: const Row(
//         children: [
//           Expanded(
//             child: Text(
//               'Connection Status',
//               overflow: TextOverflow.ellipsis,
//               style: TextStyle(fontSize: 13.5, color: Color(0xFF374151)),
//             ),
//           ),
//           _Dot(color: Color(0xFF10B981), size: 10),
//           SizedBox(width: 8),
//           Text(
//             'Connected',
//             style: TextStyle(
//               color: Color(0xFF009B69),
//               fontSize: 13.5,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _StorageInformationCard extends StatelessWidget {
//   const _StorageInformationCard();

//   @override
//   Widget build(BuildContext context) {
//     return _Panel(
//       title: 'Storage Information',
//       child: Column(
//         children: [
//           const SizedBox(height: 8),
//           SizedBox(
//             height: 194,
//             width: double.infinity,
//             child: CustomPaint(
//               painter: _StorageGaugePainter(),
//               child: const Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(height: 49),
//                   Text(
//                     'USED',
//                     style: TextStyle(
//                       color: Color(0xFF71819B),
//                       fontSize: 10,
//                       fontWeight: FontWeight.w700,
//                       letterSpacing: 1.8,
//                     ),
//                   ),
//                   SizedBox(height: 1),
//                   Text(
//                     '45 GB',
//                     style: TextStyle(
//                       color: Color(0xFF111827),
//                       fontSize: 34,
//                       height: 1,
//                       fontWeight: FontWeight.w800,
//                       letterSpacing: -1.2,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(height: 8),
//           LayoutBuilder(
//             builder: (context, constraints) {
//               final compact = constraints.maxWidth < 380;
//               final items = const [
//                 _StorageLegend(
//                   color: Color(0xFF2860ED),
//                   title: 'Used Storage',
//                   amount: '45 GB',
//                   percent: '(45%)',
//                 ),
//                 _StorageLegend(
//                   color: Color(0xFF20B6EF),
//                   title: 'Free Storage',
//                   amount: '35 GB',
//                   percent: '(35%)',
//                 ),
//                 _StorageLegend(
//                   color: Color(0xFFE1E7EF),
//                   title: 'Available Storage',
//                   amount: '20 GB',
//                   percent: '(20%)',
//                 ),
//               ];
//               return compact
//                   ? const Column(
//                       children: [
//                         _StorageLegend(
//                           color: Color(0xFF2860ED),
//                           title: 'Used Storage',
//                           amount: '45 GB',
//                           percent: '(45%)',
//                         ),
//                         SizedBox(height: 10),
//                         _StorageLegend(
//                           color: Color(0xFF20B6EF),
//                           title: 'Free Storage',
//                           amount: '35 GB',
//                           percent: '(35%)',
//                         ),
//                         SizedBox(height: 10),
//                         _StorageLegend(
//                           color: Color(0xFFE1E7EF),
//                           title: 'Available Storage',
//                           amount: '20 GB',
//                           percent: '(20%)',
//                         ),
//                       ],
//                     )
//                   : Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: items
//                           .map((item) => Expanded(child: item))
//                           .toList(),
//                     );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _StorageGaugePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final double stroke = math
//         .max(20.0, math.min(28.0, size.width * 0.055))
//         .toDouble();
//     final center = Offset(size.width / 2, size.height - 7);
//     final double radius = math
//         .min(size.width * 0.255, size.height * 0.73)
//         .toDouble();
//     final rect = Rect.fromCircle(center: center, radius: radius);
//     const start = math.pi;
//     const sweep = math.pi;

//     final base = Paint()
//       ..color = const Color(0xFFE2E8F0)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = stroke
//       ..strokeCap = StrokeCap.butt;
//     canvas.drawArc(rect, start, sweep, false, base);

//     final used = Paint()
//       ..color = const Color(0xFF2860ED)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = stroke
//       ..strokeCap = StrokeCap.butt;
//     canvas.drawArc(rect, start, sweep * .45, false, used);

//     final free = Paint()
//       ..color = const Color(0xFF20B6EF)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = stroke
//       ..strokeCap = StrokeCap.butt;
//     canvas.drawArc(rect, start + sweep * .45, sweep * .35, false, free);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }

// class _StorageLegend extends StatelessWidget {
//   final Color color;
//   final String title;
//   final String amount;
//   final String percent;

//   const _StorageLegend({
//     required this.color,
//     required this.title,
//     required this.amount,
//     required this.percent,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _Dot(color: color, size: 10),
//             const SizedBox(width: 7),
//             Flexible(
//               child: Text(
//                 title,
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 style: const TextStyle(
//                   fontSize: 12.5,
//                   color: Color(0xFF667085),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 8),
//         RichText(
//           text: TextSpan(
//             children: [
//               TextSpan(
//                 text: amount,
//                 style: const TextStyle(
//                   color: Color(0xFF111827),
//                   fontWeight: FontWeight.w700,
//                   fontSize: 15,
//                 ),
//               ),
//               TextSpan(
//                 text: '  $percent',
//                 style: const TextStyle(
//                   color: Color(0xFF94A3B8),
//                   fontSize: 10.5,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _DatabaseHealthCard extends StatelessWidget {
//   const _DatabaseHealthCard();

//   @override
//   Widget build(BuildContext context) {
//     return _Panel(
//       title: 'Database Health',
//       child: const Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _MetricBar(
//             label: 'CPU Usage',
//             percent: '67%',
//             value: .32,
//             color: Color(0xFF13B8A6),
//             badgeColor: Color(0xFFCFF2EE),
//           ),
//           SizedBox(height: 20),
//           _MetricBar(
//             label: 'Memory Utilization',
//             percent: '54%',
//             value: .25,
//             color: Color(0xFF702080),
//             badgeColor: Color(0xFFF0D3F5),
//           ),
//           SizedBox(height: 20),
//           Wrap(
//             alignment: WrapAlignment.spaceBetween,
//             crossAxisAlignment: WrapCrossAlignment.center,
//             runSpacing: 6,
//             children: [
//               Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(Icons.history, size: 15, color: Color(0xFF64748B)),
//                   SizedBox(width: 8),
//                   Text(
//                     'Last Backup',
//                     style: TextStyle(fontSize: 13.5, color: Color(0xFF454D5C)),
//                   ),
//                 ],
//               ),
//               Text(
//                 '08-Sep-2026 02:00 AM',
//                 style: TextStyle(fontSize: 13.5, color: Color(0xFF17191D)),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _MetricBar extends StatelessWidget {
//   final String label;
//   final String percent;
//   final double value;
//   final Color color;
//   final Color badgeColor;

//   const _MetricBar({
//     required this.label,
//     required this.percent,
//     required this.value,
//     required this.color,
//     required this.badgeColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             Text(
//               label,
//               style: const TextStyle(fontSize: 13.5, color: Color(0xFF454D5C)),
//             ),
//             const Spacer(),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//               decoration: BoxDecoration(
//                 color: badgeColor,
//                 borderRadius: BorderRadius.circular(4),
//               ),
//               child: Text(
//                 percent,
//                 style: TextStyle(
//                   color: color,
//                   fontSize: 11,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 15),
//         ClipRRect(
//           borderRadius: BorderRadius.circular(5),
//           child: LinearProgressIndicator(
//             value: value,
//             minHeight: 15,
//             backgroundColor: const Color(0xFFE5E7EB),
//             valueColor: AlwaysStoppedAnimation<Color>(color),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _MaintenanceSettingsCard extends StatelessWidget {
//   final String selectedWindow;
//   final List<String> windows;
//   final bool autoBackup;
//   final ValueChanged<String> onWindowChanged;
//   final ValueChanged<bool> onBackupChanged;

//   const _MaintenanceSettingsCard({
//     required this.selectedWindow,
//     required this.windows,
//     required this.autoBackup,
//     required this.onWindowChanged,
//     required this.onBackupChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return _Panel(
//       title: 'Maintenances Settings',
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Maintenance window',
//             style: TextStyle(fontSize: 13.5, color: Color(0xFF454D5C)),
//           ),
//           const SizedBox(height: 14),
//           DropdownButtonFormField<String>(
//             value: selectedWindow,
//             isExpanded: true,
//             icon: const Icon(
//               Icons.keyboard_arrow_down,
//               color: Color(0xFF111827),
//             ),
//             decoration: InputDecoration(
//               filled: true,
//               fillColor: const Color(0xFFF9F9FA),
//               contentPadding: const EdgeInsets.symmetric(
//                 horizontal: 12,
//                 vertical: 10,
//               ),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: const BorderSide(color: Color(0xFFDCE3EA)),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: const BorderSide(color: Color(0xFFDCE3EA)),
//               ),
//             ),
//             items: windows
//                 .map(
//                   (window) => DropdownMenuItem(
//                     value: window,
//                     child: Text(
//                       window,
//                       style: const TextStyle(fontSize: 13.5),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                 )
//                 .toList(),
//             onChanged: (value) {
//               if (value != null) onWindowChanged(value);
//             },
//           ),
//           const SizedBox(height: 17),
//           Row(
//             children: [
//               const Text(
//                 'Auto Backup',
//                 style: TextStyle(fontSize: 13.5, color: Color(0xFF344054)),
//               ),
//               const SizedBox(width: 17),
//               Switch.adaptive(
//                 value: autoBackup,
//                 activeColor: Colors.white,
//                 activeTrackColor: const Color(0xFF2860ED),
//                 onChanged: onBackupChanged,
//               ),
//             ],
//           ),
//           const SizedBox(height: 9),
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
//             decoration: BoxDecoration(
//               border: Border.all(color: const Color(0xFFD8E5FF)),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: const Row(
//               children: [
//                 Icon(Icons.info_outline, color: Color(0xFF2454E8), size: 14),
//                 SizedBox(width: 8),
//                 Expanded(
//                   child: Text(
//                     'Schedule maintenance to ensure smooth database performance and reduce downtime.',
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       color: Color(0xFF2454E8),
//                       fontSize: 10.5,
//                       height: 1.2,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _Panel extends StatelessWidget {
//   final String title;
//   final Widget child;

//   const _Panel({required this.title, required this.child});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border.all(color: const Color(0xFFDCE5EF)),
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: const [
//           BoxShadow(
//             color: Color(0x080F172A),
//             blurRadius: 12,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(
//               color: Color(0xFF111B31),
//               fontSize: 17,
//               fontWeight: FontWeight.w700,
//               letterSpacing: -0.25,
//             ),
//           ),
//           const SizedBox(height: 16),
//           child,
//         ],
//       ),
//     );
//   }
// }

// class _SavedBanner extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       constraints: const BoxConstraints(minHeight: 60),
//       padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border.all(color: const Color(0xFFD4EBDD)),
//         borderRadius: BorderRadius.circular(11),
//         boxShadow: const [
//           BoxShadow(
//             color: Color(0x12000000),
//             blurRadius: 7,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: const Row(
//         children: [
//           SizedBox(
//             height: 44,
//             child: VerticalDivider(
//               width: 8,
//               thickness: 5,
//               color: Color(0xFF16834C),
//             ),
//           ),
//           SizedBox(width: 14),
//           Icon(Icons.check_circle, color: Color(0xFF16834C), size: 21),
//           SizedBox(width: 15),
//           Expanded(
//             child: Text(
//               'Your changes has been saved successfully.',
//               style: TextStyle(
//                 color: Color(0xFF16834C),
//                 fontSize: 15,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _ConnectionToast extends StatelessWidget {
//   final double maxWidth;

//   const _ConnectionToast({required this.maxWidth});

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.transparent,
//       child: Container(
//         width: maxWidth,
//         constraints: BoxConstraints(maxWidth: maxWidth),
//         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 17),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           border: Border.all(color: const Color(0xFF9BE7B5)),
//           borderRadius: BorderRadius.circular(11),
//           boxShadow: const [
//             BoxShadow(
//               color: Color(0x16000000),
//               blurRadius: 12,
//               offset: Offset(0, 4),
//             ),
//           ],
//         ),
//         child: const Row(
//           children: [
//             Icon(
//               Icons.check_circle_outline,
//               color: Color(0xFF00B85A),
//               size: 24,
//             ),
//             SizedBox(width: 11),
//             Flexible(
//               child: Text(
//                 'Connection successful',
//                 overflow: TextOverflow.ellipsis,
//                 style: TextStyle(
//                   color: Color(0xFF20252D),
//                   fontSize: 13.5,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _Dot extends StatelessWidget {
//   final Color color;
//   final double size;

//   const _Dot({required this.color, this.size = 9});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: size,
//       height: size,
//       decoration: BoxDecoration(color: color, shape: BoxShape.circle),
//     );
//   }
// }
import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app_theme.dart';

/// App-wide Riverpod settings. Keep the application's ProviderScope above
/// MaterialApp/GoRouter (normally in main.dart), not inside individual routes,
/// so values remain available when navigating away and returning.
/// These in-memory values survive route changes, not a full browser restart.
class TenantDatabaseSettings {
  final String selectedTenant;
  final String maintenanceWindow;
  final bool autoBackup;

  const TenantDatabaseSettings({
    this.selectedTenant = 'ABX Technologies Pvt.Ltd',
    this.maintenanceWindow = 'Sunday 02.00 AM',
    this.autoBackup = true,
  });

  TenantDatabaseSettings copyWith({
    String? selectedTenant,
    String? maintenanceWindow,
    bool? autoBackup,
  }) => TenantDatabaseSettings(
    selectedTenant: selectedTenant ?? this.selectedTenant,
    maintenanceWindow: maintenanceWindow ?? this.maintenanceWindow,
    autoBackup: autoBackup ?? this.autoBackup,
  );
}

class TenantDatabaseSettingsNotifier extends Notifier<TenantDatabaseSettings> {
  @override
  TenantDatabaseSettings build() => const TenantDatabaseSettings();

  /// Commit all edited values together only when the user presses Save.
  void save({
    required String selectedTenant,
    required String maintenanceWindow,
    required bool autoBackup,
  }) {
    state = state.copyWith(
      selectedTenant: selectedTenant,
      maintenanceWindow: maintenanceWindow,
      autoBackup: autoBackup,
    );
  }
}

final tenantDatabaseSettingsProvider =
    NotifierProvider<TenantDatabaseSettingsNotifier, TenantDatabaseSettings>(
      TenantDatabaseSettingsNotifier.new,
    );

/// Tenant Database page for the Tenant Management module.
/// This page is a child route inside AppLayout and does not create a Scaffold.
class TenantDatabasePage extends ConsumerStatefulWidget {
  const TenantDatabasePage({super.key});

  @override
  ConsumerState<TenantDatabasePage> createState() => _TenantDatabasePageState();
}

class _TenantDatabasePageState extends ConsumerState<TenantDatabasePage> {
  static const List<String> _tenants = [
    'ABX Technologies Pvt.Ltd',
    'Stackly Technologies',
    'Nexa Solutions Pvt.Ltd',
    'Vertex Global Systems',
  ];

  static const List<String> _maintenanceWindows = [
    'Sunday 02.00 AM',
    'Sunday 03.00 AM',
    'Saturday 01.00 AM',
    'Saturday 02.00 AM',
    'Monday 02.00 AM',
  ];

  bool _showSavedBanner = false;
  bool _showConnectionToast = false;
  bool _isRefreshing = false;
  Timer? _bannerTimer;
  Timer? _toastTimer;

  // Editable draft values. These are separate from the saved Riverpod state.
  // They are committed only when the Save button is pressed.
  late String _draftSelectedTenant;
  late String _draftMaintenanceWindow;
  late bool _draftAutoBackup;

  @override
  void initState() {
    super.initState();
    final saved = ref.read(tenantDatabaseSettingsProvider);
    _draftSelectedTenant = saved.selectedTenant;
    _draftMaintenanceWindow = saved.maintenanceWindow;
    _draftAutoBackup = saved.autoBackup;
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    _toastTimer?.cancel();
    super.dispose();
  }

  void _saveChanges() {
    // Persist the draft to the app-wide Riverpod state only on Save.
    ref
        .read(tenantDatabaseSettingsProvider.notifier)
        .save(
          selectedTenant: _draftSelectedTenant,
          maintenanceWindow: _draftMaintenanceWindow,
          autoBackup: _draftAutoBackup,
        );

    setState(() => _showSavedBanner = true);
    _bannerTimer?.cancel();
    _bannerTimer = Timer(const Duration(seconds: 4), () {
      if (mounted) setState(() => _showSavedBanner = false);
    });
  }

  Future<void> _refresh() async {
    if (_isRefreshing) return;
    setState(() {
      _isRefreshing = true;
      _showSavedBanner = false;
      final saved = ref.read(tenantDatabaseSettingsProvider);
      _draftSelectedTenant = saved.selectedTenant;
      _draftMaintenanceWindow = saved.maintenanceWindow;
      _draftAutoBackup = saved.autoBackup;
    });
    await Future<void>.delayed(const Duration(milliseconds: 1400));
    if (mounted) setState(() => _isRefreshing = false);
  }

  void _testConnection() {
    setState(() => _showConnectionToast = true);
    _toastTimer?.cancel();
    _toastTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) setState(() => _showConnectionToast = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.hasBoundedWidth
            ? constraints.maxWidth
            : MediaQuery.sizeOf(context).width;
        final isNarrow = width < 1180;
        final horizontalPadding = width < 500 ? 14.0 : 20.0;

        return Stack(
          children: [
            SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                18,
                horizontalPadding,
                24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPageHeader(isNarrow),
                  if (_showSavedBanner) ...[
                    const SizedBox(height: 16),
                    _SavedBanner(),
                  ],
                  const SizedBox(height: 18),
                  _buildTenantSelector(isNarrow, _draftSelectedTenant),
                  const SizedBox(height: 16),
                  if (width < 960)
                    Column(
                      children: [
                        _DatabaseDetailsCard(),
                        const SizedBox(height: 16),
                        const _StorageInformationCard(),
                        const SizedBox(height: 16),
                        const _DatabaseHealthCard(),
                        const SizedBox(height: 16),
                        _MaintenanceSettingsCard(
                          selectedWindow: _draftMaintenanceWindow,
                          windows: _maintenanceWindows,
                          autoBackup: _draftAutoBackup,
                          onWindowChanged: (value) {
                            setState(() => _draftMaintenanceWindow = value);
                          },
                          onBackupChanged: (value) {
                            setState(() => _draftAutoBackup = value);
                          },
                        ),
                      ],
                    )
                  else
                    Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _DatabaseDetailsCard()),
                            const SizedBox(width: 16),
                            const Expanded(child: _StorageInformationCard()),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Expanded(child: _DatabaseHealthCard()),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _MaintenanceSettingsCard(
                                selectedWindow: _draftMaintenanceWindow,
                                windows: _maintenanceWindows,
                                autoBackup: _draftAutoBackup,
                                onWindowChanged: (value) {
                                  setState(
                                    () => _draftMaintenanceWindow = value,
                                  );
                                },
                                onBackupChanged: (value) {
                                  setState(() => _draftAutoBackup = value);
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                ],
              ),
            ),
            if (_isRefreshing)
              Positioned.fill(
                child: ColoredBox(
                  color: Colors.black.withValues(alpha: 0.28),
                  child: Center(
                    child: Container(
                      width: 200,
                      padding: const EdgeInsets.symmetric(
                        vertical: 28,
                        horizontal: 24,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 42,
                            height: 42,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.4,
                              color: AppTheme.ink,
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            'Refreshing...',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.text,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            if (_showConnectionToast)
              Positioned(
                top: 12,
                left: 16,
                right: 16,
                child: Align(
                  alignment: Alignment.topRight,
                  child: LayoutBuilder(
                    builder: (context, toastConstraints) {
                      return _ConnectionToast(
                        maxWidth: math.min(330.0, toastConstraints.maxWidth),
                      );
                    },
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildPageHeader(bool isNarrow) {
    final actions = Wrap(
      spacing: 10,
      runSpacing: 8,
      children: [
        OutlinedButton.icon(
          onPressed: _refresh,
          icon: const Icon(Icons.refresh, size: 17),
          label: const Text('Refresh'),
          style: _actionButtonStyle(),
        ),
        OutlinedButton.icon(
          onPressed: _saveChanges,
          icon: const Icon(Icons.save_outlined, size: 17),
          label: const Text('Save'),
          style: _actionButtonStyle(),
        ),
        ElevatedButton.icon(
          onPressed: _testConnection,
          icon: const Icon(Icons.link, size: 17),
          label: const Text('Test Connection'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3047F5),
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
            textStyle: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isNarrow) ...[
          const Text(
            'Tenant Database',
            style: TextStyle(
              color: Color(0xFF1B2936),
              fontSize: 25,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Manage tenant databases, monitor health, storage, and backup configurations',
            style: TextStyle(fontSize: 12.5, color: Colors.black87),
          ),
          const SizedBox(height: 14),
          actions,
        ] else
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tenant Database',
                      style: TextStyle(
                        color: Color(0xFF1B2936),
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Manage tenant databases, monitor health, storage, and backup configurations',
                      style: TextStyle(fontSize: 12.5, color: Colors.black87),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              actions,
            ],
          ),
      ],
    );
  }

  ButtonStyle _actionButtonStyle() {
    return OutlinedButton.styleFrom(
      foregroundColor: const Color(0xFF1C2935),
      side: const BorderSide(color: Color(0xFFDCE3EA)),
      backgroundColor: Colors.white,
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildTenantSelector(bool isNarrow, String selectedTenant) {
    final selector = SizedBox(
      width: 256,
      height: 41,
      child: DropdownButtonFormField<String>(
        value: selectedTenant,
        isExpanded: true,
        icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF111827)),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 13,
            vertical: 9,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFDCE3EA)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFDCE3EA)),
          ),
        ),
        items: _tenants
            .map(
              (tenant) => DropdownMenuItem(
                value: tenant,
                child: Text(
                  tenant,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 13.5),
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          if (value != null) {
            setState(() => _draftSelectedTenant = value);
          }
        },
      ),
    );

    return isNarrow
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Tenant',
                style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              SizedBox(width: double.infinity, child: selector),
            ],
          )
        : Row(
            children: [
              const SizedBox(
                width: 106,
                child: Text(
                  'Select Tenant',
                  style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
                ),
              ),
              selector,
            ],
          );
  }
}

class _DatabaseDetailsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _Panel(
      title: 'Database Details',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _ReadOnlyField(label: 'Database Name', value: 'tenant_abc_db'),
          SizedBox(height: 14),
          _ReadOnlyField(label: 'Database Type', value: 'PosgreSQL'),
          SizedBox(height: 14),
          _ReadOnlyField(label: 'Server Name', value: 'db-server-01'),
          SizedBox(height: 15),
          _ConnectionStatus(),
        ],
      ),
    );
  }
}

class _ReadOnlyField extends StatelessWidget {
  final String label;
  final String value;

  const _ReadOnlyField({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13.5, color: Color(0xFF343B4B)),
        ),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          height: 40,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF9F9FA),
            border: Border.all(color: const Color(0xFFDCE3EA)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: const TextStyle(fontSize: 13.5, color: Color(0xFF17191D)),
          ),
        ),
      ],
    );
  }
}

class _ConnectionStatus extends StatelessWidget {
  const _ConnectionStatus();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: const Color(0xFFE2FCE8),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Row(
        children: [
          Expanded(
            child: Text(
              'Connection Status',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 13.5, color: Color(0xFF374151)),
            ),
          ),
          _Dot(color: Color(0xFF10B981), size: 10),
          SizedBox(width: 8),
          Text(
            'Connected',
            style: TextStyle(
              color: Color(0xFF009B69),
              fontSize: 13.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _StorageInformationCard extends StatelessWidget {
  const _StorageInformationCard();

  @override
  Widget build(BuildContext context) {
    return _Panel(
      title: 'Storage Information',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 380;
          return Column(
            children: [
              const SizedBox(height: 8),
              SizedBox(
                height: compact ? 218 : 220,
                width: double.infinity,
                child: CustomPaint(
                  painter: _StorageGaugePainter(),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      // Keep the value in the open centre of the semicircle,
                      // below the arc rather than over the coloured stroke.
                      padding: const EdgeInsets.only(bottom: 17),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            'USED',
                            style: TextStyle(
                              color: Color(0xFF71819B),
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.8,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '45 GB',
                            style: TextStyle(
                              color: Color(0xFF111827),
                              fontSize: 34,
                              height: 1,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              if (compact)
                const Column(
                  children: [
                    _StorageLegend(
                      color: Color(0xFF2860ED),
                      title: 'Used Storage',
                      amount: '45 GB',
                      percent: '(45%)',
                    ),
                    SizedBox(height: 10),
                    _StorageLegend(
                      color: Color(0xFF20B6EF),
                      title: 'Free Storage',
                      amount: '35 GB',
                      percent: '(35%)',
                    ),
                    SizedBox(height: 10),
                    _StorageLegend(
                      color: Color(0xFFE1E7EF),
                      title: 'Available Storage',
                      amount: '20 GB',
                      percent: '(20%)',
                    ),
                  ],
                )
              else
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: _StorageLegend(
                        color: Color(0xFF2860ED),
                        title: 'Used Storage',
                        amount: '45 GB',
                        percent: '(45%)',
                      ),
                    ),
                    Expanded(
                      child: _StorageLegend(
                        color: Color(0xFF20B6EF),
                        title: 'Free Storage',
                        amount: '35 GB',
                        percent: '(35%)',
                      ),
                    ),
                    Expanded(
                      child: _StorageLegend(
                        color: Color(0xFFE1E7EF),
                        title: 'Available Storage',
                        amount: '20 GB',
                        percent: '(20%)',
                      ),
                    ),
                  ],
                ),
            ],
          );
        },
      ),
    );
  }
}

class _StorageGaugePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double stroke = math.max(20.0, math.min(28.0, size.width * 0.075));
    // A wider radius gives the gauge a more open shape on narrow phones.
    final double radius = math.min(size.width * 0.325, size.height * 0.72);
    final center = Offset(size.width / 2, size.height - stroke / 2 - 8);
    final rect = Rect.fromCircle(center: center, radius: radius);
    const start = math.pi;
    const sweep = math.pi;

    final base = Paint()
      ..color = const Color(0xFFE2E8F0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.butt;
    canvas.drawArc(rect, start, sweep, false, base);

    final used = Paint()
      ..color = const Color(0xFF2860ED)
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.butt;
    canvas.drawArc(rect, start, sweep * .45, false, used);

    final free = Paint()
      ..color = const Color(0xFF20B6EF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.butt;
    canvas.drawArc(rect, start + sweep * .45, sweep * .35, false, free);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _StorageLegend extends StatelessWidget {
  final Color color;
  final String title;
  final String amount;
  final String percent;

  const _StorageLegend({
    required this.color,
    required this.title,
    required this.amount,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _Dot(color: color, size: 10),
            const SizedBox(width: 7),
            Flexible(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.5,
                  color: Color(0xFF667085),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: amount,
                style: const TextStyle(
                  color: Color(0xFF111827),
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
              TextSpan(
                text: '  $percent',
                style: const TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 10.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DatabaseHealthCard extends StatelessWidget {
  const _DatabaseHealthCard();

  @override
  Widget build(BuildContext context) {
    return _Panel(
      title: 'Database Health',
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _MetricBar(
            label: 'CPU Usage',
            percent: '67%',
            value: .32,
            color: Color(0xFF13B8A6),
            badgeColor: Color(0xFFCFF2EE),
          ),
          SizedBox(height: 20),
          _MetricBar(
            label: 'Memory Utilization',
            percent: '54%',
            value: .25,
            color: Color(0xFF702080),
            badgeColor: Color(0xFFF0D3F5),
          ),
          SizedBox(height: 20),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            runSpacing: 6,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.history, size: 15, color: Color(0xFF64748B)),
                  SizedBox(width: 8),
                  Text(
                    'Last Backup',
                    style: TextStyle(fontSize: 13.5, color: Color(0xFF454D5C)),
                  ),
                ],
              ),
              Text(
                '08-Sep-2026 02:00 AM',
                style: TextStyle(fontSize: 13.5, color: Color(0xFF17191D)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetricBar extends StatelessWidget {
  final String label;
  final String percent;
  final double value;
  final Color color;
  final Color badgeColor;

  const _MetricBar({
    required this.label,
    required this.percent,
    required this.value,
    required this.color,
    required this.badgeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 13.5, color: Color(0xFF454D5C)),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: badgeColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                percent,
                style: TextStyle(
                  color: color,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: LinearProgressIndicator(
            value: value,
            minHeight: 15,
            backgroundColor: const Color(0xFFE5E7EB),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }
}

class _MaintenanceSettingsCard extends StatelessWidget {
  final String selectedWindow;
  final List<String> windows;
  final bool autoBackup;
  final ValueChanged<String> onWindowChanged;
  final ValueChanged<bool> onBackupChanged;

  const _MaintenanceSettingsCard({
    required this.selectedWindow,
    required this.windows,
    required this.autoBackup,
    required this.onWindowChanged,
    required this.onBackupChanged,
  });

  @override
  Widget build(BuildContext context) {
    return _Panel(
      title: 'Maintenances Settings',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Maintenance window',
            style: TextStyle(fontSize: 13.5, color: Color(0xFF454D5C)),
          ),
          const SizedBox(height: 14),
          DropdownButtonFormField<String>(
            value: selectedWindow,
            isExpanded: true,
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Color(0xFF111827),
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFF9F9FA),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFDCE3EA)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFDCE3EA)),
              ),
            ),
            items: windows
                .map(
                  (window) => DropdownMenuItem(
                    value: window,
                    child: Text(
                      window,
                      style: const TextStyle(fontSize: 13.5),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) onWindowChanged(value);
            },
          ),
          const SizedBox(height: 17),
          Row(
            children: [
              const Text(
                'Auto Backup',
                style: TextStyle(fontSize: 13.5, color: Color(0xFF344054)),
              ),
              const SizedBox(width: 17),
              Switch.adaptive(
                value: autoBackup,
                activeColor: Colors.white,
                activeTrackColor: const Color(0xFF2860ED),
                onChanged: onBackupChanged,
              ),
            ],
          ),
          const SizedBox(height: 9),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFD8E5FF)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Icon(Icons.info_outline, color: Color(0xFF2454E8), size: 14),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Schedule maintenance to ensure smooth database performance and reduce downtime.',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Color(0xFF2454E8),
                      fontSize: 10.5,
                      height: 1.2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Panel extends StatelessWidget {
  final String title;
  final Widget child;

  const _Panel({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFDCE5EF)),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x080F172A),
            blurRadius: 12,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF111B31),
              fontSize: 17,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.25,
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _SavedBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 60),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFD4EBDD)),
        borderRadius: BorderRadius.circular(11),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: const Row(
        children: [
          SizedBox(
            height: 44,
            child: VerticalDivider(
              width: 8,
              thickness: 5,
              color: Color(0xFF16834C),
            ),
          ),
          SizedBox(width: 14),
          Icon(Icons.check_circle, color: Color(0xFF16834C), size: 21),
          SizedBox(width: 15),
          Expanded(
            child: Text(
              'Your changes has been saved successfully.',
              style: TextStyle(
                color: Color(0xFF16834C),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ConnectionToast extends StatelessWidget {
  final double maxWidth;

  const _ConnectionToast({required this.maxWidth});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: maxWidth,
        constraints: BoxConstraints(maxWidth: maxWidth),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 17),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFF9BE7B5)),
          borderRadius: BorderRadius.circular(11),
          boxShadow: const [
            BoxShadow(
              color: Color(0x16000000),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: const Row(
          children: [
            Icon(
              Icons.check_circle_outline,
              color: Color(0xFF00B85A),
              size: 24,
            ),
            SizedBox(width: 11),
            Flexible(
              child: Text(
                'Connection successful',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Color(0xFF20252D),
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final Color color;
  final double size;

  const _Dot({required this.color, this.size = 9});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
