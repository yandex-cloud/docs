# Удаление облака


Чтобы удалить облако, у вас должна быть роль `{{ roles-cloud-owner }}` на это облако. Если вы не можете выполнить эту операцию, обратитесь к [владельцу облака](../../concepts/resources-hierarchy.md#owner).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) в списке слева выберите нужное облако.
  1. В правом верхнем углу страницы нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. Выберите срок удаления облака, после которого оно будет удалено. Выберите один из возможных периодов или `Удалить сейчас`. Срок удаления облака по умолчанию — 7 дней.
  1. Нажмите **{{ ui-key.yacloud.common.delete }}**.

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

  Чтобы удалить облако, воспользуйтесь вызовом gRPC API [CloudService/Delete](../../api-ref/grpc/cloud_service.md#Delete).

{% endlist %}

Ресурсы будут остановлены, облако перейдет в статус ожидания удаления `PENDING_DELETION`. Удаление облака, находящегося в статусе `PENDING_DELETION`, можно [отменить](delete-cancel.md).

{% include [alert-pending-deletion](../../../_includes/resource-manager/alert-pending-deletion.md) %}

После завершения периода ожидания облако переходит в статус `DELETING`. В этом статусе происходит процесс необратимого удаления, занимающий до 72 часов.
