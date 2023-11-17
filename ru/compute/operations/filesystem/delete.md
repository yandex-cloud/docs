# Удалить файловое хранилище

1. [Отключите файловое хранилище](detach-from-vm.md) от всех ВМ, к которым оно подключено.
1. Удалите файловое хранилище в {{ compute-name }}:

    {% list tabs %}

    - Консоль управления

       1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится файловое хранилище.
       1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
       1. На панели слева выберите ![image](../../../_assets/compute/storage.svg) **{{ ui-key.yacloud.compute.switch_file-storages }}**.
       1. В строке нужного файлового хранилище нажмите ![image](../../../_assets/options-grey.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
       1. В открывшемся окне нажмите **{{ ui-key.yacloud.common.delete }}**.

    - {{ TF }}

      {% include [terraform-install](../../../_includes/terraform-install.md) %}

      1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием хранилища:

          {% cut "Пример описания хранилища в конфигурации {{ TF }}" %}

          ```hcl
          ...
          resource "yandex_compute_filesystem" "default" {
            name  = "fs-name"
            type  = "network-ssd"
            zone  = "{{ region-id }}-a"
            size  = 150
          }
          ...
          ```
          
          {% endcut %}

      1. Примените изменения:

          {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

      Проверить удаление хранилища можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

        ```bash
        yc compute filesystem list
        ```

    - API

      Воспользуйтесь методом REST API [delete](../../api-ref/Filesystem/delete.md) для ресурса [Filesystem](../../api-ref/Filesystem/index.md) или вызовом gRPC API [FilesystemService/Delete](../../api-ref/grpc/filesystem_service.md#Delete).

    {% endlist %}