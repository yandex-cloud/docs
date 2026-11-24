---
title: Настроить логирование в {{ sws-full-name }} через {{ alb-name }}
description: Следуя данной инструкции, вы сможете настроить логирование в {{ sws-full-name }} через {{ alb-name }}.
---

# Настроить логирование через {{ alb-name }}

Этот способ записывает HTTP-запросы, которые обрабатывает L7-балансировщик, включая результат проверки {{ sws-name }}. Для подробного анализа сработавших правил и отбора логов по типам правил и вердиктам используйте [логирование через {{ sws-name }}](configure-logging.md).

{% include [logging-services](../../_includes/smartwebsecurity/logging-services.md) %}

### Включить логирование {#enable-logging}

{% note info %}

Для настройки логирования нужна роль [alb.editor](../../application-load-balancer/security/index.md#alb-editor), а для просмотра логов — [monium.logs.reader](../../monium/security/index.md#monium-logs-reader) на каталог с балансировщиком.

{% endnote %}

{% list tabs group=sws-log-type %}

- Логи HTTP-запросов {#request-logs}

  [Включите запись логов балансировщика](../../application-load-balancer/operations/application-load-balancer-manage-logs.md#enable-logs) через CLI, API или {{ TF }}. Управление логированием в интерфейсе {{ alb-name }} пока недоступно.

  Для сокращения объема логов настройте [правила отбрасывания](../../application-load-balancer/operations/application-load-balancer-manage-logs.md#update-logs).

- Аудитные события {#audit-trails}

  Настройте запись событий {{ sws-name }} в [бакет](../../storage/concepts/bucket.md) {{ objstorage-name }}. Перед созданием трейла [подготовьте бакет и сервисный аккаунт](../../audit-trails/operations/create-trail.md#before-you-begin).

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится профиль {{ sws-name }}.
  1. [Перейдите]({{ link-console-main }}/link/audit-trails) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
  1. Нажмите **{{ ui-key.yacloud.audit-trails.button_create-trail }}**.
  1. В поле **{{ ui-key.yacloud.audit-trails.label_log-receiver }}** выберите **{{ ui-key.yacloud.audit-trails.label_objectStorage }}**.
  1. В поле **{{ ui-key.yacloud.audit-trails.label_bucket }}** выберите подготовленный бакет.
  1. Отключите **{{ ui-key.yacloud.audit-trails.label_control-plane-collection-new }}**.
  1. В блоке **{{ ui-key.yacloud.audit-trails.label_data-plane-collection-new }}** очистите список и выберите сервис **{{ ui-key.yacloud.audit-trails.label_smartwebsecurity }}**.
  1. В блоке **{{ ui-key.yacloud.audit-trails.label_service-account }}** выберите подготовленный аккаунт с ролями [storage.uploader](../../storage/security/index.md#storage-uploader) на бакет и [audit-trails.viewer](../../audit-trails/security/index.md#at-viewer) на каталог с профилем безопасности.
  1. В блоке **{{ ui-key.yacloud.audit-trails.section_general-info }}** введите имя трейла, например `trail-sws`.
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

  Трейл настроен на сбор событий {{ sws-name }} уровня сервисов в текущем каталоге. События уровня конфигурации записываться не будут.

  Для передачи подробных событий `SWSMatchedRequest` включите логирование в профиле безопасности и выберите выход `AUDIT_TRAILS`, как описано в [инструкции по настройке логирования через {{ sws-name }}](configure-logging.md#audit-trails). События `WafMatchedRule`, `WafMatchedExclusionRule` и `ArlMatchedRequest` формируются при соответствующих срабатываниях независимо от настроек логирования профиля.

  Другие способы включения записи событий описаны в разделе [{#T}](../../audit-trails/operations/create-trail.md).

{% endlist %}

### Просмотреть логи {#view-logs}

{% list tabs group=instructions %}

- {{ monium-name }} {#monium}

  {% include [view-logs-monium-steps](../../_includes/application-load-balancer/view-logs-monium-steps.md) %}

  ## Примеры фильтрации логов {#filtration}

  Одна запись соответствует одному HTTP-запросу к L7-балансировщику. Результат проверки {{ sws-name }} содержится в поле `smartwebsecurity`. Описание вложенных полей приведено в [справочнике логов {{ alb-name }}](../../application-load-balancer/logs-ref.md).

  Введите запрос в текстовом режиме на [языке запросов {{ monium-name }}](../../monium/logs/query.md). Укажите идентификаторы каталога и балансировщика. Метки указываются без префикса `labels.`, а поля метаинформации — с префиксом `meta.`.

  ### Фильтры для активных правил {#active-rule-filters}

  Например, чтобы найти запросы, направленные Smart Protection на JS-проверку, используйте фильтр:

  ```text
  {
    project="folder__<идентификатор_каталога>",
    service="__application-load-balancer__",
    resource_id="<идентификатор_балансировщика>",
    meta.smartwebsecurity.matched_rule.rule_type="SMART_PROTECTION",
    meta.smartwebsecurity.matched_rule.verdict="JS_CHALLENGE"
  }
  ```

  Для других сценариев сохраните метки `project`, `service` и `resource_id` и замените дополнительные условия:

  * Блокировка базовым правилом: `meta.smartwebsecurity.matched_rule.rule_type="RULE_CONDITION", meta.smartwebsecurity.matched_rule.verdict="DENY"`.
  * Направление на капчу правилом Smart Protection: `meta.smartwebsecurity.matched_rule.rule_type="SMART_PROTECTION", meta.smartwebsecurity.matched_rule.verdict="CAPTCHA"`.
  * Блокировка правилом WAF: `meta.smartwebsecurity.matched_rule.rule_type="WAF", meta.smartwebsecurity.matched_rule.verdict="DENY"`.
  * Блокировка правилом ARL: `meta.smartwebsecurity.advanced_rate_limiter.verdict="DENY"`. Имя сработавшего правила указано в `meta.smartwebsecurity.advanced_rate_limiter.applied_quota_name`.
  * Запрос без подходящего маршрута: `meta.error_details="no_route"`.
  * Ответ `403` от бэкенда SolidWall WAF: `meta.backend_name="<имя_бэкенда>", meta.http_status="403"`.

  В последнем примере укажите имя бэкенда SolidWall WAF. Такой фильтр отбирает ответы бэкенда с кодом `403`. Например, запрос, разрешенный {{ sws-name }} и ARL, может быть заблокирован SolidWall WAF. HTTP-код ответа не является вердиктом {{ sws-name }}.

  ### Фильтры для правил в режиме логирования {#dry-run-filters}

  Для поиска результатов правил в режиме **Только логирование** добавьте к базовым меткам условие `meta.smartwebsecurity.dry_run_matched_rule.dry_run="true"`. При необходимости укажите тип правила в `meta.smartwebsecurity.dry_run_matched_rule.rule_type` и тестовый вердикт в `meta.smartwebsecurity.dry_run_matched_rule.verdict`. Тестовый вердикт может быть `ALLOW`. Наличия блока `dry_run_matched_rule` недостаточно: значение `dry_run` может быть `false`.

  В логах профиля безопасности поля `dry_run_matched_rule_*` записываются для тестовых вердиктов `DENY`, `CAPTCHA`, `JS_CHALLENGE` и `COOKIE_CHALLENGE`. При тестовом `ALLOW` эти поля отсутствуют, хотя запись о запросе может присутствовать. Итоговый `ALLOW` может сочетаться с тестовым `DENY`.

  Для правил ARL в режиме **Только логирование** список правил с превышенными лимитами находится в `meta.smartwebsecurity.advanced_rate_limiter.dry_run_exceeded_quota_names`.

  Чтобы найти один запрос в логах профиля безопасности и балансировщика, используйте значение `alb_request_id` из лога профиля в условии `meta.request_id="<идентификатор_запроса>"` для лога балансировщика. Для поиска в логах профиля используйте метку `alb_request_id` и [селектор профиля безопасности](configure-logging.md#filtration).

- {{ at-name }} {#at}

  Для просмотра логов нужна роль [storage.viewer](../../storage/security/index.md#storage-viewer) на бакет.

  1. В [консоли управления]({{ link-console-main }}) выберите каталог с бакетом.
  1. [Перейдите]({{ link-console-main }}/link/storage) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Выберите бакет, указанный в настройках трейла.
  1. На вкладке **{{ ui-key.yacloud.storage.bucket.switch_files }}** найдите файлы за нужную дату. [Путь к файлу](../../audit-trails/concepts/format-data-plane.md#log-file-name) содержит идентификатор трейла и дату записи.
  1. [Скачайте](../../storage/operations/objects/download.md) нужный JSON-файл и откройте его в текстовом редакторе.

  Каждый файл содержит массив событий. Чтобы найти определенное [событие {{ sws-name }}](../at-ref.md#data-plane-events), ищите значение поля `event_type` в формате `yandex.cloud.audit.smartwebsecurity.<имя_события>`.

{% endlist %}


