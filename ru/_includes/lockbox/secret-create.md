Чтобы создать [секрет](../../lockbox/concepts/secret.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создан секрет.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.lockbox.button_create-secret }}**.
  1. В поле **{{ ui-key.yacloud.common.name }}** введите имя секрета.
  1. (Опционально) Для разделения метрик в сервисе {{ monitoring-full-name }} добавьте [метку](../../monitoring/concepts/data-model.md#metric).
  1. (Опционально) Включите опцию **{{ ui-key.yacloud.lockbox.forms.field_deletion-protection }}**. Пока опция включена, удалить секрет невозможно. Не защищает содержимое секрета от изменения.
  1. Выберите **{{ ui-key.yacloud.lockbox.forms.title_secret-type }}**:
      * **{{ ui-key.yacloud.lockbox.forms.title_secret-type-generated }}** — значение формируется автоматически:
  
        * В поле **{{ ui-key.yacloud.lockbox.forms.label_key }}** введите неконфиденциальный идентификатор.
        * (Опционально) Разверните блок **{{ ui-key.yacloud.lockbox.forms.title_auto-generation_params_section }}** и задайте парамеры для конфиденциального значения (например, пароля).
  
      * **{{ ui-key.yacloud.lockbox.forms.title_secret-type-custom }}** — значение задается вручную:

        * В поле **{{ ui-key.yacloud.lockbox.forms.label_key }}** введите неконфиденциальный идентификатор.
        * В поле **{{ ui-key.yacloud.lockbox.forms.label_value }}** введите конфиденциальные данные для хранения.

          Чтобы добавить больше данных, нажмите кнопку **{{ ui-key.yacloud.lockbox.forms.button_add-pair }}** и повторите шаги.
  1. (Опционально) В поле **{{ ui-key.yacloud.lockbox.forms.title_kms-key }}** укажите существующий [ключ](../../kms/concepts/key.md) или [создайте новый](../../kms/operations/key.md#create).

     Указанный ключ [{{ kms-full-name }}](../../kms/) используется для шифрования секрета. Если вы не будете указывать ключ, секрет будет зашифрован специальным системным ключом.

     {% note tip %}

     Использование своего ключа {{ kms-name }} дает возможность использовать все преимущества сервиса {{ kms-name }}.

     {% endnote %}

  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания секрета:

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
     * `--payload` — содержимое секрета в виде массива формата YAML или JSON.

       Вы можете одновременно передать один или несколько [ключей](../../kms/concepts/key.md) `key`. Если секрет будет содержать несколько значений, перечислите их через запятую. Если ключи будут содержать значения в бинарном формате, передавайте их в кодировке `base64`.

       >Например, для сохранения ключа `username` с текстовым значением `myusername` и ключа `avatar` с загруженным из файла `avatar.jpg` значением в бинарном формате можно указать:
       >
       >`[{'key': 'username', 'text_value': 'myusername'},{'key': 'avatar', 'binary_value': $(base64 -w 0 ./avatar.jpg)}]`
     * `--cloud-id` — [идентификатор облака](../../resource-manager/operations/cloud/get-id.md), в котором будет создан секрет.
     * `--folder-id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором будет создан секрет.
     * `--deletion-protection` — защита от удаления секрета. Пока опция включена, удалить секрет невозможно. Не защищает содержимое секрета. Необязательный параметр.

     >Пример команды для создания секрета:
     >
     >```bash
     >yc lockbox secret create \
     >  --name sample-secret \
     >  --description sample_secret \
     >  --payload "[{'key': 'username', 'text_value': 'myusername'},{'key': 'avatar', 'binary_value': $(base64 -w 0 ./avatar.jpg)}]" \
     >  --cloud-id b1gwa87mbaom******** \
     >  --folder-id b1qt6g8ht345******** \
     >  --deletion-protection
     >```
     >
     >В этом примере создается секрет с двумя ключами: один ключ с текстовым значением, другой — со значением в бинарном формате.
     >
     >Результат:
     >
     >```text
     >id: e6q6nbjfu9m2********
     >folder_id: b1qt6g8ht345********
     >created_at: "2023-10-09T16:29:11.402Z"
     >...
     >    - username
     >    - avatar
     >deletion_protection: true
     >```

- {{ TF }} {#tf}

  Секрет содержит только метаинформацию о себе: имя, описание, уникальный идентификатор и т. д. Для начала работы с секретом необходимо [создать версию](../../lockbox/operations/secret-version-manage.md) секрета.

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     ```hcl
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
     * `folder_id` — [идентификатор](../../resource-manager/operations/folder/get-id.md) [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder) в котором будет создан секрет. Необязательный параметр.
     * `kms_key_id` — идентификатор [ключа шифрования {{ kms-name }}](../../kms/concepts/key.md). Указанный ключ {{ kms-name }} используется для шифрования секрета. Если не указывать ключ {{ kms-name }}, секрет будет зашифрован специальным системным ключом. Необязательный параметр.
     * `deletion_protection` — флаг защиты от удаления. Для включения защиты укажите значение `true`. Для отключения защиты — `false`. Значение по умолчанию `false`. Необязательный параметр.
     * `labels` — [метка](../../overview/concepts/services.md#labels) ресурса в формате `<ключ>:"<значение>"`. Необязательный параметр.

     Более подробную информацию о параметрах ресурса `yandex_lockbox_secret` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}Resources/lockbox_secret).
  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  После этого в указанном каталоге будет создан секрет. Проверить появление секрета и его настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/):

  ```bash
  yc lockbox secret get <имя_секрета>
  ```

- API {#api}

  Чтобы создать секрет, воспользуйтесь методом REST API [create](../../lockbox/api-ref/Secret/create.md) для ресурса [Secret](../../lockbox/api-ref/Secret/index.md) или вызовом gRPC API [SecretService/Create](../../lockbox/api-ref/grpc/Secret/create.md).

{% endlist %}