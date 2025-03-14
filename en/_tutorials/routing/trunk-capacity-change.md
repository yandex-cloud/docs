## Changing the trunk capacity {#trunk-capacity-change}

In this tutorial, we will change the capacity of a trunk.

You can change the trunk capacity for the following entities:
* [Direct trunk](../../interconnect/concepts/trunk.md)
* [Partner trunk](../../interconnect/concepts/trunk.md#partner-link) 


### Contacting support to change the trunk capacity {#trunk-ticket}

Create a [new support ticket]({{ link-console-support }}) to change the capacity of a trunk.

Follow this request format:

```s
Subject: [CIC] Changing the trunk capacity.

Request text:
Please change the trunk capacity from 500mbps to 1gbps
for trunk_id euus5dfgchu23b******.
```


### Tech support team's response to your ticket {#trunk-ticket-resp}

Support will notify you when the trunk capacity has been changed.

Support response example:

```s
The capacity of your trunk has been changed.

trunk_id: euus5dfgchu23b******
capacity: 1gbps
```

Where: 

* `trunk_id`: Trunk ID.
* `capacity`: New [trunk capacity](../../interconnect/concepts/capacity.md).


{% note info %}

Changing the trunk capacity will immediately affect the {{ interconnect-name }} billing metrics.

Once the support team update your trunk capacity, billing will start to receive the new capacity data, and your payments will change accordingly. 

{% endnote %}

