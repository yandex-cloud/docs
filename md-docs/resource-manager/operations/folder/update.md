# Изменение каталога

Чтобы изменить имя и описание [каталога](../../concepts/resources-hierarchy.md#folder), используйте консоль управления, CLI, API или Terraform.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![image](../../../_assets/console-icons/layout-side-content-left.svg) или ![image](../../../_assets/console-icons/chevron-down.svg) и выберите нужный каталог. Если необходимо, [переключитесь на другое облако](../cloud/switch-cloud.md).
  1. Нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) напротив каталога и выберите **Редактировать**.
  1. Введите новое имя каталога и описание.
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

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
     
       ```text
       +----------------------+--------------------+--------+--------+-------------+
       |          ID          |        NAME        | LABELS | STATUS | DESCRIPTION |
       +----------------------+--------------------+--------+--------+-------------+
       | b1gppulhhm2a******** | yet-another-folder |        | ACTIVE |             |
       | b1gvmob95yys******** | default            |        | ACTIVE |             |
       +----------------------+--------------------+--------+--------+-------------+
       ```
     
       * Если вы знаете идентификатор ресурса, который принадлежит нужному каталогу, получите идентификатор каталога из информации об этом ресурсе:
     
       ```bash
       yc <имя_сервиса> <категория_сервиса> get <идентификатор_ресурса>
       ```
     
       Где:
       * `<имя_сервиса>` — имя сервиса, например `compute`.
       * `<категория_сервиса>` — категория ресурса, например `instance`.
       * `<идентификатор_ресурса>` — идентификатор ресурса.
     
       Например, виртуальная машина `fhmp74bfis2a********` принадлежит каталогу `b1gpvjd9ir42********`:
     
       ```bash
       yc compute instance get fhmp74bfis2a********
       ```
     
       Результат:
     
       ```text
       id: fhmp74bfis2a********
       folder_id: b1gpvjd9ia42********
       ...
       ```
          
  1. Измените параметры каталога, например имя и описание. Вы можете указать изменяемый каталог по имени или идентификатору.

      ```bash
      yc resource-manager folder update default \
        --new-name myfolder \
        --description "this is my default-folder"
      ```

      Команда переименует каталог `default` в `myfolder` и обновит его описание. Требования к имени каталога:

      * длина — от 3 до 63 символов;
      * может содержать строчные буквы латинского алфавита, цифры и дефисы;
      * первый символ — буква, последний — не дефис.

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы изменить настройки каталога, созданный с помощью Terraform:

  1. Откройте файл конфигурации Terraform и измените фрагмент с описанием каталога.

     {% cut "Пример описания каталога в конфигурации Terraform" %}

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

     Более подробную информацию о параметрах ресурса `yandex_resourcemanager_folder` в Terraform, см. в [документации провайдера](../../../terraform/resources/resourcemanager_folder.md).

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
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.

  1. Примените изменения конфигурации:
     ```
     terraform apply
     ```
     
  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменение каталога можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/quickstart.md):

     ```
     yc resource-manager folder list-operations <имя_или_идентификатор_каталога>
     ```

- API {#api}

  Чтобы изменить каталог, воспользуйтесь методом REST API [update](../../api-ref/Folder/update.md) для ресурса [Folder](../../api-ref/Folder/index.md) или вызовом gRPC API [FolderService/Update](../../api-ref/grpc/Folder/update.md).

{% endlist %}