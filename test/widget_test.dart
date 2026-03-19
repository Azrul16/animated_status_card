import 'package:animated_status_card/animated_status_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders animated status card content', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AnimatedStatusCard(
            title: 'Pending Appointments',
            value: '128',
            subtitle: 'Updated just now',
            icon: Icons.pending_actions_rounded,
            trendValue: '+12%',
            trendDirection: TrendDirection.up,
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Pending Appointments'), findsOneWidget);
    expect(find.text('128'), findsOneWidget);
    expect(find.text('+12%'), findsOneWidget);
  });

  testWidgets('shows shimmer when loading', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AnimatedStatusCard(
            title: 'Loading',
            value: '0',
            isLoading: true,
          ),
        ),
      ),
    );

    await tester.pump();

    expect(find.byType(AnimatedStatusShimmerCard), findsOneWidget);
  });
}
