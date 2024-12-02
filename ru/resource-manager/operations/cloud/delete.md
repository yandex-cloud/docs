# Удаление облака

Чтобы удалить облако, у вас должна быть роль [{{ roles-resource-manager-editor }}](../../security/index.md#resource-manager-editor) или выше на это облако. Если вы не можете выполнить эту операцию, обратитесь к [владельцу облака](../../concepts/resources-hierarchy.md#owner).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) в списке слева выберите нужное облако.
  1. В правом верхнем углу страницы нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. Выберите срок удаления облака, по истечении которого облако будет удалено. Выберите один из возможных периодов или `{{ ui-key.yacloud_billing.component.iam-delete-folder-or-cloud-dialog.label_delete-now }}`. Срок удаления облака по умолчанию — 7 дней.
  1. Нажмите **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Посмотрите описание команды удаления облака:

      ```bash
      yc resource-manager cloud delete --help
      ```

  1. Получите список доступных облаков:

      {% include [get-cloud-list](../../../_includes/resource-manager/get-cloud-list.md) %}

  1. Удалите облако, указав его имя или идентификатор:

      ```bash
      yc resource-manager cloud delete <имя_или_идентификатор_облака> \
        --delete-after <срок_удаления_облака> \
        --async
      ```

      Где:

      * `--delete-after` — срок удаления облака в формате `HhMmSs`. Процесс удаления облака начнется по истечении заданного срока. Например: `--delete-after 22h30m50s`.
      
          Чтобы удалить облако сейчас, укажите `0s`.
      * `--async` — флаг асинхронного удаления.
      
          Удаление облака может занять до 72 часов. Выполняйте команду в асинхронном режиме, чтобы вернуть управление терминалом, не дожидаясь завершения выполнения команды.

      Результат:

      ```text
      id: b1gqkbbj04d9********
      description: Delete cloud
      created_at: "2024-10-17T05:16:30.648219069Z"
      created_by: ajei280a73vc********
      modified_at: "2024-10-17T05:16:30.648219069Z"
      metadata:
        '@type': type.googleapis.com/yandex.cloud.resourcemanager.v1.DeleteCloudMetadata
        cloud_id: b1g66mft1vop********
        delete_after: "2024-10-18T03:47:19.441433Z"
      ```

      Где `id` — идентификатор операции, с помощью которого вы сможете позднее отследить ее статус.

  1. (Опционально) Получите информацию о статусе операции удаления:

      ```bash
      yc operation get <идентификатор_операции>
      ```

      После завершения удаления облака, ответ будет содержать поле `done` со значением `true` (`done: true`).

  Подробнее о команде `yc resource-manager cloud delete` см. в [справочнике CLI](../../../cli/cli-ref/resource-manager/cli-ref/cloud/delete.md).

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы удалить облако, созданное с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием облака.

      {% cut "Пример описания облака в конфигурации {{ TF }}" %}

      ```hcl
      ...
      resource "yandex_resourcemanager_cloud" "cloud1" {
        name            = "cloud-main"
        organization_id = "bpf7nhb9hkph********"
      }
      ...
      ```

      {% endcut %}

      Более подробную информацию о параметрах ресурса `yandex_resourcemanager_cloud` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/resourcemanager_cloud).

  1. В командной строке перейдите в папку, где вы отредактировали конфигурационный файл.
  1. Проверьте корректность конфигурационного файла с помощью команды:

      ```bash
      terraform validate
      ```

      Если конфигурация является корректной, появится сообщение:
     
      ```bash
      Success! The configuration is valid.
      ```

  1. Выполните команду:

      ```bash
      terraform plan
      ```

      В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Примените изменения конфигурации:

      ```bash
      terraform apply
      ```

  1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

      ```bash
      yc resource-manager cloud list
      ```

- API {#api}

  Чтобы удалить облако, воспользуйтесь вызовом gRPC API [CloudService/Delete](../../api-ref/grpc/Cloud/delete.md).

{% endlist %}

Ресурсы будут остановлены, облако перейдет в статус ожидания удаления `PENDING_DELETION`. Удаление облака, находящегося в статусе `PENDING_DELETION`, можно [отменить](delete-cancel.md).

{% include [alert-pending-deletion](../../../_includes/resource-manager/alert-pending-deletion.md) %}

После завершения периода ожидания облако переходит в статус `DELETING`. В этом статусе происходит процесс необратимого удаления, занимающий до 72 часов. В результате вместе с облаком будут удалены все его ресурсы.
