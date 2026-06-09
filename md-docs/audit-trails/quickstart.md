# Как начать работать с {{ at-name }}

{{ at-name }} собирает [аудитные логи](concepts/format.md) ресурсов {{ yandex-cloud }} для контроля действий с ресурсами и событий доступа. Логи можно загружать в [бакет](../storage/concepts/bucket.md) {{ objstorage-full-name }}, [лог-группу](../logging/concepts/log-group.md) {{ cloud-logging-full-name }} или [поток данных](../data-streams/concepts/glossary.md#stream-concepts) {{ yds-full-name }}.

Для сбора и доставки аудитных логов в {{ at-name }} используются [трейлы](concepts/trail.md). Для каждого вида хранилища нужен отдельный трейл.

По этой инструкции вы создадите трейл для загрузки аудитных логов ресурсов организации. Выберите объект назначения в зависимости от задачи:
* [Бакет](../storage/concepts/bucket.md) {{ objstorage-name }} — для долговременного хранения аудитных логов и их последующего анализа.
* [Лог-группу](../logging/concepts/log-group.md) {{ cloud-logging-name }} — для быстрого просмотра и поиска логов в реальном времени. Также подойдет для первого знакомства с сервисом.

## Перед началом работы {#before-you-begin}

Инструкция предполагает, что у вас уже есть ресурсы {{ yandex-cloud }}, поэтому перед началом убедитесь:

* у вас есть [облако](../resource-manager/concepts/resources-hierarchy.md#cloud);
* к облаку подключен [платежный аккаунт](../billing/concepts/billing-account.md) со статусом `ACTIVE` или `TRIAL_ACTIVE`.

Для создания трейла вам потребуются роли:

* `iam.serviceAccounts.user` — на сервисный аккаунт, от имени которого будет собираться аудитный лог. Сервисный аккаунт можно создать при создании трейла.
* `audit-trails.editor` — на каталог, в котором будет находиться трейл.
* `audit-trails.viewer` — на организацию, с которой будут собираться аудитные логи.
* При использовании бакета:
   * `kms.editor` — на каталог, в котором будет создан ключ шифрования для бакета.
   * `storage.viewer` — на бакет или каталог.
* При использовании лог-группы — `logging.viewer` на лог-группу или каталог.

{% note info %}

Если вы не можете управлять ролями, обратитесь к администратору вашего облака или организации.

{% endnote %}

## Создать трейл {#the-trail-creation}

{% list tabs group=audit-trails-destination %}

- Бакет {#bucket}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите разместить трейл.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.audit-trails.button_create-trail }}**.
  1. В поле **{{ ui-key.yacloud.common.name }}** укажите имя создаваемого трейла.
  1. В блоке **{{ ui-key.yacloud.audit-trails.label_destination }}** задайте параметры объекта назначения:
      * **{{ ui-key.yacloud.audit-trails.label_destination }}** — `{{ ui-key.yacloud.audit-trails.label_objectStorage }}`.
      * **{{ ui-key.yacloud.audit-trails.label_bucket }}** — выберите бакет, в который будут загружаться аудитные логи. Если бакета нет, нажмите кнопку **{{ ui-key.yacloud.common.create }}** и [создайте новый бакет](../storage/quickstart.md#the-first-bucket) с ограниченным доступом.
      * **{{ ui-key.yacloud.audit-trails.label_object-prefix }}** — необязательный параметр, участвует в [полном имени](concepts/format.md#log-file-name) файла аудитного лога.
      
      {% note info %}
      
      Используйте [префикс](../storage/concepts/object.md#key), если вы храните аудитные логи и сторонние данные в одном и том же бакете. Не используйте одинаковый префикс для логов и других объектов в бакете, так как в этом случае логи и сторонние объекты могут перезаписать друг друга.
      
      {% endnote %}
      * **{{ ui-key.yacloud.audit-trails.title_kms-key }}** — если выбранный бакет [зашифрован](../storage/concepts/encryption.md), укажите ключ шифрования.
      
  1. В блоке **{{ ui-key.yacloud.audit-trails.label_service-account }}** выберите существующий [сервисный аккаунт](../iam/concepts/users/service-accounts.md) или создайте новый. От имени этого аккаунта трейл будет загружать файлы аудитного лога в бакет.
      Если вы создаете новый аккаунт, нажмите кнопку **{{ ui-key.yacloud.common.create }}**, укажите имя и назначьте ему роли:
      * `storage.uploader` на бакет;
      * `audit-trails.viewer` на каталог, если планируете собирать события с каталога;
      * `kms.keys.encrypter` на ключ шифрования, если бакет зашифрован.

  1. В блоке **{{ ui-key.yacloud.audit-trails.label_path-filter-section }}** задайте параметры:
      * **{{ ui-key.yacloud.audit-trails.label_collecting-logs }}** — `{{ ui-key.yacloud.common.enabled }}`.
      * **{{ ui-key.yacloud.audit-trails.label_resource-type }}** — уровень сбора событий: `{{ ui-key.yacloud.audit-trails.label_organization-manager.organization }}`, `{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}` или `{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}`.
      * В зависимости от выбранного уровня сбора событий:
          * Назначьте сервисному аккаунту соответствующие роли. Например, при выборе уровня **Каталог** понадобится роль `audit-trails.viewer` на этот каталог.
          * Укажите организацию, облако или каталог, с которых будут собираться аудитные логи.

  1. Проверьте блок **{{ ui-key.yacloud.audit-trails.label_event-filter-section }}** и при необходимости настройте параметры:
     
       {% note warning %}
       
       В консоли управления сбор некоторых событий [уровня сервисов](concepts/control-plane-vs-data-plane.md#data-plane-events) включен [по умолчанию](concepts/trail.md#default). Их доставка оплачивается в соответствии с [правилами тарификации](pricing.md). Если события уровня сервисов вам не нужны, отключите их сбор.
       
       {% endnote %}
     
       * **{{ ui-key.yacloud.audit-trails.label_collecting-logs }}** — `{{ ui-key.yacloud.common.enabled }}`.
       * Выберите [сервисы](concepts/events-data-plane.md), для которых вы хотите собирать аудитные логи.
       * Для каждого выбранного сервиса укажите [область](concepts/trail.md#collecting-area) сбора аудитных логов и тип фильтра событий:
     
           * `Получать все` — чтобы получать все события сервиса.
           * `Выбранные` — чтобы получать только выбранные события. Затем выберите [события](concepts/events-data-plane.md#dns).
           * `Исключить` — чтобы получать все события, кроме выбранных. Затем выберите события.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- Лог-группа {#log-group}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите разместить трейл.
  1. [Перейдите](../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.audit-trails.button_create-trail }}**.
  1. В поле **{{ ui-key.yacloud.common.name }}** укажите имя создаваемого трейла.
  1. В блоке **{{ ui-key.yacloud.audit-trails.label_destination }}** задайте параметры объекта назначения:
      * **{{ ui-key.yacloud.audit-trails.label_destination }}** — `{{ ui-key.yacloud.audit-trails.label_cloudLogging }}`.
      * **{{ ui-key.yacloud.audit-trails.label_log-group }}** — выберите лог-группу, в которую будут загружаться аудитные логи. Если лог-группы нет, нажмите кнопку **{{ ui-key.yacloud.common.create }}** и [создайте новую лог-группу](../logging/quickstart.md).

  1. В блоке **{{ ui-key.yacloud.audit-trails.label_service-account }}** выберите существующий [сервисный аккаунт](../iam/concepts/users/service-accounts.md) или создайте новый. От имени этого аккаунта трейл будет загружать файлы аудитного лога в лог-группу.
      Если вы создаете новый аккаунт, нажмите кнопку **{{ ui-key.yacloud.common.create }}**, укажите имя и назначьте ему роли:
      * `logging.writer` на лог-группу;
      * `audit-trails.viewer` на каталог, если планируете собирать события с каталога.

  1. В блоке **{{ ui-key.yacloud.audit-trails.label_path-filter-section }}** задайте параметры сбора аудитных логов уровня конфигурации:
      * **{{ ui-key.yacloud.audit-trails.label_collecting-logs }}** — выберите `{{ ui-key.yacloud.common.enabled }}`.
      * **{{ ui-key.yacloud.audit-trails.label_resource-type }}** — выберите уровень сбора событий: `{{ ui-key.yacloud.audit-trails.label_organization-manager.organization }}`, `{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}` или `{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}`.
      * В зависимости от выбранного уровня сбора событий:
          * Назначьте сервисному аккаунту соответствующие роли. Например, при выборе уровня **Каталог** понадобится роль `audit-trails.viewer` на этот каталог.
          * Укажите организацию, облако или каталог, с которых будут собираться аудитные логи.

  1. Проверьте блок **{{ ui-key.yacloud.audit-trails.label_event-filter-section }}** и при необходимости настройте параметры:
     
       {% note warning %}
       
       В консоли управления сбор некоторых событий [уровня сервисов](concepts/control-plane-vs-data-plane.md#data-plane-events) включен [по умолчанию](concepts/trail.md#default). Их доставка оплачивается в соответствии с [правилами тарификации](pricing.md). Если события уровня сервисов вам не нужны, отключите их сбор.
       
       {% endnote %}
     
       * **{{ ui-key.yacloud.audit-trails.label_collecting-logs }}** — `{{ ui-key.yacloud.common.enabled }}`.
       * Выберите [сервисы](concepts/events-data-plane.md), для которых вы хотите собирать аудитные логи.
       * Для каждого выбранного сервиса укажите [область](concepts/trail.md#collecting-area) сбора аудитных логов и тип фильтра событий:
     
           * `Получать все` — чтобы получать все события сервиса.
           * `Выбранные` — чтобы получать только выбранные события. Затем выберите [события](concepts/events-data-plane.md#dns).
           * `Исключить` — чтобы получать все события, кроме выбранных. Затем выберите события.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

Вы также можете создать трейл с помощью [CLI](operations/create-trail.md#cli), [Terraform](operations/create-trail.md#tf) или [API](operations/create-trail.md#api).

{% note info %}

При смене объекта назначения в существующем трейле часть событий может быть потеряна. Чтобы избежать потери данных, для каждого объекта создавайте свой трейл.

{% endnote %}

## Просмотреть аудитные логи {#watch-logs}

{% list tabs group=audit-trails-destination %}

- Бакет {#bucket}

  {{ at-name }} формирует файлы аудитных логов приблизительно раз в 5 минут. {{ at-name }} создает файлы логов в формате `JSON`.
  
  Получите доступ к содержимому файла аудитного лога одним из способов:
  * [Скачайте объект](../storage/operations/objects/download.md).
  * [Получите публичную ссылку на объект](../storage/operations/objects/link-for-download.md).
  * Смонтируйте бакет через [FUSE](https://ru.wikipedia.org/wiki/FUSE_(модуль_ядра)): [s3fs](../storage/tools/s3fs.md) или [goofys](../storage/tools/goofys.md).

- Лог-группа {#log-group}

  Вы можете просматривать аудитные логи в реальном времени в интерфейсе {{ cloud-logging-name }}.
  
  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится лог-группа.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
  1. Нажмите на строку с нужной лог-группой.
  1. Перейдите на вкладку **{{ ui-key.yacloud.common.logs }}**.
  1. Настройте фильтры для поиска нужных событий.

{% endlist %}

## Экспортировать аудитные логи в SIEM {#export-to-siem}

Вы можете [экспортировать](concepts/export-siem.md) файлы аудитных логов в ваше SIEM-решение.

## Что дальше {#whats-next}

* Узнайте больше о [сервисе](concepts/index.md).
* Узнайте о [типах аудитных логов](concepts/control-plane-vs-data-plane.md).
* Ознакомьтесь с [требованиями к аудитным логам в стандарте безопасности](../security/standard/audit-logs.md).