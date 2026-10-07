[Документация Yandex Cloud](../../index.md) > [Yandex API Gateway](../index.md) > [Пошаговые инструкции](index.md) > Управление API-шлюзом > Подключить домен

# Подключить домен

Вы можете подключить собственный домен для обращения к API-шлюзу. К API-шлюзу можно подключить wildcard-домен, например `*.example.com`, чтобы API-шлюз обрабатывал запросы на все поддомены `example.com`, или несколько доменов. Домен будет идентифицироваться по заголовку `Host`.

{% note warning %}

Если вашим доменом управляет сторонний DNS-провайдер, домен должен быть ниже второго уровня. Например, можно подключить домен `www.example.com`, а `example.com` — нельзя. Это связано с особенностями обработки CNAME-записей на DNS-хостингах. Подробнее в [RFC 1912, пункт 2.4](https://www.ietf.org/rfc/rfc1912.txt).

Чтобы использовать домен второго уровня (`example.com`), делегируйте его [Yandex Cloud DNS](../../dns/index.md) и создайте [ANAME-запись](../../dns/concepts/resource-record.md#aname) в зоне DNS.

{% endnote %}

На домене должен быть установлен [X.509‑сертификат](https://ru.wikipedia.org/wiki/X.509), соответствующий требованиям [IETF](https://www.ietf.org/) (RFC [2459](https://www.ietf.org/rfc/rfc2459.txt)/[3280](https://www.ietf.org/rfc/rfc3280.txt)/[5280](https://www.ietf.org/rfc/rfc5280.txt)). Для сертификатов с алгоритмом [ECDSA](https://ru.wikipedia.org/wiki/ECDSA) поддерживается только кривая P‑256.

Чтобы подключить домен к API-шлюзу:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Разместите у своего DNS-провайдера или на собственном DNS-сервере CNAME-запись:
    
        ```text
        <домен> IN CNAME <служебный_домен_API-шлюза>
        ```

        Чтобы узнать служебный домен API-шлюза:

       1. Перейдите в [консоль управления](https://console.yandex.cloud) и выберите каталог, в котором находится API-шлюз.
       1. [Перейдите](https://console.yandex.cloud/link/api-gateway) в сервис **API Gateway**.
       1. Выберите API-шлюз.
       1. Служебный домен будет в поле **Служебный домен**.

        Доменные имена должны заканчиваться точкой.

        Чтобы использовать домен выше второго уровня, делегируйте его [Yandex Cloud DNS](../../dns/index.md) и [создайте](../../dns/operations/resource-record-create.md) ANAME-запись в зоне DNS. Создать запись в Yandex Cloud DNS можно не только до, но и после создания домена. Смотрите шаг 6.

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится API-шлюз.

    1. [Перейдите](https://console.yandex.cloud/link/certificate-manager) в сервис **Certificate Manager** и в нем:

        1. Добавьте [сертификат от Let's Encrypt<sup>®</sup>](../../certificate-manager/operations/managed/cert-create.md) или [пользовательский сертификат](../../certificate-manager/operations/import/cert-create.md) для подключаемого домена.

            {% note info %}

            Сертификаты необходимо своевременно обновлять. Подробнее о том, как обновить [сертификат от Let's Encrypt<sup>®</sup>](../../certificate-manager/operations/managed/cert-update.md) и [пользовательский сертификат](../../certificate-manager/operations/import/cert-update.md).

            {% endnote %}

        1. Дождитесь, когда сертификат перейдет в статус `Issued`.
    
    1. Вернитесь на страницу каталога.

    1. [Перейдите](https://console.yandex.cloud/link/api-gateway) в сервис **API Gateway** и в нем:

        1. Выберите API-шлюз.
        1. Перейдите на вкладку **Домены**.
        1. Нажмите **Подключить**, выберите сертификат и введите имя домена ([FQDN](../../glossary/fqdn.md)).           

    1. Если вы пропустили шаг 1 и не разместили CNAME-запись, создайте ANAME-запись в Yandex Cloud DNS:

        1. В строке с доменом нажмите кнопку **Создать запись**.
        1. Если у вас нет DNS-зоны, имя которой совпадает с доменом, создайте ее. Для этого нажмите **Создать зону**.
        1. Если необходимо, в поле **TTL (в секундах)** выберите другое значение.
        1. Нажмите кнопку **Создать**.
        
- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. Откройте файл конфигурации Terraform и добавьте блок `custom_domains` в описание ресурса `yandex_api_gateway`:

     ```hcl
     resource "yandex_api_gateway" "<имя_API-шлюза>" {
       name = "<имя_API-шлюза>"
       ...
       custom_domains {
         fqdn           = "<доменное_имя>"
         certificate_id = "<идентификатор_сертификата>"
       }
     }
     ```

     Где:

     * `fqdn` — [FQDN](../../glossary/fqdn.md) подключаемого домена.
     * `certificate_id` — идентификатор [сертификата](../../certificate-manager/concepts/index.md) домена в Yandex Certificate Manager.

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

  Чтобы подключить домен к API-шлюзу, воспользуйтесь методом REST API [addDomain](../apigateway/api-ref/ApiGateway/addDomain.md) для ресурса [ApiGateway](../apigateway/api-ref/ApiGateway/index.md) или вызовом gRPC API [ApiGatewayService/AddDomain](../apigateway/api-ref/grpc/ApiGateway/addDomain.md).

{% endlist %}