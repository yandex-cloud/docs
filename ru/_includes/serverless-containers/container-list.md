{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите посмотреть список контейнеров.
    1. Откройте сервис **{{ serverless-containers-name }}**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить список контейнеров, выполните команду:

    ```
    yc serverless container list
    ```

    Результат:

    ```
    +----------------------+--------------------+-----------------------+--------+
    |          ID          |        NAME        |      FOLDER ID        | STATUS |
    +----------------------+--------------------+-----------------------+--------+
    | b097d9ous3ge******** | my-beta-container   | aoek49ghmknn******** | ACTIVE |
    +----------------------+--------------------+-----------------------+--------+
    ```

{% endlist %}
