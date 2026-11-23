1. Откройте [{{ monium-name }}]({{ link-monium }}).
1. На панели слева выберите ![compass](../../_assets/console-icons/compass.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.all-panel.menu.category.explore }}** → **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.logs.title }}**.
1. Вверху страницы выберите период поиска. Например, нажмите **1h**, чтобы посмотреть события за последний час.
1. В строке запроса укажите метки:

    * `project` — проект каталога с трейлом в формате `folder__<идентификатор_каталога>`;
    * `service` — `__audit-trails__`;
    * (Опционально) `trail_id` — идентификатор трейла, который доставил события.

1. Нажмите **{{ ui-key.yacloud_monitoring.querystring.action.execute-query }}**. На графике отобразится количество записей за выбранный период. Сами записи появятся в таблице логов.
1. Разверните запись лога, чтобы увидеть сведения о событии.

    * `message` — краткое описание события;
    * `labels.trail_id` — идентификатор трейла;
    * `meta` — подробные сведения о событии.


Для дополнительной фильтрации используйте [язык запросов {{ monium-name }}](../../monium/logs/query.md). Подробнее о просмотре записей — в разделе [{#T}](../../monium/logs/logs-explorer.md).

