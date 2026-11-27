---
alternate:
  - href: ru/audit-trails/quickstart.md
    type: text/markdown
    title: Markdown version
---
# Как начать работать с {{ at-name }}

{{ at-name }} собирает [аудитные логи](./concepts/format.md) ресурсов {{ yandex-cloud }} для контроля действий с ресурсами и событий доступа. Логи можно загружать в [бакет](../storage/concepts/bucket.md) {{ objstorage-full-name }}, в [проект](*monium-folder-project) {{ monium-logs-name }} или [поток данных](../data-streams/concepts/glossary.md#stream-concepts) {{ yds-full-name }}.

Для сбора и доставки аудитных логов в {{ at-name }} используются [трейлы](./concepts/trail.md). Для каждого вида хранилища нужен отдельный трейл.

По этой инструкции вы создадите трейл для загрузки аудитных логов ресурсов организации. Выберите объект назначения в зависимости от задачи:

* [Бакет](../storage/concepts/bucket.md) {{ objstorage-name }} — для долговременного хранения аудитных логов и их последующего анализа.
* [{{ monium-logs-name }}](concepts/trail.md#monium) — для просмотра и поиска аудитных логов в интерфейсе {{ monium-name }}.

## Перед началом работы {#before-you-begin}

Инструкция предполагает, что у вас уже есть ресурсы {{ yandex-cloud }}, поэтому перед началом убедитесь:

* у вас есть [облако](../resource-manager/concepts/resources-hierarchy.md#cloud);
* к облаку подключен [платежный аккаунт](../billing/concepts/billing-account.md) со статусом `ACTIVE` или `TRIAL_ACTIVE`.

Для создания трейла и просмотра логов вам потребуются роли:

* `iam.serviceAccounts.user` — на сервисный аккаунт, от имени которого будет собираться аудитный лог. Сервисный аккаунт можно создать при создании трейла.
* `audit-trails.editor` — на каталог, в котором будет находиться трейл.
* `audit-trails.viewer` — на организацию, с которой будут собираться аудитные логи.
* При использовании бакета:
   
   * `kms.editor` — на каталог, в котором будет создан ключ шифрования для бакета.
   * `storage.viewer` — на бакет или каталог.

* Для просмотра логов в {{ monium-name }} — `monium.logs.reader` на каталог с трейлом.

{% include [note-managing-roles](../_includes/mdb/note-managing-roles.md) %}

## Создать трейл {#the-trail-creation}

{% list tabs group=audit-trails-destination %}

- Бакет {#bucket}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите разместить трейл.
  1. [Перейдите]({{ link-console-main }}/link/audit-trails) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
  1. Нажмите **{{ ui-key.yacloud.audit-trails.button_create-trail }}**.
  1. В блоке **{{ ui-key.yacloud.audit-trails.label_destination }}** задайте параметры объекта назначения:
      
      * **{{ ui-key.yacloud.audit-trails.label_destination }}** — `{{ ui-key.yacloud.audit-trails.label_objectStorage }}`.
      * **{{ ui-key.yacloud.audit-trails.label_bucket }}** — выберите бакет, в который будут загружаться аудитные логи. Если бакета нет, нажмите **{{ ui-key.yacloud.common.create }}** и [создайте новый бакет](../storage/quickstart.md#the-first-bucket) с ограниченным доступом.
      * **{{ ui-key.yacloud.audit-trails.label_object-prefix }}** — необязательный параметр, участвует в [полном имени](./concepts/format.md#log-file-name) файла аудитного лога.
      
      {% include [note-bucket-prefix](../_includes/audit-trails/note-bucket-prefix.md) %}
      
      * **{{ ui-key.yacloud.audit-trails.title_kms-key }}** — если выбранный бакет [зашифрован](../storage/concepts/encryption.md), укажите ключ шифрования.

  1. {% include [control-plane-on-console](../_includes/audit-trails/control-plane-on-console.md) %}
  1. {% include [data-plane-on-console](../_includes/audit-trails/data-plane-on-console.md) %}
  1. В блоке **{{ ui-key.yacloud.audit-trails.label_service-account }}** выберите существующий [сервисный аккаунт](../iam/concepts/users/service-accounts.md) или создайте новый. От имени этого аккаунта трейл будет загружать файлы аудитного лога в бакет.
      Если вы создаете новый аккаунт, нажмите **{{ ui-key.yacloud.common.create }}**, укажите имя и назначьте ему роли:
      
      * `storage.uploader` на бакет;
      * `audit-trails.viewer` на каталог, если планируете собирать события с каталога;
      * `kms.keys.encrypter` на ключ шифрования, если бакет зашифрован.

  1. В поле **{{ ui-key.yacloud.common.name }}** укажите имя создаваемого трейла.
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

- {{ monium-name }} {#monium}

  Для загрузки в {{ monium-name }} создайте трейл через CLI, {{ TF }} или API. В этой инструкции используется CLI.

  {% include [cli-install](../_includes/cli-install.md) %}

  1. [Создайте сервисный аккаунт](../iam/operations/sa/create.md) для трейла.
  1. [Назначьте сервисному аккаунту роль](../organization/operations/add-role.md) `audit-trails.viewer` на организацию, события которой будете собирать.
  1. Создайте трейл:

      ```bash
      yc audit-trails trail create \
        --name <имя_трейла> \
        --folder-id <идентификатор_каталога_трейла> \
        --service-account-id <идентификатор_сервисного_аккаунта> \
        --destination-monium \
        --filter-all-organisation-id <идентификатор_организации>
      ```

      Трейл начнет передавать события уровня конфигурации из организации в [проект каталога с трейлом](concepts/trail.md#monium). Чтобы дополнительно собирать события уровня сервисов, настройте [политику фильтрации](operations/create-trail.md#cli).

{% endlist %}

Вы также можете создать трейл с помощью [CLI](./operations/create-trail.md#cli), [Terraform](./operations/create-trail.md#tf) или [API](./operations/create-trail.md#api).

{% include [note-lose-target-when-switch-trail](../_includes/audit-trails/note-lose-target-when-switch-trail.md) %}

## Просмотреть аудитные логи {#watch-logs}

{% list tabs group=audit-trails-destination %}

- Бакет {#bucket}

  {{ at-name }} формирует файлы аудитных логов приблизительно раз в 5 минут. {{ at-name }} создает файлы логов в формате `JSON`.
  
  Получите доступ к содержимому файла аудитного лога одним из способов:
  
  * [Скачайте объект](../storage/operations/objects/download.md).
  * [Получите публичную ссылку на объект](../storage/operations/objects/link-for-download.md).
  * Смонтируйте бакет через [FUSE](https://ru.wikipedia.org/wiki/FUSE_(модуль_ядра)): [s3fs](../storage/tools/s3fs.md) или [goofys](../storage/tools/goofys.md).

- {{ monium-name }} {#monium}

  {% include [view-logs-monium](../_includes/audit-trails/view-logs-monium.md) %}

{% endlist %}

## Экспортировать аудитные логи в SIEM {#export-to-siem}

Вы можете [экспортировать](./concepts/export-siem.md) файлы аудитных логов в ваше SIEM-решение.

## Что дальше {#whats-next}

* Узнайте больше о [сервисе](./concepts/index.md).
* Узнайте о [типах аудитных логов](./concepts/control-plane-vs-data-plane.md).
* Ознакомьтесь с [требованиями к аудитным логам в стандарте безопасности](../security/standard/audit-logs.md).

[*monium-folder-project]: {% include notitle [folder-project](../_popups/monium/folder-project.md) %}
