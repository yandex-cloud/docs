{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте [главную страницу сервиса]({{ link-monitoring }}) {{ monitoring-name }}.
  1. На панели слева выберите **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**.
  1. Вверху в списке **Источник данных** выберите **{{ prometheus-name }}**.
  1. Выберите воркспейс.
  1. Введите запрос на языке [PromQL](https://prometheus.io/docs/prometheus/latest/querying/basics/).
  1. Чтобы отобразить на графике несколько линий, нажмите кнопку **{{ ui-key.yacloud_monitoring.querystring.action.add-query }}** и введите новый запрос.
  1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.querystring.action.execute-query }}**, чтобы построить график.

      Получившийся график можно [добавить](#add-to-dashboard) на [дашборд](../../monitoring/concepts/visualization/dashboard.md) в качестве [виджета](../../monitoring/concepts/visualization/widget.md).

{% endlist %}