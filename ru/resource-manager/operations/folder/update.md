# Изменение каталога

Чтобы изменить имя и описание каталога, используйте консоль управления, CLI, API или {{ TF }}.

{% list tabs %}

- Консоль управления

  1. Выберите каталог на [стартовой странице]({{ link-console-cloud }}) консоли управления. На этой странице отображаются каталоги для выбранного облака. Если необходимо, [переключитесь на другое облако](../cloud/switch-cloud.md).
  1. Нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) напротив каталога и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. Введите новое имя каталога и описание.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.cloud.folders.popup-edit_button_save }}**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Посмотрите описание команды изменения каталога:

      ```bash
      yc resource-manager folder update --help
      ```
  1. {% include [get-folder-id-or-name](../../../_includes/resource-manager/get-folder-id-or-name.md) %}
          
  1. Измените параметры каталога, например имя и описание. Вы можете указать изменяемый каталог по имени или идентификатору.

      ```bash
      yc resource-manager folder update default \
        --new-name myfolder \
        --description "this is my default-folder"
      ```

      Команда переименует каталог `default` в `myfolder` и обновит его описание. Требования к имени каталога:

      {% include [name-format](../../../_includes/name-format.md) %}

- API

  Чтобы изменить каталог, воспользуйтесь методом REST API [update](../../api-ref/Folder/update.md) для ресурса [Folder](../../api-ref/Folder/index.md) или вызовом gRPC API [FolderService/Update](../../api-ref/grpc/folder_service.md#Update).

- {{ TF }}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы изменить настройки каталога, созданный с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и измените фрагмент с описанием каталога.

     {% cut "Пример описания каталога в конфигурации {{ TF }}" %}

     ```hcl
     ...
     resource "yandex_resourcemanager_folder" "folder1" {
       cloud_id    = "b1gia12lt1tp********"
       name        = "myfolder"
       description = "this is my default-folder"
     }
     ...
     ```

     {% endcut %}

     Более подробную информацию о параметрах ресурса `yandex_resourcemanager_folder` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/resourcemanager_folder).

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
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Примените изменения конфигурации:
     ```
     terraform apply
     ```
     
  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменение каталога можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

     ```
     yc resource-manager folder list-operations <имя_каталога>|<ID_каталога>
     ```

{% endlist %}

