# Настроить логирование через Application Load Balancer

Для записи логов Smart Web Security используются сервисы [Cloud Logging](../../logging/index.md) и [Audit Trails](../../audit-trails/index.md). Они решают разные задачи:

* Cloud Logging — для анализа HTTP-запросов и сработавших правил в профилях безопасности, WAF и ARL.
* Audit Trails — для сбора аудитных событий Smart Web Security. Это не полноценные логи Smart Web Security, а записи о событиях безопасности и действиях с ресурсами.

## Логи аудита {#audit-events}

В Audit Trails есть два типа событий:

* [Уровня конфигурации](../at-ref.md#control-plane-events) — действия, связанные с конфигурированием ресурсов Yandex Cloud. Например, создание или удаление профиля безопасности.
* [Уровня сервисов](../at-ref.md#data-plane-events) — действия, которые происходят с ресурсами внутри сервисов Yandex Cloud. Например, срабатывание правила из профиля WAF.

Записывать события можно в бакет Object Storage, лог-группу Cloud Logging или поток данных Data Streams.

## Логи HTTP-запросов и применения правил {#requests-logging}

Для записи логов доступны два варианта: через Smart Web Security и через L7-балансировщик Application Load Balancer, к которому подключен профиль безопасности. Логирование через Smart Web Security предоставляет больше возможностей для анализа, чем логирование через Application Load Balancer. Логи записываются в лог-группу Cloud Logging.

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

Для управления [логированием](../concepts/logging.md) в L7-балансировщике нужны роли:

- [alb.editor](../../application-load-balancer/security/index.md#alb-editor) на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится профиль безопасности;
- [logging.writer](../../logging/security/index.md#logging-writer) на [лог-группу](../../logging/concepts/log-group.md), в которую передаются логи.

Для просмотра логов нужна роль [logging.viewer](../../logging/security/index.md#logging-viewer) на лог-группу.

{% endnote %}

{% list tabs group=instructions %}

- Cloud Logging {#logging}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится профиль Smart Web Security.
  1. Перейдите в сервис **Application Load Balancer**.
  1. В списке выберите балансировщик, к которому привязан профиль безопасности.
  1. Нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **Редактировать**.
  1. В блоке **Настройки логов**:
     1. Включите опцию **Запись логов**.
     1. Выберите или создайте [лог-группу](../../logging/concepts/log-group.md) Cloud Logging, в которую будут записываться логи балансировщика.
     1. Нажмите кнопку **Добавить правило отбрасывания логов** и настройте его [параметры](../../application-load-balancer/concepts/application-load-balancer.md#discard-logs-rules).
  1. Нажмите **Сохранить**.

  Другие способы включения логов см. в разделе [Настроить запись логов L7-балансировщика](../../application-load-balancer/operations/application-load-balancer-manage-logs.md).

- Audit Trails {#at}

  События Audit Trails можно записывать в бакет Object Storage, лог-группу Cloud Logging, поток данных Data Streams или шину EventRouter. В этой инструкции настроим запись аудитных событий в лог-группу.

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится профиль Smart Web Security.
  1. Перейдите в сервис **Audit Trails**.
  1. Нажмите кнопку **Создать трейл**.
  1. Введите имя трейла, например `trail-sws`.
  1. В блоке **Назначение** выберите объект назначения — **Cloud Logging**.
  1. Выберите или создайте [лог-группу](../../logging/concepts/log-group.md) Cloud Logging, в которую будут записываться события Smart Web Security.
  1. В блоке **Сбор событий с уровня сервисов** включите сбор событий и выберите сервис **Smart Web Security**.

      Для остальных настроек в этом блоке оставьте значения по умолчанию. Будут записываться все события Smart Web Security уровня сервисов в текущем каталоге. События уровня конфигурации записываться не будут.
  
  1. В блоке **Сервисный аккаунт** создайте или выберите аккаунт с ролью `logging.writer`.
  1. Нажмите **Создать**.

  Другие способы включения записи событий см. в разделе [Создание трейла для загрузки аудитных логов](../../audit-trails/operations/create-trail.md).

{% endlist %}

### Просмотреть логи {#view-logs}

{% list tabs group=instructions %}

- Cloud Logging {#logging}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится профиль Smart Web Security.
  1. Перейдите в сервис **Application Load Balancer**.
  1. Выберите раздел **Логи**.
  1. Выберите количество сообщений на одной странице и период: 1 час, 3 часа, 1 день, 1 неделя, 2 недели.
  1. В строке **Запрос** укажите запрос на [языке фильтрующих выражений](../../logging/concepts/filter.md) и нажмите кнопку **Выполнить**.

     Примеры запросов приведены ниже.

  1. Чтобы посмотреть содержимое лога, разверните его.

  Другие способы просмотра логов см. в разделах [Посмотреть логи L7-балансировщика](../../application-load-balancer/operations/application-load-balancer-get-logs.md) и [Чтение записей](../../logging/operations/read-logs.md).


  ## Примеры готовых фильтров для логов {#filtration}

  Логи поставляются в формате JSON. Одна запись в логах соответствует одному запросу клиента к L7-балансировщику.

  Запросы для фильтрации логов составляются исходя из взаимосвязи профилей и правил [Smart Web Security](../concepts/profiles.md#profile-rules-schema). Вы можете посмотреть логи активных, работающих правил или правил в режиме **Только логирование** (dry run).

  ### Фильтры для активных правил {#active-rule-filters}

  * Показать запросы, заблокированные базовыми правилами с определенными [условиями](../concepts/conditions.md). Например, по списку или региону IP:
    ```
    json_payload.smartwebsecurity.matched_rule.rule_type = RULE_CONDITION and json_payload.smartwebsecurity.matched_rule.verdict = DENY
    ```
    
  * Показать запросы, для которых сработали правила [Smart Protection](../concepts/rules.md#smart-protection-rules) с отправкой на капчу:
    ```
    json_payload.smartwebsecurity.matched_rule.rule_type = SMART_PROTECTION and json_payload.smartwebsecurity.matched_rule.verdict = CAPTCHA
    ```

  * Показать запросы, заблокированные по профилю [WAF](../concepts/waf.md) — правилами WAF из профиля безопасности:
    ```
    json_payload.smartwebsecurity.matched_rule.rule_type = WAF and json_payload.smartwebsecurity.matched_rule.verdict = DENY
    ```

  * Показать запросы, заблокированные правилами профиля [ARL](../concepts/arl.md):
    ```
    json_payload.smartwebsecurity.advanced_rate_limiter.verdict = DENY
    ```

  * Показать запросы, для которых сработало конкретное правило ARL — `arl-rule-1`:
    ```
    json_payload.smartwebsecurity.advanced_rate_limiter.verdict = DENY and json_payload.smartwebsecurity.advanced_rate_limiter.applied_quota_name = "arl-rule-1"
    ```

  Таким же образом вы можете добавить в фильтры другие условия и изменять их с учетом особенностей вашего потока трафика.

  ### Фильтры для правил в режиме логирования {#dry-run-filters}

  * Показать запросы, для которых сработали правила [Smart Protection](../concepts/rules.md#smart-protection-rules) с отправкой на капчу:
    
    ```
    json_payload.smartwebsecurity.dry_run_matched_rule.rule_type = SMART_PROTECTION and json_payload.smartwebsecurity.dry_run_matched_rule.verdict = CAPTCHA
    ```

  * Посмотреть запросы, для которых сработали правила ARL (лимиты на запросы).
    
    Для режима **Только логирование** не подойдет запрос с фильтрацией по вердикту `DENY`, поскольку в этом режиме запросы не блокируются. Вердикт правил будет `ALLOW` даже после превышения лимита. Для отладки правил используйте параметр `dry_run_exceeded_quota_names`. Параметр показывает, какие правила ARL сработали на запросе. Если в этом параметре нет правил — лимиты не превышались.

    Пример фрагмента лога с параметром `dry_run_exceeded_quota_names`:

    ```text
    "smartwebsecurity": {
      "advanced_rate_limiter": {
        "applied_quota_name": "",
        "dry_run_exceeded_quota_names": [
          "<rule_name_1>",
          "<rule_name_2>"
        ],
        "profile_id": "<profile_id>",
        "verdict": "ALLOW"
      },
    ```

  В этом фрагменте лимиты превышены для правил `<rule_name_1>` и `<rule_name_2>` в профиле `<profile_id>`.

- Audit Trails {#at}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится профиль Smart Web Security.
  1. Перейдите в сервис **Cloud Logging**.
  1. Выберите лог-группу, в которую передаются события Audit Trails.
  1. Выберите количество сообщений на одной странице и период: 1 час, 3 часа, 1 день, 1 неделя, 2 недели.
  1. В строке **Запрос** укажите запрос на [языке фильтрующих выражений](../../logging/concepts/filter.md) и нажмите кнопку **Выполнить**.

     События Audit Trails записываются в формате JSON. Чтобы найти определенное [событие](../at-ref.md#data-plane-events), укажите его имя в формате:

     ```
     yandex.cloud.audit.smartwebsecurity.<имя_события>
     ```

     Примеры составления запросов см. в разделе [Примеры запросов для поиска событий в аудитных логах](../../audit-trails/tutorials/search-events-audit-logs/examples.md).

  1. Чтобы посмотреть содержимое лога, разверните его.

Другие способы просмотра логов см. в разделе [Посмотреть логи L7-балансировщика](../../application-load-balancer/operations/application-load-balancer-get-logs.md).

{% endlist %}