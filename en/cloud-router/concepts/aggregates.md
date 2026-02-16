### Aggregated prefixes (aggregates) {#agg-subnets}

To automatically announce new subnets to {{ interconnect-name }}, you can use **aggregated subnet prefixes** (aggregates). With aggregates, you only need to set up prefix announcements once. From then on, you can add new subnets to your {{ vpc-short-name }} without contacting support.

> For example, when setting up `Routing Instance`, you can specify announcements for aggregated IPv4 prefixes formatted as follows:
>
> ```
> {{ region-id }}-a [10.128.0.0/16]
> {{ region-id }}-b [10.130.0.0/16]
> {{ region-id }}-d [10.140.0.0/16]
> ```
>
> If later you create a subnet with the `10.128.15.0/24` prefix in this network in the `{{ region-id }}-a` availability zone, it will automatically be available via {{ interconnect-name }} because the `10.128.15.0/24` subnet belongs to the already announced address space, `10.128.0.0/16`.

