{% note info %}

As part of the closed testing, you can establish network connectivity between {{ baremetal-name }} private subnets and on-premises resources using [{{ cr-name }} v2](../../cloud-router/index.yaml).

This architecture ensures direct network communication between the {{ baremetal-name }} servers and on-premises resources, optimizes traffic routing by eliminating redundant intermediate nodes, and supports default route (`0.0.0.0/0`) advertisement.

{% endnote %}
