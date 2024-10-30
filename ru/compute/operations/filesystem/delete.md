# Удалить файловое хранилище

1. [Отключите файловое хранилище](detach-from-vm.md) от всех [виртуальных машин](../../concepts/vm.md), к которым оно подключено.
1. Удалите [файловое хранилище](../../concepts/filesystem.md) в {{ compute-name }}:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится файловое хранилище.
     1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
     1. На панели слева выберите ![image](../../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.compute.switch_file-storages }}**.
     1. В строке нужного файлового хранилище нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
     1. В открывшемся окне нажмите **{{ ui-key.yacloud.common.delete }}**.

   - CLI {#cli}

     {% include [cli-install](../../../_includes/cli-install.md) %}

     {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

     1. Посмотрите описание команды [CLI](../../../cli/) для удаления файлового хранилища:

        ```bash
        yc compute filesystem delete --help
        ```

     1. Получите список файловых хранилищ в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

        {% include [compute-filesystem-list](../../_includes_service/compute-filesystem-list.md) %}

     1. Выполните команду, указав имя или идентификатор файлового хранилища, которое требуется удалить:

        ```bash
        yc compute filesystem delete <имя_или_идентификатор_файлового_хранилища>
        ```

     1. Убедитесь, что файловое хранилище было удалено:

        ```bash
        yc compute filesystem list
        ```

   - {{ TF }} {#tf}

     {% include [terraform-install](../../../_includes/terraform-install.md) %}

     1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием хранилища:

        {% cut "Пример описания хранилища в конфигурации {{ TF }}" %}

        ```hcl
        ...
        resource "yandex_compute_filesystem" "default" {
          name = "fs-name"
          type = "network-ssd"
          zone = "{{ region-id }}-a"
          size = 150
        }
        ...
        ```

        {% endcut %}

     1. Примените изменения:

        {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     Проверить удаление хранилища можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/):

     ```bash
     yc compute filesystem list
     ```

   - API {#api}

     Воспользуйтесь методом REST API [delete](../../api-ref/Filesystem/delete.md) для ресурса [Filesystem](../../api-ref/Filesystem/index.md) или вызовом gRPC API [FilesystemService/Delete](../../api-ref/grpc/Filesystem/delete.md).

   {% endlist %}