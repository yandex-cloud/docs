{% note info %}

На уровне [политики доступа](../../storage/concepts/policy.md) можно разрешить доступ в бакет из сервисных подключений {{ vpc-short-name }} с идентификаторами, указанными в политике. Однако, согласно [схеме механизмов доступа](../../storage/security/overview.md#scheme), все еще остается возможность доступа в бакет из публичной сети, например с помощью [ACL](../../storage/concepts/acl.md) объекта или при наличии другого разрешающего правила в политике.

Также при такой настройке остается возможность [копирования объектов на стороне сервера (Server Side Copy)](../../storage/operations/objects/copy.md) в такой бакет и из него.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы настроили сервисное подключение {{ vpc-short-name }}.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ objstorage-name }}**.
  1. Выберите бакет в списке.
  1. Перейдите на вкладку ![image](../../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud.storage.bucket.switch_security }}** в меню слева.
  1. В верхней части экрана перейдите на вкладку **{{ ui-key.yacloud.storage.bucket.switch_policy }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.bucket.policy.button_policy-edit }}**.
  1. Введите идентификатор политики доступа, например `private-endpoint-policy`.
  1. Настройте правило:

      1. Введите идентификатор правила, например `private-endpoint-rule`.
      1. Настройте параметры правила:
          * **{{ ui-key.yacloud.storage.bucket.policy.field_effect }}** — разрешить.
          * **{{ ui-key.yacloud.storage.bucket.policy.field_principal-type }}** — включить пользователей.
          * **{{ ui-key.yacloud.storage.bucket.policy.field_user }}** — все пользователи.
          * **{{ ui-key.yacloud.storage.bucket.policy.field_action }}** — выберите опцию **Все действия**.
          * **{{ ui-key.yacloud.storage.bucket.policy.field_resource }}** — `<имя_бакета>/*`.

            Нажмите кнопку **{{ ui-key.yacloud.storage.bucket.policy.button_add-resource }}** и введите `<имя_бакета>`.

            {% note info %}

            {% include [policy-bucket-objects](policy-bucket-objects.md) %}

            {% endnote %}

      1. Добавьте [условие](../../storage/s3/api-ref/policy/conditions.md) для правила:

          * В поле **{{ ui-key.yacloud.storage.bucket.policy.field_key }}** выберите `private-endpoint-id`.
          * В поле **{{ ui-key.yacloud.storage.bucket.policy.field_operator }}** выберите `StringEquals`.
          * В поле **{{ ui-key.yacloud.storage.bucket.policy.field_value }}** укажите идентификатор сервисного подключения (Private Endpoint), например `enpd7rq1s3f5********`.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения настроек бакета:

      ```bash
      yc storage bucket update --help
      ```

  1. Опишите конфигурацию политики доступа в виде [схемы данных](../../storage/s3/api-ref/policy/scheme.md) формата JSON:

      {% include [policy-scheme-json](../vpc/policy-scheme-json.md) %}

  1. Сохраните готовую конфигурацию в файле `policy.json`.
  1. Выполните команду:

      ```bash
      yc storage bucket update \
        --name <имя_бакета> \
        --policy-from-file <путь_к_файлу_с_политикой>
      ```

      После успешного применения политики доступа подключение к бакету будет возможно только из облачной сети {{ vpc-short-name }}, в которой было создано соответствующее сервисное подключение (Private Endpoint).

- AWS CLI {#aws-cli}

  {% note info %}

  Для управления политикой доступа с помощью AWS CLI сервисному аккаунту должна быть назначена [роль](../../storage/security/index.md#storage-admin) `storage.admin`.

  {% endnote %}

  Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../storage/tools/aws-cli.md).

  1. Опишите конфигурацию политики доступа в виде [схемы данных](../../storage/s3/api-ref/policy/scheme.md) формата JSON:

      {% include [policy-scheme-json](../vpc/policy-scheme-json.md) %}

  1. Сохраните готовую конфигурацию в файле `policy.json`.

  1. Выполните команду:

      ```bash
      aws s3api put-bucket-policy \
        --endpoint https://{{ s3-storage-host }} \
        --bucket <имя_бакета> \
        --policy file://policy.json
      ```

  После успешного применения политики доступа подключение к бакету будет возможно только из облачной сети {{ vpc-short-name }}, в которой было создано соответствующее сервисное подключение (Private Endpoint).

- {{ TF }} {#tf}

  {% include [terraform-install](../terraform-install.md) %}

  {% include [iam-auth-note](iam-auth-note.md) %}

  {% include [terraform-role](terraform-role.md) %}

  1. Откройте файл конфигурации {{ TF }} и задайте политику с помощью ресурса `yandex_storage_bucket_policy`:

     ```hcl
     resource "yandex_storage_bucket_policy" "bpolicy" {
       bucket = "my-policy-bucket"
       policy = <<POLICY
     {
       "Version": "2012-10-17",
       "Statement": {
         "Effect": "Allow",
         "Principal": "*",
         "Action": "*",
         "Resource": [
           "arn:aws:s3:::<имя_бакета>/*",
           "arn:aws:s3:::<имя_бакета>"
         ],
         "Condition": {
           "StringEquals": {
             "yc:private-endpoint-id": "<идентификатор_подключения>"
           }
         }
       }
     }
     POLICY
     }
     ```

     Где:
     * `<имя_бакета>` — имя бакета в {{ objstorage-name }}, к которому нужно применить политику доступа, например `my-s3-bucket`.
     * `<идентификатор_подключения>` — идентификатор сервисного подключения (Private Endpoint), например `enpd7rq1s3f5********`.

     Более подробную информацию о параметрах ресурса `yandex_storage_bucket_policy` см. в [документации провайдера]({{ tf-provider-resources-link }}/storage_bucket_policy).

  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     Проверить изменения можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  Чтобы настроить политику доступа для бакета, воспользуйтесь методом REST API [update](../../storage/api-ref/Bucket/update.md) для ресурса [Bucket](../../storage/api-ref/Bucket/index.md), вызовом gRPC API [BucketService/Update](../../storage/api-ref/grpc/Bucket/update.md) или методом S3 API [PutBucketPolicy](../../storage/s3/api-ref/policy/put.md). Если ранее для бакета уже была настроена политика доступа, то после применения новой политики она будет полностью перезаписана.

{% endlist %}

Подробная информация о работе с политикой доступа бакета изложена на странице [Управление политикой доступа](../../storage/operations/buckets/policy.md).