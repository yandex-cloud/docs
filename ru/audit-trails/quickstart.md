# Как начать работать с {{ at-name }}

{{ at-name }} собирает [аудитные логи](./concepts/format.md) ресурсов {{ yandex-cloud }} и загружает их в бакет {{ objstorage-name }}, лог-группу {{ cloud-logging-name }} или поток данных {{ yds-name }}.

Управление аудитными логами внутри {{ at-name }} осуществляется через [трейлы](./concepts/trail.md).

По этой инструкции вы создадите новый трейл, который будет загружать аудитные логи ресурсов вашей организации в бакет {{ objstorage-name }}.

## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.
1. На странице [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../billing/concepts/billing-account.md) и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md#create_billing_account).
1. Убедитесь, что в вашем облаке существует бакет для хранения аудитного лога, при необходимости [создайте новый бакет](../storage/quickstart.md#the-first-bucket) с ограниченным доступом.
1. [Создайте](../iam/operations/sa/create.md) сервисный аккаунт и назначьте ему роли:

    {% list tabs %}

    - CLI

      {% include [cli-install](../_includes/cli-install.md) %}

      {% include [default-catalogue](../_includes/default-catalogue.md) %}

      * Назначьте роль [`storage.uploader`](../storage/security/index.md#storage-uploader) на каталог, в котором будет находиться трейл:

        ```
        yc resource-manager folder add-access-binding \
          --role storage.uploader \
          --id <идентификатор_каталога> \
          --service-account-id <идентификатор_сервисного_аккаунта>
        ```

        Где:

        * `role` — назначаемая роль.
        * `id` — идентификатор каталога, в котором будет находиться трейл.
        * `service-account-id` — идентификатор сервисного аккаунта.

      * Назначьте роль [`audit-trails.viewer`](./security/index.md#roles-list) на организацию, с которой будут собираться аудитные логи:

        ```
        yc organization-manager organization add-access-binding \
          --role audit-trails.viewer \
          --id <идентификатор_организации> \
          --service-account-id <идентификатор_сервисного_аккаунта>
        ```

        Где:

        * `role` — назначаемая роль.
        * `id` — идентификатор организации, с которой будут собираться аудитные логи.
        * `service-account-id` — идентификатор сервисного аккаунта.

    {% endlist %}

1. На странице [Управление доступом]({{ link-console-access-management }}) убедитесь, что у вас есть роли:
    * `iam.serviceAccounts.user` на сервисный аккаунт;
    * `audit-trails.editor` на каталог, где будет находиться трейл;
    * `audit-trails.viewer` на организацию, с которой будут собираться аудитные логи;
    * `storage.viewer` на бакет или каталог.

## Создание трейла {#the-trail-creation}

Чтобы создать первый трейл в {{ at-name }} и запустить процесс управления аудитными логами уровня конфигурации:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите разместить трейл.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.audit-trails.button_create-trail }}**.
  1. В поле **{{ ui-key.yacloud.common.name }}** укажите имя создаваемого трейла.
  1. В поле **{{ ui-key.yacloud.common.description }}** задайте описание трейла, необязательный параметр.
  1. В блоке **{{ ui-key.yacloud.audit-trails.label_destination }}** задайте параметры объекта назначения:

      * **{{ ui-key.yacloud.audit-trails.label_destination }}** — `{{ ui-key.yacloud.audit-trails.label_objectStorage }}`.
      * **{{ ui-key.yacloud.audit-trails.label_bucket }}** — выберите бакет, в который будут загружаться аудитные логи.
      * **{{ ui-key.yacloud.audit-trails.label_object-prefix }}** — необязательный параметр, участвует в [полном имени](./concepts/format.md#log-file-name) файла аудитного лога.
      
      {% include [note-bucket-prefix](../_includes/audit-trails/note-bucket-prefix.md) %}
      * **{{ ui-key.yacloud.audit-trails.title_kms-key }}** — если выбранный бакет [зашифрован](../storage/concepts/encryption.md), укажите ключ шифрования.

  1. В блоке **{{ ui-key.yacloud.audit-trails.label_service-account }}** выберите сервисный аккаунт, от имени которого трейл будет загружать файлы аудитного лога в бакет.
  1. В блоке **{{ ui-key.yacloud.audit-trails.label_path-filter-section }}** задайте параметры сбора аудитных логов уровня конфигурации:

      * **{{ ui-key.yacloud.audit-trails.label_collecting-logs }}** — выберите `{{ ui-key.yacloud.common.enabled }}`.
      * **{{ ui-key.yacloud.audit-trails.label_resource-type }}** — выберите `{{ ui-key.yacloud.audit-trails.label_organization-manager.organization }}`.
      * **{{ ui-key.yacloud.audit-trails.label_organization-manager.organization }}** — не требует заполнения, содержит имя текущей организации.
      * **{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}** — оставьте значение по умолчанию `{{ ui-key.yacloud.common.all }}`.

  1. {% include [data-plane-on-console](../_includes/audit-trails/data-plane-on-console.md) %}
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Просмотр аудитных логов {#watch-logs}

При загрузке аудитных логов в бакет {{ at-name }} формирует файлы аудитных логов приблизительно раз в 5 минут. Трейл запишет все [события](./concepts/events.md), которые произошли за это время с ресурсами организации, в один или несколько файлов. Если никакие события за этот период не произойдут, файлы не сформируются.

Удостоверьтесь, что файл аудитного лога существует в бакете, указанном при создании трейла.

### Просмотр файлов аудитных логов {#watch-log-file}

{{ at-name }} создает файлы логов в формате `JSON`.

Получите доступ к содержимому файла аудитного лога одним из способов:
* [Скачайте объект](../storage/operations/objects/download.md).
* [Получите публичную ссылку на объект](../storage/operations/objects/link-for-download.md).
* Смонтируйте бакет через [FUSE](https://ru.wikipedia.org/wiki/FUSE_(модуль_ядра)): [s3fs](../storage/tools/s3fs.md) или [goofys](../storage/tools/goofys.md). 

## Экспорт аудитных логов в SIEM {#watch-log-file}

Вы можете [экспортировать](./concepts/export-siem.md) файлы аудитных логов в ваше SIEM-решение.

## Что дальше {#whats-next}

* Узнайте больше о [сервисе](./concepts/index.md).
* Узнайте о [типах аудитных логов](./concepts/control-plane-vs-data-plane.md).
