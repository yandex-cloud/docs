{% include [intro.md](_includes/index/intro.md) %}

{% if audience == "internal" or audience == "tech" %}

Для разработки в Yandex необходимо использовать внутренние сборки SDK:

|  Язык   | Аркадия | Документация |
| ------- | ----------------- | ------------ |
| C++     | [https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/cpp](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/cpp) | [Разработка на C++](../../getting_started/start_cpp.md) |
| Python  | [https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/python](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/python) </br> Pypi: [https://pypi.yandex-team.ru/dashboard/repositories/default/packages/ydb/](https://pypi.yandex-team.ru/dashboard/repositories/default/packages/ydb/) | [Разработка на Python](../../getting_started/start_python.md)
| Go      | [https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/go](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/go) | |
| Node.js | [https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/nodejs](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/nodejs) | |
| PHP     | Запрещен внутри Yandex | |
| Java    | [https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/java](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/java) | [Разработка на Java](../../getting_started/start_java.md) |
| C# (.NET)    | | |

{% endif %}

{% if audience == "external" %}

При работе с Yandex.Cloud вы можете воспользоваться материалами раздела [Установка и конфигурация SDK](yc_setup.md).

{% endif %}

{% include [examples.md](_includes/index/examples.md) %}
