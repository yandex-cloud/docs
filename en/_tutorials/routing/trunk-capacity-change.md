## Changing trunk capacity {#trunk-capacity-change}

This guide explains how to change the capacity of a trunk.

You can change trunk capacity for the following objects (resources):
* [Direct trunk](../../interconnect/concepts/trunk.md)
* [Partner trunk](../../interconnect/concepts/trunk.md#partner-link) 


### Contacting support to change trunk capacity {#trunk-ticket}

Create a [new support request]({{ link-console-support }}) to change the capacity of a trunk.

Follow this request format:


```s
Subject: [CIC] Changing trunk capacity.

Request text:
Please change trunk capacity from 500mbps to 1gbps
for trunk_id euus5dfgchu23b******.
```


### Tech support team's response to the customer's request {#trunk-ticket-resp}

Support will notify you when the trunk capacity has been changed.

Example of support's response:

```s
The capacity of your trunk has been changed.

trunk_id: euus5dfgchu23b******
capacity: 1gbps
```

Where: 

* `trunk_id`: Trunk ID.
* `capacity`: Current [trunk capacity](../../interconnect/concepts/capacity.md) for this trunk.


{% note info %}

Changing the capacity of a trunk will immediately affect {{ interconnect-name }} billing metrics.

Once the support team update your trunk capacity, billing will start to receive the new capacity data, and your charges will change respectively. 

{% endnote %}

