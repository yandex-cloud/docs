[Документация Yandex Cloud](../../../../../index.md) > [Yandex Serverless Integrations](../../../../index.md) > [Концепции](../../../index.md) > Workflows > [Спецификация YaWL](../index.md) > Интеграционные шаги > GRPCCall

# GRPCCall

Только для сервисов, которые поддерживают [gRPC reflection](https://grpc.io/docs/guides/reflection/).

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`endpoint` | `string` | Да | Нет | Да | Адрес сервера.
`method` | `string` | Да | Нет | Да | gRPC-сервис и метод.
`useServiceAccount` | `bool` | Нет | `false` | Нет | Если `true`, в заголовки запроса добавляется IAM-токен сервисного аккаунта, указанного в настройках рабочего процесса.
`body` | `string` | Нет | `""` | Да | Тело запроса.
`headers` | `map<string, string>` | Нет | `{}` | Да — в значениях заголовков | Заголовки запроса.