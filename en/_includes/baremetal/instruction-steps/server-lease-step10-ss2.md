* `{{ ui-key.yacloud.baremetal.label_public-ip-from-dedicated-subnet }}`: To assign an IP address from the range of addresses of a [dedicated public subnet](../../../baremetal/concepts/network.md#public-subnet).

    In the field that opens, select a public subnet or click **{{ ui-key.yacloud.baremetal.action_create-public-subnet-from-server }}** to [order](../../../baremetal/operations/reserve-public-subnet.md) a new one.

    {% note warning %}

    {% include [public-subnet-no-dhcp](../../../_includes/baremetal/public-subnet-no-dhcp.md) %}

    {% endnote %}
