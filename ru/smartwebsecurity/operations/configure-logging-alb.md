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

  Будут записываться все события {{ sws-name }} уровня сервисов в текущем каталоге. События уровня конфигурации записываться не будут.

  Другие способы включения записи событий описаны в разделе [{#T}](../../audit-trails/operations/create-trail.md).

{% endlist %}

### Просмотреть логи {#view-logs}

{% list tabs group=instructions %}

- {{ monium-name }} {#monium}

  {% include [view-logs-monium](../../_includes/application-load-balancer/view-logs-monium.md) %}

  ## Примеры фильтрации логов {#filtration}

  Одна запись соответствует одному HTTP-запросу к L7-балансировщику. Результат проверки {{ sws-name }} содержится в поле `smartwebsecurity`. Описание вложенных полей приведено в [справочнике логов {{ alb-name }}](../../application-load-balancer/logs-ref.md).

  Чтобы отбирать запросы по результату проверки, добавляйте условия по этим полям на [языке запросов {{ monium-name }}](../../monium/logs/query.md). В примерах не указаны метки проекта, сервиса и ресурса — сохраните `project`, `service` и `resource_id` в запросе.

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

- {{ at-name }} {#at}

  Для просмотра логов нужна роль [storage.viewer](../../storage/security/index.md#storage-viewer) на бакет.

  1. В [консоли управления]({{ link-console-main }}) выберите каталог с бакетом.
  1. [Перейдите]({{ link-console-main }}/link/storage) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Выберите бакет, указанный в настройках трейла.
  1. На вкладке **{{ ui-key.yacloud.storage.bucket.switch_files }}** найдите файлы за нужную дату. [Путь к файлу](../../audit-trails/concepts/format-data-plane.md#log-file-name) содержит идентификатор трейла и дату записи.
  1. [Скачайте](../../storage/operations/objects/download.md) нужный JSON-файл и откройте его в текстовом редакторе.

  Каждый файл содержит массив событий. Чтобы найти определенное [событие {{ sws-name }}](../at-ref.md#data-plane-events), ищите значение поля `event_type` в формате `yandex.cloud.audit.smartwebsecurity.<имя_события>`.

{% endlist %}


