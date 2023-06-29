# Bandwidth

Bandwidth is a rating unit in {{ interconnect-name }} equal to the amount of traffic transmitted within a month.

> For example, for a bandwidth of 30 TB, the capacity is 100 `Mbps`.

Here are the bandwidths currently available:

| Bandwidth, TB | Capacity, Mbps |
--- | ---
| 30 | 100 |
| 75 | 250 |
| 150 | 500 |
| 300 | 1,000 |
| 615 | 2,000 |
| 900 | 3,000 |
| 1,545 | 5000 |
| 3,090 | 10,000 |

{% note info %}

* You can double-check your bandwidth cost with your {{ yandex-cloud }} manager.
* When creating a request for a new trunk (either direct or partner), make sure to specify the trunk capacity in `mbps`. The trunk capacities available are listed in the table above. No other values are supported.
* To change the capacity for an existing trunk, contact tech support.

{% endnote %}
