{% include [example-java.md](_includes/example-java.md) %}

{% if audience == "internal" or audience == "tech" %}

## Разработка в Аркадии {#in-arcadia}

Для демонстрации работы с SDK мы подготовили приложение [basic_example](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/java/examples/src/main/java/com/yandex/ydb/examples/basic_example). Чтобы успешно запустить [basic_example](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/java/examples/src/main/java/com/yandex/ydb/examples/basic_example) потребуется:

* база данных (подробно о создании и управлении базой данных написано в разделе ["Базы данных - создание и управление"](../../../getting_started/create_manage_database.md);
* endpoint базы данных (информация об endpoint доступна на странице Info [web-интерфейса](https://ydb.yandex-team.ru) вашей БД);
* [токен для аутентификации приложения](../../../getting_started/start_auth.md);
* [SDK](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/java) (доступен в [Аркадии](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/java));
* код приложения [basic_example](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/java/examples).

{% note info "Аутентификация" %}

Для аутентификации в YDB тестовое приложение использует токен из переменной окружения __YDB_TOKEN__.

{% endnote %}

{% endif %}
