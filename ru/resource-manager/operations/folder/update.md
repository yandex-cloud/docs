# Изменение каталога

Через консоль управления можно изменить только имя каталога. Чтобы изменить его описание, используйте CLI или API.

{% list tabs %}

- Консоль управления

  1. Выберите каталог на [стартовой странице]({{ link-console-cloud }}) консоли управления. На этой странице отображаются каталоги для выбранного облака. Если необходимо, [переключитесь на другое облако](../cloud/switch-cloud.md).
  1. Нажмите значок ![image](../../../_assets/options.svg) напротив каталога и выберите **Редактировать**.
  1. Введите новое имя каталога.
  1. Нажмите кнопку **Сохранить**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Посмотрите описание команды изменения каталога:

      ```bash
      yc resource-manager folder update --help
      ```
  1. Если вы знаете идентификатор или имя каталога, переходите к следующему шагу. Если нет, то узнайте это одним из способов:

      * Получите список каталогов:

          ```bash
          yc resource-manager folder list
          ```

          Результат:

          ```
          +----------------------+--------------------+--------+--------+-------------+
          |          ID          |        NAME        | LABELS | STATUS | DESCRIPTION |
          +----------------------+--------------------+--------+--------+-------------+
          | b1gppulhhm2aaufq9eug | yet-another-folder |        | ACTIVE |             |
          | b1gvmob95yysaplct532 | default            |        | ACTIVE |             |
          +----------------------+--------------------+--------+--------+-------------+
          ```

      * Если вы знаете идентификатор ресурса, который принадлежит нужному каталогу, получите идентификатор каталога из информации об этом ресурсе:

          ```bash
          yc <service-name> <resource> get <resource-id>
          ```

          Где:
          * `<service-name>` — имя сервиса, например `compute`.
          * `<resource>` — категория ресурса, например `instance`.
          * `<resource-id>` — идентификатор ресурса.

          Например, виртуальная машина `fhmp74bfis2aim728p2a` принадлежит каталогу `b1gpvjd9ir42nsng55ck`:

          ```bash
          yc compute instance get fhmp74bfis2ais728p2a
          ```
          
          Результат:

          ```
          id: fhmp74bfis2ais728p2a
          folder_id: b1gpvjd9ia42nsng55ck
          ...
          ```
          
  1. Измените параметры каталога, например имя и описание. Вы можете указать изменяемый каталог по имени или идентификатору.

      ```bash
      yc resource-manager folder update default \
        --new-name myfolder \
        --description "this is my default-folder"
      ```

      Команда переименует каталог `default` в `myfolder` и обновит его описание.

      {% include [name-format](../../../_includes/name-format.md) %}

- API

  Чтобы изменить каталог, воспользуйтесь методом REST API [update](../../api-ref/Folder/update.md) для ресурса [Folder](../../api-ref/Folder/index.md) или вызовом gRPC API [FolderService/Update](../../api-ref/grpc/folder_service.md#Update).

- {{ TF }}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы изменить настройки каталога, созданный с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и измените фрагмент с описанием каталога.

     {% cut "Пример описания каталога в конфигурации {{ TF }}" %}

     ```hcl
     ...
     resource "yandex_resourcemanager_folder" "folder1" {
       cloud_id    = "b1gia12......fvsleds"
       name        = "myfolder"
       description = "this is my default-folder"
     }
     ...
     ```

     {% endcut %}

     Более подробную информацию о параметрах ресурса `yandex_resourcemanager_folder` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/resourcemanager_folder).

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
     yc resource-manager folder list-operations <имя каталога>|<ID каталога>
     ```

{% endlist %}

