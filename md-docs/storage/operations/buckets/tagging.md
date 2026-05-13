# Управление метками бакета

[Метки бакетов](../../concepts/tags.md) — это пары ключ-значение для логической маркировки бакетов.

{% note info %}

В терминологии Yandex Cloud для логической маркировки ресурсов используется понятие _метка_ (_label_). Object Storage поддерживает совместимость с [Amazon S3 API](https://docs.aws.amazon.com/AmazonS3/latest/API/Welcome.html), поэтому в командах для [AWS CLI](../../tools/aws-cli.md) и в параметрах [API](../../s3/index.md) применяется термин AWS — _тег_ (_tag_).

{% endnote %}

## Добавить или изменить метки {#add-edit-tag}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Object Storage**.
  1. Выберите бакет, в котором нужно добавить или изменить метки.
  1. На панели слева выберите ![image](../../../_assets/console-icons/wrench.svg) **Настройки**.
  1. Выберите вкладку **Основные**.
  1. Нажмите кнопку **Добавить метку**.
  1. Введите метку в формате `ключ: значение`. Чтобы изменить существующую метку, введите ее ключ и новое значение.
  1. Нажмите **Enter**.
  1. Нажмите кнопку **Сохранить**.

- Yandex Cloud CLI {#cli}

  {% note warning %}
  
  В результате изменения настроек бакета существующий набор меток будет полностью перезаписан новым набором меток.
  
  {% endnote %}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для изменения настроек бакета:

       ```bash
       yc storage bucket update --help
       ```

  1. Получите список бакетов в каталоге по умолчанию:

      ```bash
      yc storage bucket list
      ```

      Результат:

      ```text
      +------------------+----------------------+----------+-----------------------+---------------------+
      |       NAME       |      FOLDER ID       | MAX SIZE | DEFAULT STORAGE CLASS |     CREATED AT      |
      +------------------+----------------------+----------+-----------------------+---------------------+
      | my-bucket        | b1gmit33ngp3******** | 10       | STANDARD              | 2022-12-16 13:58:18 |
      +------------------+----------------------+----------+-----------------------+---------------------+
      ```

  1. Добавьте метки, указав имя нужного бакета:

      ```bash
      yc storage bucket update <имя_бакета> \
        --tags <ключ_метки_1>=<значение_метки_1>,<ключ_метки_2>=<значение_метки_2>,...,<ключ_метки_n>=<значение_метки_n>
      ```

      Где `--tags` — параметр для перечисления меток бакета в формате `ключ=значение`.

      Результат:

      ```text
      name: my-bucket
      folder_id: b1gmit33ngp3********
      default_storage_class: STANDARD
      versioning: VERSIONING_ENABLED
      acl: {}
      created_at: "2023-04-24T14:15:28.240705Z"
      tags:
        - key: key-tag
          value: key-value
      ```

- AWS CLI {#aws-cli}

  {% note warning %}
  
  В результате изменения настроек бакета существующий набор меток будет полностью перезаписан новым набором меток.
  
  {% endnote %}

  Если у вас еще нет интерфейса командной строки AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).

  В терминале выполните команду:

  ```bash
  aws s3api put-bucket-tagging \
    --bucket <имя_бакета> \
    --tagging 'TagSet=[{Key=<ключ_метки>,Value=<значение_метки>},{Key=<ключ_метки>,Value=<значение_метки>}]' \
    --endpoint-url=https://storage.yandexcloud.net
  ```

  Где:
  * `--bucket` — имя бакета.
  * `--tagging` — массив меток бакета, где:
    * `Key` — ключ метки, тип: `string`.
    * `Value` — значение метки, тип: `string`.
  * `--endpoint-url` — эндпоинт Object Storage.

- Terraform {#tf}

  {% note warning %}
  
  В результате изменения настроек бакета существующий набор меток будет полностью перезаписан новым набором меток.
  
  {% endnote %}

  {% note info %}
  
  Если вы работаете с Object Storage через Terraform от имени [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md), [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту нужную [роль](../../security/index.md#roles-list), например `storage.admin`, на каталог, в котором будут создаваться ресурсы.
  
  {% endnote %}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).


  1. Откройте файл конфигурации Terraform и добавьте блок `tags` во фрагмент с описанием бакета:

      ```hcl
      resource "yandex_storage_bucket" "test-bucket" {
        bucket           = "<имя_бакета>"
        ...
        tags             = {
          <ключ_метки_1> = "<значение_метки_1>"
          <ключ_метки_2> = "<значение_метки_2>"
        }
        ...
      }
      ```

      Где `tags` — массив меток бакета в формате `<ключ> = "<значение>"`.

      Более подробную информацию о параметрах ресурса `yandex_storage_bucket` в Terraform, см. в [документации провайдера](../../../terraform/resources/storage_bucket.md).

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

  После этого к бакету будут добавлены метки. Проверить появление меток и настройки бакета можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/quickstart.md):

  ```bash
  yc storage bucket get <имя_бакета> --full
  ```

- API {#api}

  {% note warning %}
  
  В результате изменения настроек бакета существующий набор меток будет полностью перезаписан новым набором меток.
  
  {% endnote %}

  Чтобы добавить или изменить метки бакета, воспользуйтесь методом REST API [update](../../api-ref/Bucket/update.md) для ресурса [Bucket](../../api-ref/Bucket/index.md), вызовом gRPC API [BucketService/Update](../../api-ref/grpc/Bucket/update.md) или методом S3 API [putBucketTagging](../../s3/api-ref/bucket/putbuckettagging.md).

  **Пример вызова gRPC API**

  ```bash
  export IAM_TOKEN="<IAM-токен>"
  grpcurl \
    -H "Authorization: Bearer $IAM_TOKEN" \
    -d '{"name": "test-bucket", "update_mask": {"paths": ["tags"]}, "tags": [{"key": "test-key", "value": "test-value"}]}' \
    storage.api.cloud.yandex.net:443 \
    yandex.cloud.storage.v1.BucketService/Update 
  ```

  Где:
  * `IAM_TOKEN` — [IAM-токен](../../../iam/concepts/authorization/iam-token.md).
  * `name` — имя бакета.
  * `update_mask` — перечень параметров бакета, которые вы хотите изменить.
  * `tags` — перечень меток бакета.
  * `key` — ключ метки.
  * `value` — значение метки.

  Результат:

  ```json
  {
    "id": "e3e5fsr6076bo*******",
    "description": "update bucket",
    "createdAt": "2023-04-27T12:01:03.636597Z",
    "createdBy": "ajelcjkv67arb*******",
    "modifiedAt": "2023-04-27T12:01:03.636597Z",
    "done": true,
    "metadata": {"@type":"type.googleapis.com/yandex.cloud.storage.v1.UpdateBucketMetadata","name":"test-bucket"},
    "response": {"@type":"type.googleapis.com/yandex.cloud.storage.v1.Bucket","acl":{},"createdAt":"2023-03-27T08:23:26.890770Z","defaultStorageClass":"STANDARD","folderId":"b1gsm0k26v1l2*******","maxSize":"53687091200","name":"test-bucket","tags":[{"key":"test-key","value":"test-value"}],"versioning":"VERSIONING_DISABLED"}
  }
  ```

{% endlist %}

## Посмотреть метки {#get-tag}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Object Storage**.
  1. Выберите нужный бакет из списка.
  1. На панели слева выберите ![image](../../../_assets/console-icons/wrench.svg) **Настройки**.
  1. Выберите вкладку **Основные**.

- Yandex Cloud CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для получения информации о бакете:

      ```bash
      yc storage bucket get --help
      ```

  1. Получите список бакетов в каталоге по умолчанию:

      ```bash
      yc storage bucket list
      ```

      Результат:

      ```text
       +------------------+----------------------+----------+-----------------------+---------------------+
       |       NAME       |      FOLDER ID       | MAX SIZE | DEFAULT STORAGE CLASS |     CREATED AT      |
       +------------------+----------------------+----------+-----------------------+---------------------+
       | my-bucket        | b1gmit33ngp3******** | 10       | STANDARD              | 2022-12-16 13:58:18 |
       +------------------+----------------------+----------+-----------------------+---------------------+
      ```

  1. Получите информацию о метках, указав имя нужного бакета:

      ```bash
      yc storage bucket get <имя_бакета> --full
      ```

      Результат:

      ```text
      name: my-bucket
      folder_id: b1gmit33ngp3********
      default_storage_class: STANDARD
      ...
      tags:
        - key: key-tag
          value: key-value
      ...
      ```

- AWS CLI {#aws-cli}

  Если у вас еще нет интерфейса командной строки AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).

  В терминале выполните команду:

  ```bash
  aws s3api get-bucket-tagging \
    --bucket <имя_бакета> \
    --endpoint-url=https://storage.yandexcloud.net
  ```

  Где:
  * `--bucket` — имя бакета.
  * `--endpoint-url` — эндпоинт Object Storage.

  Результат:

  ```json
  {
      "TagSet": [
          {
              "Key": "test-key-1",
              "Value": "test-value-1"
          },
          {
              "Key": "test-key-2",
              "Value": "test-value-2"
          }
      ]
  }
  ```  

- API {#api}

  Чтобы посмотреть метки бакета, воспользуйтесь методом REST API [get](../../api-ref/Bucket/get.md) для ресурса [Bucket](../../api-ref/Bucket/index.md), вызовом gRPC API [BucketService/Get](../../api-ref/grpc/Bucket/get.md) или методом S3 API [getBucketTagging](../../s3/api-ref/bucket/getbuckettagging.md).

  **Пример вызова gRPC API**

  ```bash
  export IAM_TOKEN="<IAM-токен>"
  grpcurl \
    -H "Authorization: Bearer $IAM_TOKEN" \
    -d '{"name": "test-bucket", "view": "VIEW_FULL"}' \
    storage.api.cloud.yandex.net:443 \
    yandex.cloud.storage.v1.BucketService/Get 
  ```

  Где:
  * `IAM_TOKEN` — [IAM-токен](../../../iam/concepts/authorization/iam-token.md).
  * `name` — имя бакета.
  * `view` — объем предоставляемой информации, `VIEW_FULL` — полная информация о бакете.
 
  Результат:

  ```json
  {
    "name": "test-bucket",
    "folderId": "b1gsm0k26v1l2*******",
    "anonymousAccessFlags": {
      "read": true,
      "list": true,
      "configRead": true
    },
    "defaultStorageClass": "STANDARD",
    "versioning": "VERSIONING_DISABLED",
    "maxSize": "53687091200",
    "acl": {

    },
    "createdAt": "2023-03-27T08:23:26.890770Z",
    "websiteSettings": {
      "redirectAllRequests": {

      }
    },
    "tags": [
      {
        "key": "test-key",
        "value": "test-value"
      }
    ]
  }
  ```

{% endlist %}

## Удалить метки {#delete-tag}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Object Storage**.
  1. Выберите нужный бакет из списка.
  1. На панели слева выберите ![image](../../../_assets/console-icons/wrench.svg) **Настройки**.
  1. Выберите вкладку **Основные**.
  1. Напротив нужной метки нажмите значок ![image](../../../_assets/console-icons/xmark.svg).
  1. Нажмите кнопку **Сохранить**.

- Yandex Cloud CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для изменения настроек бакета:

      ```bash
      yc storage bucket update --help
      ```

  1. Получите список бакетов в каталоге по умолчанию:

      ```bash
      yc storage bucket list
      ```

      Результат:

      ```text
      +------------------+----------------------+----------+-----------------------+---------------------+
      |       NAME       |      FOLDER ID       | MAX SIZE | DEFAULT STORAGE CLASS |     CREATED AT      |
      +------------------+----------------------+----------+-----------------------+---------------------+
      | my-bucket        | b1gmit33ngp3******** | 10       | STANDARD              | 2022-12-16 13:58:18 |
      +------------------+----------------------+----------+-----------------------+---------------------+
      ```

  1. Удалите метки, указав имя нужного бакета:

      ```bash
      yc storage bucket update <имя_бакета> \
        --remove-tags
      ```

      Результат:

      ```text
      name: my-bucket
      folder_id: b1gmit33ngp3********
      default_storage_class: STANDARD
      versioning: VERSIONING_ENABLED
      acl: {}
      created_at: "2023-04-24T14:15:28.240705Z"
      ```

- AWS CLI {#aws-cli}

  Если у вас еще нет интерфейса командной строки AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).

  В терминале выполните команду:

  ```bash
  aws s3api delete-bucket-tagging \
    --bucket <имя_бакета> \
    --endpoint-url=https://storage.yandexcloud.net
  ```

  Где:
  * `--bucket` — имя бакета.
  * `--endpoint-url` — эндпоинт Object Storage.

- Terraform {#tf}

  {% note info %}
  
  Если вы работаете с Object Storage через Terraform от имени [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md), [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту нужную [роль](../../security/index.md#roles-list), например `storage.admin`, на каталог, в котором будут создаваться ресурсы.
  
  {% endnote %}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).


  1. Откройте файл конфигурации Terraform и удалите блок `tags` из фрагмента с описанием бакета.

     {% cut "Пример описания тегов бакета в конфигурации Terraform" %}

      ```hcl
      resource "yandex_storage_bucket" "test-bucket" {
        bucket           = "<имя_бакета>"
        ...
        tags             = {
          <ключ_метки_1> = "<значение_метки_1>"
          <ключ_метки_2> = "<значение_метки_2>"
        }
        ...
      }
      ```

     {% endcut %}

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

  После этого метки бакета будут удалены. Проверить удаление меток и настройки бакета можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/quickstart.md):

  ```bash
  yc storage bucket get <имя_бакета> --full
  ```

- API {#api}

  Чтобы удалить метки бакета, воспользуйтесь методом REST API [update](../../api-ref/Bucket/update.md) для ресурса [Bucket](../../api-ref/Bucket/index.md), вызовом gRPC API [BucketService/Update](../../api-ref/grpc/Bucket/update.md) или методом S3 API [deleteBucketTagging](../../s3/api-ref/bucket/deletebuckettagging.md).

  **Пример вызова gRPC API**

  ```bash
  export IAM_TOKEN="<IAM-токен>"
  grpcurl \
    -H "Authorization: Bearer $IAM_TOKEN" \
    -d '{"name": "test-bucket", "update_mask": {"paths": ["tags"]}, "tags": []}' \
    storage.api.cloud.yandex.net:443 \
    yandex.cloud.storage.v1.BucketService/Update 
  ```

  Где:
  * `IAM_TOKEN` — [IAM-токен](../../../iam/concepts/authorization/iam-token.md).
  * `name` — имя бакета.
  * `update_mask` — перечень параметров бакета, которые вы хотите изменить.
  * `tags` — перечень меток бакета.

  Результат:

  ```json
  {
    "id": "e3epc33apcche*******",
    "description": "update bucket",
    "createdAt": "2023-04-27T12:18:18.885391Z",
    "createdBy": "ajelcjkv67arb*******",
    "modifiedAt": "2023-04-27T12:18:18.885391Z",
    "done": true,
    "metadata": {"@type":"type.googleapis.com/yandex.cloud.storage.v1.UpdateBucketMetadata","name":"test-bucket-777"},
    "response": {"@type":"type.googleapis.com/yandex.cloud.storage.v1.Bucket","acl":{},"createdAt":"2023-03-27T08:23:26.890770Z","defaultStorageClass":"STANDARD","folderId":"b1gsm0k26v1l2*******","maxSize":"53687091200","name":"test-bucket-777","versioning":"VERSIONING_DISABLED"}
  }
  ```

{% endlist %}