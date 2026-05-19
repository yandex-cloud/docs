# Using the SDK for a function in Python

You can use the SDK library to work with the [{{ yandex-cloud }} API](../../../api-design-guide/). To install it, specify the [dependency](dependencies.md) in the `requirements.txt` file. The SDK library is pre-installed in the `python37` and `python38` runtimes.

The library source code is available on [GitHub](https://github.com/yandex-cloud/python-sdk).

The [SDK (Software Development Kit)](https://en.wikipedia.org/wiki/Software_development_kit) helps you manage {{ yandex-cloud }} resources using the [service account](../../operations/function-sa.md) specified in the function parameters. For example, you can get a list of available clouds:

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
