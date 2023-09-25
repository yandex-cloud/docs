# Смонтировать бакеты в функцию

{% include [read-note](../../../_includes/functions/read-note.md) %}

{% list tabs %}

- Консоль управления
    
    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Выберите функцию.
    1. Перейдите на вкладку **{{ ui-key.yacloud.serverless-functions.item.switch_editor }}**.
    1. В блоке **Смонтированные бакеты** нажмите **Добавить бакет**.
    1. Укажите в поле:
        * **Точка монтирования** — имя точки монтирования. Директория, к которой смонтируется бакет, будет доступна по пути `/function/storage/<точка_монтирования>`.
        * **Бакет** — имя бакета, который хотите смонтировать, или создайте новый.
        * **Папка** — [папку](../../../storage/concepts/object.md#folder) в бакете. Если поле пустое, смонтируется весь бакет.
    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

- API

    Чтобы смонтировать бакет, воспользуйтесь методом REST API [createVersion](../../functions/api-ref/Function/createVersion.md) для ресурса [Function](../../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/CreateVersion](../../functions/api-ref/grpc/function_service.md#CreateVersion).

{% endlist %}

## См. также {#see-also}

* [Монтирование бакетов в функцию](../../concepts/mounting.md)
* [Монтирование бакетов в контейнер](../../../serverless-containers/concepts/mounting.md)
