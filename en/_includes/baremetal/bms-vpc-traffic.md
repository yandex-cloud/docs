Traffic sent from {{ vpc-full-name }} to {{ baremetal-full-name }} public addresses is classified as outgoing traffic subject to the [{{ vpc-short-name }} pricing policy](../../vpc/pricing.md#prices-traffic).

{% note info %}

To transfer large data volumes between {{ vpc-full-name }} and {{ baremetal-full-name }}, use [{{ interconnect-full-name }}](../../interconnect/index.yaml).

Traffic transmitted via {{ interconnect-full-name }} between private {{ baremetal-full-name }} and {{ vpc-full-name }} addresses in either direction is not billable.

{% endnote %}