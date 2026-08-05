[Документация Yandex Cloud](../../index.md) > [Yandex API Gateway](../index.md) > [Пошаговые инструкции](index.md) > Управление API-шлюзом > Указать облачную сеть

# Указать облачную сеть, в которой будет находиться API-шлюз

Вы можете указать [облачную сеть](../../vpc/concepts/network.md#network), в которой будет находиться API-шлюз.

Облачная сеть должна соответствовать следующим условиям:
* Имеет [подсети](../../vpc/concepts/network.md#subnet) во всех [зонах доступности](../../overview/concepts/geo-scope.md).
* Есть хотя бы один ресурс, IP-адрес которого находится в указанной облачной сети.

{% note info %}

Если сеть не соответствует условиям выше, сервис не гарантирует ее работу.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится API-шлюз.
    1. [Перейдите](https://console.yandex.cloud/link/api-gateway) в сервис **API Gateway**.
    1. Выберите API-шлюз.
    1. Нажмите кнопку ![image](../../_assets/console-icons/pencil.svg) **Редактировать**.
    1. В поле **Сеть** укажите облачную сеть, в которой будет находиться API-шлюз.
    1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для изменения API-шлюза:

     ```bash
     yc serverless api-gateway update --help
     ```

  1. Получите список API-шлюзов в каталоге по умолчанию:

     ```bash
     yc serverless api-gateway list
     ```

  1. Укажите облачную сеть для нужного API-шлюза:

     ```bash
     yc serverless api-gateway update \
       --id <идентификатор_API-шлюза> \
       --network-name <имя_облачной_сети>
     ```

     Где:
     * `--id` — идентификатор API-шлюза.
     * `--network-name` — имя облачной сети. Вместо имени можно указать идентификатор сети в параметре `--network-id`.

     Чтобы ограничить набор подсетей, в которых будет размещен API-шлюз, вместо сети укажите подсети в параметрах `--subnet-id` или `--subnet-name`.

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. Откройте файл конфигурации Terraform и добавьте блок `connectivity` в описание ресурса `yandex_api_gateway`:

     ```hcl
     resource "yandex_api_gateway" "test-api-gateway" {
       name = "<имя_API-шлюза>"
       ...
       connectivity {
         network_id = "<идентификатор_облачной_сети>"
       }
     }
     ```

     Где `network_id` — идентификатор облачной сети, в которой будет находиться API-шлюз.

     Более подробную информацию о параметрах ресурса `yandex_api_gateway` читайте в [документации провайдера](../../terraform/resources/api_gateway.md).

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

     Проверить результат можно в [консоли управления](https://console.yandex.cloud) или с помощью команды CLI:

     ```bash
     yc serverless api-gateway get <идентификатор_API-шлюза>
     ```

- API {#api}

  Чтобы указать облачную сеть, в которой будет находиться API-шлюз, воспользуйтесь методом REST API [update](../apigateway/api-ref/ApiGateway/update.md) для ресурса [ApiGateway](../apigateway/api-ref/ApiGateway/index.md) или вызовом gRPC API [ApiGatewayService/Update](../apigateway/api-ref/grpc/ApiGateway/update.md).

  В параметре `updateMask` укажите `connectivity`, а в параметре `connectivity.networkId` — идентификатор облачной сети.

{% endlist %}

#### Полезные ссылки {#see-also}

[Сетевое взаимодействие в API Gateway](../concepts/networking.md)