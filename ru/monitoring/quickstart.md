# Как начать работать с {{ monitoring-full-name }}

При помощи этой инструкции вы создадите дашборд и разместите виджеты, которые отображают состояния ресурсов {{ yandex-cloud }}.

{% note info %}

{{ monitoring-full-name }} автоматически создает сервисные дашборды с набором готовых виджетов, которые отображают состояние ваших облачных ресурсов.

Если у вас нет ресурсов, создайте их (например, виртуальную машину и кластер {{ CH }}), чтобы начать работать с сервисом.

{% endnote %}


## Создайте новый дашборд {#create-dashboard}

1. На [главной странице]({{ link-monitoring }}) сервиса нажмите **{{ ui-key.yacloud_monitoring.homepage.button_dashboards-action }}**.
1. Нажмите **{{ ui-key.yacloud_monitoring.dashboard.widget-placeholder.add-title }}**.
1. В текстовом поле введите `Кросс-сервисный дашборд`.
1. Нажмите **{{ ui-key.yacloud_monitoring.actions.common.add }}**.
1. Перетащите созданный виджет на необходимое место на дашборде.


## Добавьте виджет сервиса {{ compute-full-name }} {#add-compute-widget}

1. На странице редактирования дашборда нажмите **{{ ui-key.yacloud_monitoring.dashboard.widget-placeholder.add-graph }}**.
1. Настройте новый график с загрузкой CPU всех виртуальных машин в каталоге, указав в запросе метрику `cpu_usage` сервиса {{ compute-full-name }}. Для этого выберите следующие метки в конструкторе запроса:
    - `service=Compute Cloud`
    - `name=cpu_usage`
    - `resource_id=*`
    - `resource_type=vm`
1. Нажмите **{{ ui-key.yacloud_monitoring.actions.common.save }}**. Виджет отобразится на дашборде.
1. Нажмите ![gear](../_assets/console-icons/gear.svg), откроется модальное окно настроек виджета.
1. В параметр **{{ ui-key.yacloud_monitoring.dashboard.widget-settings.title }}** введите имя виджета, например, `CPU on all hosts`.
1. Нажмите **{{ ui-key.yacloud_monitoring.actions.common.save }}**. Имя виджета отобразится в верхней части виджета.
1. Перетащите созданный виджет на необходимое место на дашборде.

## Добавьте виджет сервиса {{ mch-full-name }} {#add-clickhouse-widget}

1. На странице редактирования дашборда нажмите **{{ ui-key.yacloud_monitoring.dashboard.widget-placeholder.add-graph }}**.
1. Настройте новый график с количеством свободного места на машинах кластера {{ mch-full-name }}, указав в запросе метрику `disk.free_bytes`. Для этого выберите следующие метки в конструкторе запроса:
    - `service=Managed Service for ClickHouse`
    - `name=disk.free_bytes`
    - `host=*`
    - `resource_id=*`
    - `resource_type=cluster`

1. Нажмите **{{ ui-key.yacloud_monitoring.actions.common.save }}**. Виджет отобразится на дашборде.
1. Нажмите ![gear](../_assets/console-icons/gear.svg), откроется модальное окно настроек виджета.
1. В параметр **{{ ui-key.yacloud_monitoring.dashboard.widget-settings.title }}** введите имя виджета, например, `Free space on ClickHouse hosts`.
1. Нажмите **{{ ui-key.yacloud_monitoring.actions.common.save }}**. Имя виджета отобразится в верхней части виджета.
1. Перетащите созданный виджет на необходимое место на дашборде.

## Сохраните созданный дашборд {#save-dashboard}

1. Нажмите **{{ ui-key.yacloud_monitoring.actions.common.save }}** в правом верхнем углу меню.
1. Введите имя дашборда и нажмите **{{ ui-key.yacloud_monitoring.actions.common.save }}**.

В результате вы создали дашборд с виджетами, которые отображают состояние ресурсов из разных сервисов {{ yandex-cloud }}.
