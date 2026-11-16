[Документация Yandex Cloud](../../index.md) > [Yandex Smart Web Security](../index.md) > [Пошаговые инструкции](index.md) > Настроить логи через Application Load Balancer

# Настроить логирование через Application Load Balancer

Этот способ записывает HTTP-запросы, которые обрабатывает L7-балансировщик, включая результат проверки Smart Web Security. Для подробного анализа сработавших правил и отбора логов по типам правил и вердиктам используйте [логирование через Smart Web Security](configure-logging.md).

Для записи логов Smart Web Security используются:

* [Monium Logs](../../monium/logs/quickstart-resources.md) — для логов профилей безопасности, прокси-серверов и L7-балансировщиков Application Load Balancer. Логи содержат информацию об HTTP-запросах и сработавших правилах, включая WAF и ARL.
* [Audit Trails](../../audit-trails/index.md) — для сбора аудитных событий Smart Web Security. Это записи о событиях безопасности и действиях с ресурсами.

## Логи аудита {#audit-events}

В Audit Trails есть два типа событий:

* [Уровня конфигурации](../at-ref.md#control-plane-events) — действия, связанные с конфигурированием ресурсов Yandex Cloud. Например, создание или удаление профиля безопасности.
* [Уровня сервисов](../at-ref.md#data-plane-events) — действия, которые происходят с ресурсами внутри сервисов Yandex Cloud. Например, срабатывание правила из профиля WAF.

Записывать события можно в бакет Object Storage, проект Monium или поток данных Data Streams.

## Логи HTTP-запросов и применения правил {#requests-logging}

Логи HTTP-запросов можно записывать в Monium Logs через профиль безопасности Smart Web Security, прокси-сервер или L7-балансировщик Application Load Balancer. Логирование через профиль безопасности предоставляет больше возможностей для анализа сработавших правил.

Логи поступают в [проект каталога](*monium-folder-project), в котором находится соответствующий ресурс.



Логи профилей безопасности и прокси-серверов доступны в интерфейсах Smart Web Security и Monium, а логи L7-балансировщиков — в интерфейсе Monium. Просмотр логов в интерфейсе Application Load Balancer пока недоступен.

Анализ логов позволяет настраивать и отслеживать работу Smart Web Security:

* Тестировать работу правил безопасности, WAF и ARL в режиме **Только логирование** (dry run). В этом режиме запросы пользователей не блокируются, но в логи записывается информация о срабатывании правил.
* Просматривать количество заблокированных и пропущенных запросов, оценивать и корректировать работу правил.
* Просматривать подробную информацию о запросе, выявлять ложноположительные срабатывания.

В некоторых случаях сервис может блокировать трафик при атаках. В логах для таких блокировок будет указана отметка [сервисного правила](../concepts/rules.md#service-rule): `sws_service_rule`.

## Работа с логами {#configure-logging}

Чтобы начать работать с логами Smart Web Security:

1. [Включите и настройте запись логов](#enable-logging).
1. [Посмотрите и отфильтруйте логи](#view-logs).

### Включить логирование {#enable-logging}

{% note info %}

Для настройки логирования нужна роль [alb.editor](../../application-load-balancer/security/index.md#alb-editor), а для просмотра логов — [monium.logs.reader](../../monium/security/index.md#monium-logs-reader) на каталог с балансировщиком.

{% endnote %}

{% list tabs group=sws-log-type %}

- Логи HTTP-запросов {#request-logs}

  [Включите запись логов балансировщика](../../application-load-balancer/operations/application-load-balancer-manage-logs.md#enable-logs) через CLI, API или Terraform. Управление логированием в интерфейсе Application Load Balancer пока недоступно.

  Для сокращения объема логов настройте [правила отбрасывания](../../application-load-balancer/operations/application-load-balancer-manage-logs.md#update-logs).

- Аудитные события {#audit-trails}

  Настройте запись событий Smart Web Security в [бакет](../../storage/concepts/bucket.md) Object Storage. Перед созданием трейла [подготовьте бакет и сервисный аккаунт](../../audit-trails/operations/create-trail.md#before-you-begin).

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится профиль Smart Web Security.
  1. [Перейдите](https://console.yandex.cloud/link/audit-trails) в сервис **Audit Trails**.
  1. Нажмите **Создать трейл**.
  1. В поле **Приёмник логов** выберите **Object Storage**.
  1. В поле **Бакет** выберите подготовленный бакет.
  1. Отключите **Сбор логов с управляющего слоя**.
  1. В блоке **Сбор логов со слоя данных** очистите список и выберите сервис **Smart Web Security**.
  1. В блоке **Сервисный аккаунт** выберите подготовленный аккаунт с ролями [storage.uploader](../../storage/security/index.md#storage-uploader) на бакет и [audit-trails.viewer](../../audit-trails/security/index.md#at-viewer) на каталог с профилем безопасности.
  1. В блоке **Общая информация** введите имя трейла, например `trail-sws`.
  1. Нажмите **Создать**.

  Будут записываться все события Smart Web Security уровня сервисов в текущем каталоге. События уровня конфигурации записываться не будут.

  Другие способы включения записи событий описаны в разделе [Создание трейла для загрузки аудитных логов](../../audit-trails/operations/create-trail.md).

{% endlist %}

### Просмотреть логи {#view-logs}

{% list tabs group=instructions %}

- Monium {#monium}

  Для просмотра логов нужна роль [monium.logs.reader](../../monium/security/index.md#monium-logs-reader) на каталог с балансировщиком.
  
  1. Откройте [Monium](https://monium.yandex.cloud). Просмотр логов в интерфейсе Application Load Balancer пока недоступен.
  1. На панели слева выберите ![compass](../../_assets/console-icons/compass.svg) **Обзор** → **Логи**.
  1. Задайте период поиска логов.
  1. В строке запроса укажите значения меток:
  
     * `project` — [проект каталога](*monium-folder-project) с балансировщиком.
     * `service` — `__application-load-balancer__`.
     * `resource_id` — [идентификатор балансировщика](../../application-load-balancer/operations/application-load-balancer-get.md).
  
     Составьте запрос в режиме токенов или введите его в текстовом режиме:
  
     ```text
     {project="folder__<идентификатор_каталога>", service="__application-load-balancer__", resource_id="<идентификатор_балансировщика>"}
     ```
  
  1. Нажмите **Выполнить запрос**. Чтобы посмотреть содержимое записи, разверните ее.
  
  Для дополнительной фильтрации используйте [язык запросов Monium](../../monium/logs/query.md).
  
  Подробнее о работе с логами — в разделе [«Поиск и анализ логов»](../../monium/logs/logs-explorer.md).
  
  [*monium-folder-project]: Для каждого каталога Yandex Cloud автоматически создается проект Monium с идентификатором `folder__<идентификатор_каталога>`. По умолчанию выбран проект текущего каталога. [Идентификатор каталога](../../resource-manager/operations/folder/get-id.md) можно скопировать в консоли управления или получить с помощью CLI.

  ## Примеры фильтрации логов {#filtration}

  Одна запись соответствует одному HTTP-запросу к L7-балансировщику. Результат проверки Smart Web Security содержится в поле `smartwebsecurity`. Описание вложенных полей приведено в [справочнике логов Application Load Balancer](../../application-load-balancer/logs-ref.md).

  Чтобы отбирать запросы по результату проверки, добавляйте условия по этим полям на [языке запросов Monium](../../monium/logs/query.md). В примерах не указаны метки проекта, сервиса и ресурса — сохраните `project`, `service` и `resource_id` в запросе.

  ### Фильтры для активных правил {#active-rule-filters}

  Для поиска заблокированных запросов и запросов, направленных на капчу, используйте следующие значения полей внутри `smartwebsecurity`:

  * Базовые правила: `matched_rule.rule_type` — `RULE_CONDITION`, `matched_rule.verdict` — `DENY`.
  * Smart Protection: `matched_rule.rule_type` — `SMART_PROTECTION`, `matched_rule.verdict` — `CAPTCHA`.
  * WAF: `matched_rule.rule_type` — `WAF`, `matched_rule.verdict` — `DENY`.
  * ARL: `advanced_rate_limiter.verdict` — `DENY`. Имя сработавшего правила указано в `advanced_rate_limiter.applied_quota_name`.

  ### Фильтры для правил в режиме логирования {#dry-run-filters}

  Для правил в режиме **Только логирование** проверяйте следующие поля внутри `smartwebsecurity`:

  * Smart Protection: `dry_run_matched_rule.rule_type` — `SMART_PROTECTION`, `dry_run_matched_rule.verdict` — `CAPTCHA`.
  * ARL: `advanced_rate_limiter.dry_run_exceeded_quota_names` — список правил, лимиты которых превышены.

  В режиме **Только логирование** правила ARL не блокируют запросы, поэтому вердикт `DENY` не подходит для их поиска. Если список `dry_run_exceeded_quota_names` пуст, лимиты правил в этом режиме не превышены.

- Audit Trails {#at}

  Для просмотра логов нужна роль [storage.viewer](../../storage/security/index.md#storage-viewer) на бакет.

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог с бакетом.
  1. [Перейдите](https://console.yandex.cloud/link/storage) в сервис **Object Storage**.
  1. Выберите бакет, указанный в настройках трейла.
  1. На вкладке **Объекты** найдите файлы за нужную дату. [Путь к файлу](../../audit-trails/concepts/format-data-plane.md#log-file-name) содержит идентификатор трейла и дату записи.
  1. [Скачайте](../../storage/operations/objects/download.md) нужный JSON-файл и откройте его в текстовом редакторе.

  Каждый файл содержит массив событий. Чтобы найти определенное [событие Smart Web Security](../at-ref.md#data-plane-events), ищите значение поля `event_type` в формате `yandex.cloud.audit.smartwebsecurity.<имя_события>`.

{% endlist %}