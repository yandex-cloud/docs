# YDB SDK

Для работы с YDB доступны OpenSource SDK для следующих языков программирования:

{% if cpp_oss_link %}
- C++ [{{ cpp_oss_link }}]({{ cpp_oss_link }}){% endif %}
- Python [https://github.com/yandex-cloud/ydb-python-sdk](https://github.com/yandex-cloud/ydb-python-sdk)
- Go [https://github.com/yandex-cloud/ydb-go-sdk](https://github.com/yandex-cloud/ydb-go-sdk)
- Node.js [https://github.com/yandex-cloud/ydb-nodejs-sdk](https://github.com/yandex-cloud/ydb-nodejs-sdk)
- PHP [https://github.com/yandex-cloud/ydb-php-sdk](https://github.com/yandex-cloud/ydb-php-sdk)
- Java [https://github.com/yandex-cloud/ydb-java-sdk](https://github.com/yandex-cloud/ydb-java-sdk)
- .NET [https://github.com/ydb-platform/ydb-dotnet-sdk](https://github.com/ydb-platform/ydb-dotnet-sdk)

{% if audience == "external" %}

При работе с Yandex.Cloud вы можете воспользоваться материалами со следующих страниц:
- [Установка и конфигурация SDK](yc_setup.md)
- [Комментарии к коду тестового приложения](example_code.md)

{% endif %}

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
| .NET    | | |

{% endif %}