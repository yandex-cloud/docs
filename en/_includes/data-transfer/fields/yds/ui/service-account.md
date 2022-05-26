{% if audience != "internal" %}

**SA Account**: Select or [create](../../../../../iam/operations/sa/create.md) a [service account](../../../../../iam/concepts/users/service-accounts.md) that {{ data-transfer-name }} will connect to the data source as.

{% else %}

**SA Account**: Select or create a service account that {{ data-transfer-name }} will use to connect to the data source.

{% endif %}
