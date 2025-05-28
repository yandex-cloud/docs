Under **{{ ui-key.yacloud.baremetal.title_section-server-network-settings }}**:

1. In the **{{ ui-key.yacloud.baremetal.field_subnet-id }}** field, select an existing [private subnet](../../../baremetal/concepts/network.md#private-subnet) or click **{{ ui-key.yacloud.common.create }}** to create a new one.
1. In the **{{ ui-key.yacloud.baremetal.field_needed-public-ip }}** field, select a public IP address assignment method:

    {% include [server-lease-step9-ss1](./server-lease-step9-ss1.md) %}

    {% include [server-lease-step9-ss2](./server-lease-step9-ss2.md) %}

    For the [{{ backup-name }} agent](../../../backup/concepts/agent.md) to exchange data with the [backup provider](../../../backup/concepts/index.md#providers) servers, make sure the server has network access to the IP addresses of {{ backup-name }} resources based on the following table: {#ip-access}

    {% include [outgoing traffic](../../backup/outgoing-rules.md) %}