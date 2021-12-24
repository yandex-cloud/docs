{% include [example-python.md](_includes/example-python.md) %}

{% if audience == "internal" or audience == "tech" %}

## Разработка в Аркадии {#in-arcadia}

Для демонстрации работы с SDK мы подготовили приложение [basic_example](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/python/examples/basic_example_v1). Чтобы успешно запустить [basic_example](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/python/examples/basic_example_v1) потребуется:

* база данных (подробно о создании и управлении базой данных написано в разделе ["Базы данных - создание и управление"](../../getting_started/create_manage_database.md);
* endpoint базы данных (информация об endpoint доступна на странице Info [web-интерфейса](https://ydb.yandex-team.ru) вашей БД);
* [токен для аутентификации приложения](../../getting_started/start_auth.md);
* SDK (доступен в [Аркадии](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/python), или в [pypi](https://pypi.yandex-team.ru/dashboard/repositories/default/packages/ydb/));
* код приложения [basic_example](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/python/examples/basic_example_v1).

{% note info "Аутентификация" %}

Для аутентификации в YDB тестовое приложение использует токен из переменной окружения __YDB_TOKEN__.

{% endnote %}

{% endif %}
