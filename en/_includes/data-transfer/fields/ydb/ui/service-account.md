{% if audience != "internal" %}

**Service account ID**: Select or [create](../../../../../iam/operations/sa/create.md) a [service account](../../../../../iam/concepts/users/service-accounts.md) that {{ data-transfer-name }} will connect to the database as.

{% else %}

**Service account ID**: Select or create a service account that {{ data-transfer-name }} will use to connect to the database.

{% endif %}
