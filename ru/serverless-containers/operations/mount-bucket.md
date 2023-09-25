# Смонтировать бакеты в контейнер

{% include [read-note](../../_includes/functions/read-note.md) %}

{% list tabs %}

- Консоль управления
    
    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится контейнер.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
    1. Выберите контейнер.
    1. Перейдите на вкладку **{{ ui-key.yacloud.serverless-containers.label_editor }}**.
    1. В блоке **Смонтированные бакеты** нажмите кнопку **Добавить бакет**.
    1. Укажите в поле:
        * **Путь монтирования** — путь монтирования. Директория, к которой смонтируется бакет, будет доступна по указанному пути.
        * **Бакет** — имя бакета, который хотите смонтировать, или создайте новый.
        * **Папка** — [папку](../../storage/concepts/object.md#folder) в бакете. Если поле пустое, смонтируется весь бакет.
    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-containers.button_deploy-revision }}**.

- API

  Чтобы смонтировать бакет, воспользуйтесь методом REST API [deployRevision](../containers/api-ref/Container/deployRevision.md) для ресурса [Container](../containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/DeployRevision](../containers/api-ref/grpc/container_service.md#DeployRevision).

{% endlist %}

## См. также {#see-also}

* [Монтирование бакетов в контейнер](../concepts/mounting.md)
* [Монтирование бакетов в функцию](../../functions/concepts/mounting.md)
