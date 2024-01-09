# Изменить файловое хранилище

После создания файлового хранилища вы можете изменить его имя, описание и размер.

{% note info %}

Размер хранилища можно изменить только с помощью CLI или API.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится файловое хранилище.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/compute/storage.svg) **{{ ui-key.yacloud.compute.switch_file-storages }}**.
  1. В строке нужного файлового хранилище нажмите ![image](../../../_assets/options-grey.svg) и выберите пункт **{{ ui-key.yacloud.common.edit }}**.
  1. Измените параметры файлового хранилища: например, переименуйте его, отредактировав поле **{{ ui-key.yacloud.common.name }}**.

     {% note info %}

     Размер хранилища можно изменить только с помощью CLI или API.

     {% endnote %}

  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  1. Посмотрите описание команд CLI для изменения хранилища:
     
     * Для изменения имени, описания и размера:

       ```bash
       yc compute filesystem update --help
       ```
     
     * Для изменения размера:

       ```bash
       yc compute filesystem resize --help
       ```

  1. Получите список доступных хранилищ:

     ```bash
     yc compute filesystem list --format yaml
     ```

     Результат:

     ```bash
     - id: epd0u6h8lh41kq5tua6h
       folder_id: b1g86q4m5vej8lkljme5
       created_at: "2022-04-26T16:59:19Z"
       name: storage-1
       type_id: network-hdd
       zone_id: {{ region-id }}-b
       size: "1073741824"
       block_size: "4096"
       status: READY
     - id: epd5g123c8hk1thkkccm
       folder_id: b1g86q4m5vej8lkljme5
       created_at: "2022-04-26T16:37:30Z"
       name: storage-2
       description: test
       type_id: network-hdd
       zone_id: {{ region-id }}-b
       size: "1073741824"
       block_size: "4096"
       status: READY
     ```

  1. Измените параметры хранилища, указав в команде идентификатор (`--id`) или имя (`--name`) нужного хранилища. Например, измените:

     * Имя и описание:

       ```bash
       yc compute filesystem update \
         --name storage-1 \
         --new-name storage-3 \
         --description vm-storage
       ```

       Результат:

       ```bash
       id: epd5g123c8hk1thkkccm
       folder_id: b1g86q4m5vej8lkljme5
       created_at: "2022-04-26T16:37:30Z"
       name: storage-3
       description: vm-storage
       type_id: network-hdd
       zone_id: {{ region-id }}-b
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

       ```bash
       id: epd5g123c8hk1thkkccm
       folder_id: b1g86q4m5vej8lkljme5
       created_at: "2022-04-26T16:37:30Z"
       name: storage-1
       type_id: network-hdd
       zone_id: {{ region-id }}-b
       size: "2147483648"
       block_size: "4096"
       status: READY
       ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Откройте файл конфигурации {{ TF }} и измените фрагмент с описанием хранилища:

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

  Проверить изменение хранилища и его настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

    ```bash
    yc compute filesystem get <имя_хранилища>
    ```

- API {#api}
   
  Воспользуйтесь методом REST API [update](../../api-ref/Filesystem/update.md) для ресурса [Filesystem](../../api-ref/Filesystem/index.md) или вызовом gRPC API [FilesystemService/Update](../../api-ref/grpc/filesystem_service.md#Update).
  
{% endlist %}