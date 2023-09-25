# Загрузка аудитных логов каталога в {{ objstorage-name }}

По этой инструкции вы создадите новый [трейл](../concepts/trail.md), который будет загружать аудитные логи уровня конфигурации (Control Plane) всех ресурсов и (опционально) аудитные логи уровня сервисов (Data Plane) выбранных сервисов отдельного каталога в бакет {{ objstorage-name }}.

{% include [bucket-encryption-tip](../../_includes/audit-trails/bucket-encryption-tip.md) %}


## Подготовить окружение {#before-you-begin}

Для сбора аудитных логов каталога:

1. [Создайте новый бакет](../../storage/operations/buckets/create.md) с ограниченным доступом для загрузки в него аудитных логов.
1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт.
1. Назначьте роли сервисному аккаунту:

    {% list tabs %}

    - CLI

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      * Назначьте роль [`audit-trails.viewer`](../security/index.md#roles-list) на каталог, со всех ресурсов которого будут собираться аудитные логи:

        ```
        yc resource-manager folder add-access-binding \
          --role audit-trails.viewer \
          --id <идентификатор_каталога> \
          --service-account-id <идентификатор_сервисного_аккаунта>
        ```

        Где:
        * `role` — назначаемая роль;
        * `id` — идентификатор каталога, с которого будут собираться аудитные логи;
        * `service-account-id` — идентификатор сервисного аккаунта.

      * Назначьте роль [`storage.uploader`](../../storage/security/index.md#storage-uploader) на каталог, в котором будет находиться трейл:

        ```
        yc resource-manager folder add-access-binding \
          --role storage.uploader \
          --id <идентификатор_каталога> \
          --service-account-id <идентификатор_сервисного_аккаунта>
        ```

        Где:
        * `role` — назначаемая роль;
        * `id` — идентификатор каталога, в котором будет находиться трейл;
        * `service-account-id` — идентификатор сервисного аккаунта.

    {% endlist %}

1. На странице [Права доступа]({{ link-console-access-management }}) убедитесь, что у вас есть роли:
    * `iam.serviceAccounts.user` на сервисный аккаунт;
    * `audit-trails.editor` на каталог, где будет находиться трейл;
    * `audit-trails.viewer` на каталог, с которого будут собираться аудитные логи;
    * `storage.viewer` на бакет или каталог.


{% include [bucket-encryption-section](../../_includes/audit-trails/bucket-encryption-section.md) %}


## Создать трейл {#the-trail-creation}

Чтобы создать первый трейл в {{ at-name }} и запустить процесс управления аудитными логами:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите разместить трейл.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.audit-trails.button_create-trail }}** и укажите:

      * **{{ ui-key.yacloud.common.name }}** — имя создаваемого трейла.
      * **{{ ui-key.yacloud.common.description }}** — описание трейла, необязательный параметр.

  1. В блоке **{{ ui-key.yacloud.audit-trails.label_destination }}** задайте параметры объекта назначения:

      * **{{ ui-key.yacloud.audit-trails.label_destination }}** — `{{ ui-key.yacloud.audit-trails.label_objectStorage }}`.
      * **{{ ui-key.yacloud.audit-trails.label_bucket }}** — имя [бакета](../../storage/operations/buckets/create.md), в который будут загружаться аудитные логи.
      * **{{ ui-key.yacloud.audit-trails.label_object-prefix }}** — необязательный параметр, участвует в [полном имени](../concepts/format.md#log-file-name) файла аудитного лога.
      
      {% include [note-bucket-prefix](../../_includes/audit-trails/note-bucket-prefix.md) %}

  1. В блоке **{{ ui-key.yacloud.audit-trails.label_service-account }}** выберите сервисный аккаунт, от имени которого трейл будет загружать файлы аудитного лога в бакет.

  1. В блоке **{{ ui-key.yacloud.audit-trails.label_path-filter-section }}** задайте параметры сбора аудитных логов уровня конфигурации:

      * **Статус** — выберите `{{ ui-key.yacloud.common.enabled }}`.
      * **{{ ui-key.yacloud.audit-trails.label_resource-type }}** — выберите `{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}`.
      * **{{ ui-key.yacloud.audit-trails.label_resource-manager.folder }}** — не требует заполнения, содержит имя текущего каталога.

  1. {% include [data-plane-on-console](../../_includes/audit-trails/data-plane-on-console.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}


## Что дальше {#whats-next} 

* Узнайте о [формате аудитных логов](../concepts/format.md).
* Узнайте о порядке [загрузки аудитных логов в SIEM](../concepts/export-siem.md).
* Узнайте о [поиске по аудитным логам в бакете](../tutorials/search-bucket.md).
