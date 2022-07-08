# Using the SDK for a Python function

The `python37` and `python38` runtime environments contain a built-in library for working with the [{{ yandex-cloud }} API](../../../api-design-guide/). To use it, you don't need to add a [dependency](dependencies.md) to a Python application unless you need a version of the library other than the one built in. The library source code is available on [GitHub](https://github.com/yandex-cloud/python-sdk). You can install the SDK library in other versions of the runtime by specifying a dependency in `requirements.txt`.

The [SDK (Software Development Kit)]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/SDK){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Software_development_kit){% endif %} helps you manage {{ yandex-cloud }} resources on behalf of the [service account](../../operations/function-sa.md) specified in the function parameters. For example, you can retrieve a list of available clouds:

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
