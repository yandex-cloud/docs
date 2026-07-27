[Документация Yandex Cloud](../../index.md) > [Yandex Cloud Logging](../index.md) > [Пошаговые инструкции](index.md) > Выгрузка логов > Выгрузить логи > Object Storage

# Выгрузить логи в Object Storage

{% note info %}

Выгрузить логи в Object Storage можно только в течение срока хранения, который задан для лог-группы. По истечении этого срока логи удаляются из лог-группы и выгрузить их не получится.

{% endnote %}

Для запуска выгрузки логов у пользователя или сервисного аккаунта должна быть [роль](../../iam/roles-reference.md#logging-roles) `logging.editor` или выше.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находятся лог-группа и приемник логов.
    1. [Перейдите](https://console.yandex.cloud/link/logging) в сервис **Cloud Logging**.
    1. Выберите лог-группу, из которой хотите выгрузить логи.
    1. Перейдите на вкладку **Логи**.
    1. Справа от кнопки **Выполнить** нажмите значок ![image](../../_assets/console-icons/chevron-down.svg) → **Выгрузить логи**.
    1. В открывшемся окне:
        
        1. Укажите период выгрузки.
        1. Выберите приемник логов.
        1. Укажите имя файла выгрузки.
        1. Нажмите кнопку **Выгрузить логи**.

    Файл сохранится в бакет, который указан в настройках выбранного приемника логов.

- API {#api}

    Чтобы выгрузить логи, воспользуйтесь методом REST API [run](../api-ref/Export/run.md) для ресурса [Export](../api-ref/Export/index.md) или вызовом gRPC API [ExportService/Run](../api-ref/grpc/Export/run.md).

{% endlist %}


#### Полезные ссылки {#see-also}

* [Репликация логов в Yandex Object Storage с помощью Fluent Bit](../tutorials/replicate-logs-to-storage.md)
* [Репликация логов в Yandex Object Storage с помощью Yandex Data Streams](../tutorials/replicate-logs-to-storage-via-data-streams.md)