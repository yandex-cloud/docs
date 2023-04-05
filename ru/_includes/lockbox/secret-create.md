Чтобы создать секрет:

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создан секрет.
    1. В списке сервисов выберите **{{ lockbox-short-name }}**.
    1. Нажмите кнопку **Создать секрет**.
    1. В поле **Имя** введите имя секрета.
    1. (опционально) В поле **Ключ {{ kms-short-name }}** укажите существующий ключ или [создайте новый](../../kms/operations/key.md#create).
        
        Указанный ключ {{ kms-short-name }} используется для шифрования секрета. Если вы не будете указывать ключ, секрет будет зашифрован специальным системным ключом. 
        
        {% note tip %}
        
        Использование своего [ключа {{ kms-short-name }}](../../kms/concepts/key.md) дает возможность использовать все преимущества сервиса {{ kms-full-name }}.
        
        {% endnote %}
        
    1. В блоке **Версия**:
        * В поле **Ключ** введите неконфиденциальный идентификатор.
        * В поле **Значение** введите конфиденциальные данные для хранения.
        
        Чтобы добавить больше данных нажмите кнопку **Добавить пару** и повторите шаги.
    1. Нажмите кнопку **Создать**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания секрета:
      ```bash
      yc lockbox secret create --help
      ```

  1. Выполните команду, указав в параметрах имя каталога и [идентификатор облака](../../resource-manager/operations/cloud/get-id.md). Вы можете передать один или несколько ключей `key`. Если секрет будет содержать несколько значений, перечисляйте их через запятую. В примере указаны два ключа:
     ```bash
     yc lockbox secret create --name <имя секрета> \
       --description <описание секрета> \
       --payload "[{'key': '<ключ>', 'text_value': '<текстовое значение>'},{'key': '<ключ>', 'text_value': '<текстовое значение>'}]" \
       --cloud-id <идентификатор облака> --folder-name <название каталога> 
     ```

     Результат:
     
     ```
     id: e6q2ad0j9b55tk3d781j
     folder_id: b1gktjk2rg494evcsd2a
     created_at: "2021-11-08T19:23:00.383Z"
     name: <имя секрета>
     description: <описание секрета>
     status: ACTIVE
     current_version:
       id: g6q4fn3b6okjkckanaib
       secret_id: e6e2ei4u9b55gh2d561j
       created_at: "2021-11-08T19:23:00.383Z"
       status: ACTIVE
       payload_entry_keys:
       - <ключ>
     ```

- {{ TF }}

  Секрет содержит только метаинформацию о себе: имя, описание, уникальный идентификатор и т. д. Для начала работы с секретом необходимо [создать версию](../../lockbox/operations/secret-version-manage.md) секрета.

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

          
     ```
     terraform {
       required_providers {
         yandex = {
           source = "yandex-cloud/yandex"
         }
       }
       required_version = ">= 0.13"
     }
     provider "yandex" {
       zone = "{{ region-id }}-a"
     }

     resource "yandex_lockbox_secret" "my_secret" {
       name                = "<имя_секрета>"
       description         = "<описание_секрета>"
       folder_id           = "<идентификатор_каталога>"
       kms_key_id          = "<идентификатор_ключа_шифрования>"
       deletion_protection = <флаг_защиты_от_удаления>
       labels              = {
         <ключ_метки_1>  = "<значение_метки_1>",
         <ключ_метки_2>  = "<значение_метки_2>"
       }
     }
     ```



      Где:

      * `name` — имя секрета. Обязательный параметр.
      * `description` — описание секрета. Необязательный параметр.
      * `folder_id` — [идентификатор](../../resource-manager/operations/folder/get-id.md) каталога в котором будет создан секрет. Необязательный параметр.
      * `kms_key_id` — идентификатор [ключа шифрования {{ kms-short-name }}](../../kms/concepts/). Указанный KMS-ключ используется для шифрования секрета. Если не указывать ключ, то секрет будет зашифрован специальным системным ключом. Необязательный параметр.
      * `deletion_protection` — флаг защиты от удаления. Для включения защиты укажите значение `true`. Для отключения защиты — `false`. Значение по умолчанию `false`. Необязательный параметр.
      * `labels` — [метка](../../overview/concepts/services.md#labels) ресурса в формате `<ключ>:"<значение>"`. Необязательный параметр.

      Более подробную информацию о параметрах ресурса `yandex_lockbox_secret` в Terraform, см. в [документации провайдера]({{ tf-provider-link }}/lockbox_secret).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

  После этого в указанном каталоге будет создан секрет. Проверить появление секрета и его настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

    ```bash
    yc lockbox secret get <имя_секрета>
    ```

- API

  Чтобы создать секрет, воспользуйтесь методом REST API [create](../../lockbox/api-ref/Secret/create.md) для ресурса [Secret](../../lockbox/api-ref/Secret/index.md) или вызовом gRPC API [SecretService/Create](../../lockbox/api-ref/grpc/secret_service.md#Create).

{% endlist %}
