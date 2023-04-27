# Подключить домен

Вы можете подключить собственный домен для обращения к API-шлюзу. К одному API-шлюзу можно подключить несколько доменов. В таком случае домен будет идентифицироваться по заголовку `Host`.

{% note warning %}

Домен должен быть ниже второго уровня. Например, можно подключить домен www.example.com, а example.com — нельзя. Это связано с особенностями обработки CNAME-записей на DNS-хостингах. Подробнее в [RFC 1912, пункт 2.4.](https://www.ietf.org/rfc/rfc1912.txt)

{% endnote %}

Чтобы подключить домен к API-шлюзу:

{% list tabs %}

- Консоль управления

    1. Разместите у своего DNS-провайдера или на собственном DNS-сервере CNAME-запись:
    
        ```
        <домен> IN CNAME <служебный домен API-шлюза>
        ```

        Чтобы узнать служебный домен API-шлюза:

       1. Перейдите в [консоль управления]({{ link-console-main }}).
       1. Выберите каталог, в котором находится API-шлюз, и в списке сервисов — **API Gateway**.
       1. Выберите API-шлюз.
       1. Служебный домен будет в блоке **Общая информация**.

        Доменные имена должны заканчиваться точкой.

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится API-шлюз.

    1. В списке сервисов выберите **Certificate Manager** и в нем:

        1. Создайте [сертификат от Let's Encrypt<sup>®</sup>](../../certificate-manager/operations/managed/cert-create.md) или [пользовательский сертификат](../../certificate-manager/operations/import/cert-create.md).

            {% note info %}

            Сертификаты необходимо своевременно обновлять. Подробнее о том, как обновить [сертификат от Let's Encrypt<sup>®</sup>](../../certificate-manager/operations/managed/cert-update.md) и [пользовательский сертификат](../../certificate-manager/operations/import/cert-update.md).

            {% endnote %}

        1. Дождитесь, когда сертификат перейдет в статус `Issued`.
    
    1. Вернитесь на страницу каталога.

    1. В списке сервисов выберите **API Gateway** и в нем:

        1. Выберите API-шлюз.
        1. В открывшемся окне перейдите в раздел **Домены**.
        1. Нажмите **Подключить**, выберите сертификат и введите имя домена (FQDN).

- API

  Чтобы подключить домен к API-шлюзу, воспользуйтесь методом REST API [addDomain](../apigateway/api-ref/ApiGateway/addDomain.md) для ресурса [ApiGateway](../apigateway/api-ref/ApiGateway/index.md) или вызовом gRPC API [ApiGatewayService/AddDomain](../apigateway/api-ref/grpc/apigateway_service.md#AddDomain).

{% endlist %}
