---
title: "Смонтировать бакеты в функцию"
description: "Следуя данной инструкции, вы сможете смонтировать бакеты в функцию."
---

# Смонтировать бакеты в функцию

{% include [read-note](../../../_includes/functions/read-note.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}
    
    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Выберите функцию.
    1. Перейдите на вкладку **{{ ui-key.yacloud.serverless-functions.item.switch_editor }}**.
    1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.title_mount-files }}** нажмите **{{ ui-key.yacloud.serverless-functions.item.editor.label_add-folder }}**.
    1. Укажите в поле:
        * **{{ ui-key.yacloud.serverless-functions.item.editor.label_mount-point-name }}** — имя точки монтирования. Директория, к которой смонтируется бакет, будет доступна по пути `/function/storage/<точка_монтирования>`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.label_bucket }}** — имя бакета, который хотите смонтировать, или создайте новый.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.label_bucket-prefix }}** — [папку](../../../storage/concepts/object.md#folder) в бакете. Если поле пустое, смонтируется весь бакет.
    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

- API {#api}

    Чтобы смонтировать бакет, воспользуйтесь методом REST API [createVersion](../../functions/api-ref/Function/createVersion.md) для ресурса [Function](../../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/CreateVersion](../../functions/api-ref/grpc/function_service.md#CreateVersion).

{% endlist %}

## См. также {#see-also}

* [Монтирование бакетов в функцию](../../concepts/mounting.md)
* [Монтирование бакетов в контейнер](../../../serverless-containers/concepts/mounting.md)
