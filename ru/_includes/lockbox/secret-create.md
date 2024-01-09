Чтобы создать секрет:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создан [секрет](../../lockbox/concepts/secret.md).
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.lockbox.button_create-secret }}**.
    1. В поле **{{ ui-key.yacloud.common.name }}** введите имя секрета.
    1. (Опционально) В поле **{{ ui-key.yacloud.lockbox.forms.field_kms-key }}** укажите существующий ключ или [создайте новый](../../kms/operations/key.md#create).

        Указанный ключ {{ kms-short-name }} используется для шифрования секрета. Если вы не будете указывать ключ, секрет будет зашифрован специальным системным ключом.

        {% note tip %}

        Использование своего [ключа {{ kms-short-name }}](../../kms/concepts/key.md) дает возможность использовать все преимущества сервиса {{ kms-full-name }}.

        {% endnote %}

    1. (опционально) Включите опцию **{{ ui-key.yacloud.lockbox.forms.field_deletion-protection }}**. Пока опция включена, удалить секрет невозможно. Не защищает содержимое секрета.
    1. В блоке **{{ ui-key.yacloud.lockbox.forms.section_version }}**:

        * В поле **{{ ui-key.yacloud.lockbox.forms.label_key }}** введите неконфиденциальный идентификатор.
        * В поле **{{ ui-key.yacloud.lockbox.forms.label_value }}** введите конфиденциальные данные для хранения.
        
        Чтобы добавить больше данных нажмите кнопку **{{ ui-key.yacloud.lockbox.forms.button_add-pair }}** и повторите шаги.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания [секрета](../../lockbox/concepts/secret.md):

      ```bash
      yc lockbox secret create --help
      ```

  1. Выполните команду:
  
     ```bash
     yc lockbox secret create \
       --name <имя_секрета> \
       --description <описание_секрета> \
       --payload "<массив_с_содержимым_секрета>" \
       --cloud-id <идентификатор_облака> \
       --folder-id <идентификатор_каталога> \
       --deletion-protection
     ```

     Где:

     * `--name` — имя секрета. Обязательный параметр.
     * `--description` — описание секрета. Необязательный параметр.
     * `--payload` — содержимое секрета в виде массива YAML или JSON. 
        
         Вы можете одновременно передать один или несколько ключей `key`. Если секрет будет содержать несколько значений, перечислите их через запятую. Если ключи будут содержать значения в бинарном формате, передавайте их в кодировке `base64`. 
        
         Например, для сохранения ключа `username` с текстовым значением `myusername` и ключа `avatar` с загруженным из файла `avatar.jpg` значением в бинарном формате можно указать:
         `[{'key': 'username', 'text_value': 'myusername'},{'key': 'avatar', 'binary_value': $(base64 -w 0 ./avatar.jpg)}]`.
     * `--cloud-id` — [идентификатор облака](../../resource-manager/operations/cloud/get-id.md), в котором будет создан секрет.
     * `--folder-id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором будет создан секрет.
     * `--deletion-protection` — защита от удаления секрета. Пока опция включена, удалить секрет невозможно. Не защищает содержимое секрета. Необязательный параметр.

     Пример команды для создания секрета:

     ```bash
     yc lockbox secret create \
       --name sample-secret \
       --description sample_secret \
       --payload "[{'key': 'username', 'text_value': 'myusername'},{'key': 'avatar', 'binary_value': $(base64 -w 0 ./avatar.jpg)}]" \
       --cloud-id b1gwa87mbaom******** \
       --folder-id b1qt6g8ht345******** \
       --deletion-protection
     ``` 

     В этом примере создается секрет с двумя ключами: один ключ с текстовым значением, другой — со значением в бинарном формате.

     Результат:
     
     ```
     id: e6q6nbjfu9m2********
     folder_id: b1qt6g8ht345********
     created_at: "2023-10-09T16:29:11.402Z"
     name: sample-secret
     description: sample_secret
     status: ACTIVE
     current_version:
       id: e6q0s9airqca********
       secret_id: e6q6nbjfu9m2********
       created_at: "2023-10-09T16:29:11.402Z"
       status: ACTIVE
       payload_entry_keys:
         - username
         - avatar
     deletion_protection: true
     ```

- {{ TF }} {#tf}

  [Секрет](../../lockbox/concepts/secret.md) содержит только метаинформацию о себе: имя, описание, уникальный идентификатор и т. д. Для начала работы с секретом необходимо [создать версию](../../lockbox/operations/secret-version-manage.md) секрета.

  {% include [terraform-install](../../_includes/terraform-install.md) %}

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

      Более подробную информацию о параметрах ресурса `yandex_lockbox_secret` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}Resources/lockbox_secret).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

  После этого в указанном каталоге будет создан секрет. Проверить появление секрета и его настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

    ```bash
    yc lockbox secret get <имя_секрета>
    ```

- API {#api}

  Чтобы создать секрет, воспользуйтесь методом REST API [create](../../lockbox/api-ref/Secret/create.md) для ресурса [Secret](../../lockbox/api-ref/Secret/index.md) или вызовом gRPC API [SecretService/Create](../../lockbox/api-ref/grpc/secret_service.md#Create).

{% endlist %}
