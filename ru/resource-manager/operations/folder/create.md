# Создание каталога

_Каталог_  — это пространство, в котором создаются и [группируются ресурсы](../../concepts/resources-hierarchy.md) {{ yandex-cloud }}.

{% list tabs %}

- Консоль управления

  {% include [create-folder](../../../_includes/create-folder.md) %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Посмотрите описание команды создания каталога:

      ```bash
      yc resource-manager folder create --help
      ```

  2. Создайте новый каталог:

      * с именем и без описания:
          ```bash
          yc resource-manager folder create \
            --name new-folder
          ```

          {% include [name-format](../../../_includes/name-format.md) %}

      * с именем и описанием:

          ```bash
          yc resource-manager folder create \
            --name new-folder \
            --description "my first folder with description"
          ```

- API

  Чтобы создать каталог, воспользуйтесь методом REST API [create](../../api-ref/Folder/create.md) для ресурса [Folder](../../api-ref/Folder/index.md) или вызовом gRPC API [FolderService/Create](../../api-ref/grpc/folder_service.md#Create).

- {{ TF }}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     * `cloud_id` — [идентификатор облака](../cloud/get-id.md), в котором будет создан каталог. Необязательный параметр. По умолчанию будет использовано значение, указанное в настройках провайдера.
     * `name` — имя создаваемого каталога. Обязательный параметр. Требования к имени:

       {% include [name-format](../../../_includes/name-format.md) %}

     * `description` — описание каталога. Необязательный параметр.

     Пример структуры конфигурационного файла:

     ```hcl
     resource "yandex_resourcemanager_folder" "folder1" {
       cloud_id    = "<идентификатор облака>"
       name        = "<имя создаваемого каталога>"
       description = "<описание каталога>"
     }
     ```

     Более подробную информацию о параметрах ресурса `yandex_resourcemanager_folder` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/resourcemanager_folder).

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.

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

        Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 

  1. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```
        terraform apply
        ```

     1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

     После этого в указанном облаке будет создан каталог. Проверить появление каталога и его настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

     ```
     yc resource-manager cloud list
     ```

{% endlist %}
