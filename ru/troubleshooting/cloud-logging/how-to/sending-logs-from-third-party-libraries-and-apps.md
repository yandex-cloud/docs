# Как настроить отправку журналов работы сторонних приложений в {{ cloud-logging-name }}


## Описание задачи {#case-description}

Необходимо отправлять журналы работы сторонних приложений и сервисов в {{ cloud-logging-full-name }}.

## Решение {#case-resolution}

Для записи пользовательских логов вы можете воспользоваться примером для {{ sf-full-name }}.

{% cut "Пример облачной функции с уровнями логирования" %}
Параметры версии функции в этом примере такие:

* Среда выполнения: `python38`;
* Точка входа: `index.handler`;
* Память: 128 МБ;
* Таймаут: 3 секунды;
* Сервисный аккаунт: `<ID_сервисного_аккаунта>`.

{% note info %}

Используемый для запуска функции сервисный аккаунт должен иметь роли `{{ roles-logging-writer }}` и `{{ roles-functions-invoker }}`.
О том, как назначить данные роли для аккаунта, читайте в разделах:

* [Управление правами доступа к лог-группе](../../../logging/operations/access-rights.md);
* [Управление доступом в {{ sf-name }}](../../../functions/security/index.md#about-access-control)


{% endnote %}

```python
import logging
from pythonjsonlogger import jsonlogger


class YcLoggingFormatter(jsonlogger.JsonFormatter):
    def add_fields(self, log_record, record, message_dict):
        super(YcLoggingFormatter, self).add_fields(log_record, record, message_dict)
        log_record['logger'] = record.name
        log_record['level'] = str.replace(str.replace(record.levelname, "WARNING", "WARN"), "CRITICAL", "FATAL")


def handler(event, context):
    logHandler = logging.StreamHandler()
    logHandler.setFormatter(YcLoggingFormatter('%(message)s %(level)s %(logger)s'))

    logger = logging.getLogger('MyLogger')
    logger.propagate = False
    logger.addHandler(logHandler)
    logger.setLevel(logging.DEBUG)

    logger.debug("My log message of level DEBUG", extra={"my-key": "my-value"})
    logger.info("My log message of level INFO", extra={"my-key": "my-value"})
    logger.warning("My log message of level WARNING", extra={"my-key": "my-value"})
    logger.error("My log message of level ERROR", extra={"my-key": "my-value"})
    logger.fatal("My log message of level FATAL", extra={"my-key": "my-value"})
    
    cloud_logging_service = yandexcloud.SDK().client(LogReadingServiceStub)
    logs = {}
    criteria = Criteria(log_group_id='<id_log_группы>', resource_ids=['<id_ресурса>'])
    read_request = ReadRequest(criteria=criteria)

    logs = cloud_logging_service.Read(read_request)
    return logs
```
{% endcut %}

Также логи можно выгрузить командой `yc logging read  --group-id <ID_группы> --folder-id <ID_каталога> --since "YYYY-MM-DDT00:00:00Z" --until "YYYY-MM-DDT23:59:59Z" --filter 'resource_id: <ID_MDB_КЛАСТЕРА>' --limit 1000`
Вы можете применить к этому запросу собственные фильтры, для этого ознакомьтесь с [синтаксисом языка запросов](../../../logging/concepts/filter).

{% note warning %}

Лимит выдачи журналов, возвращаемых этой командой – 1000 строк. Если строк журналов, хранимых в {{ cloud-logging-full-name }} за этот период окажется более 1000, самые ранние из них не войдут в эту выборку.

Рекомендуем выгружать журналы с указанием интервала в 15 минут, поскольку в них может содержаться большое количество событий.

{% endnote %}