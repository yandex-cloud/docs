# Удалить файловое хранилище

1. [Отключите файловое хранилище](detach-from-vm.md) от всех [виртуальных машин](../../concepts/vm.md), к которым оно подключено.
1. Удалите [файловое хранилище](../../concepts/filesystem.md) в {{ compute-name }}:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится файловое хранилище.
     1. Перейдите в сервис **{{ compute-name }}**.
     1. На панели слева выберите ![image](../../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.compute.file-storages_pNPw1 }}**.
     1. В строке нужного файлового хранилище нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
     1. В открывшемся окне нажмите **{{ ui-key.yacloud.common.delete }}**.

   - CLI {#cli}

     Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

     По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

     1. Посмотрите описание команды [CLI](../../../cli/index.md) для удаления файлового хранилища:

        ```bash
        yc compute filesystem delete --help
        ```

     1. Получите список файловых хранилищ в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

        ```bash
        yc compute filesystem list
        ```
        
        Результат:
        
        ```text
        +----------------------+-------------------+------------+---------------+--------+-------------+
        |          ID          |        NAME       |    SIZE    |     ZONE      | STATUS | DESCRIPTION |
        +----------------------+-------------------+------------+---------------+--------+-------------+
        | epdtcr9blled******** | first-filesystem  | 1073741824 | {{ region-id }}-a | READY  |             |
        | epd3f4gv8bs4******** | second-filesystem | 1073741824 | {{ region-id }}-a | READY  |             |
        +----------------------+-------------------+------------+---------------+--------+-------------+
        ```

     1. Выполните команду, указав имя или идентификатор файлового хранилища, которое требуется удалить:

        ```bash
        yc compute filesystem delete <имя_или_идентификатор_файлового_хранилища>
        ```

     1. Убедитесь, что файловое хранилище было удалено:

        ```bash
        yc compute filesystem list
        ```

   - {{ TF }} {#tf}

     Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
     
     
     Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

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
        
           В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
        1. Примените изменения конфигурации:
        
           ```bash
           terraform apply
           ```
        
        1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

     Проверить удаление хранилища можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/index.md):

     ```bash
     yc compute filesystem list
     ```

   - API {#api}

     Воспользуйтесь методом REST API [delete](../../api-ref/Filesystem/delete.md) для ресурса [Filesystem](../../api-ref/Filesystem/index.md) или вызовом gRPC API [FilesystemService/Delete](../../api-ref/grpc/Filesystem/delete.md).

   {% endlist %}