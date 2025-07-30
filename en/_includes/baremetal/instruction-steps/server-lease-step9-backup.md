1. Under **{{ ui-key.yacloud.baremetal.title_section-server-private-network }}**, in the **{{ ui-key.yacloud.baremetal.field_subnet-id }}** field, select an existing [private subnet](../../../baremetal/concepts/network.md#private-subnet) or click **{{ ui-key.yacloud.common.create }}** to create a new one.

1. Under **{{ ui-key.yacloud.baremetal.title_section-server-public-network }}**, in the **{{ ui-key.yacloud.baremetal.field_needed-public-ip }}** field, select a public IP address assignment method:

    {% include [server-lease-step10-ss1](./server-lease-step10-ss1.md) %}

    {% include [server-lease-step10-ss2](./server-lease-step10-ss2.md) %}

    {% include [server-lease-cli-backup-network](./server-lease-cli-backup-network.md) %}

    {% include [outgoing traffic](../../backup/outgoing-rules.md) %}