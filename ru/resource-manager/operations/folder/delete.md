# Удаление каталога

Чтобы удалить [каталог](../../concepts/resources-hierarchy.md#folder), у вас должна быть роль [{{ roles-resource-manager-editor }}](../../security/index.md#resource-manager-editor) или выше на этот каталог. Если вы не можете выполнить эту операцию, обратитесь к [администратору](../../../iam/roles-reference.md#admin) или [владельцу каталога](../../concepts/resources-hierarchy.md#owner).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Выберите каталог на [стартовой странице]({{ link-console-cloud }}) консоли управления. На этой странице отображаются каталоги для выбранного облака. Если необходимо, [переключитесь на другое облако](../cloud/switch-cloud.md).
  1. Нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) напротив каталога и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. Выберите срок удаления каталога, по истечении которого каталог будет удален. Выберите один из возможных периодов или `{{ ui-key.yacloud_billing.component.iam-delete-folder-or-cloud-dialog.label_delete-now }}`. По умолчанию срок удаления каталога — 7 дней.
  1. Нажмите **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Посмотрите описание команды удаления каталога:

      ```bash
      yc resource-manager folder delete --help
      ```

  1. {% include [get-folder-id-or-name](../../../_includes/resource-manager/get-folder-id-or-name.md) %}

  1. Удалите каталог, указав его имя или идентификатор:

      ```bash
      yc resource-manager folder delete <имя_или_идентификатор_каталога> \
        --delete-after <срок_удаления_каталога> \
        --async
      ```

      Где:

      * `--delete-after` — срок удаления каталога в формате `HhMmSs`. Процесс удаления каталога начнется по истечении заданного срока. Например: `--delete-after 22h30m50s`.

          Чтобы удалить каталог сейчас, укажите `0s`.
      * `--async` — флаг асинхронного удаления.
      
          Удаление каталога может занять до 72 часов. Выполняйте команду в асинхронном режиме, чтобы вернуть управление терминалом, не дожидаясь завершения выполнения команды.

      Результат:

      ```text
      id: b1gqkbbj04d9********
      description: Delete folder
      created_at: "2024-10-17T05:16:30.648219069Z"
      created_by: ajei280a73vc********
      modified_at: "2024-10-17T05:16:30.648219069Z"
      metadata:
        '@type': type.googleapis.com/yandex.cloud.resourcemanager.v1.DeleteFolderMetadata
        folder_id: b1g66mft1vop********
        delete_after: "2024-10-18T03:47:19.441433Z"
      ```

      Где `id` — идентификатор операции, с помощью которого вы сможете позднее отследить ее статус.

  1. (Опционально) Получите информацию о статусе операции удаления:

      ```bash
      yc operation get <идентификатор_операции>
      ```

      После завершения удаления каталога, ответ будет содержать поле `done` со значением `true` (`done: true`).

  Подробнее о команде `yc resource-manager folder delete` см. в [справочнике CLI](../../../cli/cli-ref/resource-manager/cli-ref/folder/delete.md).

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы удалить каталог, созданный с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием каталога.

      {% cut "Пример описания каталога в конфигурации {{ TF }}" %}

      ```hcl
      ...
      resource "yandex_resourcemanager_folder" "folder1" {
        cloud_id    = "b1gia12lt1tp********"
        name        = "new-folder"
        description = "this is my default-folder"
      }
      ...
      ```

      {% endcut %}

      Более подробную информацию о параметрах ресурса `yandex_resourcemanager_folder` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/resourcemanager_folder).

  1. В командной строке перейдите в папку, где расположен конфигурационный файл {{ TF }}.

  1. Проверьте конфигурацию командой:

      ```
      terraform validate
      ```

      Если конфигурация является корректной, появится сообщение:

      ```
      Success! The configuration is valid.
      ```

  1. Выполните команду:

      ```
      terraform plan
      ```

      В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Примените изменения конфигурации:

      ```
      terraform apply
      ```

  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

      Проверить удаление каталога можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

      ```
      yc resource-manager folder list
      ```

- API {#api}

  Чтобы удалить каталог, воспользуйтесь методом REST API [delete](../../api-ref/Folder/delete.md) для ресурса [Folder](../../api-ref/Folder/index.md) или вызовом gRPC API [FolderService/Delete](../../api-ref/grpc/Folder/delete.md).

{% endlist %}

Удаление начинается с остановки ресурсов. Каталог переходит в статус `PENDING_DELETION`. Запускается подготовка к удалению. Время нахождения в этом статусе зависит от выбранного срока удаления. Удаление каталога, находящегося в статусе `PENDING_DELETION`, можно отменить. Для этого в [консоли управления]({{ link-console-cloud }}) справа от имени каталога нажмите значок ![***](../../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.iam.cloud.folders.button_cancel-deletion }}**.

{% note alert %}

Пока каталог находится в статусе `PENDING_DELETION`, ваши диски, зарезервированные IP-адреса и другие данные продолжают храниться и тарифицироваться. 

Пока каталог находится в статусе `DELETING` тарификация платных ресурсов продолжается, если метрики фиксируют их потребление.

Стоимость хранения рассчитывается по прежнему тарифу. Следите за тарификацией ресурсов в [сервисе {{ billing-name }}]({{ link-console-billing }}).

{% endnote %}

После завершения подготовки к удалению и срока удаления каталог переходит в статус `DELETING`. В этом статусе происходит процесс необратимого удаления, занимающий до 72 часов. В результате вместе с каталогом будут удалены все его ресурсы.

Удаление каталога может быть отменено системой, если в нем есть ресурсы, которые нельзя удалить. Подробнее см. в разделе [{#T}](../../concepts/resources-hierarchy.md#inability-to-delete). После отмены удаления каталог вернется в статус `ACTIVE`, а пользователь получит сообщение с описанием причин, которые не позволили удалить каталог.