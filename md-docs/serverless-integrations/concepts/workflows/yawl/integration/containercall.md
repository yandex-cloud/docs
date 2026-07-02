[Документация Yandex Cloud](../../../../../index.md) > [Yandex Serverless Integrations](../../../../index.md) > [Концепции](../../../index.md) > Workflows > [Спецификация YaWL](../index.md) > Интеграционные шаги > ContainerCall

# ContainerCall

Вызов контейнера [Yandex Serverless Containers](../../../../../serverless-containers/index.md).

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`containerId` | `string` | Да | Нет | Нет | Идентификатор контейнера.
`path` | `string` | Нет | `""` | Да | Путь запроса.
`method` | `enum` | Нет | `GET` | Да | HTTP-метод запроса.
`body` | `string` | Нет | `""` | Да | Тело запроса.
`headers` | `map<string, string>` | Нет | `{}` | Да — в значениях заголовков | Заголовки запроса.
`query` | `map<string, string>` | Нет | `{}` | Да — в значениях query-параметров | Query-параметры запроса.