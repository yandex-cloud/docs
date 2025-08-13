---
title: Настроить логирование в {{ sws-full-name }}
description: Следуя данной инструкции, вы сможете настроить логирование в {{ sws-full-name }}.
---

# Настроить логирование

Анализ логов {{ sws-full-name }} позволяет:

* Тестировать работу правил безопасности, WAF и ARL в режиме **Только логирование** (dry run).

  В этом режиме запросы пользователей не блокируются, но в логи записывается информация о срабатывании правил.

* Посмотреть количество заблокированных и пропущенных запросов, оценить и скорректировать работу правил.
* Посмотреть подробную информацию о запросе, выявить ложноположительные срабатывания.
* Расследовать инциденты безопасности.

Вы можете настроить логирование {{ sws-full-name }} с помощью двух сервисов: [{{ cloud-logging-full-name }}](../../logging/) и [{{ at-full-name }}](../../audit-trails/).

* {{ cloud-logging-short-name }} — позволяет собирать базовые логи по трафику и сработавшим правилам профилей безопасности, WAF и ARL.

   Логи {{ sws-name }} передаются через [L7-балансировщик](../../application-load-balancer/concepts/application-load-balancer.md), к которому подключен профиль безопасности, и записываются в [лог-группу](../../logging/concepts/log-group.md).

* {{ at-name }} — позволяет собирать более детальные аудитные логи (события) по правилам WAF и ARL.

   В {{ at-name }} события передаются не через L7-балансировщик, а напрямую от сервиса {{ sws-name }}. В {{ at-name }} есть два типа событий:

   * [Уровня конфигурации](../at-ref.md#control-plane-events) — действия, связанные с конфигурированием ресурсов {{ yandex-cloud }}. Например, создание или удаление профиля безопасности.
   * [Уровня сервисов](../at-ref.md#data-plane-events) — действия, которые происходят с ресурсами внутри сервисов {{ yandex-cloud }}. Например, срабатывание правила из профиля WAF.

   Записывать события {{ at-name }} можно в бакет {{ objstorage-name }}, лог-группу {{ cloud-logging-name }} или поток данных {{ yds-name }}.

Чтобы начать работать с логами {{ sws-name }}:

1. [Включите и настройте запись логов](#enable-logging).
1. [Посмотрите и отфильтруйте логи](#view-logs).

## Включить логирование {#enable-logging}

{% list tabs group=instructions %}

- {{ cloud-logging-short-name }} {#logging}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится профиль {{ sws-name }}.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. В списке выберите балансировщик, к которому привязан профиль безопасности.
  1. Нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. В блоке **{{ ui-key.yacloud.alb.section_logs-settings }}**:
     1. Включите опцию **{{ ui-key.yacloud.alb.label_log-requests }}**.
     1. Выберите или создайте [лог-группу](../../logging/concepts/log-group.md) {{ cloud-logging-name }}, в которую будут записываться логи балансировщика.
     1. Нажмите кнопку **{{ ui-key.yacloud.alb.button_add-discard-rule }}** и настройте его [параметры](../../application-load-balancer/concepts/application-load-balancer.md#discard-logs-rules).
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

  Другие способы включения логов см. в разделе [{#T}](../../application-load-balancer/operations/application-load-balancer-manage-logs.md).

- {{ at-name }} {#at}

  События {{ at-name }} можно записывать в бакет {{ objstorage-name }}, лог-группу {{ cloud-logging-name }} или поток данных {{ yds-name }}. В этом руководстве настроим запись событий в лог-группу.

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится профиль {{ sws-name }}.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.audit-trails.button_create-trail }}**.
  1. Введите имя трейла, например `trail-sws`.
  1. В блоке **{{ ui-key.yacloud.audit-trails.label_destination }}** выберите объект назначения — **{{ ui-key.yacloud.audit-trails.label_cloudLogging }}**.
  1. Выберите или создайте [лог-группу](../../logging/concepts/log-group.md) {{ cloud-logging-name }}, в которую будут записываться события {{ sws-name }}.
  1. В блоке **{{ ui-key.yacloud.audit-trails.label_event-filter-section }}** включите сбор событий и выберите сервис **{{ sws-name }}**.

      Остальные настройки в этом блоке оставьте по умолчанию. Будут записываться все события {{ sws-name }} уровня сервисов в текущем каталоге. События уровня конфигурации записываться не будут.
  
  1. В блоке **{{ ui-key.yacloud.audit-trails.label_service-account }}** создайте или выберите аккаунт с ролью `logging.writer`.
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

  Другие способы включения записи событий см. в разделе [{#T}](../../audit-trails/operations/create-trail.md).

{% endlist %}

## Просмотреть логи {#view-logs}

{% list tabs group=instructions %}

- {{ cloud-logging-short-name }} {#logging}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится профиль {{ sws-name }}.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. Выберите раздел **{{ ui-key.yacloud.common.logs }}**.
  1. Выберите количество сообщений на одной странице и период: 1 час, 3 часа, 1 день, 1 неделя, 2 недели.
  1. В строке **Запрос** укажите запрос на [языке фильтрующих выражений](../../logging/concepts/filter.md) и нажмите кнопку **Выполнить**.

     Примеры запросов приведены ниже.

  1. Чтобы посмотреть содержимое лога, разверните его.

  Другие способы просмотра логов см. в разделах [{#T}](../../application-load-balancer/operations/application-load-balancer-get-logs.md) и [{#T}](../../logging/operations/read-logs.md).


  ## Примеры готовых фильтров для логов {#filtration}

  Логи поставляются в формате JSON. Одна запись в логах соответствует одному запросу клиента к L7-балансировщику.

  Запросы для фильтрации логов составляются, исходя из взаимосвязи профилей и правил [{{ sws-name }}](../concepts/profiles.md#profile-rules-schema). Вы можете посмотреть логи активных, работающих правил или правил в режиме **Только логирование** (dry run).

  ### Фильтры для активных правил {#active-rule-filters}

  * Показать запросы, заблокированные базовыми правилами с определенными [условиями](../concepts/conditions.md). Например, по списку или региону IP:
    ```
    json_payload.smartwebsecurity.matched_rule.rule_type = RULE_CONDITION and json_payload.smartwebsecurity.matched_rule.verdict = DENY
    ```
  * Показать запросы, для которых сработали правила [Smart Protection](../concepts/rules.md##smart-protection-rules) с отправкой на капчу:
    ```
    json_payload.smartwebsecurity.matched_rule.rule_type = SMART_PROTECTION and json_payload.smartwebsecurity.matched_rule.verdict = CAPTCHA
    ```
  * Показать запросы, заблокированные по профилю [WAF](../concepts/waf.md) – правилами WAF из профиля безопасности:
    ```
    json_payload.smartwebsecurity.matched_rule.rule_type = WAF and json_payload.smartwebsecurity.matched_rule.verdict = DENY
    ```
  * Показать запросы, заблокированные правилами профиля [ARL](../concepts/arl.md):
    ```
    json_payload.smartwebsecurity.advanced_rate_limiter.verdict = DENY
    ```

  ### Фильтры для правил в режиме логирования {#dry-run-filters}

  * Показать запросы, для которых сработали правила [Smart Protection](../concepts/rules.md#smart-protection-rules) с отправкой на капчу:
    ```
    json_payload.smartwebsecurity.dry_run_matched_rule.rule_type = SMART_PROTECTION and json_payload.smartwebsecurity.dry_run_matched_rule.verdict = CAPTCHA
    ```

  * Показать запросы, для которых сработало конкретное правило ARL — `arl-rule-1`:
    ```
    json_payload.smartwebsecurity.advanced_rate_limiter.verdict = DENY and json_payload.smartwebsecurity.advanced_rate_limiter.applied_quota_name = "arl-rule-1"
    ```

  Таким же образом вы можете добавить в фильтры другие условия и изменять их с учетом особенностей вашего потока трафика.

- {{ at-name }} {#at}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится профиль {{ sws-name }}.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
  1. Выберите лог-группу, в которую передаются события {{ at-name }}.
  1. Выберите количество сообщений на одной странице и период: 1 час, 3 часа, 1 день, 1 неделя, 2 недели.
  1. В строке **Запрос** укажите запрос на [языке фильтрующих выражений](../../logging/concepts/filter.md) и нажмите кнопку **Выполнить**.

     Логи {{ at-name }} записываются в формате JSON. Чтобы найти определенное [событие](../at-ref.md#data-plane-events), укажите его имя в формате:

     ```
     yandex.cloud.audit.smartwebsecurity.<имя_события>
     ```

     Примеры составления запросов см. в разделе [{#T}](../../audit-trails/tutorials/search-events-audit-logs/examples.md).

  1. Чтобы посмотреть содержимое лога, разверните его.

Другие способы просмотра логов см. в разделе [{#T}](../../application-load-balancer/operations/application-load-balancer-get-logs.md).

{% endlist %}


