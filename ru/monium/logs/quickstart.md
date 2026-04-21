# Начало работы с логами приложений

{{ monium-logs-name }} — распределенная и высокодоступная система для хранения, поиска, визуализации и анализа логов. Система входит в платформу {{ monium-name }} и использует ее базовые компоненты — управление доступом, модель данных и единый интерфейс.

Этот раздел содержит общие сведения о передаче и просмотре логов из вашего приложения в {{ monium-name }}.

Для ресурсов {{ yandex-cloud }} см. раздел [{#T}](quickstart-resources.md).

## Поставка логов {#data-send}

Если вы еще не работали с облаком {{ yandex-cloud }} или у вас нет приложения, на котором можно проверить отправку логов, перейдите к разделу [{#T}](../quickstart.md). Там описана базовая настройка окружения и поставка телеметрии с помощью Otel Collector.

Поставка логов в {{ monium-name }} настраивается так же, как и другие виды телеметрии. Данные принимаются в формате OpenTelemetry, поэтому для отправки логов можно использовать любой агент или коллектор, который его поддерживает, либо передавать данные напрямую из приложения.

Если облако и приложение уже настроены и вы работали с поставкой телеметрии ранее, настройте отправку логов по параметрам ниже.

### Параметры {{ cloud-logging-name }} {#main-parameters}

* {% include [otel-only](../../_includes/monium/otel-only.md) %}

* Адрес для записи логов: `{{ api-host-monium }}:443`.

* Аутентификация:
  * [Сервисный аккаунт](../../iam/operations/sa/create.md) с ролью `monium.logs.writer` или общей ролью `monium.telemetry.writer`.
  * [API-ключ](../../iam/operations/iam-token/create-for-sa.md) с областью действия `yc.monium.logs.write` или `yc.monium.telemetry.write`.

* В заголовке: параметр `x-monium-project=<идентификатор_проекта>`.

    Это может быть проект облака (`cloud__<идентификатор_облака>`), каталога (`folder__<идентификатор_каталога>`) или другой [проект](../../monium/collector/project.md#project-create).

* В атрибутах ресурса `OTEL_RESOURCE_ATTRIBUTES`: `cluster` или `deployment.name` и `service` или `service.name`.

    Если кластер не указан, то по умолчанию `cluster = default`.


## Просмотр логов {#view-logs}

{% list tabs group=instructions %}

- Интерфейс {{ monium-name }} {#console}

  1. На главной странице сервиса [{{ monium-name }}]({{ link-monium }}) слева выберите **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.logs.title }}**.
  1. Вверху на шкале времени задайте промежуток поиска данных.
  1. В строке поиска введите запрос для поиска логов приложения:
     
     {% include [application-labels](../../_includes/monium/application-labels.md) %}

  1. Нажмите **{{ ui-key.yacloud_monitoring.querystring.action.execute-query }}**.
  1. Чтобы посмотреть логи для определенной записи, раскройте ее.

{% endlist %}

Подробнее о работе с логами см. раздел [{#T}](logs-explorer.md).

## Сервисный дашборд для логов {#logs-service-dashboard}

{% include [service-logs](../../_includes/monium/service-logs.md) %}

#### См. также {#see-also}

* [{#T}](../traces/index.md)
* [{#T}](../metrics/quickstart.md)