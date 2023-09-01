---
title: "Quotas and limits in {{ sf-name }}"
description: "{{ sf-name }} has limits and quotas for the number of functions, the number of instances of a single function in each availability zone, and the number of concurrent function calls (for all functions in each availability zone). For more information about the service restrictions, read this article."
---

# Quotas and limits in {{ sf-name }}

{{ sf-name }} has the following limits:

{% include [quotes-limits-def.md](../../_includes/quotes-limits-def.md) %}

{% include [increase-quotas.md](../../_includes/increase-quotas.md) %}

{% note info %}

To choose correctly which quotas to increase, familiarize yourself with their [characteristics and interrelationships](#related-quotas).

{% endnote %}

{% include [functions-limits.md](../../_includes/functions-limits.md) %}

#### Relationship between quotas {#related-quotas}

The quotas for concurrent calls, function instances, and total RAM are interconnected. To increase the number of function calls, you should increase:

* The quotas for concurrent calls and instances equally.
* The quota for total RAM to the value of the actual consumption by the instances.

The number of concurrent calls and function instances are interconnected as follows:

* It makes no sense requesting more function instances than concurrent function calls. One instance is used to process each call. If there are more instances, they remain idle.
* You might only consider setting the number of concurrent calls higher than that of instances to prevent a function call from ending in an error when all instances are busy. In this case, the call is queued and considered to be in progress, while also being counted towards the quota for the number of concurrent calls.

Instances and calls are randomly distributed among the [availability zones](../../overview/concepts/geo-scope.md). {{ sf-name }} does not guarantee their even distribution among the zones. For example, all calls, no matter how many, might end up in the same zone. Therefore, with a quota of 10, you can simultaneously call from 10 to 30 functions and use from 10 to 30 instances, but only 10 are guaranteed.

The quota for total RAM across all the running functions limits the number of instances. Set the total RAM quota equal to the number of instances times the average RAM of the functions they will be used for. For example, if you call 10 functions, each with 4 GB RAM, the first 5 instances will already use up the whole 20 GB RAM quota. As a result, new instances needed for the remaining 5 calls will not be created. In this case, you need to set the total RAM quota to 40 GB.

The quotas for the number of concurrent operations on all functions and versions only limit such operations as creating a function/version and deleting a function. These quotas do not affect the number of concurrent function calls and instances.
