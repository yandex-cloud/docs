{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.
    1. Выберите сервис **{{ sf-name }}**.
    1. На панели слева выберите ![image](../../_assets/functions/functions.svg) **Функции**.
    1. Выберите функцию, для которой хотите получить список версий.
    1. В разделе **История версий** будет показан список версий функции и подробная информация о них.

- CLI

    {% include [cli-install](../cli-install.md) %}

    {% include [default-catalogue](../default-catalogue.md) %}

    Чтобы узнать имя или уникальный идентификатор версии функции, получите [список версий функции](./version-list.md) в каталоге.

    Чтобы получить подробную информацию о версии функции:

    * по `ID`, выполните команду:
        ```
        yc serverless function version get <идентификатор_версии>
        ```
        Результат:
        ```
        id: b09u830mb1n3********
        function_id: b097d9ous3ge********
        created_at: "2019-06-13T09:23:23.383Z"
        runtime: python37
        entrypoint: test.handler
        resources:
          memory: "134217728"
        execution_timeout: 5s
        image_size: "4096"
        status: ACTIVE
        tags:
        - $latest
        log_group_id: eolv6578frac********
        ```

    * по `TAGS`, выполните команду:
        ```
        yc serverless function version get-by-tag --function-name <имя_функции> --tag <тег>
        ```
        Результат:
        ```
        id: b09ch6pmpohf********
        function_id: b097d9ous3ge********
        created_at: "2019-06-13T09:12:38.464Z"
        runtime: python37
        entrypoint: test.handler
        resources:
          memory: "134217728"
        execution_timeout: 5s
        image_size: "4096"
        status: ACTIVE
        tags:
        - beta
        log_group_id: eolv6578frac********
        ```

- API

    Получить подробную информацию о версии функции можно с помощью метода API [getVersion](../../functions/functions/api-ref/Function/getVersion.md).

- Yandex Cloud Toolkit

    Получить подробную информацию о версии функции можно с помощью [плагина Yandex Cloud Toolkit]{% if lang == "ru" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains){% endif %}{% if lang == "en" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md){% endif %} для семейства IDE на [платформе IntelliJ]{% if lang == "ru" %}(https://www.jetbrains.com/ru-ru/opensource/idea/){% endif %}{% if lang == "en" %}(https://www.jetbrains.com/opensource/idea/){% endif %} от [JetBrains](https://www.jetbrains.com/).

{% endlist %}
