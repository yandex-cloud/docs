# Создание подключения к {{ yandex-cloud }} Billing

Вы можете получить доступ к статистике только тех платежных аккаунтов, в которых вы имеете роль `{{ roles-viewer }}`, `{{ roles-editor }}` или `{{ roles-admin }}`. Подробнее про управление доступом в сервисе {{ billing-name }} читайте в документации в разделе [Управление доступом](../../../billing/security/index.md).

Чтобы создать подключение к {{ yandex-cloud }} Billing:


{% include [datalens-workbooks-collections-note](../../../_includes/datalens/operations/datalens-workbooks-collections-note.md) %}


1. Перейдите на [страницу подключений]({{ link-datalens-main }}/connections).
1. Нажмите кнопку **Создать подключение**.
1. Выберите подключение **{{ yandex-cloud }} Billing**.
1. Включите опцию **Автоматически создать дашборд, чарты и датасет над подключением**, если хотите получить готовый {{ yandex-cloud }} Billing Dashboard с датасетом и набором чартов.
1. Нажмите **Создать подключение**.
1. Введите имя подключения и нажмите **Создать**.