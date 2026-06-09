# Удаление брокера

{% note warning %}

Сервис Yandex IoT Core больше не доступен для новых пользователей. 

Текущие пользователи могут создавать ресурсы до 1 ноября 2026 года. После сервис перейдет в режим read-only, а 1 декабря 2026 года — прекратит работу. Подробнее о сроках и порядке закрытия читайте на странице [Закрытие сервиса](../../sunset.md).

{% endnote %}

{% note info %}

Брокер находится на стадии [Preview](../../../overview/concepts/launch-stages.md).

{% endnote %}

Для обращения к [брокеру](../../concepts/index.md#broker) используйте его уникальный идентификатор или имя. Как узнать уникальный идентификатор или имя брокера, читайте в разделе [Получение информации о брокере](broker-list.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог, из которого вы хотите удалить брокер.
    1. Перейдите в сервис **IoT Core**.
    1. На панели слева выберите **Брокеры**.
    1. Справа от имени брокера, который хотите удалить, нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и в выпадающем списке выберите **Удалить**.
    1. В открывшемся окне нажмите кнопку **Удалить**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).
    
    По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    1. Удалите брокер:

        ```
        yc iot broker delete my-broker
        ```

    1. Проверьте, что брокер удален:

        ```
        yc iot broker list
        ```

        Результат:
        ```
        +----+------+
        | ID | NAME |
        +----+------+
        +----+------+
        ```

- Terraform {#tf}

    [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
    
    Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
    
    Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

    Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    
    
    Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

    Чтобы удалить брокер, созданный с помощью Terraform:

    1. Откройте файл конфигурации Terraform и удалите фрагмент с описанием брокера.

        Пример описания брокера в конфигурации Terraform:

        ```hcl
        resource "yandex_iot_core_broker" "my_broker" {
          name        = "test-broker"
          description = "test broker for terraform provider documentation"
          }
        ...
        }
        ```

        Более подробную информацию о параметрах ресурса `yandex_iot_core_broker` в Terraform, см. в [документации провайдера](../../../terraform/resources/iot_core_broker.md).
    1. В командной строке перейдите в папку, где вы отредактировали конфигурационный файл.
    1. Проверьте корректность конфигурационного файла с помощью команды:

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

        Проверить изменения можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/quickstart.md):

        ```bash
        yc iot broker list
        ```

- API {#api}

  Чтобы удалить брокер, воспользуйтесь методом REST API [delete](../../broker/api-ref/Broker/delete.md) для ресурса [Broker](../../broker/api-ref/Broker/index.md) или вызовом gRPC API [BrokerService/Delete](../../broker/api-ref/grpc/Broker/delete.md).

{% endlist %}