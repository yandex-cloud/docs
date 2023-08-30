# Загрузка аудитных логов облака в {{ cloud-logging-name }}

По этой инструкции вы создадите новый трейл, который будет загружать аудитные логи ресурсов отдельного облака в лог-группу {{ cloud-logging-name }}.


## Подготовить окружение {#before-you-begin}

Для экспорта аудитных логов облака:

1. [Создайте](../../logging/operations/create-group.md) лог-группу для загрузки в нее аудитных логов.
1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт.
1. Назначьте роли сервисному аккаунту:

    {% list tabs %}

    - CLI

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      * [`audit-trails.viewer`](../security/index.md#roles-list) на облако, с которого будут собираться аудитные логи:

        ```
        yc resource-manager cloud add-access-binding \
          --role audit-trails.viewer \
          --id <идентификатор облака> \
          --service-account-id <идентификатор сервисного аккаунта>
        ```

        Где:

        * `role` — назначаемая роль.
        * `id` — [идентификатор облака](../../resource-manager/operations/cloud/get-id.md), с которого будут собираться аудитные логи.
        * `service-account-id` — идентификатор сервисного аккаунта.

      * [`logging.writer`](../../logging/security/index.md#roles-list) на каталог, в котором будет находиться трейл:

        ```
        yc resource-manager folder add-access-binding \
          --role logging.writer \
          --id <идентификатор каталога> \
          --service-account-id <идентификатор сервисного аккаунта>
        ```

        Где:

        * `role` — назначаемая роль.
        * `id` — идентификатор каталога, в котором будет находиться трейл.
        * `service-account-id` — идентификатор сервисного аккаунта.

    {% endlist %}

1. На странице [Права доступа]({{ link-console-access-management }}) убедитесь, что у вас есть роли:
    * `iam.serviceAccounts.user` на сервисный аккаунт;
    * `audit-trails.editor` на каталог, где будет находиться трейл;
    * `audit-trails.viewer` на облако, с которого будут собираться аудитные логи;
    * `logging.viewer` на лог-группу {{ cloud-logging-name }}.


## Создать трейл {#the-trail-creation}

Чтобы создать трейл, который экспортирует аудитные логи облака:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите разместить трейл.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.audit-trails.button_create-trail }}** и укажите:
      * **{{ ui-key.yacloud.common.name }}** — имя создаваемого трейла.
      * **{{ ui-key.yacloud.common.description }}** — описание трейла, необязательный параметр.
  1. В блоке **{{ ui-key.yacloud.audit-trails.label_filter }}** задайте параметры области сбора аудитных логов:
      * **{{ ui-key.yacloud.audit-trails.label_resource-type }}** — выберите `{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}`.
      * **{{ ui-key.yacloud.audit-trails.label_resource-manager.cloud }}** — не требует заполнения, содержит имя облака, в котором будет находиться трейл.
      * **{{ ui-key.yacloud.audit-trails.label_folders }}** — оставьте значение по умолчанию `{{ ui-key.yacloud.audit-trails.label_all-folders }}`.
  1. В блоке **{{ ui-key.yacloud.audit-trails.label_destination }}** задайте параметры объекта назначения:
      * **{{ ui-key.yacloud.audit-trails.label_destination }}** —  `{{ ui-key.yacloud.audit-trails.label_cloudLogging }}`.
      * **{{ ui-key.yacloud.logging.label_loggroup }}** — выберите лог-группу. Также вы можете создать новую лог-группу, для этого:
        * Нажмите кнопку **{{ ui-key.yacloud.common.label_create-new_female }}** и укажите параметры лог-группы:
          * **{{ ui-key.yacloud.common.name }}** — имя создаваемой группы.
      	  * **{{ ui-key.yacloud.common.description }}** — описание лог-группы, необязательный параметр..
      	  * **{{ ui-key.yacloud.logging.label_retention-period }}**.
		* Нажмите кнопку **{{ ui-key.yacloud.logging.button_create-group }}**.
  1. В блоке **{{ ui-key.yacloud.audit-trails.label_service-account }}** выберите сервисный аккаунт, от имени которого трейл будет загружать аудитные логи в лог-группу.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

Трейл создастся и начнет загружать аудитные логи в лог-группу. 

## Что дальше {#whats-next} 

* Узнайте о [формате аудитных логов](../concepts/format.md).
* Узнайте о порядке [загрузки аудитных логов в SIEM](../concepts/export-siem.md).
* Узнайте о [поиске по аудитным логам в бакете](../tutorials/search-bucket.md).
