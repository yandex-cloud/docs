[Документация Yandex Cloud](../../index.md) > [Yandex Application Load Balancer](../index.md) > [Пошаговые инструкции](index.md) > L7-балансировщики > Посмотреть логи L7-балансировщика

# Посмотреть логи L7-балансировщика



[Логи](../concepts/monitoring.md#logging) L7-балансировщика записываются в [Monium Logs](../../monium/logs/quickstart-resources.md). Если запись отключена, [включите ее](application-load-balancer-manage-logs.md#enable-logs).

{% list tabs group=instructions %}

- Monium {#monium}

  Для просмотра логов нужна роль [monium.logs.reader](../../monium/security/index.md#monium-logs-reader) на каталог с балансировщиком.
  
  1. Откройте [Monium](https://monium.yandex.cloud). Просмотр логов в интерфейсе Application Load Balancer пока недоступен.
  1. На панели слева выберите ![compass](../../_assets/console-icons/compass.svg) **Обзор** → **Логи**.
  1. Задайте период поиска логов.
  1. В строке запроса укажите значения меток:
  
     * `project` — [проект каталога](*monium-folder-project) с балансировщиком.
     * `service` — `__application-load-balancer__`.
     * `resource_id` — [идентификатор балансировщика](application-load-balancer-get.md).
  
     Составьте запрос в режиме токенов или введите его в текстовом режиме:
  
     ```text
     {project="folder__<идентификатор_каталога>", service="__application-load-balancer__", resource_id="<идентификатор_балансировщика>"}
     ```
  
  1. Нажмите **Выполнить запрос**. Чтобы посмотреть содержимое записи, разверните ее.
  
  Для дополнительной фильтрации используйте [язык запросов Monium](../../monium/logs/query.md).
  
  Подробнее о работе с логами — в разделе [«Поиск и анализ логов»](../../monium/logs/logs-explorer.md).
  
  [*monium-folder-project]: Для каждого каталога Yandex Cloud автоматически создается проект Monium с идентификатором `folder__<идентификатор_каталога>`. По умолчанию выбран проект текущего каталога. [Идентификатор каталога](../../resource-manager/operations/folder/get-id.md) можно скопировать в консоли управления или получить с помощью CLI.

{% endlist %}