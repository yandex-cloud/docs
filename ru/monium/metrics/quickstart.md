# Начало работы с метриками ресурсов {{ yandex-cloud }}

{{ monium-name }} позволяет работать с метриками сервисов {{ yandex-cloud }}, а также с любыми другими метриками, загруженными в {{ monium-name }}. Например, из ваших приложений, вашей инфраструктуры или других облаков.

Эта инструкция поможет вам создать дашборд и виджеты, которые отображают состояния ресурсов {{ yandex-cloud }}.

{% note info %}

Метрики ресурсов {{ yandex-cloud }} передаются в {{ monium-name }} автоматически. Также многие сервисы предоставляют сервисные дашборды с набором готовых виджетов, которые отображают состояние ваших облачных ресурсов.

Если у вас нет ресурсов для проверки {{ monium-name }}, создайте [виртуальную машину](../../compute/operations/vm-create/create-linux-vm.md).

{% endnote %}

## Создайте новый дашборд {#create-dashboard}

1. На главной странице [{{ monium-name }}]({{ link-monium }}) слева выберите раздел **Дашборды**.
1. Слева вверху выберите проект каталога, в котором находится нужный ресурс.
1. Справа вверху нажмите **Создать**.
1. Справа вверху нажмите ![image](../../_assets/console-icons/plus.svg) и выберите **{{ ui-key.yacloud_monitoring.dashboard.widget-placeholder.add-title }}**.
1. В текстовом поле введите `Кросс-сервисный дашборд`.
1. Нажмите **{{ ui-key.yacloud_monitoring.actions.common.save }}**.
   
   Заголовок позволяет отделить одну секцию дашборда от другой.
1. Сохраните дашборд:
   1. Справа вверху нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_monitoring.actions.common.save }}**.
   1. Введите заголовок дашборда.


## Добавьте виджет сервиса {{ compute-full-name }} {#add-compute-widget}

1. Справа вверху нажмите ![image](../../_assets/console-icons/plus.svg) и выберите **{{ ui-key.yacloud_monitoring.dashboard.widget-placeholder.add-graph }}**.
1. Настройте новый график с загрузкой CPU всех виртуальных машин в каталоге, указав в запросе метрику `cpu_usage` сервиса {{ compute-full-name }}. Для этого выберите следующие метки в конструкторе запроса:
    - `cluster`=`default`
    - `service=__compute__`
    - `name=cpu_usage`
    - `resource_id=*`
    - `resource_type=vm`
1. Нажмите **{{ ui-key.yacloud_monitoring.querystring.action.execute-query }}**, и на странице отобразится график.
1. Вверху рядом с именем дашборда введите имя виджета, например, `CPU on all hosts`.
1. Справа вверху нажмите **{{ ui-key.yacloud_monitoring.actions.common.apply }}**.
1. Вернитесь на страницу редактирования дашборда: вверху нажмите заголовок дашборда, который указали ранее.

## Добавьте виджет секции {#add-section}

1. Нажмите ![image](../../_assets/console-icons/plus.svg) и выберите **Секция**.
1. Перенесите заголовок и график в созданную секцию.
1. Рядом с названием секции нажмите настройки и введите заголовок секции, например, `Виртуальные машины`.
1. Нажмите **{{ ui-key.yacloud_monitoring.actions.common.save }}**. 

## Сохраните созданный дашборд {#save-dashboard}

1. При необходимости измените размер виджетов и разместите их в произвольном порядке на дашборде.
1. Справа вверху нажмите ![image](../../_assets/console-icons/floppy-disk.svg) **{{ ui-key.yacloud_monitoring.actions.common.save }}**.

В результате вы создали дашборд с виджетами, которые отображают состояние ресурсов из разных сервисов {{ yandex-cloud }}.

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
