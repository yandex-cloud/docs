# Изменить файловое хранилище

После создания [файлового хранилища](../../concepts/filesystem.md) вы можете изменить его имя, описание и размер.

{% note info %}

Размер файлового хранилища можно изменить только с помощью [CLI](../../../cli/) или API. Изменить размер хранилища можно лишь в сторону увеличения, уменьшить размер хранилища нельзя.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится файловое хранилище.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.compute.file-storages_pNPw1 }}**.
  1. В строке нужного файлового хранилище нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.common.edit }}**.
  1. Измените параметры файлового хранилища: например, переименуйте его, отредактировав поле **{{ ui-key.yacloud.common.name }}**.

     {% note info %}

     Размер файлового хранилища можно изменить только с помощью CLI или API.

     {% endnote %}

  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команд CLI для изменения файлового хранилища:
     * Для изменения имени, описания и размера:

       ```bash
       yc compute filesystem update --help
       ```

     * Для изменения размера:

       ```bash
       yc compute filesystem resize --help
       ```

  1. Получите список доступных файловых хранилищ:

     ```bash
     yc compute filesystem list --format yaml
     ```

     Результат:

     ```text
     - id: epd0u6h8lh41********
       folder_id: b1g86q4m5vej********
       created_at: "2022-04-26T16:59:19Z"
     ...
       size: "1073741824"
       block_size: "4096"
       status: READY
     ```

  1. Измените параметры файлового хранилища, указав в команде идентификатор (`--id`) или имя (`--name`) нужного хранилища. Например, измените:
     * Имя и описание:

       ```bash
       yc compute filesystem update \
         --name storage-1 \
         --new-name storage-3 \
         --description vm-storage
       ```

       Результат:

       ```text
       id: epd5g123c8hk********
       folder_id: b1g86q4m5vej********
       created_at: "2022-04-26T16:37:30Z"
       ...
       size: "1073741824"
       block_size: "4096"
       status: READY
       ```

     * Размер:

       ```bash
       yc compute filesystem resize \
         --name storage-1 \
         --size 2GB
       ```

       Результат:

       ```text
       id: epd5g123c8hk********
       folder_id: b1g86q4m5vej********
       created_at: "2022-04-26T16:37:30Z"
       ...
       size: "2147483648"
       block_size: "4096"
       status: READY
       ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Откройте файл конфигурации {{ TF }} и измените фрагмент с описанием файлового хранилища:

     {% cut "Пример описания файлового хранилища в конфигурации {{ TF }}" %}

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

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  Проверить изменение файлового хранилища и его настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды CLI:

  ```bash
  yc compute filesystem get <имя_файлового_хранилища>
  ```

- API {#api}

  Воспользуйтесь методом REST API [update](../../api-ref/Filesystem/update.md) для ресурса [Filesystem](../../api-ref/Filesystem/index.md) или вызовом gRPC API [FilesystemService/Update](../../api-ref/grpc/Filesystem/update.md).

{% endlist %}