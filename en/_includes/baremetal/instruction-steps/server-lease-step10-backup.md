Under **{{ ui-key.yacloud.baremetal.title_section-server-public-network }}**, in the **{{ ui-key.yacloud.baremetal.field_needed-public-ip }}** field, select a public IP address assignment method:

  {% include [server-lease-step10-ss1](./server-lease-step10-ss1.md) %}

  {% include [server-lease-step10-ss2](./server-lease-step10-ss2.md) %}

For the [{{ backup-name }}](../../../backup/concepts/agent.md) agent to exchange data with the [backup provider](../../../backup/concepts/index.md#providers) servers, make sure the server has network access to the IP addresses of {{ backup-name }} resources based on the following table: {#ip-access}

{% include [outgoing traffic](../../backup/outgoing-rules.md) %}