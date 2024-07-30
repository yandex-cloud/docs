# Использование SDK для функции на Python

Среды выполнения `python37` и `python38` содержат предустановленную библиотеку для работы с [API {{ yandex-cloud }}](../../../api-design-guide/). Для ее использования не требуется добавлять [зависимость](dependencies.md) в приложение на Python, за исключением случаев, когда требуется версия библиотеки, отличающаяся от предустановленной.

В `python39` и более поздних средах выполнения библиотека не предустановлена. Пользователь может установить ее самостоятельно, указав зависимость в файле `requirements.txt`.

Исходный код библиотеки находится на [GitHub](https://github.com/yandex-cloud/python-sdk).

[SDK (Software Development Kit)](https://ru.wikipedia.org/wiki/SDK) позволяет управлять ресурсами {{ yandex-cloud }} от имени [сервисного аккаунта](../../operations/function-sa.md), который указан в параметрах функции. Например, можно получить список доступных облаков:

```python
import yandexcloud

from yandex.cloud.resourcemanager.v1.cloud_service_pb2 import ListCloudsRequest
from yandex.cloud.resourcemanager.v1.cloud_service_pb2_grpc import CloudServiceStub


def handler(event, context):
    cloud_service = yandexcloud.SDK().client(CloudServiceStub)
    clouds = {}
    for c in cloud_service.List(ListCloudsRequest()).clouds:
        clouds[c.id] = c.name
    return clouds
```
