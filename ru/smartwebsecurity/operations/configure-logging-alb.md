---
title: Настроить логирование в {{ sws-full-name }} через {{ alb-name }}
description: Следуя данной инструкции, вы сможете настроить логирование в {{ sws-full-name }} через {{ alb-name }}.
---

# Настроить логирование через {{ alb-name }}

Этот способ записывает HTTP-запросы, которые обрабатывает L7-балансировщик, включая результат проверки {{ sws-name }}. Для подробного анализа сработавших правил и отбора логов по типам правил и вердиктам используйте [логирование через {{ sws-name }}](configure-logging.md).

{% include [logging-services](../../_includes/smartwebsecurity/logging-services.md) %}

### Включить логирование {#enable-logging}

{% note info %}

Для управления [логированием](../concepts/logging.md) в L7-балансировщике нужны роли:

* [alb.editor](../../application-load-balancer/security/index.md#alb-editor) на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) с балансировщиком;
* [logging.writer](../../logging/security/index.md#logging-writer) на [лог-группу](../../logging/concepts/log-group.md), в которую передаются логи.

Для просмотра логов нужна роль [logging.viewer](../../logging/security/index.md#logging-viewer) на лог-группу.

{% endnote %}

{% list tabs group=instructions %}

- {{ cloud-logging-name }} {#logging}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог с балансировщиком.
  1. [Перейдите]({{ link-console-main }}/link/application-load-balancer) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. В списке выберите балансировщик, к которому привязан профиль безопасности.
  1. Нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. В блоке **{{ ui-key.yacloud.alb.section_logs-settings }}**:

      1. Включите опцию **{{ ui-key.yacloud.alb.label_log-requests }}**.
      1. Выберите [лог-группу](../../logging/concepts/log-group.md) {{ cloud-logging-name }}, в которую будут записываться логи балансировщика, или [создайте новую](../../logging/operations/create-group.md).
      1. (Опционально) Чтобы уменьшить объем логов, нажмите **{{ ui-key.yacloud.alb.button_add-discard-rule }}** и настройте [правило отбрасывания](../../application-load-balancer/concepts/monitoring.md#discard-logs-rules).

  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

  Другие способы включения логов описаны в разделе [{#T}](../../application-load-balancer/operations/application-load-balancer-manage-logs.md).

- {{ at-name }} {#at}

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

- {{ cloud-logging-name }} {#logging}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог с лог-группой.
  1. [Перейдите]({{ link-console-main }}/link/logging) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
  1. На вкладке **{{ ui-key.yacloud.logging.label_groups }}** выберите лог-группу, в которую передаются логи балансировщика.
  1. Перейдите на вкладку **{{ ui-key.yacloud.common.logs }}**.
  1. Задайте период поиска логов.
  1. Введите фильтр на [языке фильтрующих выражений](../../logging/concepts/filter.md) и нажмите **Enter**. Например, чтобы отобрать логи конкретного балансировщика:

      ```text
      resource_type = "alb.loadBalancer" and resource_id = "<идентификатор_балансировщика>"
      ```

  1. Чтобы посмотреть содержимое записи, разверните ее.

  Логи также можно [просмотреть в интерфейсе {{ alb-name }}](../../application-load-balancer/operations/application-load-balancer-get-logs.md).

  ## Примеры фильтрации логов {#filtration}

  Одна запись соответствует одному HTTP-запросу к L7-балансировщику. Результат проверки {{ sws-name }} находится в блоке `json_payload.smartwebsecurity`. Описание полей приведено в [справочнике логов {{ alb-name }}](../../application-load-balancer/logs-ref.md).

  Условия ниже можно объединить с фильтром по балансировщику с помощью `and`.

  ### Фильтры для активных правил {#active-rule-filters}

  Чтобы отобрать запросы по результату проверки, используйте условия:

  * Запросы, заблокированные базовыми правилами:

      ```text
      json_payload.smartwebsecurity.matched_rule.rule_type = RULE_CONDITION and json_payload.smartwebsecurity.matched_rule.verdict = DENY
      ```

  * Запросы, направленные правилами Smart Protection на капчу:

      ```text
      json_payload.smartwebsecurity.matched_rule.rule_type = SMART_PROTECTION and json_payload.smartwebsecurity.matched_rule.verdict = CAPTCHA
      ```

  * Запросы, заблокированные Cloud WAF:

      ```text
      json_payload.smartwebsecurity.matched_rule.rule_type = WAF and json_payload.smartwebsecurity.matched_rule.verdict = DENY
      ```

  * Запросы, заблокированные ARL:

      ```text
      json_payload.smartwebsecurity.advanced_rate_limiter.verdict = DENY
      ```

  * Запросы, заблокированные конкретным правилом ARL, например `arl-rule-1`:

      ```text
      json_payload.smartwebsecurity.advanced_rate_limiter.verdict = DENY and json_payload.smartwebsecurity.advanced_rate_limiter.applied_quota_name = "arl-rule-1"
      ```

  ### Фильтры для правил в режиме логирования {#dry-run-filters}

  Для правил в режиме **Только логирование** используйте следующие условия:

  * Запросы, которые правила Smart Protection направили бы на капчу:

      ```text
      json_payload.smartwebsecurity.dry_run_matched_rule.rule_type = SMART_PROTECTION and json_payload.smartwebsecurity.dry_run_matched_rule.verdict = CAPTCHA
      ```

  * Для ARL проверьте поле `json_payload.smartwebsecurity.advanced_rate_limiter.dry_run_exceeded_quota_names` — список правил, лимиты которых превышены. Найдите нужное имя правила в этом списке.

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


