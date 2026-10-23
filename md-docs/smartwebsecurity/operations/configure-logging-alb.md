[Документация Yandex Cloud](../../index.md) > [Yandex Smart Web Security](../index.md) > [Пошаговые инструкции](index.md) > Настроить логи через Application Load Balancer

# Настроить логирование через Application Load Balancer

Этот способ записывает HTTP-запросы, которые обрабатывает L7-балансировщик, включая результат проверки Smart Web Security. Для подробного анализа сработавших правил и отбора логов по типам правил и вердиктам используйте [логирование через Smart Web Security](configure-logging.md).

Для записи логов Smart Web Security используются сервисы:

* [Monium Logs](../../monium/logs/quickstart-resources.md) — для логов профилей безопасности. Логи содержат информацию об HTTP-запросах и сработавших правилах, включая WAF и ARL, и сохраняются в проектах Monium.
* [Cloud Logging](../../logging/index.md) — для логов прокси-серверов и L7-балансировщиков Application Load Balancer. Логи сохраняются в лог-группах.
* [Audit Trails](../../audit-trails/index.md) — для сбора аудитных событий Smart Web Security. Это записи о событиях безопасности и действиях с ресурсами.

## Логи аудита {#audit-events}

В Audit Trails есть два типа событий:

* [Уровня конфигурации](../at-ref.md#control-plane-events) — действия, связанные с конфигурированием ресурсов Yandex Cloud. Например, создание или удаление профиля безопасности.
* [Уровня сервисов](../at-ref.md#data-plane-events) — действия, которые происходят с ресурсами внутри сервисов Yandex Cloud. Например, срабатывание правила из профиля WAF.

Записывать события можно в бакет Object Storage, проект Monium или поток данных Data Streams.

## Логи HTTP-запросов и применения правил {#requests-logging}

Логи проверки запросов можно записывать через профиль безопасности Smart Web Security в Monium Logs или через L7-балансировщик Application Load Balancer в Cloud Logging. Логирование через профиль безопасности предоставляет больше возможностей для анализа.

Логи профиля безопасности поступают в проект Monium `folder__<идентификатор_каталога>`, где указан идентификатор каталога с профилем. Логи можно просматривать в интерфейсе Smart Web Security или Monium.

Логи прокси-серверов и L7-балансировщиков поступают в выбранную лог-группу Cloud Logging. Логи прокси-сервера также доступны в интерфейсе Smart Web Security, а балансировщика — в интерфейсе Application Load Balancer.

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

* [alb.editor](../../application-load-balancer/security/index.md#alb-editor) на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) с балансировщиком;
* [logging.writer](../../logging/security/index.md#logging-writer) на [лог-группу](../../logging/concepts/log-group.md), в которую передаются логи.

Для просмотра логов нужна роль [logging.viewer](../../logging/security/index.md#logging-viewer) на лог-группу.

{% endnote %}

{% list tabs group=instructions %}

- Cloud Logging {#logging}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог с балансировщиком.
  1. [Перейдите](https://console.yandex.cloud/link/application-load-balancer) в сервис **Application Load Balancer**.
  1. В списке выберите балансировщик, к которому привязан профиль безопасности.
  1. Нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **Редактировать**.
  1. В блоке **Настройки логов**:

      1. Включите опцию **Запись логов**.
      1. Выберите [лог-группу](../../logging/concepts/log-group.md) Cloud Logging, в которую будут записываться логи балансировщика, или [создайте новую](../../logging/operations/create-group.md).
      1. (Опционально) Чтобы уменьшить объем логов, нажмите **Добавить правило** и настройте [правило отбрасывания](../../application-load-balancer/concepts/monitoring.md#discard-logs-rules).

  1. Нажмите **Сохранить**.

  Другие способы включения логов описаны в разделе [Настроить запись логов L7-балансировщика](../../application-load-balancer/operations/application-load-balancer-manage-logs.md).

- Audit Trails {#at}

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

- Cloud Logging {#logging}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог с лог-группой.
  1. [Перейдите](https://console.yandex.cloud/link/logging) в сервис **Cloud Logging**.
  1. На вкладке **Группы** выберите лог-группу, в которую передаются логи балансировщика.
  1. Перейдите на вкладку **Логи**.
  1. Задайте период поиска логов.
  1. Введите фильтр на [языке фильтрующих выражений](../../logging/concepts/filter.md) и нажмите **Enter**. Например, чтобы отобрать логи конкретного балансировщика:

      ```text
      resource_type = "alb.loadBalancer" and resource_id = "<идентификатор_балансировщика>"
      ```

  1. Чтобы посмотреть содержимое записи, разверните ее.

  Логи также можно [просмотреть в интерфейсе Application Load Balancer](../../application-load-balancer/operations/application-load-balancer-get-logs.md).

  ## Примеры фильтрации логов {#filtration}

  Одна запись соответствует одному HTTP-запросу к L7-балансировщику. Результат проверки Smart Web Security находится в блоке `json_payload.smartwebsecurity`. Описание полей приведено в [справочнике логов Application Load Balancer](../../application-load-balancer/logs-ref.md).

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

- Audit Trails {#at}

  Для просмотра логов нужна роль [storage.viewer](../../storage/security/index.md#storage-viewer) на бакет.

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог с бакетом.
  1. [Перейдите](https://console.yandex.cloud/link/storage) в сервис **Object Storage**.
  1. Выберите бакет, указанный в настройках трейла.
  1. На вкладке **Объекты** найдите файлы за нужную дату. [Путь к файлу](../../audit-trails/concepts/format-data-plane.md#log-file-name) содержит идентификатор трейла и дату записи.
  1. [Скачайте](../../storage/operations/objects/download.md) нужный JSON-файл и откройте его в текстовом редакторе.

  Каждый файл содержит массив событий. Чтобы найти определенное [событие Smart Web Security](../at-ref.md#data-plane-events), ищите значение поля `event_type` в формате `yandex.cloud.audit.smartwebsecurity.<имя_события>`.

{% endlist %}