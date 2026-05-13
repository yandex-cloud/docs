# Указать облачную сеть, в которой будет исполняться контейнер

Вы можете указать [облачную сеть](../../vpc/concepts/network.md#network), в которой будет исполняться контейнер.

Облачная сеть должна соответствовать следующим условиям:
* Имеет [подсети](../../vpc/concepts/network.md#subnet) во всех [зонах доступности](../../overview/concepts/geo-scope.md).
* Есть хотя бы один ресурс, IP-адрес которого находится в указанной облачной сети.

{% note info %}

Если сеть не соответствует условиям выше, сервис не гарантирует ее работу.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}
    
    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится контейнер.
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Serverless Containers**.
    1. Выберите контейнер.
    1. Перейдите на вкладку **Редактор**.
    1. В блоке **Настройки**, в поле **Сеть**, укажите облачную сеть, в которой будет исполняться контейнер.
    1. Нажмите кнопку **Создать ревизию**.

- API {#api}

  Чтобы указать облачную сеть, в которой будет исполняться контейнер, воспользуйтесь методом REST API [deployRevision](../containers/api-ref/Container/deployRevision.md) для ресурса [Container](../containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/DeployRevision](../containers/api-ref/grpc/Container/deployRevision.md).

{% endlist %}

## См. также

* [Сетевое взаимодействие в Serverless Containers](../concepts/networking.md).