# Указать облачную сеть, в которой будет исполняться контейнер

{% include [note-preview](../../_includes/note-preview.md) %}

Вы можете указать [облачную сеть](../../vpc/concepts/network.md#network), в которой будет исполняться контейнер.

{% include [network](../../_includes/functions/network.md) %}

{% list tabs %}

- Консоль управления
    
    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится контейнер.
    1. Выберите сервис **{{ serverless-containers-name }}**.
    1. Выберите контейнер.
    1. Перейдите на вкладку **Редактор**.
    1. В блоке **Настройки**, в поле **Сеть**, укажите облачную сеть, в которой будет исполняться контейнер.
    1. Нажмите кнопку **Создать ревизию**.

- API

  Чтобы указать облачную сеть, в которой будет исполняться контейнер, воспользуйтесь методом REST API [deployRevision](../containers/api-ref/Container/deployRevision.md) для ресурса [Container](../containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/DeployRevision](../containers/api-ref/grpc/container_service.md#DeployRevision).

{% endlist %}

## См. также

* [Сетевое взаимодействие в {{ serverless-containers-name }}](../concepts/networking.md).
