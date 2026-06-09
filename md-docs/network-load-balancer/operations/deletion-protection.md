# Настроить защиту от удаления

Чтобы предотвратить случайное удаление сетевого балансировщика, [включите для него защиту от удаления](#enable-deletion-protection).

Если защита вам больше не нужна, вы можете [отключить ее](#disable-deletion-protection).

## Включить защиту от удаления {#enable-deletion-protection}

{% note warning %}

Включенная защита балансировщика от удаления не помешает удалить его обработчики и целевые группы.

{% endnote %}

{% list tabs %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите сервис **Network Load Balancer**.
    1. Справа от имени нужного балансировщика нажмите ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) и выберите **Редактировать**.
    1. Включите настройку **Защита от удаления**.
    1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    1. Просмотрите описание команды CLI для изменения атрибутов балансировщика:

        ```bash
        yc load-balancer network-load-balancer update --help
        ```

    1. Включите защиту от удаления:

        ```bash
        yc load-balancer network-load-balancer update <имя_или_идентификатор_балансировщика> \
            --deletion-protection
        ```

        Идентификатор и имя балансировщика можно получить со [списком сетевых балансировщиков в каталоге](load-balancer-list.md#list).

- Terraform {#tf}

    [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
    
    Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
    
    Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

    Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    
    
    Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

    1. Откройте актуальный конфигурационный файл с описанием инфраструктуры.

    1. Добавьте к описанию балансировщика параметр `deletion_protection`:


       ```hcl
       resource "yandex_lb_network_load_balancer" "foo" {
         ...
         deletion_protection = true
         ...
       }
       ```

    1. Проверьте корректность настроек.

       1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
       1. Выполните команду:
       
          ```bash
          terraform validate
          ```
       
          Если в файлах конфигурации есть ошибки, Terraform на них укажет.

    1. Примените изменения.

       1. Выполните команду для просмотра планируемых изменений:
       
          ```bash
          terraform plan
          ```
       
          Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
       
       1. Если вас устраивают планируемые изменения, внесите их:
          1. Выполните команду:
       
             ```bash
             terraform apply
             ```
       
          1. Подтвердите изменение ресурсов.
          1. Дождитесь завершения операции.

- API {#api}

    Чтобы включить защиту от удаления, воспользуйтесь методом REST API [update](../api-ref/NetworkLoadBalancer/update.md) для ресурса [NetworkLoadBalancer](../api-ref/NetworkLoadBalancer/index.md) или вызовом gRPC API [NetworkLoadBalancerService/Update](../api-ref/grpc/NetworkLoadBalancer/update.md) и передайте в запросе:

    * Имя параметра `deletionProtection` в параметре `updateMask`.
    * Значение `true` в параметре `deletionProtection`.

    {% note warning %}
    
    Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
    
    {% endnote %}

{% endlist %}

## Отключить защиту от удаления {#disable-deletion-protection}

{% list tabs %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите сервис **Network Load Balancer**.
    1. Справа от имени нужного балансировщика нажмите ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) и выберите **Редактировать**.
    1. Отключите настройку **Защита от удаления**.
    1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    1. Просмотрите описание команды CLI для изменения атрибутов балансировщика:

        ```bash
        yc load-balancer network-load-balancer update --help
        ```

    1. Отключите защиту от удаления:

        ```bash
        yc load-balancer network-load-balancer update <имя_или_идентификатор_балансировщика> \
            --deletion-protection=false
        ```

        Идентификатор и имя балансировщика можно получить со [списком сетевых балансировщиков в каталоге](load-balancer-list.md#list).

- Terraform {#tf}

    [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
    
    Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
    
    Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

    Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    
    
    Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

    1. Откройте актуальный конфигурационный файл с описанием инфраструктуры.

    1. В описании балансировщика измените значение параметра `deletion_protection` на `false`:


       ```hcl
       resource "yandex_lb_network_load_balancer" "foo" {
         ...
         deletion_protection = false
         ...
       }
       ```

    1. Проверьте корректность настроек.

       1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
       1. Выполните команду:
       
          ```bash
          terraform validate
          ```
       
          Если в файлах конфигурации есть ошибки, Terraform на них укажет.

    1. Примените изменения.

       1. Выполните команду для просмотра планируемых изменений:
       
          ```bash
          terraform plan
          ```
       
          Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
       
       1. Если вас устраивают планируемые изменения, внесите их:
          1. Выполните команду:
       
             ```bash
             terraform apply
             ```
       
          1. Подтвердите изменение ресурсов.
          1. Дождитесь завершения операции.

- API {#api}

    Чтобы включить защиту от удаления, воспользуйтесь методом REST API [update](../api-ref/NetworkLoadBalancer/update.md) для ресурса [NetworkLoadBalancer](../api-ref/NetworkLoadBalancer/index.md) или вызовом gRPC API [NetworkLoadBalancerService/Update](../api-ref/grpc/NetworkLoadBalancer/update.md) и передайте в запросе:

    * Имя параметра `deletionProtection` в параметре `updateMask`.
    * Значение `false` в параметре `deletionProtection`.

    {% note warning %}
    
    Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
    
    {% endnote %}

{% endlist %}