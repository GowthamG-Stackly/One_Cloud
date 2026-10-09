import 'package:flutter/material.dart';

class PipelinePage extends StatelessWidget {
  const PipelinePage({super.key});

  // ==========================================================================
  // PIPELINE DATA
  // ==========================================================================

  List<Map<String, dynamic>> get pipelineStages => [
    {
      'title': 'Lead',
      'value': '\$85,000',
      'deals': ['ABC Technologies', 'Prime Solutions'],
      'icon': Icons.person_add_alt_1_outlined,
    },
    {
      'title': 'Qualified',
      'value': '\$120,000',
      'deals': ['Smart Industries', 'Global Systems'],
      'icon': Icons.verified_outlined,
    },
    {
      'title': 'Proposal',
      'value': '\$95,000',
      'deals': ['Future Technologies', 'Enterprise Corp'],
      'icon': Icons.description_outlined,
    },
    {
      'title': 'Negotiation',
      'value': '\$65,000',
      'deals': ['Tech Solutions'],
      'icon': Icons.handshake_outlined,
    },
    {
      'title': 'Won',
      'value': '\$150,000',
      'deals': ['Digital Systems', 'Cloud Corp'],
      'icon': Icons.check_circle_outline,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sales Pipeline')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;

          final isMobile = width < 600;
          final isTablet = width >= 600 && width < 1100;

          return SingleChildScrollView(
            padding: EdgeInsets.all(isMobile ? 14 : 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ============================================================
                // PAGE HEADER
                // ============================================================

                Text(
                  'Sales Pipeline',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: isMobile ? 24 : 28,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  'View and manage opportunities across sales stages.',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: isMobile ? 13 : 14,
                  ),
                ),

                SizedBox(height: isMobile ? 18 : 24),

                // ============================================================
                // PIPELINE
                // ============================================================
                if (isMobile)
                  _buildMobilePipeline()
                else if (isTablet)
                  _buildTabletPipeline()
                else
                  _buildDesktopPipeline(),
              ],
            ),
          );
        },
      ),
    );
  }

  // ==========================================================================
  // MOBILE PIPELINE
  // ==========================================================================

  Widget _buildMobilePipeline() {
    return Column(
      children: pipelineStages.map((stage) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: _PipelineStageCard(
            title: stage['title'] as String,
            value: stage['value'] as String,
            deals: List<String>.from(stage['deals']),
            icon: stage['icon'] as IconData,
            isMobile: true,
          ),
        );
      }).toList(),
    );
  }

  // ==========================================================================
  // TABLET PIPELINE
  // ==========================================================================

  Widget _buildTabletPipeline() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final stageWidth = (constraints.maxWidth - 16) / 2;

        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: pipelineStages.map((stage) {
            return SizedBox(
              width: stageWidth,
              child: _PipelineStageCard(
                title: stage['title'] as String,
                value: stage['value'] as String,
                deals: List<String>.from(stage['deals']),
                icon: stage['icon'] as IconData,
              ),
            );
          }).toList(),
        );
      },
    );
  }

  // ==========================================================================
  // DESKTOP PIPELINE
  // ==========================================================================

  Widget _buildDesktopPipeline() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: pipelineStages.map((stage) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 12),
            child: _PipelineStageCard(
              title: stage['title'] as String,
              value: stage['value'] as String,
              deals: List<String>.from(stage['deals']),
              icon: stage['icon'] as IconData,
            ),
          ),
        );
      }).toList(),
    );
  }
}

// ============================================================================
// PIPELINE STAGE CARD
// ============================================================================

class _PipelineStageCard extends StatelessWidget {
  final String title;
  final String value;
  final List<String> deals;
  final IconData icon;
  final bool isMobile;

  const _PipelineStageCard({
    required this.title,
    required this.value,
    required this.deals,
    required this.icon,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 16 : 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================================================================
            // STAGE HEADER
            // ================================================================

            Row(
              children: [
                Container(
                  width: isMobile ? 40 : 36,
                  height: isMobile ? 40 : 36,
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    size: isMobile ? 21 : 19,
                    color: Colors.blue,
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: isMobile ? 17 : 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 6),

            // ================================================================
            // PIPELINE VALUE
            // ================================================================
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: isMobile ? 14 : 13,
                fontWeight: FontWeight.w500,
              ),
            ),

            SizedBox(height: isMobile ? 14 : 12),

            // ================================================================
            // DEALS
            // ================================================================
            ...deals.map(
              (deal) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _DealCard(deal: deal, isMobile: isMobile),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// DEAL CARD
// ============================================================================

class _DealCard extends StatelessWidget {
  final String deal;
  final bool isMobile;

  const _DealCard({required this.deal, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 13 : 11),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: const BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
          ),

          const SizedBox(width: 9),

          Expanded(
            child: Text(
              deal,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: isMobile ? 14 : 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
