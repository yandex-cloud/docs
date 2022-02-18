{% if audience != "internal" %}

**SA Аккаунт** — выберите или [создайте](../../../../../iam/operations/sa/create.md) [сервисный аккаунт](../../../../../iam/concepts/users/service-accounts.md), от имени которого сервис {{ data-transfer-name }} будет подключаться к источнику данных.

{% else %}

**SA Аккаунт** — выберите или создайте сервисный аккаунт, от имени которого {{ data-transfer-name }} будет подключаться к источнику данных.

{% endif %}
