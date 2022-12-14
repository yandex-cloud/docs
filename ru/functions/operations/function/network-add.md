# Указать облачную сеть, в которой будет исполняться функция

{% include [note-preview](../../../_includes/note-preview.md) %}

Вы можете указать [облачную сеть](../../../vpc/concepts/network.md#network), в которой будет исполняться функция.

{% include [network](../../../_includes/functions/network.md) %}

{% list tabs %}

- Консоль управления
    
    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.
    1. Выберите сервис **{{ sf-name }}**.
    1. Выберите функцию.
    1. Перейдите на вкладку **Редактор**.
    1. В блоке **Параметры**, в поле **Сеть**, выберите сеть, в которой будет исполняться функция.
    1. Нажмите кнопку **Создать версию**.
    
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

    Указать облачную сеть можно с помощью метода API [createVersion](../../functions/api-ref/Function/createVersion.md).

{% endlist %}

## См. также

* [Cетевое взаимодействие в {{ sf-name }}](../../concepts/networking.md).