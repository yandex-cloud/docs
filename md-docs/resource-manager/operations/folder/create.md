# Создание каталога

_Каталог_  — это пространство, в котором создаются и [группируются ресурсы](../../concepts/resources-hierarchy.md) {{ yandex-cloud }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) на панели сверху нажмите ![image](../../../_assets/console-icons/layout-side-content-left.svg) или ![image](../../../_assets/console-icons/chevron-down.svg) и выберите нужное [облако](../../concepts/resources-hierarchy.md#cloud).
  1. Справа от названия облака нажмите ![image](../../../_assets/console-icons/ellipsis.svg).
  1. Выберите ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
  
     ![create-folder1](../../../_assets/resource-manager/create-folder-1.png)
  
  1. Введите имя [каталога](../../concepts/resources-hierarchy.md#folder). Требования к имени:
  
      * длина — от 3 до 63 символов;
      * может содержать строчные буквы латинского алфавита, цифры и дефисы;
      * первый символ — буква, последний — не дефис.
  
  1. (Опционально) Введите описание каталога.
  1. Выберите опцию **{{ ui-key.yacloud.iam.cloud.folders-create.field_default-net }}**. Будет создана [сеть](../../../vpc/concepts/network.md#network) с подсетями в каждой зоне доступности. Также в этой сети будет создана [группа безопасности по умолчанию](../../../vpc/concepts/security-groups.md#default-security-group), внутри которой весь сетевой трафик разрешен.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.
  
     ![create-folder2](../../../_assets/resource-manager/create-folder-2.png)

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

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

          Требования к имени:

          * длина — от 3 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.

      * с именем и описанием:

          ```bash
          yc resource-manager folder create \
            --name new-folder \
            --description "my first folder with description"
          ```

- {{ TF }} {#tf}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     * `cloud_id` — [идентификатор облака](../cloud/get-id.md), в котором будет создан каталог. Необязательный параметр. По умолчанию будет использовано значение, указанное в настройках провайдера.
     * `name` — имя создаваемого каталога. Обязательный параметр. Требования к имени:

       * длина — от 3 до 63 символов;
       * может содержать строчные буквы латинского алфавита, цифры и дефисы;
       * первый символ — буква, последний — не дефис.

     * `description` — описание каталога. Необязательный параметр.

     Пример структуры конфигурационного файла:

     ```hcl
     resource "yandex_resourcemanager_folder" "folder1" {
       cloud_id    = "<идентификатор_облака>"
       name        = "<имя_создаваемого_каталога>"
       description = "<описание_каталога>"
     }
     ```

     Более подробную информацию о параметрах ресурса `yandex_resourcemanager_folder` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/resourcemanager_folder).

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
        yc resource-manager folder list
        ```

- API {#api}

  Чтобы создать каталог, воспользуйтесь методом REST API [create](../../api-ref/Folder/create.md) для ресурса [Folder](../../api-ref/Folder/index.md) или вызовом gRPC API [FolderService/Create](../../api-ref/grpc/Folder/create.md).

{% endlist %}