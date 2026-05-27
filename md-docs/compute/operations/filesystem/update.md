# Изменить файловое хранилище

После создания [файлового хранилища](../../concepts/filesystem.md) вы можете изменить его имя, описание и размер.

{% note info %}

Размер файлового хранилища можно изменить только с помощью [CLI](../../../cli/index.md) или API. Изменить размер хранилища можно лишь в сторону увеличения, уменьшить размер хранилища нельзя.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится файловое хранилище.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/nodes-right.svg) **Файловые хранилища**.
  1. В строке нужного файлового хранилище нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите пункт **Редактировать**.
  1. Измените параметры файлового хранилища: например, переименуйте его, отредактировав поле **Имя**.

     {% note info %}

     Размер файлового хранилища можно изменить только с помощью CLI или API.

     {% endnote %}

  1. Нажмите **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Откройте файл конфигурации Terraform и измените фрагмент с описанием файлового хранилища:

     {% cut "Пример описания файлового хранилища в конфигурации Terraform" %}

     ```hcl
     ...
     resource "yandex_compute_filesystem" "default" {
       name  = "fs-name"
       type  = "network-ssd"
       zone  = "ru-central1-a"
       size  = 150
     }
     ...
     ```

     {% endcut %}

  1. Примените изменения:

     1. В терминале перейдите в директорию с конфигурационным файлом.
     1. Проверьте корректность конфигурации с помощью команды:
     
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
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

  Проверить изменение файлового хранилища и его настройки можно в [консоли управления](https://console.yandex.cloud) или с помощью команды CLI:

  ```bash
  yc compute filesystem get <имя_файлового_хранилища>
  ```

- API {#api}

  Воспользуйтесь методом REST API [update](../../api-ref/Filesystem/update.md) для ресурса [Filesystem](../../api-ref/Filesystem/index.md) или вызовом gRPC API [FilesystemService/Update](../../api-ref/grpc/Filesystem/update.md).

{% endlist %}