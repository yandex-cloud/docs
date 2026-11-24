---
title: Мониторинг состояния инстанса {{ GL }} и хостов
description: Вы можете отслеживать состояние инстанса {{ mgl-name }} с помощью инструментов мониторинга в консоли управления. Эти инструменты предоставляют диагностическую информацию в виде графиков. Также вы можете настроить алерты {{ monium-full-name }} для автоматического мониторинга состояния инстанса.
---

# Мониторинг состояния инстанса {{ mgl-name }}

{% include [note-preview](../../../_includes/note-preview.md) %}

Данные о состоянии инстанса можно посмотреть на вкладке **{{ ui-key.yacloud.common.monitoring }}** страницы инстанса или в [{{ monium-full-name }}](../../../monium/).

Диагностическая информация о состоянии инстанса представлена в виде графиков. На них автоматически применяются наиболее подходящие кратные единицы измерения (гигабайты, проценты и т. д.).

Вы можете [настроить алерты](#monitoring-integration) в {{ monium-full-name }} для получения уведомлений о сбоях в работе инстанса. В {{ monium-name }} используются два порога срабатывания алерта: `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}` и `{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}`. При превышении заданного порога вы получите оповещения через настроенные [каналы уведомлений](../../../monium/concepts/alerting/notification-channel.md).

## Мониторинг состояния инстанса {#view-graphs}

Чтобы посмотреть детальную информацию о состоянии инстанса {{ mgl-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-console-main }}/link/managed-gitlab) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Нажмите на имя нужного инстанса и выберите вкладку **{{ ui-key.yacloud.common.monitoring }}**.

      На странице отображаются следующие графики:
      * **Data disk** — количество занятого и свободного места на диске для хранения данных.
      * **System disk** — количество занятого и свободного места в системном хранилище.
      * **CPU** — загрузка процессорных ядер.
      * **Memory** — использование оперативной памяти. При высоких нагрузках значение параметра **Available memory** уменьшается, а значение **Used memory** растет.

  {% note tip %}

  Чтобы перейти к работе с метриками, дашбордами или алертами в {{ monium-full-name }}, на панели сверху справа нажмите **{{ ui-key.yacloud.monitoring.button_open-in-monitoring }}**.

  {% endnote %}

{% endlist %}

## Настройка алертов в {{ monium-name }} {#monitoring-integration}

{% list tabs group=instructions %}

- Интерфейс {{ monium-name }} {#console}

   1. Откройте [главную страницу]({{ link-monium }}) {{ monium-name }}.
   1. Вверху слева выберите [проект](../../../monium/concepts/glossary.md#project), соответствующий каталогу, в котором размещен инстанс {{ mgl-name }}.
   1. На панели слева выберите ![alt](../../../_assets/console-icons/layout-cells-large.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.dashboards.title }}**.
   1. Перейдите на вкладку **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}** и выберите **Managed GitLab**.
   1. Нажмите на селектор **Host id**, в строке поиска введите имя хоста инстанса в домене `.gitlab.yandexcloud.net`, например `example` для инстанса с доменным именем `example.gitlab.yandexcloud.net`, и нажмите клавишу **Enter**.
   1. На нужном графике нажмите на значок ![options](../../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.
   1. Укажите название алерта, например `gitlab_disk_free`.
   1. Выберите **{{ ui-key.yacloud_monitoring.monitoring-alerts.type.threshold_2 }}** тип алерта. Он срабатывает при сравнении результата выбранного запроса с пороговыми значениями. Позволяет использовать имя запроса в качестве переменной в другом запросе.
   1. Выберите уровень алерта:
       * `Unspecified` — черновик или тест без выбранного уровня.
       * `Disaster` — недоступность сервиса или риск потери данных.
       * `Critical` — деградация сервиса или нехватка ресурсов.
       * `Info` — плановая операция или тестовый алерт.
   1. Посмотрите график метрик, по значениям которых будет создан алерт. Если на графике несколько показателей, в разделе **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.alert-config }}** вы можете оставить все запросы данных или только некоторые из них. Например, для метрики **System disk** можно удалить лишний запрос на занятое место в хранилище и оставить только запрос на свободное место.

      Чтобы убрать лишний запрос, в его строке нажмите ![options](../../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yacloud_monitoring.actions.common.delete }}**.

      Также в блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.alert-config }}** вы можете описать произвольный запрос к метрикам инстанса. Для поиска метрик {{ mgl-name }} укажите метку `service` = `__managed-gitlab__` и метку `host`. В метке `host` укажите имя хоста инстанса в домене `.gitlab.yandexcloud.net`, например, `example` для инстанса с доменным именем `example.gitlab.yandexcloud.net`. Подробнее о метриках и метках в [справочнике метрик](../../metrics.md).

      Подробнее о языке запросов в [документации {{ monium-name }}](../../../monium/concepts/querying.md).
   1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.alert-conditions }}** задайте [условия перехода алерта](../../../monium/concepts/alerting/alert.md#condition) в статусы `Warning` и `Alarm`:

      * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.evaluation-type }}** — функция для применения к значениям метрик во временном окне.
      * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.trigger-condition }}** — условие сравнения результата с порогами `Warning` и `Alarm`.
      * **{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}** — порог раннего предупреждения.
      * **{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}** — порог критической ошибки.
      * **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.evaluation-window-key-value }}** — интервал, за который рассчитывается функция агрегации.
      * **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.time-shift }}** — сдвиг окна вычисления назад.

   1. Настройте [уведомления](../../../monium/concepts/alerting/notification-channel.md). Если у вас нет канала уведомлений, [создайте его](../../../monium/operations/alert/create-channel.md).
   1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.actions.common.create }}**.

{% endlist %}

Рекомендуемые значения порогов для метрики **Оставшееся свободное место на диске** (`sys.filesystem.FreeB`):

1. **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.evaluation-type }}** — `Среднее`.
1. **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.trigger-condition }}** — `Меньше или равно`.
1. **{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}** — 10% от размера хранилища, в байтах.
1. **{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}** — 7% от размера хранилища, в байтах.
1. **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.evaluation-window-key-value }}** — `5m`.
1. **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.time-shift }}** — `30s`.

## Статусы инстанса {#statuses}

_Статус_ показывает, запущен ли инстанс, остановлен или находится в промежуточном состоянии. Статус можно посмотреть в списке инстансов {{ mgl-name }} и на странице каждого инстанса.

Возможные статусы:

#|
|| **Статус** | **Описание** | **Предлагаемые действия** ||
|| `Creating` | Идет подготовка к первому запуску | Подождите немного и приступайте к работе. Время создания инстанса зависит от класса хостов. ||
|| `Running` | Инстанс работает в штатном режиме | Действий не требуется. ||
|| `Stopping` | Инстанс останавливается | Через некоторое время инстансу будет присвоен статус `Stopped`, и он будет выведен из работы. Действий не требуется. ||
|| `Stopped` | Инстанс остановлен | Запустите инстанс, чтобы вернуть его в работу. ||
|| `Starting` | Остановленный ранее инстанс запускается | Через некоторое время инстансу будет присвоен статус `Running`. Подождите немного и приступайте к работе. ||
|| `Updating` | Выполняется обновление инстанса | По завершении обновления ему будет присвоен статус `Running`. Подождите немного и приступайте к работе. ||
|| `Error` | Произошла ошибка, которая не позволяет инстансу продолжить работу | Выполните начальную диагностику:

* Проанализируйте [графики мониторинга](#view-graphs) инстанса.
* На странице инстанса на вкладке **{{ ui-key.yacloud.common.operations-key-value }}** посмотрите, какие операции в нем выполнялись.

Если причины ошибки не удалось выяснить самостоятельно, [обратитесь в службу поддержки]({{ link-console-support }}). ||
|| `Status_unknown` | Инстанс не может определить свой статус | Выполните начальную диагностику:

* Проанализируйте [графики мониторинга](#view-graphs) инстанса.
* На странице инстанса на вкладке **{{ ui-key.yacloud.common.operations-key-value }}** посмотрите, какие операции в нем выполнялись.

Если причины ошибки не удалось выяснить самостоятельно, обратитесь в службу поддержки. ||
|| `Deleting` | Инстанс удаляется | По завершении удаления инстанс исчезнет со страницы **{{ ui-key.yacloud.gitlab.label_instances-title }}** и больше не будет доступен. Действий не требуется.

При удалении инстанса автоматически создается резервная копия, которая хранится в течение двух недель. Если после удаления нужно восстановить инстанс, обратитесь в службу поддержки. ||
|#
