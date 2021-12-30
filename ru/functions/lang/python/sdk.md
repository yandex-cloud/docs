# Использование SDK для функции на Python

Среды выполнения `python37` и `python38` содержат предустановленную библиотеку для работы с [API {{ yandex-cloud }}](../../../api-design-guide/). Для её использования не требуется добавлять [зависимость](dependencies.md) в приложение на Python, за исключением случаев, когда требуется версия библиотеки, отличающаяся от предустановленной. С исходным кодом библиотеки можно ознакомиться на [GitHub](https://github.com/yandex-cloud/python-sdk). В другие версии среды установить SDK-библиотеку можно, указав зависимость в файле `requirements.txt`.

[SDK (Software Development Kit)](https://ru.wikipedia.org/wiki/SDK) позволяет взаимодействовать с сервисами {{ yandex-cloud }} с помощью [сервисного аккаунта](../../operations/function-sa.md), указанного в функции. Например, вы можете получить список доступных вам облаков (аналог команды `yc resource-manager cloud list`):

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
