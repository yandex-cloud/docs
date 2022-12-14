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

    {% include [note](function-list-note.md) %}

    Чтобы получить список версий функции, выполните команду:

    ```
    yc serverless function version list --function-name <имя_функции>
    ```

    Результат:

    ```
    +----------------------+----------------------+----------+--------------+---------+---------------------+
    |          ID          |     FUNCTION ID      | RUNTIME  |  ENTRYPOINT  |  TAGS   |     CREATED AT      |
    +----------------------+----------------------+----------+--------------+---------+---------------------+
    | b09u830mb1n3******** | b097d9ous3ge******** | python37 | test.handler | $latest | 2019-06-13 09:23:23 |
    | b09ch6pmpohf******** | b097d9ous3ge******** | python37 | test.handler | beta    | 2019-06-13 09:12:38 |
    +----------------------+----------------------+----------+--------------+---------+---------------------+
    ```

- API

    Получить список версий функции можно с помощью метода API [listVersions](../../functions/functions/api-ref/Function/listVersions.md).

- Yandex Cloud Toolkit

    Получить список версий функции можно с помощью [плагина Yandex Cloud Toolkit]{% if lang == "ru" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains){% endif %}{% if lang == "en" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md){% endif %} для семейства IDE на [платформе IntelliJ]{% if lang == "ru" %}(https://www.jetbrains.com/ru-ru/opensource/idea/){% endif %}{% if lang == "en" %}(https://www.jetbrains.com/opensource/idea/){% endif %} от [JetBrains](https://www.jetbrains.com/).

{% endlist %}
