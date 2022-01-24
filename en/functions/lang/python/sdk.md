# Using the SDK for Python functions

The `python37` and `python38` runtime environments contain a built-in library to handle the [{{ yandex-cloud }} API](../../../api-design-guide/). To use it, you don't need to add a [dependency](dependencies.md) to a Python application unless you need a version of the library other than the one built in. See the library's source code on [GitHub](https://github.com/yandex-cloud/python-sdk). You can install the library in other runtime versions by specifying a dependency in `requirements.txt`.

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
