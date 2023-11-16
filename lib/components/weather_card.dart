import 'package:flutter/material.dart';
import 'package:mozc_flutter_bootcamp_23_showcase/components/metrics.dart';
import 'package:mozc_flutter_bootcamp_23_showcase/models/weather.dart';
import 'package:mozc_flutter_bootcamp_23_showcase/utils/date.dart';

class WeatherCard extends StatelessWidget {
  final DateTime date;
  final int degree;
  final WeatherStatus status;

  final String humidity;
  final String wind;
  final String chanceOfRain;

  const WeatherCard({
    super.key,
    required this.date,
    required this.degree,
    required this.status,
    required this.humidity,
    required this.wind,
    required this.chanceOfRain,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.transparent,
      child: Container(
        height: 156,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: _WeatherCardInfo(
                date: date,
                degree: degree,
                humidity: humidity,
                wind: wind,
                chanceOfRain: chanceOfRain,
              ),
            ),
            _TemperatureStatus(degree: degree, status: status)
          ],
        ),
      ),
    );
  }
}

class _WeatherCardInfo extends StatelessWidget {
  final DateTime date;
  final int degree;

  final String humidity;
  final String wind;
  final String chanceOfRain;

  const _WeatherCardInfo({
    required this.date,
    required this.degree,
    required this.humidity,
    required this.wind,
    required this.chanceOfRain,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = theme.textTheme;
    final colors = theme.colorScheme;

    final dateString = getFancyDate(date);
    final relativeDateString = getRelativeDateString(date);

    final relativeDateTextStyle = text.titleLarge?.copyWith(
      color: colors.primary,
      fontWeight: FontWeight.w500,
    );

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(relativeDateString, style: relativeDateTextStyle),
      Text(dateString, style: text.labelMedium?.copyWith(color: colors.onSurfaceVariant)),
      const Spacer(),
      TinyMetricsBar(humidity: humidity, wind: wind, chanceOfRain: chanceOfRain),
    ]);
  }
}

class _TemperatureStatus extends StatelessWidget {
  const _TemperatureStatus({
    required this.degree,
    required this.status,
  });

  final int degree;
  final WeatherStatus status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = theme.textTheme;
    final colors = theme.colorScheme;

    final tempStyle = text.headlineSmall?.copyWith(
      color: colors.primary,
      fontWeight: FontWeight.w900,
    );

    return SizedBox(
      width: 128,
      child: Stack(children: [
        const Center(child: Icon(Icons.sunny, size: 64)),
        Positioned(
          top: 4,
          right: 6,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(degree.toString(), style: tempStyle),
              Text("°C", style: text.labelMedium?.copyWith(color: colors.primary)),
            ],
          ),
        )
      ]),
    );
  }
}
