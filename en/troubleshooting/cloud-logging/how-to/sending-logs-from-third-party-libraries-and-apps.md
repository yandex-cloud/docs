# How to set up delivery of third-party application logs to {{ cloud-logging-name }}


## Case description {#case-description}

You need to deliver logs of third-party applications and services to {{ cloud-logging-full-name }}.

## Solution {#case-resolution}

To write custom logs, you can use our example for {{ sf-full-name }}.

{% cut "Example of a cloud function with logging levels" %}
The function version in this example has the following properties:

* Runtime environment: `python38`
* Entry point:`index.handler`
* RAM: 128 MB
* Timeout: 3 seconds
* Service account: `<service_account_ID>`

{% note info %}

The service account running the function must have the `{{ roles-logging-writer }}` and `{{ roles-functions-invoker }}` roles.
To learn how to assign these roles to the service account, see these sections:

* [Managing permissions to access log groups](../../../logging/operations/access-rights.md)
* [Access management in {{ sf-name }}](../../../functions/security/index.md#about-access-control)


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
    criteria = Criteria(log_group_id='<log_group_ID>', resource_ids=['<resource_ID>'])
    read_request = ReadRequest(criteria=criteria)

    logs = cloud_logging_service.Read(read_request)
    return logs
```
{% endcut %}

Alternatively, you can export logs by running this command: `yc logging read  --group-id <group_ID> --folder-id <folder_ID> --since "YYYY-MM-DDT00:00:00Z" --until "YYYY-MM-DDT23:59:59Z" --filter 'resource_id: <MDB_CLUSTER_ID_>' --limit 1000`.
To use custom filters in this query, check the [query language syntax](../../../logging/concepts/filter).

{% note warning %}

You can return a maximum of 1,000 rows of logs by this command. If the logs stored in {{ cloud-logging-full-name }} over this period exceed 1,000 rows, the earliest of them will not be selected.

We recommend exporting logs with the interval of 15 minutes as they can include numerous events.

{% endnote %}