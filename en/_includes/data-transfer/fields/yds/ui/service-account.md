{% if audience != "internal" %}

**Service account**: Select or [create](../../../../../iam/operations/sa/create.md) a [service account](../../../../../iam/concepts/users/service-accounts.md) with the `yds.editor` role that {{ data-transfer-name }} will use to connect to the data source.

{% else %}

**Service account**: Select or create a service account with the `yds.editor` role that {{ data-transfer-name }} will use to connect to the data source.

{% endif %}
