# Использование SDK для функции на Python

Чтобы работать с [API {{ yandex-cloud }}](../../../api-design-guide/), можно использовать SDK-библиотеку. Для ее установки необходимо указать [зависимость](dependencies.md) в файле `requirements.txt`. В средах выполнения `python37` и `python38` SDK-библиотека установлена по умолчанию.

Исходный код библиотеки находится на [GitHub](https://github.com/yandex-cloud/python-sdk).

[SDK (Software Development Kit)](https://ru.wikipedia.org/wiki/SDK) позволяет управлять ресурсами {{ yandex-cloud }} от имени [сервисного аккаунта](../../operations/function-sa.md), указанного в параметрах функции. Например, можно получить список доступных облаков:

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
