# Назначить политику доступа в Object Storage для сервисного подключения

{% note warning %}

Функциональность **Сервисные подключения** (VPC Private Endpoints) находится на стадии [Preview](../../overview/concepts/launch-stages.md). Чтобы запросить доступ, обратитесь к вашему аккаунт-менеджеру.

{% endnote %}


[Политики доступа (bucket policy)](../../storage/concepts/policy.md) устанавливают права на действия с [бакетами](../../storage/concepts/bucket.md), [объектами](../../storage/concepts/object.md) и группами объектов.

Минимально необходимая роль для применения или изменения политики доступа — `storage.configurer`. См. [описание роли](../../storage/security/index.md#storage-configurer).

Чтобы назначить политику доступа в Object Storage для [сервисного подключения](../concepts/private-endpoint.md):

{% note info %}

На уровне [политики доступа](../../storage/concepts/policy.md) можно разрешить доступ в бакет из сервисных подключений VPC с идентификаторами, указанными в политике. Однако, согласно [схеме механизмов доступа](../../storage/security/overview.md#scheme), все еще остается возможность доступа в бакет из публичной сети, например с помощью [ACL](../../storage/concepts/acl.md) объекта или при наличии другого разрешающего правила в политике.

Также при такой настройке остается возможность [копирования объектов на стороне сервера (Server Side Copy)](../../storage/operations/objects/copy.md) в такой бакет и из него.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы настроили сервисное подключение VPC.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Object Storage**.
  1. Выберите бакет в списке.
  1. Перейдите на вкладку ![image](../../_assets/console-icons/persons-lock.svg) **Безопасность** в меню слева.
  1. В верхней части экрана перейдите на вкладку **Политика доступа**.
  1. Нажмите кнопку **Настроить доступ**.
  1. Введите идентификатор политики доступа, например `private-endpoint-policy`.
  1. Настройте правило:

      1. Введите идентификатор правила, например `private-endpoint-rule`.
      1. Настройте параметры правила:
          * **Результат** — разрешить.
          * **Принцип выбора** — включить пользователей.
          * **Пользователь** — все пользователи.
          * **Действие** — выберите опцию **Все действия**.
          * **Ресурс** — `<имя_бакета>/*`.

            Нажмите кнопку **Добавить ресурс** и введите `<имя_бакета>`.

            {% note info %}

            Ресурс бакета не включает в себя ресурсы всех его объектов. Чтобы правило в политике доступа относилось к бакету и всем объектам, их нужно указать как отдельные ресурсы: например, `samplebucket` и `samplebucket/*`.

            {% endnote %}

      1. Добавьте [условие](../../storage/s3/api-ref/policy/conditions.md) для правила:

          * В поле **Ключ** выберите `private-endpoint-id`.
          * В поле **Оператор** выберите `StringEquals`.
          * В поле **Значение** укажите идентификатор сервисного подключения (Private Endpoint), например `enpd7rq1s3f5********`.
  1. Нажмите кнопку **Сохранить**.

- Yandex Cloud CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для изменения настроек бакета:

      ```bash
      yc storage bucket update --help
      ```

  1. Опишите конфигурацию политики доступа в виде [схемы данных](../../storage/s3/api-ref/policy/scheme.md) формата JSON:

      ```json
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
      ```
      
      Где:
      
      * `<имя_бакета>` — имя бакета в Object Storage, к которому нужно применить политику доступа, например `my-s3-bucket`.
      * `<идентификатор_подключения>` — идентификатор сервисного подключения (Private Endpoint), например `enpd7rq1s3f5********`.

  1. Сохраните готовую конфигурацию в файле `policy.json`.
  1. Выполните команду:

      ```bash
      yc storage bucket update \
        --name <имя_бакета> \
        --policy-from-file <путь_к_файлу_с_политикой>
      ```

      После успешного применения политики доступа подключение к бакету будет возможно только из облачной сети VPC, в которой было создано соответствующее сервисное подключение (Private Endpoint).

- AWS CLI {#aws-cli}

  {% note info %}

  Для управления политикой доступа с помощью AWS CLI сервисному аккаунту должна быть назначена [роль](../../storage/security/index.md#storage-admin) `storage.admin`.

  {% endnote %}

  Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../storage/tools/aws-cli.md).

  1. Опишите конфигурацию политики доступа в виде [схемы данных](../../storage/s3/api-ref/policy/scheme.md) формата JSON:

      ```json
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
      ```
      
      Где:
      
      * `<имя_бакета>` — имя бакета в Object Storage, к которому нужно применить политику доступа, например `my-s3-bucket`.
      * `<идентификатор_подключения>` — идентификатор сервисного подключения (Private Endpoint), например `enpd7rq1s3f5********`.

  1. Сохраните готовую конфигурацию в файле `policy.json`.

  1. Выполните команду:

      ```bash
      aws s3api put-bucket-policy \
        --endpoint https://storage.yandexcloud.net \
        --bucket <имя_бакета> \
        --policy file://policy.json
      ```

  После успешного применения политики доступа подключение к бакету будет возможно только из облачной сети VPC, в которой было создано соответствующее сервисное подключение (Private Endpoint).

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  По умолчанию для аутентификации в Object Storage Terraform использует IAM-токен. Кроме IAM-токена для аутентификации в Object Storage можно использовать сервисный аккаунт и статические ключи доступа. Более подробную информацию об особенностях аутентификации Terraform в Object Storage см. в [документации провайдера](../../terraform/resources/storage_bucket.md).

  {% note info %}
  
  Если вы работаете с Object Storage через Terraform от имени [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), [назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту нужную [роль](../../storage/security/index.md#roles-list), например `storage.admin`, на каталог, в котором будут создаваться ресурсы.
  
  {% endnote %}

  1. Откройте файл конфигурации Terraform и задайте политику с помощью ресурса `yandex_storage_bucket_policy`:

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
     * `<имя_бакета>` — имя бакета в Object Storage, к которому нужно применить политику доступа, например `my-s3-bucket`.
     * `<идентификатор_подключения>` — идентификатор сервисного подключения (Private Endpoint), например `enpd7rq1s3f5********`.

     Более подробную информацию о параметрах ресурса `yandex_storage_bucket_policy` см. в [документации провайдера](../../terraform/resources/storage_bucket_policy.md).

  1. Примените изменения:

     1. В терминале перейдите в директорию с конфигурационным файлом.
     1. Проверьте корректность конфигурации с помощью команды:
     
        ```bash
        terraform validate
        ```
     
        Если конфигурация является корректной, появится сообщение:
     
        ```bash
        Success! The configuration is valid.
        ```
     
     1. Выполните команду:
     
        ```bash
        terraform plan
        ```
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

     Проверить изменения можно в [консоли управления](https://console.yandex.cloud).

- API {#api}

  Чтобы настроить политику доступа для бакета, воспользуйтесь методом REST API [update](../../storage/api-ref/Bucket/update.md) для ресурса [Bucket](../../storage/api-ref/Bucket/index.md), вызовом gRPC API [BucketService/Update](../../storage/api-ref/grpc/Bucket/update.md) или методом S3 API [PutBucketPolicy](../../storage/s3/api-ref/policy/put.md). Если ранее для бакета уже была настроена политика доступа, то после применения новой политики она будет полностью перезаписана.

{% endlist %}

Подробная информация о работе с политикой доступа бакета изложена на странице [Управление политикой доступа](../../storage/operations/buckets/policy.md).