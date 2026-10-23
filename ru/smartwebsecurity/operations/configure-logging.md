---
title: Настроить логирование в {{ sws-full-name }}
description: Следуя данной инструкции, вы сможете настроить логирование в {{ sws-full-name }}.
---

# Настроить логирование через {{ sws-name }}

Этот способ дает подробные логи проверки запросов правилами безопасности, WAF и ARL. В профиле можно выбирать типы правил и вердикты для записи. [Логирование через {{ alb-name }}](configure-logging-alb.md) сохраняет HTTP-запросы балансировщика с результатом проверки {{ sws-name }}.

{% include [logging-services](../../_includes/smartwebsecurity/logging-services.md) %}

### Включить логирование {#enable-logging}

Включить логирование можно при создании [профиля безопасности](profile-create.md) или [прокси-сервера](proxy-create.md), а также при их редактировании.

{% note info %}

Для настройки логирования в профиле безопасности нужна роль [smart-web-security.editor](../security/index.md#smart-web-security-editor) на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) с профилем. Для просмотра логов в {{ monium-name }} нужна [роль с правом чтения логов](../../monium/security/index.md#roles-list).

{% endnote %}

{% list tabs group=instructions %}

- Профиль безопасности ({{ monium-name }}) {#monium}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится профиль {{ sws-name }}.
  1. [Перейдите]({{ link-console-main }}/link/smartwebsecurity) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/profiles.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}**.
  1. В строке с нужным профилем нажмите ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Включите **{{ ui-key.yacloud.smart-web-security.SecurityProfileForm.LoggingSection.loggingEnable_6eK2x }}**.
  1. В поле **{{ ui-key.yacloud.smart-web-security.SecurityProfileForm.LoggingSection.outputTitle_tw1oT }}** выберите **{{ monium-name }}**.
  1. Настройте фильтры логов:

     {% include [security-profile-logging-options](../../_includes/smartwebsecurity/security-profile-logging-options.md) %}

  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- Прокси-сервер ({{ cloud-logging-name }}) {#logging}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог с прокси-сервером.
  1. [Перейдите]({{ link-console-main }}/link/smartwebsecurity) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/domain-protection-icon.svg) **{{ ui-key.yacloud.smart-web-security.label_domain-protection }}**.
  1. В строке с нужным прокси-сервером нажмите ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Включите **{{ ui-key.yacloud.smart-web-security.ProxyServerForm.swith-enable-logging_e42nT }}**.
  1. Выберите [лог-группу](../../logging/concepts/log-group.md) {{ cloud-logging-name }}, в которую будут записываться логи, или [создайте новую](../../logging/operations/create-group.md).
  1. (Опционально) Чтобы уменьшить объем логов, создайте правило отбрасывания:

      1. Нажмите **{{ ui-key.yacloud.smart-web-security.ProxyServerForm.add-rule_fnmLk }}** в блоке **{{ ui-key.yacloud.smart-web-security.ProxyServerForm.discard-rules-title_xn6cP }}**.
      1. Выберите **HTTP-коды** или **Классы HTTP-кодов**, для которых нужно сократить запись логов.
      1. Укажите **Долю отбрасываемых логов** от `0%` (все логи записываются) до `100%` (логи не записываются).

      Для других HTTP-кодов добавьте отдельные правила.

  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

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

  Чтобы {{ sws-full-name }} передавал события в {{ at-name }}:

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится профиль {{ sws-name }}.
  1. [Перейдите]({{ link-console-main }}/link/smartwebsecurity) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/profiles.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}**.
  1. В строке с нужным профилем безопасности нажмите ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Включите **{{ ui-key.yacloud.smart-web-security.SecurityProfileForm.LoggingSection.loggingEnable_6eK2x }}**.
  1. В поле **{{ ui-key.yacloud.smart-web-security.SecurityProfileForm.LoggingSection.outputTitle_tw1oT }}** выберите **{{ at-name }}**.
  1. Настройте фильтры логов:

     {% include [security-profile-logging-options](../../_includes/smartwebsecurity/security-profile-logging-options.md) %}

  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

  Таким образом можно настроить передачу только событий из отдельных профилей безопасности или только по отдельным правилам и вердиктам.

{% endlist %}

### Просмотреть логи {#view-logs}

{% list tabs group=instructions %}

- Интерфейс {{ sws-name }} {#console}

  Для профиля безопасности:

  {% include [log-requests](../../_includes/smartwebsecurity/log-requests.md) %}

  Для прокси-сервера:

  Нужна роль [logging.viewer](../../logging/security/index.md#logging-viewer) на лог-группу.

  1. В [консоли управления]({{ link-console-main }}) выберите каталог с прокси-сервером.
  1. [Перейдите]({{ link-console-main }}/link/smartwebsecurity) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/domain-protection-icon.svg) **{{ ui-key.yacloud.smart-web-security.label_domain-protection }}**.
  1. Выберите нужный прокси-сервер.
  1. Перейдите на вкладку **{{ ui-key.yacloud.common.logs }}**.

  Логи прокси-сервера также можно [просмотреть в {{ cloud-logging-name }}](../../logging/operations/read-logs.md).

- {{ monium-name }} {#monium}

  1. На главной странице [{{ monium-name }}]({{ link-monium }}) слева выберите ![compass](../../_assets/console-icons/compass.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.all-panel.menu.category.explore }}** → **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.logs.title }}**.
  1. Задайте период поиска логов.
  1. В строке запроса укажите `project = "folder__<идентификатор_каталога>"` для каталога с профилем безопасности. Выберите значения `cluster` и `service` для логов {{ sws-name }} из выпадающих списков.
  1. Чтобы найти логи конкретного профиля, добавьте условие `security_profile_id = "<идентификатор_профиля>"`.

     Запрос можно составить из меток в выпадающих списках или ввести на [языке запросов {{ monium-name }}](../../monium/logs/query.md). Для ввода запроса нажмите ![code](../../_assets/console-icons/code.svg).

  1. Нажмите **{{ ui-key.yacloud_monitoring.querystring.action.execute-query }}**. Чтобы посмотреть содержимое записи, разверните ее.

- {{ at-name }} {#at}

  Для просмотра логов нужна роль [storage.viewer](../../storage/security/index.md#storage-viewer) на бакет.

  1. В [консоли управления]({{ link-console-main }}) выберите каталог с бакетом.
  1. [Перейдите]({{ link-console-main }}/link/storage) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Выберите бакет, указанный в настройках трейла.
  1. На вкладке **{{ ui-key.yacloud.storage.bucket.switch_files }}** найдите файлы за нужную дату. [Путь к файлу](../../audit-trails/concepts/format-data-plane.md#log-file-name) содержит идентификатор трейла и дату записи.
  1. [Скачайте](../../storage/operations/objects/download.md) нужный JSON-файл и откройте его в текстовом редакторе.

  Каждый файл содержит массив событий. Чтобы найти определенное [событие {{ sws-name }}](../at-ref.md#data-plane-events), ищите значение поля `event_type` в формате `yandex.cloud.audit.smartwebsecurity.<имя_события>`.

{% endlist %}

## Примеры готовых фильтров для логов {#filtration}

Примеры ниже относятся к логам профиля безопасности и подходят для интерфейсов {{ sws-name }} и {{ monium-name }}. Логи поставляются в формате JSON: одна запись соответствует одному запросу клиента, обработанному {{ sws-name }}.

Запросы для фильтрации логов составляются, исходя из взаимосвязи профилей и правил [{{ sws-name }}](../concepts/profiles.md#profile-rules-schema). Вы можете посмотреть логи активных, работающих правил или правил в режиме **Только логирование** (dry run).

Добавьте нужные условия из примеров ниже в селектор запроса, сохранив метки `project`, `cluster` и `service`. Поля описаны в разделе [{#T}](../concepts/logging.md).

### Фильтры для активных правил {#active-rule-filters}

* Показать запросы, заблокированные базовыми правилами с определенными [условиями](../concepts/conditions.md). Например, по списку или региону IP:

    ```text
    module_type = "RULE_CONDITION", meta.matched_rule_verdict = "DENY"
    ```

* Показать запросы, для которых сработали правила [Smart Protection](../concepts/rules.md#smart-protection-rules) с отправкой на капчу:

    ```text
    module_type = "SMART_PROTECTION", meta.matched_rule_verdict = "CAPTCHA"
    ```

* Показать запросы, заблокированные по профилю [WAF](../concepts/waf.md) — правилами WAF из профиля безопасности:

    ```text
    module_type = "WAF", meta.matched_rule_verdict = "DENY"
    ```

* Показать запросы, заблокированные правилами профиля [ARL](../concepts/arl.md):

    ```text
    meta.arl_verdict = "DENY"
    ```

* Показать запросы, для которых сработало конкретное правило ARL — `arl-rule-1`:

    ```text
    meta.arl_verdict = "DENY", meta.arl_applied_quota_name = "arl-rule-1"
    ```

### Фильтры для правил в режиме логирования {#dry-run-filters}

* Показать запросы, для которых сработали правила [Smart Protection](../concepts/rules.md#smart-protection-rules) с отправкой на капчу:

  ```text
  module_type = "SMART_PROTECTION", meta.dry_run_matched_rule_verdict = "CAPTCHA"
  ```

* Показать запросы, для которых было превышение по конкретному правилу ARL — `arl-rule-1`:

  ```text
  meta.arl_dry_run_exceeded_quota_names = "arl-rule-1"
  ```

Таким же образом вы можете добавить в фильтры другие условия и изменять их с учетом особенностей вашего потока трафика.
