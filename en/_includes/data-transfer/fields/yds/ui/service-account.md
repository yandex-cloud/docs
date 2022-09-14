{% if audience != "internal" %}

**Service account**: Select or [create](../../../../../iam/operations/sa/create.md) a [service account](../../../../../iam/concepts/users/service-accounts.md) that {{ data-transfer-name }} will use to connect to the data source.

{% else %}

**Service account**: Select or create a service account that {{ data-transfer-name }} will use to connect to the data source.

{% endif %}
