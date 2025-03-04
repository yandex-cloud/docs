# Data decimation

_Data decimation_ is a mechanism for archiving historical data in {{ monitoring-short-name }} to reduce its size.

Pursuant to the _decimation policy_, {{ monitoring-short-name }}:
1. It calculates the following values for every five minutes:
   * Average
   * Maximum
   * Minimum
   * Total
   * Last value
1. It saves only the calculated values instead of all five-minute grid metrics.

The decimation policy applies to all metrics older than one week.

To select one of the decimation types for your chart, go to **Metric Explorer** and **Dashboards** in the chart settings.

{% note info %}

You cannot change the decimation policy. Prior to August 7, 2024, only the average value was saved by the decimation policy. This is why you can select other chart values only for metrics collected after that date.

{% endnote %}
