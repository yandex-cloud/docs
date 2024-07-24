# Data decimation

_Data decimation_ is a mechanism for archiving historical data in {{ monitoring-short-name }} to reduce its size.

Pursuant to the _decimation policy_, {{ monitoring-short-name }}:
1. Computes the all-metrics average value for every five-minute period.
1. Replaces the five-minute grid metrics with the average value.

The decimation policy applies to all metrics older than one week.

{% note info %}

You cannot change the decimation policy.

{% endnote %}
