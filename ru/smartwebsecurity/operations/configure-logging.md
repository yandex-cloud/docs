---
title: Настроить логирование в {{ sws-full-name }}
description: Следуя данной инструкции, вы сможете настроить логирование в {{ sws-full-name }}.
alternate:
  - href: ru/smartwebsecurity/operations/configure-logging.md
    type: text/markdown
    title: Markdown version
---

# Настроить логирование через {{ sws-name }}

Логи профиля безопасности содержат подробные результаты проверки запросов правилами профиля, WAF и ARL. Можно выбирать типы правил и вердикты для записи. Логи прокси-сервера содержат HTTP-запросы его балансировщика с результатами проверки {{ sws-name }}, как и при [логировании через {{ alb-name }}](configure-logging-alb.md).

{% include [logging-services](../../_includes/smartwebsecurity/logging-services.md) %}

### Включить логирование {#enable-logging}

Включить логирование можно при создании [профиля безопасности](profile-create.md) или [прокси-сервера](proxy-create.md), а также при их редактировании.

Запись и хранение логов в {{ monium-logs-name }} [тарифицируются](../../monium/pricing.md).

{% note info %}

Для настройки логирования нужна роль [smart-web-security.editor](../security/index.md#smart-web-security-editor) на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) с профилем безопасности или прокси-сервером.

{% endnote %}

{% list tabs group=sws-log-source %}

- Профиль безопасности {#security-profile}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится профиль {{ sws-name }}.
  1. [Перейдите]({{ link-console-main }}/link/smartwebsecurity) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/profiles.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}**.
  1. В строке с нужным профилем нажмите ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Включите **{{ ui-key.yacloud.smart-web-security.SecurityProfileForm.LoggingSection.loggingEnable_6eK2x }}**.
  1. В поле **{{ ui-key.yacloud.smart-web-security.SecurityProfileForm.LoggingSection.outputTitle_tw1oT }}** выберите **{{ monium-name }}**.
  1. Настройте фильтры логов:

     {% include [security-profile-logging-options](../../_includes/smartwebsecurity/security-profile-logging-options.md) %}

  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

  Чтобы отключить логирование, выключите **{{ ui-key.yacloud.smart-web-security.SecurityProfileForm.LoggingSection.loggingEnable_6eK2x }}** в той же форме и сохраните изменения.

- Прокси-сервер {#proxy-server}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог с прокси-сервером.
  1. [Перейдите]({{ link-console-main }}/link/smartwebsecurity) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/domain-protection-icon.svg) **{{ ui-key.yacloud.smart-web-security.label_domain-protection }}**.
  1. В строке с нужным прокси-сервером нажмите ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Включите **{{ ui-key.yacloud.smart-web-security.ProxyServerForm.swith-enable-logging_e42nT }}**.
  1. (Опционально) Чтобы уменьшить объем логов, создайте правило отбрасывания:

      1. Нажмите **{{ ui-key.yacloud.smart-web-security.ProxyServerForm.add-rule_fnmLk }}** в блоке **{{ ui-key.yacloud.smart-web-security.ProxyServerForm.discard-rules-title_xn6cP }}**.
      1. Выберите **HTTP-коды** или **Классы HTTP-кодов**, для которых нужно сократить запись логов.
      1. Укажите **Долю отбрасываемых логов** для выбранных кодов: от `0%` (сохранять все подходящие записи) до `100%` (отбрасывать все подходящие записи).

      Для других HTTP-кодов добавьте отдельные правила.

  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

  Чтобы отключить логирование, выключите **{{ ui-key.yacloud.smart-web-security.ProxyServerForm.swith-enable-logging_e42nT }}** в той же форме и сохраните изменения.

- Аудитные события {#audit-trails}

  Настройте запись событий {{ sws-name }} через {{ at-name }} в [бакет](../../storage/concepts/bucket.md) {{ objstorage-name }}. Перед созданием трейла [подготовьте бакет и сервисный аккаунт](../../audit-trails/operations/create-trail.md#before-you-begin).

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

  Другие способы включения записи событий описаны в разделе [{#T}](../../audit-trails/operations/create-trail.md).

  События `WafMatchedRule`, `WafMatchedExclusionRule` и `ArlMatchedRequest` формируются при соответствующих срабатываниях независимо от настроек логирования профиля.

  Чтобы передавать подробные события `SWSMatchedRequest` в {{ at-name }}, включите логирование в профиле и выберите выход `AUDIT_TRAILS`:

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится профиль {{ sws-name }}.
  1. [Перейдите]({{ link-console-main }}/link/smartwebsecurity) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/profiles.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}**.
  1. В строке с нужным профилем безопасности нажмите ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Включите **{{ ui-key.yacloud.smart-web-security.SecurityProfileForm.LoggingSection.loggingEnable_6eK2x }}**.
  1. В поле **{{ ui-key.yacloud.smart-web-security.SecurityProfileForm.LoggingSection.outputTitle_tw1oT }}** выберите **{{ at-name }}**.
  1. Настройте фильтры логов:

     {% include [security-profile-logging-options](../../_includes/smartwebsecurity/security-profile-logging-options.md) %}

  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

  Таким образом можно настроить передачу событий `SWSMatchedRequest` только из отдельных профилей безопасности или только по отдельным правилам и вердиктам.

{% endlist %}

### Просмотреть логи {#view-logs}

{% list tabs group=instructions %}

- Интерфейс {{ sws-name }} {#console}

  Для просмотра логов нужна роль [monium.logs.reader](../../monium/security/index.md#monium-logs-reader) на каталог с профилем безопасности или прокси-сервером.

  1. В [консоли управления]({{ link-console-main }}) выберите каталог с профилем безопасности или прокси-сервером.
  1. [Перейдите]({{ link-console-main }}/link/smartwebsecurity) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Откройте логи нужного ресурса:

     * **Профиль безопасности** — на панели слева выберите ![receipt](../../_assets/console-icons/receipt.svg) **{{ ui-key.yacloud.common.logs }}**. В поле **Профиль безопасности** выберите нужный профиль. По умолчанию отображаются логи всех профилей каталога.
     * **Прокси-сервер** — на панели слева выберите ![image](../../_assets/smartwebsecurity/domain-protection-icon.svg) **{{ ui-key.yacloud.smart-web-security.label_domain-protection }}**, откройте нужный прокси-сервер и перейдите на вкладку **{{ ui-key.yacloud.common.logs }}**.

     В запросе уже заданы метки `project` и `service`. Для прокси-сервера также задана метка `resource_id` с идентификатором его балансировщика.

  1. Задайте период поиска логов.
  1. При необходимости добавьте условия фильтрации в строке запроса.

     Для ввода запроса в текстовом режиме нажмите ![code](../../_assets/console-icons/code.svg) и используйте [язык запросов {{ monium-name }}](../../monium/logs/query.md). Сохраните метки, выбранные по умолчанию.

  1. Нажмите **{{ ui-key.yacloud_monitoring.querystring.action.execute-query }}**. Чтобы посмотреть содержимое записи, разверните ее.

- {{ monium-name }} {#monium}

  Для просмотра логов нужна роль [monium.logs.reader](../../monium/security/index.md#monium-logs-reader) на каталог с профилем безопасности или прокси-сервером.

  1. Откройте [{{ monium-name }}]({{ link-monium }}).
  1. На панели слева выберите ![compass](../../_assets/console-icons/compass.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.all-panel.menu.category.explore }}** → **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.logs.title }}**.
  1. Задайте период поиска логов.
  1. В строке запроса для метки `project` выберите [проект каталога](*monium-folder-project) с профилем безопасности или прокси-сервером.
  1. Выберите значение метки `service` в зависимости от типа логов. Чтобы просмотреть логи конкретного ресурса, добавьте фильтр:

     #|
     || **Тип логов** | **Значение `service`** | **Фильтр для ресурса** ||
     || Профиль безопасности | `__smartwebsecurity__` | `security_profile_id` — [идентификатор профиля безопасности](profile-get.md). ||
     || Прокси-сервер | `__application-load-balancer__` | `resource_id` — идентификатор балансировщика прокси-сервера. ||
     |#

     Для прокси-сервера откройте его страницу в консоли {{ sws-name }} и на вкладке **{{ ui-key.yacloud.common.overview }}** скопируйте **Идентификатор** из блока **Балансировщик нагрузки**.

     Запрос можно составить в режиме токенов или ввести на [языке запросов {{ monium-name }}](../../monium/logs/query.md). Для ввода запроса в текстовом режиме нажмите ![code](../../_assets/console-icons/code.svg).

  1. Нажмите **{{ ui-key.yacloud_monitoring.querystring.action.execute-query }}**. Чтобы посмотреть содержимое записи, разверните ее.

  Подробнее о работе с логами — в разделе [«Поиск и анализ логов»](../../monium/logs/logs-explorer.md).

- {{ at-name }} {#at}

  Для просмотра логов нужна роль [storage.viewer](../../storage/security/index.md#storage-viewer) на бакет.

  1. В [консоли управления]({{ link-console-main }}) выберите каталог с бакетом.
  1. [Перейдите]({{ link-console-main }}/link/storage) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Выберите бакет, указанный в настройках трейла.
  1. На вкладке **{{ ui-key.yacloud.storage.bucket.switch_files }}** найдите файлы за нужную дату. [Путь к файлу](../../audit-trails/concepts/format-data-plane.md#log-file-name) содержит идентификатор трейла и дату записи.
  1. [Скачайте](../../storage/operations/objects/download.md) нужный JSON-файл и откройте его в текстовом редакторе.

  Каждый файл содержит массив событий. Чтобы найти определенное [событие {{ sws-name }}](../at-ref.md#data-plane-events), ищите значение поля `event_type` в формате `yandex.cloud.audit.smartwebsecurity.<имя_события>`.

{% endlist %}

## Примеры фильтров для логов профилей безопасности {#filtration}

Примеры подходят для поиска логов профиля безопасности в интерфейсах {{ sws-name }} и {{ monium-name }}. Введите запрос в текстовом режиме на [языке запросов {{ monium-name }}](../../monium/logs/query.md). Укажите идентификаторы каталога и профиля безопасности. Метки указываются без префикса `labels.`, а поля метаинформации — с префиксом `meta.`. Поля описаны в разделе [{#T}](../concepts/logging.md).

В [логах прокси-сервера](configure-logging-alb.md#dry-run-filters) проверяйте поле `meta.smartwebsecurity.dry_run_matched_rule.dry_run`: тестовый вердикт может быть `ALLOW`, а блок может присутствовать и при значении `false`.

Поля `meta.dry_run_matched_rule_*` записываются для тестовых вердиктов `DENY`, `CAPTCHA`, `JS_CHALLENGE` и `COOKIE_CHALLENGE`. При тестовом `ALLOW` эти поля отсутствуют, хотя запись о запросе может присутствовать. Итоговый `ALLOW` может сочетаться с тестовым `DENY`.

### Фильтры для активных правил {#active-rule-filters}

Ниже приведены примеры запросов:

* Запросы, заблокированные базовыми правилами с определенными [условиями](../concepts/conditions.md):

  ```text
  {
    project="folder__<идентификатор_каталога>",
    service="__smartwebsecurity__",
    security_profile_id="<идентификатор_профиля>",
    module_type="RULE_CONDITION",
    meta.matched_rule_verdict="DENY"
  }
  ```

* Запросы, направленные на капчу правилами [Smart Protection](../concepts/rules.md#smart-protection-rules):

  ```text
  {
    project="folder__<идентификатор_каталога>",
    service="__smartwebsecurity__",
    security_profile_id="<идентификатор_профиля>",
    module_type="SMART_PROTECTION",
    meta.matched_rule_verdict="CAPTCHA"
  }
  ```

* Запросы, направленные на JS-проверку правилами Smart Protection:

  ```text
  {
    project="folder__<идентификатор_каталога>",
    service="__smartwebsecurity__",
    security_profile_id="<идентификатор_профиля>",
    module_type="SMART_PROTECTION",
    meta.matched_rule_verdict="JS_CHALLENGE"
  }
  ```

* Запросы, заблокированные правилами [WAF](../concepts/waf.md):

  ```text
  {
    project="folder__<идентификатор_каталога>",
    service="__smartwebsecurity__",
    security_profile_id="<идентификатор_профиля>",
    module_type="WAF",
    meta.matched_rule_verdict="DENY"
  }
  ```

* Запросы, заблокированные правилами профиля [ARL](../concepts/arl.md):

  ```text
  {
    project="folder__<идентификатор_каталога>",
    service="__smartwebsecurity__",
    security_profile_id="<идентификатор_профиля>",
    meta.arl_verdict="DENY"
  }
  ```

* Запросы, заблокированные конкретным правилом ARL `arl-rule-1`:

  ```text
  {
    project="folder__<идентификатор_каталога>",
    service="__smartwebsecurity__",
    security_profile_id="<идентификатор_профиля>",
    meta.arl_verdict="DENY",
    meta.arl_applied_quota_name="arl-rule-1"
  }
  ```

### Фильтры для правил в режиме логирования {#dry-run-filters}

Чтобы найти запросы, которые правило Smart Protection направило бы на JS-проверку, используйте фильтр:

```text
{
    project="folder__<идентификатор_каталога>",
    service="__smartwebsecurity__",
    security_profile_id="<идентификатор_профиля>",
    meta.dry_run_matched_rule_type="SMART_PROTECTION",
    meta.dry_run_matched_rule_verdict="JS_CHALLENGE"
}
```

[*monium-folder-project]: {% include notitle [folder-project](../../_popups/monium/folder-project.md) %}
