# Настроить параметры сервиса метаданных ВМ

Настроить параметры [сервиса метаданных](../../concepts/vm-metadata.md#metadata-formats) виртуальной машины можно при ее [создании](../index.md#vm-create) или [изменении](../vm-control/vm-update.md).

Чтобы настроить параметры сервиса метаданных ВМ:

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для изменения параметров ВМ:

     ```bash
     yc compute instance update --help
     ```

  1. Получите список ВМ в каталоге по умолчанию:

     ```bash
     yc compute instance list
     ```

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной ВМ.
  1. Задайте настройки сервиса метаданных:

     ```bash
     yc compute instance update <идентификатор_ВМ> \
       --metadata-options gce-http-endpoint=enabled
     ```

     Где `--metadata-options` — параметр, устанавливающий настройки сервиса метаданных виртуальной машины. Возможные значения:
     * `gce-http-endpoint` — параметр управляет доступом к метаданным с использованием формата Google Compute Engine. Возможные значения: `enabled`, `disabled`.
     * `gce-http-token` — параметр управляет доступом к получению через метаданные Google Compute Engine [IAM-токена](../../../iam/concepts/authorization/iam-token.md) сервисного аккаунта, подключенного к ВМ. Возможные значения: `enabled`, `disabled`.

     Подробнее см. в разделе [{#T}](../../concepts/vm-metadata.md#metadata-formats).

  Чтобы настроить параметры сервиса метаданных ВМ при создании, аналогичным образом используйте параметр `--metadata-options` в [команде](../../../cli/cli-ref/compute/cli-ref/instance/create.md) `yc compute instance create`.

- {{ TF }} {#tf}

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  1. Откройте файл конфигурации {{ TF }} и задайте параметр `metadata_options` в описании ВМ:

     ```hcl
     ...
     resource "yandex_compute_instance" "test-vm" {
       ... 
       metadata_options {
         gce_http_endpoint    = 0
         gce_http_token       = 0
       }
       ...
     }
     ...
     ```

     Где:
     * `yandex_compute_instance` — описание ВМ:
       * `metadata_options` — параметры метаданных:
         * `gce_http_endpoint` — параметр управляет доступом к метаданным с использованием формата Google Compute Engine. Возможные значения: `0` и `1` — `enabled`, `2` — `disabled`.
         * `gce_http_token` — параметр управляет доступом к получению через метаданные Google Compute Engine [IAM-токена](../../../iam/concepts/authorization/iam-token.md) сервисного аккаунта, подключенного к ВМ. Возможные значения: `0` и `1` — `enabled`, `2` — `disabled`.

       Подробнее см. в разделе [{#T}](../../concepts/vm-metadata.md#metadata-formats).

     Более подробную информацию о параметрах ресурса `yandex_compute_instance` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/compute_instance).
  1. Создайте ресурсы:

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
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

     После этого в указанном каталоге будут созданы все требуемые ресурсы с заданными настройками. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды CLI:

     ```bash
     yc compute instance get <имя_ВМ>
     ```

- API {#api}

  При создании ВМ воспользуйтесь методом REST API [create](../../api-ref/Instance/create.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Create](../../api-ref/grpc/Instance/create.md).

  При изменении ВМ воспользуйтесь методом REST API [update](../../api-ref/Instance/update.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Update](../../api-ref/grpc/Instance/update.md).

{% endlist %}