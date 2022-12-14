# Посмотреть настройки масштабирования функции

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.
    1. Выберите сервис **{{ sf-name }}**.
    1. Выберите функцию.
    1. В блоке **История версий** наведите курсор на тег версии функции (например, ![image](../../../_assets/settings.svg) `$latest`), настройки масштабирования которой хотите посмотреть.
    1. Во всплывающем окне отобразится информация о настройках масштабирования:
        * **zone_instances_limit** — количество экземпляров функции в зоне доступности.
        * **zone_requests_limit** — количество одновременно выполняемых вызовов функции в зоне доступности.
        * **provisioned_instances_count** — количество подготовленных экземпляров.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы посмотреть настройки масштабирования функции, выполните команду:

    ```
    yc serverless function list-scaling-policies --id=d4eokpuol55h********
    ```

    Где `--id` — идентификатор функции. Чтобы узнать его, [получите](./function-list.md) список функций.

    Результат:

    ```
    +----------------------+---------+----------------------+---------------------+-----------------------------+
    |     FUNCTION ID      |   TAG   | ZONE INSTANCES LIMIT | ZONE REQUESTS LIMIT | PROVISIONED INSTANCES COUNT |
    +----------------------+---------+----------------------+---------------------+-----------------------------+
    | d4eokpuol55h******** | $latest |                    1 |                   2 |                           3 |
    +----------------------+---------+----------------------+---------------------+-----------------------------+
    ```

- API

    Посмотреть настройки масштабирования функции можно с помощью метода API [listScalingPolicies](../../functions/api-ref/Function/listScalingPolicies.md).

- Yandex Cloud Toolkit

    Посмотреть настройки масштабирования функции можно с помощью [плагина Yandex Cloud Toolkit]{% if lang == "ru" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains){% endif %}{% if lang == "en" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md){% endif %} для семейства IDE на [платформе IntelliJ]{% if lang == "ru" %}(https://www.jetbrains.com/ru-ru/opensource/idea/){% endif %}{% if lang == "en" %}(https://www.jetbrains.com/opensource/idea/){% endif %} от [JetBrains](https://www.jetbrains.com/).

{% endlist %}

{% include [see-also-scaling](../../../_includes/functions/see-also-scaling.md) %}