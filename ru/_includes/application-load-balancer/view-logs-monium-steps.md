Для просмотра логов нужна роль [monium.logs.reader](../../monium/security/index.md#monium-logs-reader) на каталог с балансировщиком.

1. Откройте [{{ monium-name }}]({{ link-monium }}). Просмотр логов в интерфейсе {{ alb-name }} пока недоступен.
1. На панели слева выберите ![compass](../../_assets/console-icons/compass.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.all-panel.menu.category.explore }}** → **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.logs.title }}**.
1. Задайте период поиска логов.
1. В строке запроса укажите значения меток:

   * `project` — [проект каталога](*monium-folder-project) с балансировщиком.
   * `service` — `__application-load-balancer__`.
   * `resource_id` — [идентификатор балансировщика](../../application-load-balancer/operations/application-load-balancer-get.md).

   Составьте запрос в режиме токенов или введите его в текстовом режиме:

   ```text
   {project="folder__<идентификатор_каталога>", service="__application-load-balancer__", resource_id="<идентификатор_балансировщика>"}
   ```

1. Нажмите **{{ ui-key.yacloud_monitoring.querystring.action.execute-query }}**. Чтобы посмотреть содержимое записи, разверните ее.

Для дополнительной фильтрации используйте [язык запросов {{ monium-name }}](../../monium/logs/query.md).

Подробнее о работе с логами — в разделе [«Поиск и анализ логов»](../../monium/logs/logs-explorer.md).

[*monium-folder-project]: {% include notitle [folder-project](../../_popups/monium/folder-project.md) %}
