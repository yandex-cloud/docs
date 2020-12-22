# Using the SDK

The runtime environment has a pre-installed library that lets you access the [{{ yandex-cloud }} API](../../../api-design-guide/). To use it, you don't need to add [dependencies](dependencies.md) to your application, except when a library version that isn't already pre-installed is required. See the library's source code on [GitHub](https://github.com/yandex-cloud/python-sdk).

[Software development kits (SDK)](https://en.wikipedia.org/wiki/Software_development_kit) let you interact with {{ yandex-cloud }} services using the [service account](../../operations/function-sa.md) specified in the function. For example, you can get a list of available clouds (similar to the `yc resource-manager cloud list` command):

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
