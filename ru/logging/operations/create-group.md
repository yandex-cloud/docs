# Создание пользовательской лог-группы

{% list tabs %}

- Консоль управления

	1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать [лог-группу](../concepts/log-group.md).
	1. Откройте сервис **{{ cloud-logging-name }}**.
	1. Нажмите кнопку **Создать группу**.
	1. (опционально) Введите имя и описание лог-группы. Формат имени:

		{% include [name-format](../../_includes/name-format.md) %}

	1. Укажите срок хранения записей в лог-группе. Максимальный срок хранения записей — 7 дней, минимальное — 1 час.
    1. Нажмите кнопку **Создать группу**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    {% note info %}

    Срок хранения записей можно указать только в часах, минутах или секундах. Например, `1h` или `1440m`.

    {% endnote %}

    Чтобы создать лог-группу, выполните команду:

    ```
    yc logging group create --name=group --retention-period=1h

    ```

    * `--name` — имя лог-группы.
    * `--retention-period` — срок хранения записей в лог-группе. Необязательный параметр. По умолчанию срок хранения записей — 3 дня.

    Результат:

    ```
    done (1s)
    id: af3flf29t8**********
    folder_id: aoek6qrs8t**********
    cloud_id: aoegtvhtp8**********
    created_at: "2021-06-24T09:56:38.970Z"
    name: group
    status: ACTIVE
    retention_period: 3600s
    ```

- API

    Создать пользовательскую лог-группу можно с помощью метода API [create](../api-ref/LogGroup/create.md).

{% endlist %}