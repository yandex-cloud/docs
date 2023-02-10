# Получить информацию о контейнере

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится контейнер.
    1. Выберите сервис **{{ serverless-containers-name }}**.
    1. На панели слева выберите **Контейнеры**.
    1. Выберите контейнер.
    1. На странице **Обзор** отобразится подробная информация о контейнере.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    {% include [note](../../_includes/serverless-containers/sc-list-note.md) %}

    Чтобы получить подробную информацию о контейнере, выполните команду:

    ```
    yc serverless container get <идентификатор_контейнера>
    ```
    Результат:
    ```
    id: bba0hq6q1prb********
    folder_id: b1gtmgn9gbvm********
    created_at: "2023-01-17T11:52:56.800Z"
    name: test
    url: https://bba0hq6q1prb********.containers.yandexcloud.net/
    status: ACTIVE
    ```

- API

    Получить подробную информацию о контейнере можно с помощью метода API [get](../containers/api-ref/Container/get.md).

{% endlist %}