# Посмотреть статистику L7-балансировщика

[Статистика](../concepts/application-load-balancer.md#stats) работы балансировщика автоматически записывается в метрики сервиса [{{ monitoring-full-name }}](../../monitoring/).

Полный список метрик представлен в [справочнике](../metrics.md).

## Посмотреть общую статистику {#summary}

В {{ alb-name }} доступна общая статистика работы балансировщика, без разбивки по привязанным к нему ресурсам.

Чтобы посмотреть статистику:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создан балансировщик.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. Нажмите на имя нужного балансировщика.
  1. Перейдите на вкладку **{{ ui-key.yacloud.common.monitoring }}**.
  1. Выберите дашборд — **{{ ui-key.yacloud.alb.label_tab-http-stats }}** или **{{ ui-key.yacloud.alb.label_tab-capacity-stats }}**.
  1. Выберите временной промежуток, за который хотите посмотреть статистику: 1 час, 3 часа, 1 день, 1 неделя, 1 месяц.

{% endlist %}

## Посмотреть статистику с разбивкой по ресурсам {#resources}

{{ monitoring-name }} предоставляет статистику работы балансировщика с разбивкой по привязанным к нему ресурсам: HTTP-роутерам, виртуальным хостам, маршрутам и т. д.

Чтобы посмотреть статистику:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создан балансировщик.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. Нажмите на имя нужного балансировщика.
  1. Перейдите на вкладку **{{ ui-key.yacloud.common.monitoring }}**.
  1. Выберите дашборд — **{{ ui-key.yacloud.alb.label_tab-http-stats }}** или **{{ ui-key.yacloud.alb.label_tab-capacity-stats }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.monitoring.button_open-in-monitoring }}**.
  1. Выберите ресурсы, для которых хотите посмотреть статистику:

     * **HTTP Router** — [HTTP-роутер](../concepts/http-router.md).
     * **Virtual Host** — виртуальный хост HTTP-роутера.
     * **Route** — маршрут виртуального хоста.
     * **Backend Group** — [группа бэкендов](../concepts/backend-group.md).
     * **Backend** — бэкенд.
     * **Zone** — зона доступности, в которой расположены узлы балансировщика. Подробнее см. в разделе [{#T}](../concepts/application-load-balancer.md#lb-location).

     Если в поле выбрано значение `*`, на дашборде будет отображаться обобщенная статистика по всем ресурсам соответствующего типа, например по всем HTTP-роутерам.

  1. Выберите временной промежуток, за который хотите посмотреть статистику.
  1. Если нужно настроить автообновление дашборда, нажмите кнопку ![](../../_assets/console-icons/arrow-rotate-right.svg).

{% endlist %}
