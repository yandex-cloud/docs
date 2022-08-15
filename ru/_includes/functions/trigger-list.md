{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите посмотреть список триггеров.
    1. Выберите сервис **{{ sf-name }}**.
    1. На панели слева выберите ![image](../../_assets/functions/triggers.svg) **Триггеры**.

- CLI

    {% include [cli-install](../cli-install.md) %}

    {% include [default-catalogue](../default-catalogue.md) %}

    Получите список триггеров:

    ```
    yc serverless trigger list
    ```

    Результат:

    ```
    +----------------------+------------+----------------------+
    |          ID          |    NAME    |      FOLDER ID       |
    +----------------------+------------+----------------------+
    | dd0gj5tsj2pq9at8ja8i | my-trigger | aoek49ghmknnpj1ll45e |
    +----------------------+------------+----------------------+
    ```

- API

    Получить список триггеров можно с помощью метода API [list](../../functions/triggers/api-ref/Trigger/list.md).

{% endlist %}
