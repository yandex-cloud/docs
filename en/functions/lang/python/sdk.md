# Using the SDK for a Python function

The `python37` and `python38` runtime environments contain a pre-installed library for working with the [{{ yandex-cloud }} API](../../../api-design-guide/). To use it, you do not need to add a [dependency](dependencies.md) to your Python application unless you need a library version different from the pre-installed one.

In `python39` or more recent runtime environments, the library is not pre-installed. The user can install it manually by specifying a dependency in `requirements.txt`.

The library source code is available on [GitHub](https://github.com/yandex-cloud/python-sdk).

The [SDK (Software Development Kit)](https://en.wikipedia.org/wiki/Software_development_kit) helps you manage {{ yandex-cloud }} resources on behalf of the [service account](../../operations/function-sa.md) specified in the function parameters. For example, you can retrieve a list of available clouds:

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
