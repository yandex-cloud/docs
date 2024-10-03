# Настройте запись логов и анализируйте производительность

Инструкции в этом пункте чек-листа помогут вам настроить работу с логами и проанализировать производительность.

## Создайте лог-группу {#log-group}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать [лог-группу](../../logging/concepts/log-group.md).
    1. Откройте сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.logging.button_create-group }}**.
    1. (Опционально) Введите имя и описание лог-группы. Формат имени:

        {% include [name-format](../../_includes/name-format.md) %}

    1. Укажите срок хранения записей в лог-группе.
    1. Нажмите кнопку **{{ ui-key.yacloud.logging.button_create-group }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    {% note info %}

    Срок хранения записей можно указать только в часах, минутах или секундах. Например, `1h` или `1440m`.

    {% endnote %}

    Чтобы создать лог-группу, выполните команду:

    ```bash
    yc logging group create --name=group --retention-period=1h
    ```

    * `--name` — имя лог-группы.
    * `--retention-period` — срок хранения записей в лог-группе. Необязательный параметр.

    Результат:

    ```text
    done (1s)
    id: af3flf29t8**********
    folder_id: aoek6qrs8t**********
    cloud_id: aoegtvhtp8**********
    created_at: "2021-06-24T09:56:38.970Z"
    name: group
    status: ACTIVE
    retention_period: 3600s
    ```

- API {#api}

    Создать пользовательскую лог-группу можно с помощью метода API [create](../../logging/api-ref/LogGroup/create.md).

{% endlist %}

## Просматривайте графики

1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится лог-группа.
1. Откройте сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
1. Выберите лог-группу.
1. Перейдите на вкладку **{{ ui-key.yacloud.common.monitoring }}**.
1. На странице появятся следующие графики:
    * **Records successfully ingested** — количество записей, доставленных в систему логирования {{ cloud-logging-name }}. Учитываются только пользовательские логи.
    * **Records saved** — количество записей, сохраненных в систему логирования {{ cloud-logging-name }}. Учитываются логи сервисов и пользовательские логи.
    * **Records read** — количество прочитанных записей.
    * **Records ingest errors** — количество ошибок при добавлении записей.
    * **Records save lag** — разница между временем доставки записи и ее сохранением в систему логирования {{ cloud-logging-name }}.

