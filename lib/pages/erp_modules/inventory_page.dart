// import 'package:flutter/material.dart';

// import '../../app_theme.dart';

// import '../../widgets/app_layout.dart';

// class InventoryPage extends StatefulWidget {
//   const InventoryPage({super.key});

//   @override
//   State<InventoryPage> createState() => _InventoryPageState();
// }

// class _InventoryPageState extends State<InventoryPage> {
//   final TextEditingController _searchController = TextEditingController();

//   String selectedCategory = 'All Categories';

//   String selectedStatus = 'All Status';

//   final List<Map<String, dynamic>> inventoryItems = [
//     {
//       'sku': 'SKU-1001',

//       'name': 'Wireless Keyboard',

//       'category': 'Electronics',

//       'warehouse': 'Hyderabad WH',

//       'quantity': 145,

//       'reorder': 50,

//       'unit': 'pcs',

//       'status': 'In Stock',

//       'value': 36250,
//     },

//     {
//       'sku': 'SKU-1002',

//       'name': 'Wireless Mouse',

//       'category': 'Electronics',

//       'warehouse': 'Hyderabad WH',

//       'quantity': 38,

//       'reorder': 40,

//       'unit': 'pcs',

//       'status': 'Low Stock',

//       'value': 7600,
//     },

//     {
//       'sku': 'SKU-1003',

//       'name': 'USB-C Cable',

//       'category': 'Accessories',

//       'warehouse': 'Bangalore WH',

//       'quantity': 420,

//       'reorder': 100,

//       'unit': 'pcs',

//       'status': 'In Stock',

//       'value': 21000,
//     },

//     {
//       'sku': 'SKU-1004',

//       'name': 'HDMI Cable 2M',

//       'category': 'Accessories',

//       'warehouse': 'Chennai WH',

//       'quantity': 74,

//       'reorder': 80,

//       'unit': 'pcs',

//       'status': 'Low Stock',

//       'value': 9250,
//     },

//     {
//       'sku': 'SKU-1005',

//       'name': '24" LED Monitor',

//       'category': 'Displays',

//       'warehouse': 'Hyderabad WH',

//       'quantity': 0,

//       'reorder': 20,

//       'unit': 'pcs',

//       'status': 'Out of Stock',

//       'value': 0,
//     },

//     {
//       'sku': 'SKU-1006',

//       'name': 'Laptop Stand',

//       'category': 'Office',

//       'warehouse': 'Bangalore WH',

//       'quantity': 96,

//       'reorder': 30,

//       'unit': 'pcs',

//       'status': 'In Stock',

//       'value': 28800,
//     },

//     {
//       'sku': 'SKU-1007',

//       'name': 'Ethernet Cable',

//       'category': 'Networking',

//       'warehouse': 'Chennai WH',

//       'quantity': 215,

//       'reorder': 75,

//       'unit': 'pcs',

//       'status': 'In Stock',

//       'value': 10750,
//     },

//     {
//       'sku': 'SKU-1008',

//       'name': 'Network Switch 8-Port',

//       'category': 'Networking',

//       'warehouse': 'Hyderabad WH',

//       'quantity': 18,

//       'reorder': 25,

//       'unit': 'pcs',

//       'status': 'Low Stock',

//       'value': 23400,
//     },

//     {
//       'sku': 'SKU-1009',

//       'name': 'Bluetooth Speaker',

//       'category': 'Electronics',

//       'warehouse': 'Bangalore WH',

//       'quantity': 62,

//       'reorder': 25,

//       'unit': 'pcs',

//       'status': 'In Stock',

//       'value': 18600,
//     },

//     {
//       'sku': 'SKU-1010',

//       'name': 'Power Adapter',

//       'category': 'Accessories',

//       'warehouse': 'Chennai WH',

//       'quantity': 7,

//       'reorder': 15,

//       'unit': 'pcs',

//       'status': 'Low Stock',

//       'value': 3500,
//     },
//   ];

//   @override
//   void dispose() {
//     _searchController.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppTheme.paperDim,

//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           final isMobile = constraints.maxWidth < 750;

//           final horizontalPadding = isMobile ? 16.0 : 28.0;

//           return SafeArea(
//             bottom: false,

//             child: Column(
//               children: [
//                 // ==================================================

//                 // FIXED INVENTORY HEADER

//                 // ==================================================
//                 Padding(
//                   padding: EdgeInsets.fromLTRB(
//                     horizontalPadding,

//                     isMobile ? 8 : 10,

//                     horizontalPadding,

//                     0,
//                   ),

//                   child: _buildPageHeader(isMobile),
//                 ),

//                 // ==================================================

//                 // SCROLLABLE CONTENT

//                 // ==================================================
//                 Expanded(
//                   child: SingleChildScrollView(
//                     padding: EdgeInsets.fromLTRB(
//                       horizontalPadding,

//                       14,

//                       horizontalPadding,

//                       28,
//                     ),

//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,

//                       children: [
//                         _buildSummaryCards(isMobile),

//                         const SizedBox(height: 24),

//                         _buildInventoryHealth(isMobile),

//                         const SizedBox(height: 24),

//                         _buildInventoryTable(isMobile),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   // ---------------------------------------------------------------------------

//   // HEADER

//   // ---------------------------------------------------------------------------

//   Widget _buildPageHeader(bool isMobile) {
//     return Container(
//       width: double.infinity,

//       padding: EdgeInsets.symmetric(
//         horizontal: isMobile ? 10 : 14,

//         vertical: 7,
//       ),

//       decoration: BoxDecoration(
//         color: AppTheme.paper,

//         borderRadius: BorderRadius.circular(10),

//         border: Border.all(color: AppTheme.border),
//       ),

//       child: Row(
//         children: [
//           Container(
//             width: 32,

//             height: 32,

//             decoration: BoxDecoration(
//               color: AppTheme.ink3.withValues(alpha: 0.08),

//               borderRadius: BorderRadius.circular(8),
//             ),

//             child: const Icon(
//               Icons.inventory_2_outlined,

//               color: AppTheme.ink3,

//               size: 17,
//             ),
//           ),

//           const SizedBox(width: 9),

//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,

//               mainAxisSize: MainAxisSize.min,

//               children: [
//                 const Text(
//                   'Inventory',

//                   maxLines: 1,

//                   overflow: TextOverflow.ellipsis,

//                   style: TextStyle(
//                     fontSize: 17,

//                     fontWeight: FontWeight.w800,

//                     color: AppTheme.text,
//                   ),
//                 ),

//                 const SizedBox(height: 1),

//                 const Text(
//                   'Manage products, stock levels and inventory across warehouses.',

//                   maxLines: 1,

//                   overflow: TextOverflow.ellipsis,

//                   style: TextStyle(fontSize: 10, color: AppTheme.textMuted),
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(width: 8),

//           ElevatedButton.icon(
//             onPressed: _showAddItemDialog,

//             icon: const Icon(Icons.add, size: 15),

//             label: const Text(
//               'Add Item',

//               style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
//             ),

//             style: _primaryButtonStyle(compact: true),
//           ),
//         ],
//       ),
//     );
//   }

//   // ---------------------------------------------------------------------------

//   // SUMMARY CARDS

//   // ---------------------------------------------------------------------------

//   Widget _buildSummaryCards(bool mobile) {
//     final cards = [
//       _summaryCard(
//         title: 'Total Items',
//         value: '10',
//         subtitle: 'Active SKUs',
//         icon: Icons.inventory_2_outlined,
//       ),
//       _summaryCard(
//         title: 'Total Units',
//         value: '1,075',
//         subtitle: 'Across warehouses',
//         icon: Icons.stacked_bar_chart_rounded,
//       ),
//       _summaryCard(
//         title: 'Low Stock',
//         value: '4',
//         subtitle: 'Needs attention',
//         icon: Icons.warning_amber_rounded,
//         alert: true,
//       ),
//       _summaryCard(
//         title: 'Inventory Value',
//         value: '₹1.59L',
//         subtitle: 'Current stock value',
//         icon: Icons.currency_rupee_rounded,
//       ),
//     ];

//     // Mobile: use a normal Column instead of GridView.
//     // This gives every KPI card its natural height and prevents
//     // vertical overflow even on very small screens such as 300px.
//     if (mobile) {
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           for (int i = 0; i < cards.length; i++) ...[
//             cards[i],
//             if (i != cards.length - 1) const SizedBox(height: 14),
//           ],
//         ],
//       );
//     }

//     // Desktop: keep all four KPI cards in one row.
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: cards.length,
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 4,
//         crossAxisSpacing: 14,
//         mainAxisSpacing: 14,
//         mainAxisExtent: 150,
//       ),
//       itemBuilder: (context, index) => cards[index],
//     );
//   }

//   Widget _summaryCard({
//     required String title,
//     required String value,
//     required String subtitle,
//     required IconData icon,
//     bool alert = false,
//   }) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16),
//       decoration: _cardDecoration(),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 width: 38,
//                 height: 38,
//                 decoration: BoxDecoration(
//                   color: alert ? const Color(0xFFFFF7E8) : AppTheme.paperDim,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Icon(
//                   icon,
//                   size: 20,
//                   color: alert ? const Color(0xFFD98B00) : AppTheme.ink3,
//                 ),
//               ),
//               const Spacer(),
//               Icon(Icons.more_horiz, size: 20, color: Colors.grey.shade400),
//             ],
//           ),
//           const SizedBox(height: 10),
//           Text(
//             title,
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//             style: const TextStyle(
//               fontSize: 12,
//               color: AppTheme.textMuted,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           const SizedBox(height: 3),
//           Text(
//             value,
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//             style: const TextStyle(
//               fontSize: 22,
//               fontWeight: FontWeight.w800,
//               color: AppTheme.text,
//             ),
//           ),
//           const SizedBox(height: 3),
//           Text(
//             subtitle,
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//             style: const TextStyle(fontSize: 11, color: AppTheme.textMuted),
//           ),
//         ],
//       ),
//     );
//   }

//   // ---------------------------------------------------------------------------

//   // INVENTORY HEALTH

//   // ---------------------------------------------------------------------------

//   Widget _buildInventoryHealth(bool mobile) {
//     return Container(
//       padding: const EdgeInsets.all(20),

//       decoration: _cardDecoration(),

//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,

//         children: [
//           Row(
//             children: [
//               const Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,

//                   children: [
//                     Text(
//                       'Inventory Health',

//                       style: TextStyle(
//                         fontSize: 17,

//                         fontWeight: FontWeight.w700,

//                         color: AppTheme.text,
//                       ),
//                     ),

//                     SizedBox(height: 4),

//                     Text(
//                       'Current stock availability overview',

//                       style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
//                     ),
//                   ],
//                 ),
//               ),

//               Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 10,

//                   vertical: 6,
//                 ),

//                 decoration: BoxDecoration(
//                   color: const Color(0xFFEFFAF3),

//                   borderRadius: BorderRadius.circular(20),
//                 ),

//                 child: const Row(
//                   children: [
//                     Icon(
//                       Icons.check_circle,

//                       size: 14,

//                       color: Color(0xFF1E9E5A),
//                     ),

//                     SizedBox(width: 5),

//                     Text(
//                       'Healthy',

//                       style: TextStyle(
//                         fontSize: 11,

//                         fontWeight: FontWeight.w700,

//                         color: Color(0xFF1E9E5A),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(height: 22),

//           if (mobile)
//             Column(
//               children: [
//                 _healthItem('In Stock', '60%', .60, const Color(0xFF1E9E5A)),

//                 const SizedBox(height: 16),

//                 _healthItem('Low Stock', '30%', .30, const Color(0xFFE5A100)),

//                 const SizedBox(height: 16),

//                 _healthItem(
//                   'Out of Stock',

//                   '10%',

//                   .10,

//                   const Color(0xFFD94A4A),
//                 ),
//               ],
//             )
//           else
//             Row(
//               children: [
//                 Expanded(
//                   child: _healthItem(
//                     'In Stock',

//                     '60%',

//                     .60,

//                     const Color(0xFF1E9E5A),
//                   ),
//                 ),

//                 const SizedBox(width: 30),

//                 Expanded(
//                   child: _healthItem(
//                     'Low Stock',

//                     '30%',

//                     .30,

//                     const Color(0xFFE5A100),
//                   ),
//                 ),

//                 const SizedBox(width: 30),

//                 Expanded(
//                   child: _healthItem(
//                     'Out of Stock',

//                     '10%',

//                     .10,

//                     const Color(0xFFD94A4A),
//                   ),
//                 ),
//               ],
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _healthItem(
//     String title,

//     String percentage,

//     double progress,

//     Color color,
//   ) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,

//       children: [
//         Row(
//           children: [
//             Text(
//               title,

//               style: const TextStyle(
//                 fontSize: 12,

//                 fontWeight: FontWeight.w600,

//                 color: AppTheme.text,
//               ),
//             ),

//             const Spacer(),

//             Text(
//               percentage,

//               style: TextStyle(
//                 fontSize: 12,

//                 fontWeight: FontWeight.w700,

//                 color: color,
//               ),
//             ),
//           ],
//         ),

//         const SizedBox(height: 8),

//         ClipRRect(
//           borderRadius: BorderRadius.circular(10),

//           child: LinearProgressIndicator(
//             value: progress,

//             minHeight: 7,

//             backgroundColor: const Color(0xFFE8EDF3),

//             valueColor: AlwaysStoppedAnimation<Color>(color),
//           ),
//         ),
//       ],
//     );
//   }

//   // ---------------------------------------------------------------------------

//   // INVENTORY TABLE

//   // ---------------------------------------------------------------------------

//   Widget _buildInventoryTable(bool mobile) {
//     return Container(
//       width: double.infinity,

//       decoration: _cardDecoration(),

//       child: Padding(
//         padding: const EdgeInsets.all(20),

//         child: Column(
//           children: [
//             _buildTableHeader(mobile),

//             const SizedBox(height: 18),

//             _buildFilters(mobile),

//             const SizedBox(height: 18),

//             mobile ? _buildMobileInventoryList() : _buildDesktopTable(),

//             const SizedBox(height: 10),

//             _buildPagination(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTableHeader(bool mobile) {
//     return Row(
//       children: [
//         const Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,

//             children: [
//               Text(
//                 'Inventory Items',

//                 style: TextStyle(
//                   fontSize: 18,

//                   fontWeight: FontWeight.w800,

//                   color: AppTheme.text,
//                 ),
//               ),

//               SizedBox(height: 4),

//               Text(
//                 'View and manage your current inventory',

//                 style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
//               ),
//             ],
//           ),
//         ),

//         if (!mobile)
//           OutlinedButton.icon(
//             onPressed: () {},

//             icon: const Icon(Icons.download_outlined, size: 17),

//             label: const Text('Export'),

//             style: OutlinedButton.styleFrom(
//               foregroundColor: AppTheme.text,

//               side: BorderSide(color: AppTheme.border),

//               padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//             ),
//           ),
//       ],
//     );
//   }

//   Widget _buildFilters(bool mobile) {
//     if (mobile) {
//       return Column(
//         children: [
//           _searchField(),

//           const SizedBox(height: 10),

//           Row(
//             children: [
//               Expanded(child: _categoryDropdown()),

//               const SizedBox(width: 10),

//               Expanded(child: _statusDropdown()),
//             ],
//           ),
//         ],
//       );
//     }

//     return Row(
//       children: [
//         Expanded(flex: 2, child: _searchField()),

//         const SizedBox(width: 12),

//         SizedBox(width: 190, child: _categoryDropdown()),

//         const SizedBox(width: 12),

//         SizedBox(width: 170, child: _statusDropdown()),
//       ],
//     );
//   }

//   Widget _searchField() {
//     return TextField(
//       controller: _searchController,

//       onChanged: (_) => setState(() {}),

//       decoration: InputDecoration(
//         hintText: 'Search by product, SKU or warehouse...',

//         hintStyle: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),

//         prefixIcon: const Icon(Icons.search, size: 19),

//         filled: true,

//         fillColor: AppTheme.paperDim,

//         contentPadding: const EdgeInsets.symmetric(vertical: 13),

//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),

//           borderSide: BorderSide.none,
//         ),
//       ),
//     );
//   }

//   Widget _categoryDropdown() {
//     return _dropdown(
//       value: selectedCategory,

//       items: const [
//         'All Categories',

//         'Electronics',

//         'Accessories',

//         'Displays',

//         'Office',

//         'Networking',
//       ],

//       onChanged: (value) {
//         setState(() {
//           selectedCategory = value!;
//         });
//       },
//     );
//   }

//   Widget _statusDropdown() {
//     return _dropdown(
//       value: selectedStatus,

//       items: const ['All Status', 'In Stock', 'Low Stock', 'Out of Stock'],

//       onChanged: (value) {
//         setState(() {
//           selectedStatus = value!;
//         });
//       },
//     );
//   }

//   Widget _dropdown({
//     required String value,

//     required List<String> items,

//     required ValueChanged<String?> onChanged,
//   }) {
//     return DropdownButtonFormField<String>(
//       value: value,

//       isExpanded: true,

//       decoration: InputDecoration(
//         filled: true,

//         fillColor: AppTheme.paperDim,

//         contentPadding: const EdgeInsets.symmetric(
//           horizontal: 12,

//           vertical: 12,
//         ),

//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),

//           borderSide: BorderSide.none,
//         ),
//       ),

//       style: const TextStyle(
//         fontSize: 12,

//         color: AppTheme.text,

//         fontWeight: FontWeight.w500,
//       ),

//       items: items
//           .map(
//             (item) => DropdownMenuItem(
//               value: item,

//               child: Text(item, overflow: TextOverflow.ellipsis),
//             ),
//           )
//           .toList(),

//       onChanged: onChanged,
//     );
//   }

//   // ---------------------------------------------------------------------------

//   // DESKTOP TABLE

//   // ---------------------------------------------------------------------------

//   Widget _buildDesktopTable() {
//     final items = _filteredItems();

//     return Container(
//       width: double.infinity,

//       decoration: BoxDecoration(
//         border: Border.all(color: const Color(0xFFE7EBF0)),

//         borderRadius: BorderRadius.circular(12),
//       ),

//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(12),

//         child: SingleChildScrollView(
//           scrollDirection: Axis.horizontal,

//           child: DataTable(
//             headingRowHeight: 48,

//             dataRowMinHeight: 70,

//             dataRowMaxHeight: 78,

//             horizontalMargin: 18,

//             columnSpacing: 25,

//             headingRowColor: WidgetStateProperty.all(AppTheme.paperDim),

//             columns: const [
//               DataColumn(label: Text('PRODUCT')),

//               DataColumn(label: Text('CATEGORY')),

//               DataColumn(label: Text('WAREHOUSE')),

//               DataColumn(label: Text('STOCK LEVEL')),

//               DataColumn(label: Text('STATUS')),

//               DataColumn(label: Text('VALUE')),

//               DataColumn(label: Text('')),
//             ],

//             rows: items.map((item) {
//               return DataRow(
//                 cells: [
//                   DataCell(_productCell(item)),

//                   DataCell(_categoryCell(item['category'])),

//                   DataCell(_warehouseCell(item['warehouse'])),

//                   DataCell(
//                     _stockLevel(
//                       item['quantity'],

//                       item['reorder'],

//                       item['unit'],
//                     ),
//                   ),

//                   DataCell(_statusBadge(item['status'])),

//                   DataCell(
//                     Text(
//                       _currency(item['value']),

//                       style: const TextStyle(
//                         fontSize: 12,

//                         fontWeight: FontWeight.w700,

//                         color: AppTheme.text,
//                       ),
//                     ),
//                   ),

//                   DataCell(
//                     IconButton(
//                       onPressed: () => _showItemDetails(item),

//                       icon: const Icon(Icons.more_vert, size: 19),

//                       color: AppTheme.textMuted,
//                     ),
//                   ),
//                 ],
//               );
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _productCell(Map<String, dynamic> item) {
//     return SizedBox(
//       width: 210,

//       child: Row(
//         children: [
//           Container(
//             width: 38,

//             height: 38,

//             decoration: BoxDecoration(
//               color: AppTheme.paperDim,

//               borderRadius: BorderRadius.circular(9),
//             ),

//             child: const Icon(
//               Icons.inventory_2_outlined,

//               size: 19,

//               color: AppTheme.ink3,
//             ),
//           ),

//           const SizedBox(width: 10),

//           Expanded(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,

//               crossAxisAlignment: CrossAxisAlignment.start,

//               children: [
//                 Text(
//                   item['name'],

//                   overflow: TextOverflow.ellipsis,

//                   style: const TextStyle(
//                     fontSize: 12,

//                     fontWeight: FontWeight.w700,

//                     color: AppTheme.text,
//                   ),
//                 ),

//                 const SizedBox(height: 3),

//                 Text(
//                   item['sku'],

//                   style: TextStyle(fontSize: 10, color: AppTheme.textMuted),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _categoryCell(String category) {
//     return Text(
//       category,

//       style: const TextStyle(fontSize: 12, color: Color(0xFF475569)),
//     );
//   }

//   Widget _warehouseCell(String warehouse) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,

//       children: [
//         Icon(Icons.warehouse_outlined, size: 16, color: AppTheme.textMuted),

//         const SizedBox(width: 6),

//         Text(
//           warehouse,

//           style: const TextStyle(fontSize: 12, color: Color(0xFF475569)),
//         ),
//       ],
//     );
//   }

//   Widget _stockLevel(int quantity, int reorder, String unit) {
//     final max = reorder * 4;

//     final progress = (quantity / max).clamp(0.0, 1.0);

//     Color color;

//     if (quantity == 0) {
//       color = const Color(0xFFD94A4A);
//     } else if (quantity <= reorder) {
//       color = const Color(0xFFE5A100);
//     } else {
//       color = const Color(0xFF1E9E5A);
//     }

//     return SizedBox(
//       width: 145,

//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,

//         mainAxisAlignment: MainAxisAlignment.center,

//         children: [
//           Row(
//             children: [
//               Text(
//                 '$quantity $unit',

//                 style: const TextStyle(
//                   fontSize: 12,

//                   fontWeight: FontWeight.w700,

//                   color: AppTheme.text,
//                 ),
//               ),

//               const Spacer(),

//               Text(
//                 'Min $reorder',

//                 style: TextStyle(fontSize: 9, color: AppTheme.textMuted),
//               ),
//             ],
//           ),

//           const SizedBox(height: 7),

//           ClipRRect(
//             borderRadius: BorderRadius.circular(5),

//             child: LinearProgressIndicator(
//               value: progress,

//               minHeight: 5,

//               backgroundColor: const Color(0xFFE9EEF3),

//               valueColor: AlwaysStoppedAnimation<Color>(color),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ---------------------------------------------------------------------------

//   // MOBILE LIST

//   // ---------------------------------------------------------------------------

//   Widget _buildMobileInventoryList() {
//     final items = _filteredItems();

//     if (items.isEmpty) {
//       return _emptyState();
//     }

//     return Column(
//       children: items.map((item) {
//         return Container(
//           margin: const EdgeInsets.only(bottom: 10),

//           padding: const EdgeInsets.all(14),

//           decoration: BoxDecoration(
//             color: const Color(0xFFFAFBFC),

//             borderRadius: BorderRadius.circular(12),

//             border: Border.all(color: const Color(0xFFE8ECF1)),
//           ),

//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     width: 42,

//                     height: 42,

//                     decoration: BoxDecoration(
//                       color: AppTheme.paperDim,

//                       borderRadius: BorderRadius.circular(10),
//                     ),

//                     child: const Icon(
//                       Icons.inventory_2_outlined,

//                       color: AppTheme.ink3,

//                       size: 20,
//                     ),
//                   ),

//                   const SizedBox(width: 11),

//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,

//                       children: [
//                         Text(
//                           item['name'],

//                           style: const TextStyle(
//                             fontSize: 13,

//                             fontWeight: FontWeight.w700,

//                             color: AppTheme.text,
//                           ),
//                         ),

//                         const SizedBox(height: 3),

//                         Text(
//                           item['sku'],

//                           style: TextStyle(
//                             fontSize: 10,

//                             color: AppTheme.textMuted,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   _statusBadge(item['status']),
//                 ],
//               ),

//               const SizedBox(height: 14),

//               const Divider(height: 1),

//               const SizedBox(height: 12),

//               Row(
//                 children: [
//                   Expanded(
//                     child: _mobileInfo(
//                       'Warehouse',

//                       item['warehouse'],

//                       Icons.warehouse_outlined,
//                     ),
//                   ),

//                   Expanded(
//                     child: _mobileInfo(
//                       'Category',

//                       item['category'],

//                       Icons.category_outlined,
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 12),

//               _stockLevel(item['quantity'], item['reorder'], item['unit']),

//               const SizedBox(height: 12),

//               Row(
//                 children: [
//                   const Text(
//                     'Stock Value',

//                     style: TextStyle(fontSize: 11, color: Color(0xFF64748B)),
//                   ),

//                   const Spacer(),

//                   Text(
//                     _currency(item['value']),

//                     style: const TextStyle(
//                       fontSize: 13,

//                       fontWeight: FontWeight.w700,

//                       color: AppTheme.text,
//                     ),
//                   ),

//                   IconButton(
//                     onPressed: () => _showItemDetails(item),

//                     icon: const Icon(Icons.more_vert, size: 19),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       }).toList(),
//     );
//   }

//   Widget _mobileInfo(String label, String value, IconData icon) {
//     return Row(
//       children: [
//         Icon(icon, size: 15, color: AppTheme.textMuted),

//         const SizedBox(width: 6),

//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,

//             children: [
//               Text(
//                 label,

//                 style: TextStyle(fontSize: 9, color: AppTheme.textMuted),
//               ),

//               const SizedBox(height: 2),

//               Text(
//                 value,

//                 overflow: TextOverflow.ellipsis,

//                 style: const TextStyle(
//                   fontSize: 11,

//                   fontWeight: FontWeight.w600,

//                   color: AppTheme.text,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   // ---------------------------------------------------------------------------

//   // STATUS

//   // ---------------------------------------------------------------------------

//   Widget _statusBadge(String status) {
//     Color background;

//     Color foreground;

//     IconData icon;

//     switch (status) {
//       case 'In Stock':
//         background = const Color(0xFFEAF8F0);

//         foreground = const Color(0xFF16834B);

//         icon = Icons.check_circle_outline;

//         break;

//       case 'Low Stock':
//         background = const Color(0xFFFFF5DF);

//         foreground = const Color(0xFFC17B00);

//         icon = Icons.warning_amber_outlined;

//         break;

//       default:
//         background = const Color(0xFFFFECEC);

//         foreground = const Color(0xFFC83C3C);

//         icon = Icons.remove_circle_outline;
//     }

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),

//       decoration: BoxDecoration(
//         color: background,

//         borderRadius: BorderRadius.circular(20),
//       ),

//       child: Row(
//         mainAxisSize: MainAxisSize.min,

//         children: [
//           Icon(icon, size: 13, color: foreground),

//           const SizedBox(width: 4),

//           Text(
//             status,

//             style: TextStyle(
//               fontSize: 10,

//               fontWeight: FontWeight.w700,

//               color: foreground,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ---------------------------------------------------------------------------

//   // PAGINATION

//   // ---------------------------------------------------------------------------

//   Widget _buildPagination() {
//     return Row(
//       children: [
//         Expanded(
//           child: Text(
//             'Showing ${_filteredItems().length} of ${inventoryItems.length} items',

//             style: TextStyle(fontSize: 11, color: AppTheme.textMuted),
//           ),
//         ),

//         IconButton(
//           onPressed: null,

//           icon: Icon(Icons.chevron_left, size: 19, color: Colors.grey.shade400),
//         ),

//         Container(
//           width: 30,

//           height: 30,

//           alignment: Alignment.center,

//           decoration: BoxDecoration(
//             color: AppTheme.ink3,

//             borderRadius: BorderRadius.circular(7),
//           ),

//           child: const Text(
//             '1',

//             style: TextStyle(
//               fontSize: 11,

//               fontWeight: FontWeight.w700,

//               color: AppTheme.paper,
//             ),
//           ),
//         ),

//         IconButton(
//           onPressed: null,

//           icon: Icon(
//             Icons.chevron_right,

//             size: 19,

//             color: Colors.grey.shade400,
//           ),
//         ),
//       ],
//     );
//   }

//   // ---------------------------------------------------------------------------

//   // FILTERING

//   // ---------------------------------------------------------------------------

//   List<Map<String, dynamic>> _filteredItems() {
//     final query = _searchController.text.trim().toLowerCase();

//     return inventoryItems.where((item) {
//       final matchesSearch =
//           query.isEmpty ||
//           item['name'].toString().toLowerCase().contains(query) ||
//           item['sku'].toString().toLowerCase().contains(query) ||
//           item['warehouse'].toString().toLowerCase().contains(query);

//       final matchesCategory =
//           selectedCategory == 'All Categories' ||
//           item['category'] == selectedCategory;

//       final matchesStatus =
//           selectedStatus == 'All Status' || item['status'] == selectedStatus;

//       return matchesSearch && matchesCategory && matchesStatus;
//     }).toList();
//   }

//   // ---------------------------------------------------------------------------

//   // DIALOGS

//   // ---------------------------------------------------------------------------

//   void _showAddItemDialog() {
//     final nameController = TextEditingController();

//     final skuController = TextEditingController();

//     final quantityController = TextEditingController();

//     showDialog(
//       context: context,

//       builder: (context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),

//           title: const Text(
//             'Add Inventory Item',

//             style: TextStyle(fontWeight: FontWeight.w700, color: AppTheme.text),
//           ),

//           content: SizedBox(
//             width: 430,

//             child: Column(
//               mainAxisSize: MainAxisSize.min,

//               children: [
//                 TextField(
//                   controller: nameController,

//                   decoration: _dialogInput(
//                     'Product Name',

//                     Icons.inventory_2_outlined,
//                   ),
//                 ),

//                 const SizedBox(height: 12),

//                 TextField(
//                   controller: skuController,

//                   decoration: _dialogInput('SKU', Icons.qr_code_2_outlined),
//                 ),

//                 const SizedBox(height: 12),

//                 TextField(
//                   controller: quantityController,

//                   keyboardType: TextInputType.number,

//                   decoration: _dialogInput(
//                     'Opening Quantity',

//                     Icons.numbers_outlined,
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),

//               child: const Text('Cancel'),
//             ),

//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context);

//                 ScaffoldMessenger.of(this.context).showSnackBar(
//                   const SnackBar(
//                     content: Text('Inventory item added successfully.'),
//                   ),
//                 );
//               },

//               style: _primaryButtonStyle(),

//               child: const Text('Add Item'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showItemDetails(Map<String, dynamic> item) {
//     showDialog(
//       context: context,

//       builder: (context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),

//           title: Text(
//             item['name'],

//             style: const TextStyle(
//               fontWeight: FontWeight.w700,

//               color: AppTheme.text,
//             ),
//           ),

//           content: Column(
//             mainAxisSize: MainAxisSize.min,

//             children: [
//               _detailRow('SKU', item['sku']),

//               _detailRow('Category', item['category']),

//               _detailRow('Warehouse', item['warehouse']),

//               _detailRow(
//                 'Available Stock',

//                 '${item['quantity']} ${item['unit']}',
//               ),

//               _detailRow('Reorder Level', '${item['reorder']} ${item['unit']}'),

//               _detailRow('Inventory Value', _currency(item['value'])),

//               const SizedBox(height: 8),

//               _statusBadge(item['status']),
//             ],
//           ),

//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),

//               child: const Text('Close'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget _detailRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 7),

//       child: Row(
//         children: [
//           Text(
//             label,

//             style: TextStyle(fontSize: 12, color: AppTheme.textMuted),
//           ),

//           const Spacer(),

//           Text(
//             value,

//             style: const TextStyle(
//               fontSize: 12,

//               fontWeight: FontWeight.w700,

//               color: AppTheme.text,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   InputDecoration _dialogInput(String label, IconData icon) {
//     return InputDecoration(
//       labelText: label,

//       prefixIcon: Icon(icon, size: 19),

//       border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//     );
//   }

//   // ---------------------------------------------------------------------------

//   // HELPERS

//   // ---------------------------------------------------------------------------

//   ButtonStyle _primaryButtonStyle({bool compact = false}) {
//     return ElevatedButton.styleFrom(
//       backgroundColor: AppTheme.ink3,

//       foregroundColor: AppTheme.paper,

//       elevation: 0,

//       padding: EdgeInsets.symmetric(
//         horizontal: compact ? 10 : 18,

//         vertical: compact ? 7 : 13,
//       ),

//       minimumSize: compact ? const Size(0, 32) : null,

//       tapTargetSize: compact
//           ? MaterialTapTargetSize.shrinkWrap
//           : MaterialTapTargetSize.padded,

//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(compact ? 8 : 10),
//       ),
//     );
//   }

//   BoxDecoration _cardDecoration() {
//     return BoxDecoration(
//       color: AppTheme.paper,

//       borderRadius: BorderRadius.circular(16),

//       border: Border.all(color: const Color(0xFFE6EAF0)),

//       boxShadow: [
//         BoxShadow(
//           color: Colors.black.withValues(alpha: .025),

//           blurRadius: 8,

//           offset: const Offset(0, 3),
//         ),
//       ],
//     );
//   }

//   Widget _emptyState() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 45),

//       child: Column(
//         children: [
//           Icon(Icons.search_off_rounded, size: 45, color: Colors.grey.shade400),

//           const SizedBox(height: 12),

//           const Text(
//             'No inventory items found',

//             style: TextStyle(
//               fontSize: 14,

//               fontWeight: FontWeight.w700,

//               color: AppTheme.text,
//             ),
//           ),

//           const SizedBox(height: 5),

//           Text(
//             'Try changing your search or filter selection.',

//             style: TextStyle(fontSize: 12, color: AppTheme.textMuted),
//           ),
//         ],
//       ),
//     );
//   }

//   String _currency(dynamic value) {
//     final amount = value is int ? value : int.tryParse(value.toString()) ?? 0;

//     if (amount >= 100000) {
//       return '₹${(amount / 100000).toStringAsFixed(2)}L';
//     }

//     if (amount >= 1000) {
//       return '₹${(amount / 1000).toStringAsFixed(1)}K';
//     }

//     return '₹$amount';
//   }
// }

import 'package:flutter/material.dart';

import '../../app_theme.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  final TextEditingController searchController = TextEditingController();

  String selectedStatus = 'All';
  String selectedCategory = 'All';

  final List<Map<String, dynamic>> inventoryItems = [
    {
      'sku': 'SKU-1001',
      'name': 'Wireless Keyboard',
      'category': 'Electronics',
      'warehouse': 'Hyderabad Main',
      'units': 245,
      'reorder': 50,
      'price': 1299,
      'status': 'In Stock',
      'updated': 'Today, 10:42 AM',
    },
    {
      'sku': 'SKU-1002',
      'name': 'Wireless Mouse',
      'category': 'Electronics',
      'warehouse': 'Bangalore DC',
      'units': 128,
      'reorder': 40,
      'price': 799,
      'status': 'In Stock',
      'updated': 'Today, 09:18 AM',
    },
    {
      'sku': 'SKU-1003',
      'name': 'USB-C Hub',
      'category': 'Accessories',
      'warehouse': 'Chennai Regional',
      'units': 32,
      'reorder': 50,
      'price': 1499,
      'status': 'Low Stock',
      'updated': 'Today, 08:35 AM',
    },
    {
      'sku': 'SKU-1004',
      'name': 'Laptop Stand',
      'category': 'Accessories',
      'warehouse': 'Pune Storage',
      'units': 86,
      'reorder': 30,
      'price': 1899,
      'status': 'In Stock',
      'updated': 'Yesterday, 06:12 PM',
    },
    {
      'sku': 'SKU-1005',
      'name': 'Bluetooth Speaker',
      'category': 'Electronics',
      'warehouse': 'Mumbai Fulfillment',
      'units': 18,
      'reorder': 35,
      'price': 2499,
      'status': 'Low Stock',
      'updated': 'Yesterday, 04:45 PM',
    },
    {
      'sku': 'SKU-1006',
      'name': 'HDMI Cable',
      'category': 'Cables',
      'warehouse': 'Delhi Regional',
      'units': 0,
      'reorder': 25,
      'price': 499,
      'status': 'Out of Stock',
      'updated': '12 Aug 2026',
    },
    {
      'sku': 'SKU-1007',
      'name': 'Mechanical Keyboard',
      'category': 'Electronics',
      'warehouse': 'Hyderabad Main',
      'units': 74,
      'reorder': 20,
      'price': 3499,
      'status': 'In Stock',
      'updated': 'Today, 11:05 AM',
    },
    {
      'sku': 'SKU-1008',
      'name': 'Web Camera',
      'category': 'Electronics',
      'warehouse': 'Bangalore DC',
      'units': 41,
      'reorder': 30,
      'price': 2899,
      'status': 'In Stock',
      'updated': 'Today, 10:15 AM',
    },
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // ===========================================================================
  // BUILD
  // ===========================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.paperDim,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool mobile = constraints.maxWidth < 850;

          final double horizontalPadding = mobile ? 12 : 28;
          final double topPadding = mobile ? 8 : 10;

          return SafeArea(
            bottom: false,
            child: Column(
              children: [
                // ==============================================================
                // FIXED HEADER
                // ==============================================================

                Padding(
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding,
                    topPadding,
                    horizontalPadding,
                    0,
                  ),
                  child: _buildHeader(mobile),
                ),

                // ==============================================================
                // SCROLLABLE CONTENT
                // ==============================================================
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(
                      horizontalPadding,
                      mobile ? 14 : 22,
                      horizontalPadding,
                      28,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildKpiSection(mobile),

                        const SizedBox(height: 18),

                        _buildInventoryHealthSection(mobile),

                        const SizedBox(height: 18),

                        _buildInventorySection(mobile),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ===========================================================================
  // HEADER
  // ===========================================================================

  Widget _buildHeader(bool mobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: mobile ? 10 : 14, vertical: 7),
      decoration: BoxDecoration(
        color: AppTheme.paper,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppTheme.border),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppTheme.ink3.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.inventory_2_outlined,
              color: AppTheme.ink3,
              size: 17,
            ),
          ),

          const SizedBox(width: 9),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Inventory',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.text,
                  ),
                ),
                SizedBox(height: 1),
                Text(
                  'Manage products, stock levels and inventory value.',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 10, color: AppTheme.textMuted),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          ElevatedButton.icon(
            onPressed: _showAddItemDialog,
            icon: const Icon(Icons.add, size: 15),
            label: const Text(
              'Add',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
            ),
            style: _primaryButtonStyle(compact: true),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // KPI SECTION
  // ===========================================================================

  Widget _buildKpiSection(bool mobile) {
    final cards = [
      _inventoryKpiCard(
        title: 'Total Items',
        value: _formatNumber(inventoryItems.length),
        icon: Icons.inventory_2_outlined,
      ),
      _inventoryKpiCard(
        title: 'Total Units',
        value: _formatNumber(_totalUnits()),
        icon: Icons.layers_outlined,
      ),
      _inventoryKpiCard(
        title: 'Low Stock',
        value: _formatNumber(_lowStockCount()),
        icon: Icons.warning_amber_outlined,
      ),
      _inventoryKpiCard(
        title: 'Inventory Value',
        value: _currency(_inventoryValue()),
        icon: Icons.currency_rupee,
      ),
    ];

    if (mobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (int i = 0; i < cards.length; i++) ...[
            cards[i],
            if (i != cards.length - 1) const SizedBox(height: 10),
          ],
        ],
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        const double gap = 14;

        final double width = (constraints.maxWidth - (gap * 3)) / 4;

        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: cards.map((card) {
            return SizedBox(width: width, child: card);
          }).toList(),
        );
      },
    );
  }

  Widget _inventoryKpiCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppTheme.paperDim,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 20, color: AppTheme.ink3),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppTheme.textMuted,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.text,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // INVENTORY HEALTH
  // ===========================================================================

  Widget _buildInventoryHealthSection(bool mobile) {
    final int total = inventoryItems.length;

    final int inStock = inventoryItems
        .where((item) => item['status'] == 'In Stock')
        .length;

    final int lowStock = _lowStockCount();

    final int outOfStock = inventoryItems
        .where((item) => item['status'] == 'Out of Stock')
        .length;

    final double healthyPercentage = total == 0 ? 0 : inStock / total;

    final double lowPercentage = total == 0 ? 0 : lowStock / total;

    final double outPercentage = total == 0 ? 0 : outOfStock / total;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Inventory Health',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.text,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Current stock availability and inventory health',
                      style: TextStyle(fontSize: 11, color: AppTheme.textMuted),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.paperDim,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${(healthyPercentage * 100).round()}% Healthy',
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.ink3,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          if (mobile)
            Column(
              children: [
                _healthItem(
                  title: 'In Stock',
                  count: inStock,
                  percentage: healthyPercentage,
                  color: const Color(0xFF1D9959),
                  icon: Icons.check_circle_outline,
                ),

                const SizedBox(height: 14),

                _healthItem(
                  title: 'Low Stock',
                  count: lowStock,
                  percentage: lowPercentage,
                  color: const Color(0xFFE09A00),
                  icon: Icons.warning_amber_outlined,
                ),

                const SizedBox(height: 14),

                _healthItem(
                  title: 'Out of Stock',
                  count: outOfStock,
                  percentage: outPercentage,
                  color: const Color(0xFFD94A4A),
                  icon: Icons.error_outline,
                ),
              ],
            )
          else
            Row(
              children: [
                Expanded(
                  child: _healthItem(
                    title: 'In Stock',
                    count: inStock,
                    percentage: healthyPercentage,
                    color: const Color(0xFF1D9959),
                    icon: Icons.check_circle_outline,
                  ),
                ),

                const SizedBox(width: 24),

                Expanded(
                  child: _healthItem(
                    title: 'Low Stock',
                    count: lowStock,
                    percentage: lowPercentage,
                    color: const Color(0xFFE09A00),
                    icon: Icons.warning_amber_outlined,
                  ),
                ),

                const SizedBox(width: 24),

                Expanded(
                  child: _healthItem(
                    title: 'Out of Stock',
                    count: outOfStock,
                    percentage: outPercentage,
                    color: const Color(0xFFD94A4A),
                    icon: Icons.error_outline,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _healthItem({
    required String title,
    required int count,
    required double percentage,
    required Color color,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 17, color: color),

            const SizedBox(width: 7),

            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.text,
                ),
              ),
            ),

            Text(
              '$count',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
          ],
        ),

        const SizedBox(height: 7),

        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: LinearProgressIndicator(
            value: percentage,
            minHeight: 6,
            backgroundColor: const Color(0xFFE8EDF2),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),

        const SizedBox(height: 5),

        Text(
          '${(percentage * 100).round()}% of inventory items',
          style: const TextStyle(fontSize: 9, color: AppTheme.textMuted),
        ),
      ],
    );
  }

  // ===========================================================================
  // INVENTORY DIRECTORY
  // ===========================================================================

  Widget _buildInventorySection(bool mobile) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _inventorySectionHeader(mobile),

          const SizedBox(height: 16),

          _buildFilters(mobile),

          const SizedBox(height: 18),

          mobile ? _buildMobileList() : _buildDesktopTable(),
        ],
      ),
    );
  }

  Widget _inventorySectionHeader(bool mobile) {
    return Row(
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Inventory Directory',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.text,
                ),
              ),
              SizedBox(height: 3),
              Text(
                'All products and current stock information',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 11, color: AppTheme.textMuted),
              ),
            ],
          ),
        ),

        if (!mobile)
          OutlinedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Export feature will be connected later.'),
                ),
              );
            },
            icon: const Icon(Icons.file_download_outlined, size: 17),
            label: const Text('Export'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppTheme.text,
              side: BorderSide(color: AppTheme.border),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
            ),
          ),
      ],
    );
  }

  // ===========================================================================
  // FILTERS
  // ===========================================================================

  Widget _buildFilters(bool mobile) {
    // IMPORTANT:
    // Mobile filters are stacked vertically.
    // This prevents narrow-screen horizontal overflow.

    if (mobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _searchField(),

          const SizedBox(height: 10),

          _statusDropdown(),

          const SizedBox(height: 10),

          _categoryDropdown(),
        ],
      );
    }

    return Row(
      children: [
        Expanded(child: _searchField()),

        const SizedBox(width: 12),

        SizedBox(width: 150, child: _statusDropdown()),

        const SizedBox(width: 12),

        SizedBox(width: 170, child: _categoryDropdown()),
      ],
    );
  }

  Widget _searchField() {
    return SizedBox(
      width: double.infinity,
      child: TextField(
        controller: searchController,
        onChanged: (value) {
          setState(() {});
        },
        decoration: InputDecoration(
          hintText: 'Search item, SKU, category or warehouse...',
          hintStyle: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
          prefixIcon: const Icon(Icons.search, size: 18),
          filled: true,
          fillColor: AppTheme.paperDim,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 11,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _statusDropdown() {
    return SizedBox(
      width: double.infinity,
      child: DropdownButtonFormField<String>(
        value: selectedStatus,
        isExpanded: true,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppTheme.paperDim,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 11,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: BorderSide.none,
          ),
        ),
        style: const TextStyle(fontSize: 11, color: AppTheme.text),
        items: const [
          DropdownMenuItem(value: 'All', child: Text('All Status')),
          DropdownMenuItem(value: 'In Stock', child: Text('In Stock')),
          DropdownMenuItem(value: 'Low Stock', child: Text('Low Stock')),
          DropdownMenuItem(value: 'Out of Stock', child: Text('Out of Stock')),
        ],
        onChanged: (value) {
          setState(() {
            selectedStatus = value ?? 'All';
          });
        },
      ),
    );
  }

  Widget _categoryDropdown() {
    return SizedBox(
      width: double.infinity,
      child: DropdownButtonFormField<String>(
        value: selectedCategory,
        isExpanded: true,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppTheme.paperDim,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 11,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: BorderSide.none,
          ),
        ),
        style: const TextStyle(fontSize: 11, color: AppTheme.text),
        items: const [
          DropdownMenuItem(value: 'All', child: Text('All Categories')),
          DropdownMenuItem(value: 'Electronics', child: Text('Electronics')),
          DropdownMenuItem(value: 'Accessories', child: Text('Accessories')),
          DropdownMenuItem(value: 'Cables', child: Text('Cables')),
        ],
        onChanged: (value) {
          setState(() {
            selectedCategory = value ?? 'All';
          });
        },
      ),
    );
  }

  // ===========================================================================
  // DESKTOP TABLE
  // ===========================================================================

  Widget _buildDesktopTable() {
    final List<Map<String, dynamic>> data = _filteredInventory();

    if (data.isEmpty) {
      return _emptyState();
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE5E9EE)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowHeight: 46,
            dataRowMinHeight: 70,
            dataRowMaxHeight: 78,
            horizontalMargin: 16,
            columnSpacing: 22,
            headingRowColor: MaterialStateProperty.all(AppTheme.paperDim),
            columns: const [
              DataColumn(label: Text('PRODUCT')),
              DataColumn(label: Text('CATEGORY')),
              DataColumn(label: Text('WAREHOUSE')),
              DataColumn(label: Text('STOCK')),
              DataColumn(label: Text('REORDER')),
              DataColumn(label: Text('VALUE')),
              DataColumn(label: Text('STATUS')),
              DataColumn(label: Text('')),
            ],
            rows: data.map((item) {
              return DataRow(
                cells: [
                  DataCell(_productNameCell(item)),
                  DataCell(
                    SizedBox(
                      width: 100,
                      child: Text(
                        item['category'].toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF475569),
                        ),
                      ),
                    ),
                  ),
                  DataCell(_warehouseCell(item)),
                  DataCell(
                    Text(
                      _formatNumber(item['units'] as int),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.text,
                      ),
                    ),
                  ),
                  DataCell(
                    Text(
                      _formatNumber(item['reorder'] as int),
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppTheme.textMuted,
                      ),
                    ),
                  ),
                  DataCell(
                    Text(
                      _currency(
                        (item['units'] as int) * (item['price'] as int),
                      ),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.text,
                      ),
                    ),
                  ),
                  DataCell(_statusBadge(item['status'].toString())),
                  DataCell(
                    IconButton(
                      onPressed: () {
                        _showItemDetails(item);
                      },
                      icon: const Icon(Icons.more_vert, size: 19),
                      color: AppTheme.textMuted,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _productNameCell(Map<String, dynamic> item) {
    return SizedBox(
      width: 210,
      child: Row(
        children: [
          Container(
            width: 37,
            height: 37,
            decoration: BoxDecoration(
              color: AppTheme.paperDim,
              borderRadius: BorderRadius.circular(9),
            ),
            child: const Icon(
              Icons.inventory_2_outlined,
              size: 18,
              color: AppTheme.ink3,
            ),
          ),

          const SizedBox(width: 9),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'].toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.text,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  item['sku'].toString(),
                  style: const TextStyle(
                    fontSize: 9,
                    color: AppTheme.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _warehouseCell(Map<String, dynamic> item) {
    return SizedBox(
      width: 145,
      child: Row(
        children: [
          const Icon(
            Icons.warehouse_outlined,
            size: 15,
            color: AppTheme.textMuted,
          ),

          const SizedBox(width: 5),

          Expanded(
            child: Text(
              item['warehouse'].toString(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 11, color: Color(0xFF475569)),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // MOBILE LIST
  // ===========================================================================

  Widget _buildMobileList() {
    final List<Map<String, dynamic>> data = _filteredInventory();

    if (data.isEmpty) {
      return _emptyState();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final item in data)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _mobileInventoryCard(item),
          ),
      ],
    );
  }

  Widget _mobileInventoryCard(Map<String, dynamic> item) {
    final int units = item['units'] as int;

    final int reorder = item['reorder'] as int;

    double stockPercentage = 0;

    if (reorder > 0) {
      stockPercentage = (units / (reorder * 4)).clamp(0.0, 1.0);
    }

    Color progressColor;

    if (item['status'] == 'Out of Stock') {
      progressColor = const Color(0xFFD94A4A);
    } else if (item['status'] == 'Low Stock') {
      progressColor = const Color(0xFFE09A00);
    } else {
      progressColor = const Color(0xFF1D9959);
    }

    return InkWell(
      onTap: () {
        _showItemDetails(item);
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFFAFBFC),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE5E9EE)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --------------------------------------------------------------
            // PRODUCT HEADER
            // --------------------------------------------------------------

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppTheme.paperDim,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: const Icon(
                    Icons.inventory_2_outlined,
                    color: AppTheme.ink3,
                    size: 20,
                  ),
                ),

                const SizedBox(width: 9),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['name'].toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.text,
                        ),
                      ),

                      const SizedBox(height: 3),

                      Text(
                        item['sku'].toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 9,
                          color: AppTheme.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 6),

                // Flexible status badge.
                Flexible(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: _statusBadge(item['status'].toString()),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            const Divider(height: 1),

            const SizedBox(height: 12),

            // --------------------------------------------------------------
            // METRICS
            // --------------------------------------------------------------
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _mobileMetric(
                    'Category',
                    item['category'].toString(),
                    Icons.category_outlined,
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: _mobileMetric(
                    'Warehouse',
                    item['warehouse'].toString(),
                    Icons.warehouse_outlined,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _mobileMetric(
                    'Available',
                    _formatNumber(units),
                    Icons.inventory_2_outlined,
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: _mobileMetric(
                    'Stock Value',
                    _currency(units * (item['price'] as int)),
                    Icons.currency_rupee,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // --------------------------------------------------------------
            // STOCK LEVEL
            // --------------------------------------------------------------
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Stock Level',
                    style: TextStyle(fontSize: 10, color: AppTheme.textMuted),
                  ),
                ),

                const SizedBox(width: 8),

                Flexible(
                  child: Text(
                    '${_formatNumber(units)} units',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: progressColor,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 6),

            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: LinearProgressIndicator(
                value: stockPercentage,
                minHeight: 6,
                backgroundColor: const Color(0xFFE7ECF1),
                valueColor: AlwaysStoppedAnimation<Color>(progressColor),
              ),
            ),

            const SizedBox(height: 5),

            Text(
              'Reorder level: ${_formatNumber(reorder)} units',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 9, color: AppTheme.textMuted),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mobileMetric(String label, String value, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 15, color: AppTheme.textMuted),

        const SizedBox(width: 6),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 9, color: AppTheme.textMuted),
              ),

              const SizedBox(height: 2),

              Text(
                value,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.text,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // STATUS BADGE
  // ===========================================================================

  Widget _statusBadge(String status) {
    final bool inStock = status == 'In Stock';

    final bool lowStock = status == 'Low Stock';

    final Color background;
    final Color foreground;
    final IconData icon;

    if (inStock) {
      background = const Color(0xFFEAF8F0);
      foreground = const Color(0xFF16834B);
      icon = Icons.check_circle_outline;
    } else if (lowStock) {
      background = const Color(0xFFFFF6DD);
      foreground = const Color(0xFFB77900);
      icon = Icons.warning_amber_outlined;
    } else {
      background = const Color(0xFFFDECEC);
      foreground = const Color(0xFFC23D3D);
      icon = Icons.error_outline;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11, color: foreground),

          const SizedBox(width: 3),

          Flexible(
            child: Text(
              status,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.w700,
                color: foreground,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // FILTERING
  // ===========================================================================

  List<Map<String, dynamic>> _filteredInventory() {
    final String query = searchController.text.trim().toLowerCase();

    return inventoryItems.where((item) {
      final bool matchesSearch =
          query.isEmpty ||
          item['name'].toString().toLowerCase().contains(query) ||
          item['sku'].toString().toLowerCase().contains(query) ||
          item['category'].toString().toLowerCase().contains(query) ||
          item['warehouse'].toString().toLowerCase().contains(query);

      final bool matchesStatus =
          selectedStatus == 'All' || item['status'] == selectedStatus;

      final bool matchesCategory =
          selectedCategory == 'All' || item['category'] == selectedCategory;

      return matchesSearch && matchesStatus && matchesCategory;
    }).toList();
  }

  // ===========================================================================
  // ADD ITEM
  // ===========================================================================

  void _showAddItemDialog() {
    final TextEditingController nameController = TextEditingController();

    final TextEditingController skuController = TextEditingController();

    final TextEditingController categoryController = TextEditingController();

    final TextEditingController unitsController = TextEditingController();

    final TextEditingController priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Add Inventory Item',
            style: TextStyle(fontWeight: FontWeight.w800, color: AppTheme.text),
          ),
          content: SizedBox(
            width: 430,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _dialogField(
                    controller: nameController,
                    label: 'Product Name',
                    icon: Icons.inventory_2_outlined,
                  ),

                  const SizedBox(height: 12),

                  _dialogField(
                    controller: skuController,
                    label: 'SKU',
                    icon: Icons.qr_code_2_outlined,
                  ),

                  const SizedBox(height: 12),

                  _dialogField(
                    controller: categoryController,
                    label: 'Category',
                    icon: Icons.category_outlined,
                  ),

                  const SizedBox(height: 12),

                  _dialogField(
                    controller: unitsController,
                    label: 'Available Units',
                    icon: Icons.layers_outlined,
                    keyboardType: TextInputType.number,
                  ),

                  const SizedBox(height: 12),

                  _dialogField(
                    controller: priceController,
                    label: 'Unit Price',
                    icon: Icons.currency_rupee,
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Inventory item added successfully.'),
                  ),
                );
              },
              style: _primaryButtonStyle(),
              child: const Text('Add Item'),
            ),
          ],
        );
      },
    );
  }

  Widget _dialogField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 19),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  // ===========================================================================
  // DETAILS
  // ===========================================================================

  void _showItemDetails(Map<String, dynamic> item) {
    final int units = item['units'] as int;

    final int price = item['price'] as int;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            item['name'].toString(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              color: AppTheme.text,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _detailRow('SKU', item['sku'].toString()),
                _detailRow('Category', item['category'].toString()),
                _detailRow('Warehouse', item['warehouse'].toString()),
                _detailRow('Available Units', _formatNumber(units)),
                _detailRow(
                  'Reorder Level',
                  _formatNumber(item['reorder'] as int),
                ),
                _detailRow('Unit Price', _currency(price)),
                _detailRow('Inventory Value', _currency(units * price)),
                _detailRow('Last Updated', item['updated'].toString()),

                const SizedBox(height: 10),

                _statusBadge(item['status'].toString()),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Close'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Edit inventory will be connected later.'),
                  ),
                );
              },
              style: _primaryButtonStyle(),
              child: const Text('Edit'),
            ),
          ],
        );
      },
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 11, color: AppTheme.textMuted),
            ),
          ),

          const SizedBox(width: 10),

          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppTheme.text,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // EMPTY STATE
  // ===========================================================================

  Widget _emptyState() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Column(
        children: [
          Icon(
            Icons.inventory_2_outlined,
            size: 48,
            color: Colors.grey.shade400,
          ),

          const SizedBox(height: 12),

          const Text(
            'No inventory items found',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppTheme.text,
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            'Try changing your search or filters.',
            style: TextStyle(fontSize: 12, color: AppTheme.textMuted),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // CALCULATIONS
  // ===========================================================================

  int _totalUnits() {
    return inventoryItems.fold<int>(
      0,
      (sum, item) => sum + (item['units'] as int),
    );
  }

  int _lowStockCount() {
    return inventoryItems.where((item) => item['status'] == 'Low Stock').length;
  }

  int _inventoryValue() {
    return inventoryItems.fold<int>(0, (sum, item) {
      final int units = item['units'] as int;

      final int price = item['price'] as int;

      return sum + (units * price);
    });
  }

  // ===========================================================================
  // STYLING
  // ===========================================================================

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: AppTheme.paper,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: const Color(0xFFE4E8ED)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.025),
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }

  ButtonStyle _primaryButtonStyle({bool compact = false}) {
    return ElevatedButton.styleFrom(
      backgroundColor: AppTheme.ink3,
      foregroundColor: AppTheme.paper,
      elevation: 0,
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 10 : 18,
        vertical: compact ? 7 : 12,
      ),
      minimumSize: compact ? const Size(0, 32) : null,
      tapTargetSize: compact
          ? MaterialTapTargetSize.shrinkWrap
          : MaterialTapTargetSize.padded,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(compact ? 8 : 9),
      ),
    );
  }

  // ===========================================================================
  // FORMATTERS
  // ===========================================================================

  String _formatNumber(int value) {
    return value.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (match) => '${match.group(1)},',
    );
  }

  String _currency(dynamic value) {
    final int amount = value is int
        ? value
        : int.tryParse(value.toString()) ?? 0;

    if (amount >= 10000000) {
      return '₹${(amount / 10000000).toStringAsFixed(2)}Cr';
    }

    if (amount >= 100000) {
      return '₹${(amount / 100000).toStringAsFixed(1)}L';
    }

    if (amount >= 1000) {
      return '₹${(amount / 1000).toStringAsFixed(1)}K';
    }

    return '₹$amount';
  }
}
