# Начало работы с логами ресурсов {{ yandex-cloud }}

{{ monium-name }} позволяет работать с логами сервисов {{ yandex-cloud }}, а также с любыми другими логами, загруженными в {{ monium-name }}. Например, из ваших приложений, вашей инфраструктуры или других облаков.

Эта инструкция поможет вам посмотреть логи, которые передают ресурсы {{ yandex-cloud }}.

{% note info %}

Как настроить передачу логов для ресурсов {{ yandex-cloud }}, см. в документации нужного ресурса. Например, настроить логирование кластера {{ AF }} можно при [создании](../../managed-airflow/operations/cluster-create.md) или [изменении](../../managed-airflow/operations/cluster-update.md) кластера.

{% endnote %}

Чтобы посмотреть логи:

1. Создайте ресурс {{ yandex-cloud }} и настройте его логирование.
   
   Список сервисов, которые поддерживают передачу логов в {{ monium-name }}, см. в разделе [{#T}](../../overview/concepts/monitoring-logging-tools.md).

1. На главной странице [{{ monium-name }}]({{ link-monium }}) слева выберите раздел **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.logs.title }}**.
1. Вверху на шкале времени задайте промежуток поиска данных.
1. В строке поиска выберите метки запроса:

   {% include [yc-resource-labels](../../_includes/monium/yc-resource-labels.md) %}

1. Чтобы отфильтровать логи по другим параметрам, выберите нужные метки из списка. Например, метка `level = WARN` покажет все логи с уровнем WARNING (предупреждение).

   Подробнее о составлении запросов см. в разделах [{#T}](../concepts/data-model.md) и [{#T}](../concepts/querying.md).

1. Чтобы сразу просмотреть логи другого ресурса, нажмите **{{ ui-key.yacloud_monitoring.querystring.action.add-query }}** и укажите параметры нужного ресурса {{ yandex-cloud }}.
1. Нажмите **{{ ui-key.yacloud_monitoring.querystring.action.execute-query }}**.

Подробнее о работе с логами см. раздел [{#T}](logs-explorer.md).

## Сервисный дашборд для логов {#logs-service-dashboard}

{% include [service-logs](../../_includes/monium/service-logs.md) %}