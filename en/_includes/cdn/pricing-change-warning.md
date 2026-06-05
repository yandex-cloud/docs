{% note warning %}

Starting July 1, 2026, a new pricing model will be effective.

The total cost for {{ cdn-name }} will be calculated based on the following:

* Number of [CDN resources](../../cdn/concepts/resource.md), amount of outbound traffic, and number of requests.
* Paid features enabled for your resources: [origin shielding](../../cdn/concepts/origins-shielding.md), [log export](../../cdn/concepts/logs.md), and [dedicated IP addressing](../../cdn/concepts/dedicated-ip-addressing.md).

The billing structure for paid features enabled for your resources will not change.

For each CDN resource you create, you will be charged a fee for a package that includes 150 GB of traffic.

Once the traffic exceeds this amount, you will be charged for outbound traffic, per GB, as per your current pricing plan.

Deleting a resource forfeits any remaining traffic.
You cannot transfer traffic from one resource to another.

Requests to CDN resource are priced as follows:

* 100,000,000 requests are free of charge.
* Once you exceed this limit, you will be charged per 100,000 requests.

{% endnote %}
