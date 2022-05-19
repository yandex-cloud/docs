# Создание каталога

_Каталог_  — это пространство, в котором создаются и группируются ресурсы {{ yandex-cloud }}.

{% list tabs %}

- Консоль управления

  {% include [create-folder](../../../_includes/create-folder.md) %}


- CLI

  1. Посмотрите описание команды создания каталога:

      ```
      $ yc resource-manager folder create --help
      ```

  2. Создайте новый каталог:

      * с именем и без описания:
          ```
          $ yc resource-manager folder create \
              --name new-folder
          ```

          {% include [name-format](../../../_includes/name-format.md) %}

      * с именем и описанием:

          ```
          $ yc resource-manager folder create \
              --name new-folder \
              --description "my first folder with description"
          ```

- API

  Чтобы создать каталог, воспользуйтесь методом [create](../../api-ref/Folder/create.md) для ресурса [Folder](../../api-ref/Folder/index.md).

- Terraform

  Если у вас ещё нет Terraform, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     ```hcl
     resource "yandex_resourcemanager_folder" "folder1" {
       cloud_id    = "<идентификатор облака>"
       name        = "<имя создаваемого каталога>"
       description = "<описание каталога>"
     }
     ```

     Где:
	 * `cloud_id` — идентификатор облака, в котором будет создан каталог. Необязательный параметр. По умолчанию будет использовано значение, указанное в настройках провайдера.
     * `name` — имя создаваемого каталога. Обязательный параметр. Требования к имени:

       {% include [name-format](../../../_includes/name-format.md) %}

     * `description` — описание каталога. Необязательный параметр.

     Более подробную информацию о параметрах ресурса `yandex_resourcemanager_folder` в Terraform, см. в [документации провайдера](https://registry.tfpla.net/providers/yandex-cloud/yandex/latest/docs/resources/resourcemanager_folder).

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

        Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет. 

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
