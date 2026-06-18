# Удаление кластера Apache Spark™

Вы можете удалить кластер Apache Spark™, если он вам больше не нужен.

## Удалить кластер {#delete}

Перед удалением кластера отключите защиту от удаления для кластера, если она включена.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, из которого нужно удалить кластер.
  1. Перейдите в сервис **Managed Service for Apache Spark**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) для нужного кластера и выберите пункт **Удалить**.
  1. В открывшемся окне подтвердите удаление и нажмите кнопку **Удалить**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы удалить кластер Apache Spark™, выполните команду:

    ```bash
    yc managed-spark cluster delete <имя_или_идентификатор_кластера>
    ```

    Имя и идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).
  
  
  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.
  
  
  Чтобы удалить кластер, созданный с помощью Terraform:
  1. В командной строке перейдите в каталог, в котором расположен актуальный конфигурационный файл Terraform с планом инфраструктуры.
  1. Удалите ресурсы с помощью команды:
  
     ```bash
     terraform destroy
     ```
  
     {% note alert %}
  
     Terraform удалит все ресурсы, которые были созданы с его помощью: кластеры, сети, подсети, виртуальные машины и т. д.
  
     {% endnote %}
  
  1. Введите слово `yes` и нажмите **Enter**.

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:
  
     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```
  
  1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
     
     ```bash
     cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
     ```
     
     Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.
  
  1. Воспользуйтесь вызовом [ClusterService/Delete](../api-ref/grpc/Cluster/delete.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):
  
     ```bash
     grpcurl \
         -format json \
         -import-path ~/cloudapi/ \
         -import-path ~/cloudapi/third_party/googleapis/ \
         -proto ~/cloudapi/yandex/cloud/spark/v1/cluster_service.proto \
         -rpc-header "Authorization: Bearer $IAM_TOKEN" \
         -d '{
                 "cluster_id": "<идентификатор_кластера>"
             }' \
         spark.api.cloud.yandex.net:443 \
         yandex.cloud.spark.v1.ClusterService.Delete
     ```
  
     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
  
  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/delete.md#yandex.cloud.operation.Operation).

{% endlist %}