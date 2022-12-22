{% if audience != "internal" %}

**Service account ID**: Select or [create](../../../../../iam/operations/sa/create.md) a [service account](../../../../../iam/concepts/users/service-accounts.md) with the `ydb.editor` role that {{ data-transfer-name }} will use to connect to the database.

{% else %}

**Service account ID**: Select or create a service account with the `ydb.editor` role that {{ data-transfer-name }} will use to connect to the database.

{% endif %}
