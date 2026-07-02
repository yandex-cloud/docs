[Документация Yandex Cloud](../../../../../index.md) > [Yandex Serverless Integrations](../../../../index.md) > [Концепции](../../../index.md) > Workflows > [Спецификация YaWL](../index.md) > Интеграционные шаги > YDS

# YDS

Отправка сообщений в топик [Yandex Data Streams](../../../../../data-streams/index.md).

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`database` | `string` | Да | Нет | Нет | Идентификатор базы данных.
`topic` | `string` | Да | Нет | Нет | Идентификатор топика.
`put` | `object` | Да | [YdsPut](#YdsPut) | Нет | Конфигурация действия `put` — отправка сообщений в поток данных.

## Объект YdsPut {#YdsPut}

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`body` | `string` | Нет | `""` | Да | Тело сообщения.
`partitionKey` | `string` | Нет | `""` | Да |  [Ключ сегмента](../../../../../data-streams/concepts/glossary.md#partition-key).