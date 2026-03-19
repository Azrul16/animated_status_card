import 'package:animated_status_card/animated_status_card.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

class ShowcaseApp extends StatelessWidget {
  const ShowcaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Animated Status Card',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0F766E),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF4F7FB),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF14B8A6),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF08111F),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: const ShowcaseScreen(),
    );
  }
}

class ShowcaseScreen extends StatelessWidget {
  const ShowcaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFF8FAFC), Color(0xFFE8F1FF), Color(0xFFF8FAFC)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1180),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Animated dashboard cards for modern Flutter apps',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Drop-in status cards with entry motion, trends, hover states, shimmer loading, and responsive layouts.',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.72),
                      ),
                    ),
                    const SizedBox(height: 28),
                    AnimatedStatusCardGrid(
                      children: const [
                        AnimatedStatusCard(
                          title: 'Total Revenue',
                          value: '\$12,450',
                          subtitle: 'This month',
                          icon: Icons.attach_money_rounded,
                          trendValue: '+8.2%',
                          trendDirection: TrendDirection.up,
                          styleType: CardStyleType.gradient,
                          statusType: CardStatusType.success,
                          badge: AnimatedMetricBadge(label: 'Premium'),
                        ),
                        AnimatedStatusCard(
                          title: 'Pending Appointments',
                          value: '128',
                          subtitle: 'Updated just now',
                          icon: Icons.event_available_rounded,
                          trendValue: '+12%',
                          trendDirection: TrendDirection.up,
                          styleType: CardStyleType.simple,
                          statusType: CardStatusType.info,
                        ),
                        AnimatedStatusCard(
                          title: 'System Health',
                          value: '99.4%',
                          subtitle: 'Cloud region sync',
                          icon: Icons.health_and_safety_rounded,
                          trendValue: 'Stable',
                          trendDirection: TrendDirection.neutral,
                          styleType: CardStyleType.glass,
                          statusType: CardStatusType.success,
                        ),
                        AnimatedStatusCard(
                          title: 'Attendance Rate',
                          value: '87.5%',
                          subtitle: 'Across 24 classes',
                          icon: Icons.fact_check_rounded,
                          trendValue: '-1.4%',
                          trendDirection: TrendDirection.down,
                          styleType: CardStyleType.outlined,
                          statusType: CardStatusType.warning,
                          footer: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Needs follow-up',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        AnimatedStatusCard(
                          title: 'Active Devices',
                          value: '1,284',
                          subtitle: 'Factory floor sensors',
                          icon: Icons.sensors_rounded,
                          trendValue: '+47',
                          trendDirection: TrendDirection.up,
                          styleType: CardStyleType.simple,
                          statusType: CardStatusType.neutral,
                        ),
                        AnimatedStatusCard(
                          title: 'Loading Preview',
                          value: '0',
                          isLoading: true,
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: const [
                        SizedBox(
                          width: 280,
                          child: AnimatedMiniStatusCard(
                            title: 'Open Tickets',
                            value: '42',
                            icon: Icons.support_agent_rounded,
                            trendValue: '+5',
                            trendDirection: TrendDirection.up,
                          ),
                        ),
                        SizedBox(
                          width: 280,
                          child: AnimatedMiniStatusCard(
                            title: 'Device Alerts',
                            value: '7',
                            icon: Icons.warning_amber_rounded,
                            trendValue: '-2',
                            trendDirection: TrendDirection.down,
                            statusType: CardStatusType.danger,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
