# Посмотреть детализацию расходов {{ ml-platform-name }}

Вы можете получить подробные сведения о расходах в {{ ml-platform-name }} с детализацией до проекта, собрав дашборд в [{{ datalens-full-name }}](../../../datalens/). Для этого:

1. Откройте или создайте новый экземпляр на [главной странице {{ datalens-name }}]({{ link-datalens-main }}). 
1. Создайте подключение с типом коннектора **{{ ui-key.datalens.connections.connectors-list.view.label_connector-ch_billing_analytics }}**.
1. Задайте название подключения и нажмите кнопку **{{ ui-key.datalens.collections.action_create }}**.
1. Откройте **{{ yandex-cloud }} Billing Dashboard** и перейдите на вкладку **Labels**.
1. Выберите: 
   * **Usage date** — нужные даты;
   * **Billing account name** — один или несколько платежных аккаунтов;
   * **Cloud name (ID)** — оставьте поле пустым;
   * **Label key** — несколько значений можно указать одновременно:
     * `project_id` — статистика по проектам.
     * `resource_id` — статистика по сообществам.
     * `label.user_labels` — статистика по пользовательским [меткам](../../../resource-manager/concepts/labels.md).

{% note warning %}

Детализация трат доступна только для проектов, запущенных после 20 октября 2022 года.

{% endnote %}

В сформированной таблице **Costs by label value breakdown** будет доступна детализация расходов по сообществам {{ ml-platform-name }}.

{% note info %}

В таблице детализации также могут отображаться расходы других сервисов, не привязанных к идентификатору облака, например {{ tracker-full-name }}.

{% endnote %}