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
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **API Gateway**.
    1. Выберите API-шлюз.
    1. Нажмите кнопку ![image](../../_assets/console-icons/pencil.svg) **Редактировать**.
    1. В поле **Сеть** укажите облачную сеть, в которой будет находиться API-шлюз.
    1. Нажмите кнопку **Сохранить**.

- API {#api}

  Чтобы указать облачную сеть, в которой будет находиться API-шлюз, воспользуйтесь методом REST API [update](../apigateway/api-ref/ApiGateway/update.md) для ресурса [ApiGateway](../apigateway/api-ref/ApiGateway/index.md) или вызовом gRPC API [ApiGatewayService/Update](../apigateway/api-ref/grpc/ApiGateway/update.md).

{% endlist %}

## См. также

* [Сетевое взаимодействие в API Gateway](../concepts/networking.md).