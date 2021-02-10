# Data decimation

_Data decimation_ is a mechanism for archiving historical data in {{ monitoring-short-name }}.

To decrease the amount of stored data, {{ monitoring-short-name }} aggregates the values of all metrics according to the _decimation policy_. The average value in the window is used as an aggregation function.

Decimation policy:

- Five-minute grid after one week (default).
- One-minute grid after one month, five-minute grid after two months.
- One-minute grid after one month, five-minute grid after three months.
- Five-minute grid after two months.
- Save source values (disable data decimation).

{% note info %}

You can't assign a decimation policy for system metrics in {{ yandex-cloud }}. To change the decimation policy for custom metrics, please contact [technical support]({{ link-console-support }}).

{% endnote %}

Data decimation is an asynchronous background process. The decimation policy defines the grid for the reduced values of metrics after the next iteration of the decimation process.
No guarantee is given for the actual point in time when the policy is applied.

> For example, if you set a five-minute grid after one week, you might still see your non-reduced data for 8 days on the dashboard.

