# Удаление бакета

{% note warning %}

Удалить можно только пустой бакет. В консоли управления информация о количестве объектов в бакете обновляется с задержкой в несколько минут.

{% endnote %}

Чтобы удалить бакет, в который [записываются логи](../../concepts/server-logs.md) другого бакета, в настройках исходного бакета [выключите механизм логирования](enable-logging.md#stop-logging) или выберите другой целевой бакет для хранения логов.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. Перейдите в сервис **Object Storage**.
  1. Выберите нужный бакет и нажмите ![image](../../../_assets/console-icons/ellipsis.svg) → ![image](../../../_assets/console-icons/trash-bin.svg) **Удалить**.
  1. В открывшемся окне нажмите **Удалить**.

  {% note info %}
  
  Работать одновременно с несколькими бакетами удобнее с помощью файловых браузеров [CyberDuck](../../tools/cyberduck.md) и [WinSCP](../../tools/winscp.md) или с помощью [AWS CLI](../../tools/aws-cli.md).
  
  {% endnote %}

- Yandex Cloud CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для удаления бакета:

      ```bash
      yc storage bucket delete --help
      ```

  1. Получите список бакетов в каталоге по умолчанию:
     
     ```bash
     yc storage bucket list
     ```
     
     Результат:
     
     ```text
     +------------------+----------------------+-------------+-----------------------+---------------------+
     |       NAME       |      FOLDER ID       |  MAX SIZE   | DEFAULT STORAGE CLASS |     CREATED AT      |
     +------------------+----------------------+-------------+-----------------------+---------------------+
     | first-bucket     | b1gmit33ngp6******** | 53687091200 | STANDARD              | 2022-12-16 13:58:18 |
     +------------------+----------------------+-------------+-----------------------+---------------------+
     ```
  1. Сохраните имя бакета (столбец `NAME`), который нужно удалить.
  1. Удалите бакет:

      ```bash
      yc storage bucket delete --name <имя_бакета>
      ```

      Где `--name` — имя бакета, который нужно удалить.

      {% note info %}
      
      Работать одновременно с несколькими бакетами удобнее с помощью файловых браузеров [CyberDuck](../../tools/cyberduck.md) и [WinSCP](../../tools/winscp.md) или с помощью [AWS CLI](../../tools/aws-cli.md).
      
      {% endnote %}

- AWS CLI {#aws-cli}

  Если у вас еще нет интерфейса командной строки AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).

  В терминале выполните команду `aws s3api delete-bucket`:

  ```bash
  aws s3api delete-bucket \
    --endpoint-url=https://storage.yandexcloud.net \
    --bucket <имя_бакета>
  ```

  Где:
  * `--bucket` — имя бакета, который нужно удалить.
  * `--endpoint-url` — эндпоинт Object Storage.

  Также вы можете использовать команду `aws s3 rb`:

  ```bash
  aws --endpoint-url=https://storage.yandexcloud.net \
    s3 rb s3://<имя_бакета>
  ```

  Чтобы одновременно удалить несколько бакетов, выполните команду:

  {% note info %}
  
  Авторизация в [Amazon S3 HTTP API](../../s3/index.md) и [инструментах с его поддержкой](../../tools/index.md) осуществляется с помощью [статических ключей](../../../iam/concepts/authorization/access-key.md), полученных для [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md).
  
  Вы можете просматривать список бакетов только в том каталоге, в котором был создан используемый сервисный аккаунт.
  
  {% endnote %}

  * **Bash:**

    ```bash
    aws s3api list-buckets \
      --endpoint-url=https://storage.yandexcloud.net \
      --query '<запрос>' \
      --output text | xargs -I {} aws s3api delete-bucket --endpoint-url=https://storage.yandexcloud.net --bucket {}
    ```

    Где `--query` — запрос в формате [JMESPath](https://jmespath.org/).

    Пример команды для удаления всех бакетов, имена которых начинаются на `samplebucket`:

    ```bash
    aws s3api list-buckets \
      --endpoint-url=https://storage.yandexcloud.net \
      --query 'Buckets[?starts_with(Name, `samplebucket`) == `true`].[Name]' \
      --output text | xargs -I {} aws s3api delete-bucket --endpoint-url=https://storage.yandexcloud.net --bucket {}
    ```

  * **PowerShell:**

    ```powershell
    Foreach($x in (aws s3api list-buckets `
      --endpoint-url=https://storage.yandexcloud.net `
      --query '<запрос>' `
      --output text)) `
      {aws s3api delete-bucket `
      --endpoint-url=https://storage.yandexcloud.net `
      --bucket $x}
    ```

    Где `--query` — запрос в формате [JMESPath](https://jmespath.org/).

    Пример команды для удаления всех бакетов, имена которых начинаются на `samplebucket`:

    ```powershell
    Foreach($x in (aws s3api list-buckets `
      --endpoint-url=https://storage.yandexcloud.net `
      --query 'Buckets[?starts_with(Name, `samplebucket`) == `true`].[Name]' `
      --output text)) `
      {aws s3api delete-bucket `
      --endpoint-url=https://storage.yandexcloud.net `
      --bucket $x}
    ```

- Terraform {#tf}

  {% note info %}
  
  Если вы работаете с Object Storage через Terraform от имени [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md), [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту нужную [роль](../../security/index.md#roles-list), например `storage.admin`, на каталог, в котором будут создаваться ресурсы.
  
  {% endnote %}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  
  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.



  Чтобы удалить бакет, созданный с помощью Terraform:
  1. Откройте файл конфигураций Terraform и удалите фрагмент с описанием бакета.

     {% cut "Пример описания бакета в конфигурации Terraform" %}

     ```hcl
     ...
     resource "yandex_storage_bucket" "test" {
       access_key = "YCAJEX9Aw2ge********-w-lJ"
       secret_key = "YCONxG7rSdz********_NRy5VbKzKlqZ********"
       bucket     = "<имя_бакета>"
     }
     ...
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

     Проверить изменения можно в [консоли управления](https://console.yandex.cloud).

- API {#api}

  Чтобы удалить бакет, воспользуйтесь методом REST API [delete](../../api-ref/Bucket/delete.md) для ресурса [Bucket](../../api-ref/Bucket/index.md), вызовом gRPC API [BucketService/Delete](../../api-ref/grpc/Bucket/delete.md) или методом S3 API [deleteBucket](../../s3/api-ref/bucket/delete.md).

  {% note info %}
  
  Работать одновременно с несколькими бакетами удобнее с помощью файловых браузеров [CyberDuck](../../tools/cyberduck.md) и [WinSCP](../../tools/winscp.md) или с помощью [AWS CLI](../../tools/aws-cli.md).
  
  {% endnote %}

{% endlist %}