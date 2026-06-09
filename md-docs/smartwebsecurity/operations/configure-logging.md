# Настроить логирование через {{ sws-name }}

{% note info %}

Функциональность сбора логов через {{ sws-name }} находится на стадии [Preview](../../overview/concepts/launch-stages.md). Для получения доступа обратитесь в [службу поддержки]({{ link-console-support }}).
 
{% endnote %}

Для записи логов {{ sws-name }} используются сервисы [{{ cloud-logging-short-name }}](../../logging/index.md) и [{{ at-name }}](../../audit-trails/index.md). Они решают разные задачи:

* {{ cloud-logging-short-name }} — для анализа HTTP-запросов и сработавших правил в профилях безопасности, WAF и ARL.
* {{ at-name }} — для сбора аудитных событий {{ sws-name }}. Это не полноценные логи {{ sws-name }}, а записи о событиях безопасности и действиях с ресурсами.

## Логи аудита {#audit-events}

В {{ at-name }} есть два типа событий:

* [Уровня конфигурации](../at-ref.md#control-plane-events) — действия, связанные с конфигурированием ресурсов {{ yandex-cloud }}. Например, создание или удаление профиля безопасности.
* [Уровня сервисов](../at-ref.md#data-plane-events) — действия, которые происходят с ресурсами внутри сервисов {{ yandex-cloud }}. Например, срабатывание правила из профиля WAF.

Записывать события можно в бакет {{ objstorage-name }}, лог-группу {{ cloud-logging-name }} или поток данных {{ yds-name }}.

## Логи HTTP-запросов и применения правил {#requests-logging}

Для записи логов доступны два варианта: через {{ sws-name }} и через L7-балансировщик {{ alb-name }}, к которому подключен профиль безопасности. Логирование через {{ sws-name }} предоставляет больше возможностей для анализа, чем логирование через {{ alb-name }}. Логи записываются в лог-группу {{ cloud-logging-name }}.

Анализ логов позволяет настраивать и отслеживать работу {{ sws-name }}:

* Тестировать работу правил безопасности, WAF и ARL в режиме **Только логирование** (dry run). В этом режиме запросы пользователей не блокируются, но в логи записывается информация о срабатывании правил.
* Просматривать количество заблокированных и пропущенных запросов, оценивать и корректировать работу правил.
* Просматривать подробную информацию о запросе, выявлять ложноположительные срабатывания.

В некоторых случаях сервис может блокировать трафик при атаках. В логах для таких блокировок будет указана отметка [сервисного правила](../concepts/rules.md#service-rule): `sws_service_rule`.

## Работа с логами {#configure-logging}

Чтобы начать работать с логами {{ sws-name }}:

1. [Включите и настройте запись логов](#enable-logging).
1. [Посмотрите и отфильтруйте логи](#view-logs).

### Включить логирование {#enable-logging}

Включить логирование можно при [создании профиля безопасности](profile-create.md) или позднее, при его редактировании.

{% note info %}

Для управления [логированием](../concepts/logging.md) в профиле безопасности нужны роли:

- [smart-web-security.editor](../security/index.md#smart-web-security-editor) на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится профиль безопасности;
- [logging.writer](../../logging/security/index.md#logging-writer) на [лог-группу](../../logging/concepts/log-group.md), в которую передаются логи.

Для просмотра логов нужна роль [logging.viewer](../../logging/security/index.md#logging-viewer) на лог-группу.

{% endnote %}

{% list tabs group=instructions %}

- {{ cloud-logging-short-name }} {#logging}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится профиль {{ sws-name }}.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/profiles.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}**.
  1. В строке с нужным профилем безопасности нажмите ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Включите **{{ ui-key.yacloud.smart-web-security.SecurityProfileForm.LoggingSection.loggingEnable_6eK2x }}**.
  1. В поле **{{ ui-key.yacloud.smart-web-security.SecurityProfileForm.LoggingSection.outputTitle_tw1oT }}** выберите **{{ cloud-logging-name }}**.
  1. Выберите или создайте [лог-группу](../../logging/concepts/log-group.md) {{ cloud-logging-name }}, в которую будут записываться логи.
  1. Для записи в логи можно выбрать только те запросы, для которых сработали:
     * **{{ ui-key.yacloud.smart-web-security.baseRulesTitle_xcJEe }}**.
     * Правила **{{ ui-key.yacloud.smart-web-security.overview.label_smart-protection-rule }}**.
     * Правила **{{ ui-key.yacloud.smart-web-security.overview.label_waf-rule }}**.
     * Правила **{{ ui-key.yacloud.smart-web-security.arlTitle_e3MD8 }}**.
     * Все выбранные правила применили действие (вердикт) **{{ ui-key.yacloud.smart-web-security.SecurityProfileForm.LoggingSection.denyAndCaptchaTitle_tCthP }}**.
     * Все выбранные правила применили действие **{{ ui-key.yacloud.smart-web-security.SecurityProfileForm.LoggingSection.allowTitle_g6CLe }}** (легитимные запросы).

       В нормальной ситуации легитимных запросов гораздо больше, чем нелегитимных. Чтобы уменьшить объем логов, настройте параметр **{{ ui-key.yacloud.smart-web-security.SecurityProfileForm.LoggingSection.allowPercentageTitle_3334 }}** — от 1 до 100 процентов. При первой настройке правил рекомендуется анализировать все легитимные запросы. Когда вы убедитесь, что правила работают корректно, можно изменить долю логов или отключить логирование запросов с вердиктом **{{ ui-key.yacloud.smart-web-security.SecurityProfileForm.LoggingSection.allowTitle_g6CLe }}**. 
  
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- {{ at-name }} {#at}

  События {{ at-name }} можно записывать в бакет {{ objstorage-name }}, лог-группу {{ cloud-logging-name }}, поток данных {{ yds-name }} или шину {{ er-name }}. В этой инструкции настроим запись аудитных событий в лог-группу.

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится профиль {{ sws-name }}.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.audit-trails.button_create-trail }}**.
  1. Введите имя трейла, например `trail-sws`.
  1. В блоке **{{ ui-key.yacloud.audit-trails.label_destination }}** выберите объект назначения — **{{ ui-key.yacloud.audit-trails.label_cloudLogging }}**.
  1. Выберите или создайте [лог-группу](../../logging/concepts/log-group.md) {{ cloud-logging-name }}, в которую будут записываться события {{ sws-name }}.
  1. В блоке **{{ ui-key.yacloud.audit-trails.label_event-filter-section }}** включите сбор событий и выберите сервис **{{ sws-name }}**.

      Остальные настройки в этом блоке оставьте по умолчанию. Будут записываться все события {{ sws-name }} уровня сервисов в текущем каталоге. События уровня конфигурации записываться не будут.
  
  1. В блоке **{{ ui-key.yacloud.audit-trails.label_service-account }}** создайте или выберите аккаунт с ролью `logging.writer`.
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

  Другие способы включения записи событий см. в разделе [{#T}](../../audit-trails/operations/create-trail.md).

  Чтобы {{ sws-full-name }} передавал события в {{ at-name }}:

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится профиль {{ sws-name }}.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/profiles.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}**.
  1. В строке с нужным профилем безопасности нажмите ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Включите **{{ ui-key.yacloud.smart-web-security.SecurityProfileForm.LoggingSection.loggingEnable_6eK2x }}**.
  1. В поле **{{ ui-key.yacloud.smart-web-security.SecurityProfileForm.LoggingSection.outputTitle_tw1oT }}** выберите **{{ at-name }}**.
  1. (Опционально) Выберите, по каким правилам или вердиктам передавать события:
     * **{{ ui-key.yacloud.smart-web-security.baseRulesTitle_xcJEe }}**.
     * **{{ ui-key.yacloud.smart-web-security.overview.label_smart-protection-rule }}**.
     * **{{ ui-key.yacloud.smart-web-security.overview.label_waf-rule }}**.
     * **{{ ui-key.yacloud.smart-web-security.arlTitle_e3MD8 }}**.
     * **{{ ui-key.yacloud.smart-web-security.SecurityProfileForm.LoggingSection.denyAndCaptchaTitle_tCthP }}**.
     * **{{ ui-key.yacloud.smart-web-security.SecurityProfileForm.LoggingSection.allowTitle_g6CLe }}**.
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

  Таким образом можно настроить передачу только событий из отдельных профилей безопасности или только по отдельным правилам и вердиктам.

{% endlist %}

### Просмотреть логи {#view-logs}

{% list tabs group=instructions %}

- {{ cloud-logging-short-name }} {#logging}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится профиль {{ sws-name }}.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Выберите раздел **{{ ui-key.yacloud.common.logs }}**.
  1. Выберите лог-группу, если их несколько.
  
  1. Выберите период показа логов одним из способов:
     
     * Нажмите кнопку с обозначением интервала, например **Последний час**, и выберите один из вариантов: **Последние 5 минут**, **Последние 30 минут**... **Последний день**.
        Также в полях **От** и **До** можно выбрать нужные даты в календаре и указать время.
     * Выберите предустановленный период: **Сейчас**, **5m**, **30m**, **1h**, **1d**, **2d** или укажите свой.
     * На временной шкале переместите индикаторы начала и конца периода.
  
  1. В строке **Запрос** укажите параметры выбора:
     
     * Выберите поля логов в выпадающем списке или начните вводить первые буквы названия поля.

       Поля для фильтрации описаны в разделе [{#T}](../concepts/logging.md).
  
     * Справа от строки запроса нажмите **</>** и введите запрос в текстовом режиме на [языке фильтрующих выражений](../../logging/concepts/filter.md).

       Примеры запросов приведены ниже.

     {% note info %}

     По умолчанию в строке запроса выбраны внутренние поля: `project`, `cluster`, `service` и `message = *SWS`. Не изменяйте эти значения.

     {% endnote %}

  1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.querystring.action.execute-query }}**. Чтобы посмотреть содержимое лога, разверните его.

  ## Примеры готовых фильтров для логов {#filtration}

  Логи поставляются в формате JSON. Одна запись в логах соответствует одному запросу клиента, обработанному {{ sws-name }}.

  Запросы для фильтрации логов составляются, исходя из взаимосвязи профилей и правил [{{ sws-name }}](../concepts/profiles.md#profile-rules-schema). Вы можете посмотреть логи активных, работающих правил или правил в режиме **Только логирование** (dry run).

  ### Фильтры для активных правил {#active-rule-filters}

  * Показать запросы, заблокированные базовыми правилами с определенными [условиями](../concepts/conditions.md). Например, по списку или региону IP:
    ```
    module_type = "RULE_CONDITION", meta.matched_rule_verdict = "DENY"
    ```
  * Показать запросы, для которых сработали правила [Smart Protection](../concepts/rules.md##smart-protection-rules) с отправкой на капчу:
    ```
    module_type = "SMART_PROTECTION", meta.matched_rule_verdict = "CAPTCHA"
    ```
  * Показать запросы, заблокированные по профилю [WAF](../concepts/waf.md) — правилами WAF из профиля безопасности:
    ```
    module_type = "WAF", meta.matched_rule_verdict = "DENY"
    ```
  * Показать запросы, заблокированные правилами профиля [ARL](../concepts/arl.md):
    ```
    meta.arl_verdict = "DENY"
    ```

  * Показать запросы, для которых сработало конкретное правило ARL — `arl-rule-1`:
    ```
    meta.arl_verdict = "DENY", meta.arl_applied_quota_name = "arl-rule-1"
    ```

  ### Фильтры для правил в режиме логирования {#dry-run-filters}

  * Показать запросы, для которых сработали правила [Smart Protection](../concepts/rules.md#smart-protection-rules) с отправкой на капчу:
    ```
    module_type = "SMART_PROTECTION", meta.dry_run_matched_rule_verdict = "CAPTCHA"
    ```

  * Показать запросы, для которых было превышение по конкретному правилу ARL — `arl-rule-1`:
    ```
    meta.arl_verdict = "DENY", meta.arl_dry_run_exceeded_quota_names = "arl-rule-1"
    ```

  Таким же образом вы можете добавить в фильтры другие условия и изменять их с учетом особенностей вашего потока трафика.

- {{ at-name }} {#at}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится профиль {{ sws-name }}.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
  1. Выберите лог-группу, в которую передаются события {{ at-name }}.
  1. Выберите количество сообщений на одной странице и период: 1 час, 3 часа, 1 день, 1 неделя, 2 недели.
  1. В строке **Запрос** укажите запрос на [языке фильтрующих выражений](../../logging/concepts/filter.md) и нажмите кнопку **Выполнить**.

     События {{ at-name }} записываются в формате JSON. Чтобы найти определенное [событие](../at-ref.md#data-plane-events), укажите его имя в формате:

     ```
     yandex.cloud.audit.smartwebsecurity.<имя_события>
     ```

     Примеры составления запросов см. в разделе [{#T}](../../audit-trails/tutorials/search-events-audit-logs/examples.md).

  1. Чтобы посмотреть содержимое лога, разверните его.

{% endlist %}