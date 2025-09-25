# Autoscaling

In [dedicated mode](serverless-and-dedicated.md#dedicated) in {{ ydb-name }}, you can use _autoscaling_ of computing resources.

Autoscaling means adjusting the number of nodes in a database as the workload changes.

To use autoscaling, you need to specify a target CPU utilization value, averaged across the database nodes, as well as the minimum and maximum number of nodes. {{ ydb-full-name }} will then dynamically adjust the number of nodes to maintain CPU utilization at this target level, while staying within the defined limits. Newly added nodes have identical configurations and are evenly distributed across availability zones.

{% note info %}

For reliable and stable performance, a database should have more than one node and maintain CPU utilization below 60%.

{% endnote %}

## Example

Your database is deployed with six compute nodes, and you need to maintain CPU utilization at 50% under the fluctuating load. This allows the system to handle traffic spikes without allocating too many resources. To achieve this, autoscaling is configured the following way: target CPU utilization of 50%, with minimum number of nodes being three and maximum number, nine. With this configuration, the system will automatically scale up the number of compute nodes when CPU utilization exceeds 50% to handle higher loads. Conversely, when CPU utilization drops below 50%, the number of nodes will be scale down to optimize costs during periods of lower loads. At all times, the total number of nodes will remain between three and nine.
