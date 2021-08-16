# Data decimation

_Data decimation_ is a mechanism for archiving historical data in {{ monitoring-short-name }}.

To decrease the amount of stored data, {{ monitoring-short-name }} aggregates the values of all metrics according to the _decimation policy_. The average value in the window is used as an aggregation function.
Decimation policy uses five-minute grid after one week.

{% note info %}

Decimation policy change is not supported.

{% endnote %}

Data decimation is an asynchronous background process. The decimation policy defines the grid for the reduced values of metrics after the next iteration of the decimation process.
No guarantee is given for the actual point in time when the policy is applied.

> For example, if you set a five-minute grid after one week, you might still see your non-reduced data for 8 days on the dashboard.

