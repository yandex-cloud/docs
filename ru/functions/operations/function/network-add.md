---
title: "Как указать облачную сеть, в которой будет исполняться функция"
description: "Следуя данной инструкции, вы сможете указать облачную сеть, в которой будет исполняться функция."
---

# Указать облачную сеть, в которой будет исполняться функция

{% include [note-preview](../../../_includes/note-preview.md) %}

Вы можете указать [облачную сеть](../../../vpc/concepts/network.md#network), в которой будет исполняться функция.

{% include [network](../../../_includes/functions/network.md) %}

{% list tabs %}

- Консоль управления
    
    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Выберите функцию.
    1. Перейдите на вкладку **{{ ui-key.yacloud.serverless-functions.item.switch_editor }}**.
    1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}**, в поле **{{ ui-key.yacloud.vpc.label_network }}**, выберите сеть, в которой будет исполняться функция.
    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.
    
- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы указать облачную сеть, выполните команду:

    ```
    yc serverless function version create \
      --function-name=<имя функции> \
      --runtime <среда выполнения> \
      --entrypoint <точка входа> \
      --memory 128m \
      --execution-timeout 5s \
      --source-version-id <идентификатор версии> \
      --network-id <идентификатор сети>
    ```
    Где:

    * `--function-name` — имя функции.
    * `--runtime` — среда выполнения.
    * `--entrypoint` — точка входа, указывается в формате <имя файла с функцией>.<имя обработчика>.
    * `--memory` — объем RAM.
    * `--execution-timeout` — максимальное время выполнения функции до таймаута.
    * `--source-version-id` — ID версии функции, код которой вы хотите скопировать.
    * `--network-id` — идентификатор облачной сети, в которой будет исполняться функция.

- API

    Чтобы указать облачную сеть, воспользуйтесь методом REST API [createVersion](../../functions/api-ref/Function/createVersion.md) для ресурса [Function](../../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/CreateVersion](../../functions/api-ref/grpc/function_service.md#CreateVersion).

{% endlist %}

## См. также

* [Сетевое взаимодействие в {{ sf-name }}](../../concepts/networking.md).