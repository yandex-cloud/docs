{% list tabs group=instructions %}

- Интерфейс {{ monium-name }} {#console}

  1. Откройте [главную страницу]({{ link-monium }}) {{ monium-name }}.
  1. Выберите [проект](../../monium/concepts/glossary.md#project), в котором находится созданный ранее воркспейс {{ prometheus-name }}.
  1. Слева выберите ![alt](../../_assets/console-icons/compass.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.all-panel.menu.category.explore }}** → ![alt](../../_assets/console-icons/rectangle-pulse.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**.
  1. Вверху в списке **Источник данных** выберите **{{ prometheus-name }}**.
  1. Выберите воркспейс.
  1. Введите запрос на языке [PromQL](https://prometheus.io/docs/prometheus/latest/querying/basics/).
  1. Чтобы отобразить на графике несколько линий, нажмите кнопку **{{ ui-key.yacloud_monitoring.querystring.action.add-query }}** и введите новый запрос.
  1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.querystring.action.execute-query }}**, чтобы построить график.

      Получившийся график можно [добавить](#add-to-dashboard) на [дашборд](../../monium/concepts/visualization/dashboard.md) в качестве [виджета](../../monium/concepts/visualization/widget.md).

{% endlist %}