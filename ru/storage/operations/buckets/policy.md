# Управление политикой доступа (bucket policy)

[Политики доступа (bucket policy)](../../concepts/policy.md) устанавливают права на действия с бакетами, объектами и группами объектов.

## Применить или изменить политику {#apply-policy}

Минимально необходимая роль для применения или изменения политики доступа — `storage.configurer`. См. [описание роли](../../../storage/security/#storage-configurer).

Для применения или изменения политики доступа к бакету:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно настроить политику доступа для бакета.
  1. Выберите сервис **{{ objstorage-name }}**.
  1. Выберите бакет в списке.
  1. Перейдите на вкладку **{{ ui-key.yacloud.storage.bucket.switch_policy }}** в меню слева.
  1. Нажмите кнопку ![pencil](../../../_assets/pencil.svg) **{{ ui-key.yacloud.storage.bucket.policy.button_policy-edit }}**.
  1. Введите идентификатор политики доступа.
  1. Настройте правило:
     1. Введите идентификатор правила.
	 1. Настройте параметры правила:
        * **{{ ui-key.yacloud.storage.bucket.policy.field_effect }}** — разрешить или запретить.
	    * **{{ ui-key.yacloud.storage.bucket.policy.field_principal-type }}** — включить или исключить пользователей.
	    * **{{ ui-key.yacloud.storage.bucket.policy.field_user }}** — все пользователи или набор конкретных пользователей.
	    * **{{ ui-key.yacloud.storage.bucket.policy.field_action }}**, для которого создается правило. Вы также можете выбрать опцию **Все действия**.
	    * **{{ ui-key.yacloud.storage.bucket.policy.field_resource }}** — по умолчанию указан выбранный бакет. Чтобы добавить другие ресурсы в правило, нажмите кнопку **{{ ui-key.yacloud.storage.bucket.policy.button_add-resource }}**.
     1. При необходимости добавьте условие для правила:
        * Выберите **{{ ui-key.yacloud.storage.bucket.policy.field_key }}** из списка.
        * Выберите **{{ ui-key.yacloud.storage.bucket.policy.field_operator }}** из списка. Чтобы оператор действовал в существующих полях, выберите опцию **{{ ui-key.yacloud.storage.bucket.policy.label_if-exists }}**. Тогда, если поля не существует, условие будет считаться выполненным.
        * Введите **{{ ui-key.yacloud.storage.bucket.policy.field_value }}**.
	    * Нажмите кнопку **{{ ui-key.yacloud.storage.bucket.policy.button_add-value }}**, чтобы добавить дополнительное значение в условие.
  1. При необходимости добавьте правила и настройте их.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.permissions-dialog.button_save }}**.

- {{ yandex-cloud }} CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для редактирования ACL бакета:

     ```bash
     yc storage bucket update --help
     ```  
  
  1. Опишите конфигурацию политики доступа в виде [схемы данных](../../s3/api-ref/policy/scheme.md) в формате JSON:

     ```json
     {
       "Version": "2012-10-17",
       "Statement": {
         "Effect": "Allow",
         "Principal": "*",
         "Action": "s3:GetObject",
         "Resource": "arn:aws:s3:::<имя бакета>/*",
         "Condition": {
           "Bool": {
             "aws:SecureTransport": "true"
           }
         }
       }
     }
     ```

  1. Выполните команду:

     ```bash
     yc storage bucket update <имя_бакета> --policy-from-file <путь_к_файлу_с_политиками>
     ```
     Результат:

     ```bash
     name: my-bucket
     folder_id: csgeoelk7fl15s6dsvbo
     default_storage_class: STANDARD
     versioning: VERSIONING_SUSPENDED
     max_size: "10737418240"
     policy:
         Statement:
           Action: s3:GetObject
           Condition:
             Bool:
               aws:SecureTransport: "true"
             Effect: Allow
             Principal: '*'
             Resource: arn:aws:s3:::my-bucket
           Version: "2012-10-17"
     acl: {}
     created_at: "2022-12-14T08:42:16.273717Z"
     ```

- AWS CLI

  {% note info %}

  Для управления политикой доступа с помощью AWS CLI сервисному аккаунту должна быть назначена роль `storage.admin`.

  {% endnote %}

  Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).

  1. Опишите конфигурацию политики доступа в виде [схемы данных](../../s3/api-ref/policy/scheme.md) формата JSON:

     ```json
     {
       "Version": "2012-10-17",
       "Statement": {
         "Effect": "Allow",
         "Principal": "*",
         "Action": "s3:GetObject",
         "Resource": "arn:aws:s3:::<имя бакета>/*",
         "Condition": {
           "Bool": {
             "aws:SecureTransport": "true"
           }
         }
       }
     }
     ```

     Сохраните готовую конфигурацию в файле `policy.json`.
  1. Выполните команду:

     ```bash
     aws --endpoint https://{{ s3-storage-host }} s3api put-bucket-policy \
       --bucket <имя бакета> \
       --policy file://policy.json
     ```

  Если ранее для бакета уже была установлена политика доступа, то после применения новой политики она будет полностью перезаписана.

- {{ TF }}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Получите [статические ключи доступа](../../../iam/operations/sa/create-access-key.md) — секретный ключ и идентификатор ключа, используемые для аутентификации в {{ objstorage-name }}.
  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     ```hcl
     resource "yandex_storage_bucket" "b" {
       bucket = "my-policy-bucket"
       policy = <<POLICY
      {
       "Version": "2012-10-17",
       "Statement": [
         {
           "Effect": "Allow",
           "Principal": "*",
           "Action": "s3:*",
           "Resource": [
             "arn:aws:s3:::my-policy-bucket/*",
             "arn:aws:s3:::my-policy-bucket"
           ]
         },
         {
           "Effect": "Deny",
           "Principal": "*",
           "Action": "s3:PutObject",
           "Resource": [
             "arn:aws:s3:::my-policy-bucket/*",
             "arn:aws:s3:::my-policy-bucket"
           ]
         }
       ]
     }
     POLICY
     }
     ```

     Где:
     * `access_key` — идентификатор статического ключа доступа.
     * `secret_key` — значение секретного ключа доступа.
     * `bucket` — имя бакета. Обязательный параметр.
     * `policy` — имя политики. Обязательный параметр.

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/).
  1. Проверьте корректность конфигурационных файлов.
     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Разверните облачные ресурсы.
     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание ресурсов.

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

- API

  Воспользуйтесь методом [PutBucketPolicy](../../s3/api-ref/policy/put.md). Если ранее для бакета уже была установлена политика доступа, то после применения новой политики она будет полностью перезаписана.

{% endlist %}

## Просмотреть политику {#view-policy}

Минимально необходимая роль для просмотра политики доступа — `storage.configViewer`. См. [описание роли](../../../storage/security/#storage-config-viewer).

Чтобы просмотреть примененную к бакету политику доступа:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно просмотреть политику доступа для бакета.
  1. Выберите сервис **{{ objstorage-name }}**.
  1. Выберите бакет в списке.
  1. Перейдите на вкладку **{{ ui-key.yacloud.storage.bucket.switch_policy }}** в меню слева.

- AWS CLI

  Выполните следующую команду:

  ```bash
  aws --endpoint https://{{ s3-storage-host }} s3api get-bucket-policy \
    --bucket <имя бакета> \
    --output text
  ```

  Результат:

  ```json
  {
    "Policy": "{\"Version\":\"2012-10-17\",\"Statement\":{\"Effect\":\"Allow\",\"Principal\":\"*\",\"Action\":\"s3:GetObject\",\"Resource\":\"arn:aws:s3:::<имя бакета>/*\",\"Condition\":{\"Bool\":{\"aws:SecureTransport\":\"true\"}}}}"
  }
  ```

  Подробнее о параметрах читайте в описании [схемы данных](../../s3/api-ref/policy/scheme.md).

- API

  Воспользуйтесь методом [GetBucketPolicy](../../s3/api-ref/policy/get.md).

{% endlist %}

## Удалить политику {#delete-policy}

Минимально необходимая роль для удаления политики доступа — `storage.configurer`. См. [описание роли](../../../storage/security/#storage-configurer).

Чтобы удалить политику доступа:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно настроить политику доступа для бакета.
  1. Выберите сервис **{{ objstorage-name }}**.
  1. Выберите бакет в списке.
  1. Перейдите на вкладку **{{ ui-key.yacloud.storage.bucket.switch_policy }}** в меню слева.
  1. Нажмите значок ![options](../../../_assets/horizontal-ellipsis.svg) и выберите **{{ ui-key.yacloud.storage.bucket.policy.button_policy-delete }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.bucket.button_action-delete }}**.

- AWS CLI

  Выполните следующую команду:

  ```bash
  aws --endpoint https://{{ s3-storage-host }} s3api delete-bucket-policy \
    --bucket <имя бакета>
  ```

- {{ TF }}

  Подробнее о {{ TF }} в [документации](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Если вы применили политику доступа к бакету при помощи {{ TF }}, вы можете удалить её:
  1. Найдите в конфигурационном файле параметры созданной ранее политики доступа, которую необходимо удалить:

     ```hcl
     resource "yandex_storage_bucket" "b" {
       bucket = "my-policy-bucket"
       policy = <<POLICY
      {
       "Version": "2012-10-17",
       "Statement": [
         {
           "Effect": "Allow",
           "Principal": "*",
           "Action": "s3:*",
           "Resource": [
             "arn:aws:s3:::my-policy-bucket/*",
             "arn:aws:s3:::my-policy-bucket"
           ]
         },
         {
           "Effect": "Deny",
           "Principal": "*",
           "Action": "s3:PutObject",
           "Resource": [
             "arn:aws:s3:::my-policy-bucket/*",
             "arn:aws:s3:::my-policy-bucket"
           ]
         }
       ]
     }
     POLICY
     }
     ```

  1. Удалите поле `policy` с описанием параметров политики доступа из конфигурационного файла.
  1. Проверьте корректность конфигурационных файлов.
     1. В командной строке перейдите в папку, где вы редактировали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров без удаляемого описания политики доступа. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Удалите политику доступа.
     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Введите слово `yes` и нажмите **Enter**.

     После этого в указанном каталоге будет удалена политика доступа к бакету. Проверить отсутствие политики доступа можно в [консоли управления]({{ link-console-main }}).

- API

  Воспользуйтесь методом [DeleteBucketPolicy](../../s3/api-ref/policy/delete.md).

{% endlist %}
