[Документация Yandex Cloud](../../index.md) > [Yandex Smart Web Security](../index.md) > [Пошаговые инструкции](index.md) > Настроить логи через Smart Web Security

# Настроить логирование через Smart Web Security

Этот способ дает подробные логи проверки запросов правилами безопасности, WAF и ARL. В профиле можно выбирать типы правил и вердикты для записи. [Логирование через Application Load Balancer](configure-logging-alb.md) сохраняет HTTP-запросы балансировщика с результатом проверки Smart Web Security.

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

Включить логирование можно при создании [профиля безопасности](profile-create.md) или [прокси-сервера](proxy-create.md), а также при их редактировании.

{% note info %}

Для настройки логирования в профиле безопасности нужна роль [smart-web-security.editor](../security/index.md#smart-web-security-editor) на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) с профилем. Для просмотра логов в Monium нужна [роль с правом чтения логов](../../monium/security/index.md#roles-list).

{% endnote %}

{% list tabs group=instructions %}

- Профиль безопасности (Monium) {#monium}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится профиль Smart Web Security.
  1. [Перейдите](https://console.yandex.cloud/link/smartwebsecurity) в сервис **Smart Web Security**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/profiles.svg) **Профили безопасности**.
  1. В строке с нужным профилем нажмите ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../_assets/console-icons/pencil.svg) **Редактировать**.
  1. Включите **Запись логов**.
  1. В поле **Записывать логи в** выберите **Monium**.
  1. Настройте фильтры логов:

     1. В блоке **Логировать запросы для правил** выберите типы правил:
     
        * **Базовые правила**.
        * **Smart Protection**.
        * **Web Application Firewall**.
        * **Advanced Rate Limiter**.
     
     1. В блоке **Логировать запросы с вердиктом** выберите вердикты:
     
        * **Разрешено (ALLOW)**.
        * **Заблокировано (DENY)**.
        * **Направлено на проверку** — **CAPTCHA** или **JS-проверка**.
     
     1. Для запросов с вердиктом `ALLOW` укажите долю пропускаемых логов в поле **Сколько не записывать логов с вердиктом ALLOW**: `0%` — записывать все, `100%` — не записывать.

  1. Нажмите **Сохранить**.

- Прокси-сервер (Cloud Logging) {#logging}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог с прокси-сервером.
  1. [Перейдите](https://console.yandex.cloud/link/smartwebsecurity) в сервис **Smart Web Security**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/domain-protection-icon.svg) **Защита доменов**.
  1. В строке с нужным прокси-сервером нажмите ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../_assets/console-icons/pencil.svg) **Редактировать**.
  1. Включите **Логировать запросы**.
  1. Выберите [лог-группу](../../logging/concepts/log-group.md) Cloud Logging, в которую будут записываться логи, или [создайте новую](../../logging/operations/create-group.md).
  1. (Опционально) Чтобы уменьшить объем логов, создайте правило отбрасывания:

      1. Нажмите **Добавить правило** в блоке **Правила отбрасывания логов**.
      1. Выберите **HTTP-коды** или **Классы HTTP-кодов**, для которых нужно сократить запись логов.
      1. Укажите **Долю отбрасываемых логов** от `0%` (все логи записываются) до `100%` (логи не записываются).

      Для других HTTP-кодов добавьте отдельные правила.

  1. Нажмите **Сохранить**.

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

  Чтобы Yandex Smart Web Security передавал события в Audit Trails:

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится профиль Smart Web Security.
  1. [Перейдите](https://console.yandex.cloud/link/smartwebsecurity) в сервис **Smart Web Security**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/profiles.svg) **Профили безопасности**.
  1. В строке с нужным профилем безопасности нажмите ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../_assets/console-icons/pencil.svg) **Редактировать**.
  1. Включите **Запись логов**.
  1. В поле **Записывать логи в** выберите **Audit Trails**.
  1. Настройте фильтры логов:

     1. В блоке **Логировать запросы для правил** выберите типы правил:
     
        * **Базовые правила**.
        * **Smart Protection**.
        * **Web Application Firewall**.
        * **Advanced Rate Limiter**.
     
     1. В блоке **Логировать запросы с вердиктом** выберите вердикты:
     
        * **Разрешено (ALLOW)**.
        * **Заблокировано (DENY)**.
        * **Направлено на проверку** — **CAPTCHA** или **JS-проверка**.
     
     1. Для запросов с вердиктом `ALLOW` укажите долю пропускаемых логов в поле **Сколько не записывать логов с вердиктом ALLOW**: `0%` — записывать все, `100%` — не записывать.

  1. Нажмите **Сохранить**.

  Таким образом можно настроить передачу только событий из отдельных профилей безопасности или только по отдельным правилам и вердиктам.

{% endlist %}

### Просмотреть логи {#view-logs}

{% list tabs group=instructions %}

- Интерфейс Smart Web Security {#console}

  Для профиля безопасности:

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог с профилем безопасности.
  1. [Перейдите](https://console.yandex.cloud/link/smartwebsecurity) в сервис **Smart Web Security**.
  1. На панели слева выберите ![receipt](../../_assets/console-icons/receipt.svg) **Логи**.
  1. Задайте период поиска логов.
  1. В строке запроса выберите поля для фильтрации. Чтобы найти логи конкретного профиля, добавьте условие `security_profile_id = "<идентификатор_профиля>"`.
  
     Для ввода запроса в текстовом режиме нажмите ![code](../../_assets/console-icons/code.svg) и используйте [язык запросов Monium](../../monium/logs/query.md). Сохраните метки `project`, `cluster` и `service`, выбранные по умолчанию.
  
  1. Нажмите **Выполнить запрос**. Чтобы посмотреть содержимое записи, разверните ее.

  Для прокси-сервера:

  Нужна роль [logging.viewer](../../logging/security/index.md#logging-viewer) на лог-группу.

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог с прокси-сервером.
  1. [Перейдите](https://console.yandex.cloud/link/smartwebsecurity) в сервис **Smart Web Security**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/domain-protection-icon.svg) **Защита доменов**.
  1. Выберите нужный прокси-сервер.
  1. Перейдите на вкладку **Логи**.

  Логи прокси-сервера также можно [просмотреть в Cloud Logging](../../logging/operations/read-logs.md).

- Monium {#monium}

  1. На главной странице [Monium](https://monium.yandex.cloud) слева выберите ![compass](../../_assets/console-icons/compass.svg) **Обзор** → **Логи**.
  1. Задайте период поиска логов.
  1. В строке запроса укажите `project = "folder__<идентификатор_каталога>"` для каталога с профилем безопасности. Выберите значения `cluster` и `service` для логов Smart Web Security из выпадающих списков.
  1. Чтобы найти логи конкретного профиля, добавьте условие `security_profile_id = "<идентификатор_профиля>"`.

     Запрос можно составить из меток в выпадающих списках или ввести на [языке запросов Monium](../../monium/logs/query.md). Для ввода запроса нажмите ![code](../../_assets/console-icons/code.svg).

  1. Нажмите **Выполнить запрос**. Чтобы посмотреть содержимое записи, разверните ее.

- Audit Trails {#at}

  Для просмотра логов нужна роль [storage.viewer](../../storage/security/index.md#storage-viewer) на бакет.

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог с бакетом.
  1. [Перейдите](https://console.yandex.cloud/link/storage) в сервис **Object Storage**.
  1. Выберите бакет, указанный в настройках трейла.
  1. На вкладке **Объекты** найдите файлы за нужную дату. [Путь к файлу](../../audit-trails/concepts/format-data-plane.md#log-file-name) содержит идентификатор трейла и дату записи.
  1. [Скачайте](../../storage/operations/objects/download.md) нужный JSON-файл и откройте его в текстовом редакторе.

  Каждый файл содержит массив событий. Чтобы найти определенное [событие Smart Web Security](../at-ref.md#data-plane-events), ищите значение поля `event_type` в формате `yandex.cloud.audit.smartwebsecurity.<имя_события>`.

{% endlist %}

## Примеры готовых фильтров для логов {#filtration}

Примеры ниже относятся к логам профиля безопасности и подходят для интерфейсов Smart Web Security и Monium. Логи поставляются в формате JSON: одна запись соответствует одному запросу клиента, обработанному Smart Web Security.

Запросы для фильтрации логов составляются, исходя из взаимосвязи профилей и правил [Smart Web Security](../concepts/profiles.md#profile-rules-schema). Вы можете посмотреть логи активных, работающих правил или правил в режиме **Только логирование** (dry run).

Добавьте нужные условия из примеров ниже в селектор запроса, сохранив метки `project`, `cluster` и `service`. Поля описаны в разделе [Логирование](../concepts/logging.md).

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