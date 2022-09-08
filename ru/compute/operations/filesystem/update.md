# Изменить файловое хранилище

После создания файлового хранилища вы можете изменить его имя, описание и размер.

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится файловое хранилище.
  1. Выберите сервис **{{ compute-name }}**.
  1. На панели слева выберите ![image](../../../_assets/compute/storage.svg) **Файловые хранилища**.
  1. В строке нужного файлового хранилище нажмите ![image](../../../_assets/options-grey.svg) и выберите пункт **Редактировать**.
  1. Измените параметры файлового хранилища: например, переименуйте его, отредактировав поле **Имя**.

     {% note info %}

     Размер хранилища можно изменить только с помощью CLI или API.

     {% endnote %}

  1. Нажмите кнопку **Сохранить**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  1. Посмотрите описание команд CLI для изменения хранилища:
     
     * Для изменения имени, описания и размера:

       ```
       yc compute filesystem update --help
       ```
     
     * Для изменения размера:

       ```
       yc compute filesystem resize --help
       ```

  1. Получите список доступных хранилищ:

     ```
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

       ```
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

       ```
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

- API
   
  Используйте метод [FilesystemService/Update](../../api-ref/grpc/filesystem_service.md#Update) gRPC API или метод [update](../../api-ref/Filesystem/update.md) ресурса Filesystem REST API.
  
{% endlist %}