{% if audience != "internal" %}

**ID сервисного аккаунта** — выберите или [создайте](../../../../../iam/operations/sa/create.md) [сервисный аккаунт](../../../../../iam/concepts/users/service-accounts.md) с ролью `ydb.editor`, от имени которого сервис {{ data-transfer-name }} будет подключаться к базе.

{% else %}

**ID сервисного аккаунта** — выберите или создайте сервисный аккаунт с ролью `ydb.editor`, от имени которого сервис {{ data-transfer-name }} будет подключаться к базе.

{% endif %}
