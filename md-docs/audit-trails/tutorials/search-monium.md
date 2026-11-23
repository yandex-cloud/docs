[Документация Yandex Cloud](../../index.md) > [Yandex Audit Trails](../index.md) > [Практические руководства](index.md) > Просмотр аудитных логов в Monium

# Просмотр аудитных логов Audit Trails в Monium

[Создайте трейл](../operations/create-trail.md#monium) с загрузкой аудитных логов в Monium или [измените назначение](../operations/manage-trail.md#update-trail) существующего трейла.

Для просмотра логов нужна роль [monium.logs.reader](../../monium/security/index.md#monium-logs-reader) на каталог с трейлом.

{% list tabs group=audit-trails-destination %}

- Monium {#monium}

  1. Откройте [Monium](https://monium.yandex.cloud).
  1. На панели слева выберите ![compass](../../_assets/console-icons/compass.svg) **Обзор** → **Логи**.
  1. Вверху страницы выберите период поиска. Например, нажмите **1h**, чтобы посмотреть события за последний час.
  1. В строке запроса укажите метки:
  
      * `project` — проект каталога с трейлом в формате `folder__<идентификатор_каталога>`;
      * `service` — `__audit-trails__`;
      * (Опционально) `trail_id` — идентификатор трейла, который доставил события.
  
  1. Нажмите **Выполнить запрос**. На графике отобразится количество записей за выбранный период. Сами записи появятся в таблице логов.
  1. Разверните запись лога, чтобы увидеть сведения о событии.
  
      * `message` — краткое описание события;
      * `labels.trail_id` — идентификатор трейла;
      * `meta` — подробные сведения о событии.
  
  
  Для дополнительной фильтрации используйте [язык запросов Monium](../../monium/logs/query.md). Подробнее о просмотре записей — в разделе [Поиск и анализ логов](../../monium/logs/logs-explorer.md).

{% endlist %}

#### Полезные ссылки {#see-also}

* [Поиск аудитных событий Yandex Cloud в Monium](search-cloud-logging.md)
* [Аудитный лог событий уровня конфигурации](../concepts/format.md)
* [Аудитный лог событий уровня сервисов](../concepts/format-data-plane.md)