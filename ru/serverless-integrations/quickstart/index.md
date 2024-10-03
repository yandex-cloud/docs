# Начало работы с {{ si-full-name }}

{{ si-full-name }} позволяет настраивать интеграции и управлять ими с помощью serverless-технологий в {{ yandex-cloud }}.

{% note info %}

{{ sw-name }} и {{ er-name }} находятся на стадии [Preview](../../overview/concepts/launch-stages.md). Чтобы получить доступ, обратитесь в [техническую поддержку]({{ link-console-support }}) или к вашему аккаунт-менеджеру.

{% endnote %}

Начните работу с инструментами {{ si-name }}:
* [{{ sw-full-name }}](workflows.md) — создайте рабочий процесс, который вызывает функцию {{ sf-name }}, и запустите его. Подробнее о возможностях {{ sw-name }} см. в [Концепциях](../concepts/workflows/workflow.md).
* [{{ er-full-name }}](eventrouter.md) — создайте шину и передайте через нее данные. Подробнее о возможностях {{ er-name }} см. в [Концепциях](../concepts/eventrouter/bus.md).
* {{ api-gw-full-name }} — сконфигурируйте API-шлюз для получения статического ответа, а затем добавьте интеграцию для вызова функции {{ sf-name }}. Подробнее о возможностях см. в [документации {{ api-gw-name }}](../../api-gateway/quickstart/index.md).
