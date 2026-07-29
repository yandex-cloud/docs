[Документация Yandex Cloud](../../../../../index.md) > [Yandex Serverless Integrations](../../../../index.md) > [Концепции](../../../index.md) > Workflows > [Спецификация YaWL](../index.md) > Интеграционные шаги > YDS

# YDS

{% note info %}

На данный момент Workflows поддерживается в двух интерфейсах — [Yandex Cloud](https://console.yandex.cloud/link/serverless-integrations/workflows/workflows) и [Yandex AI Studio](https://aistudio.yandex.ru/platform/link//workflows). При этом:

* рабочие процессы, [созданные в интерфейсе Yandex Cloud](../../../../operations/workflows/workflow/create-constructor.md), автоматически _доступны_ в интерфейсе AI Studio;
* рабочие процессы, созданные в интерфейсе AI Studio, _недоступны_ в интерфейсе Yandex Cloud.

С 3 сентября 2026 года Workflows перестанет поддерживаться в интерфейсе Yandex Cloud. Для создания рабочих процессов и управления ими используйте интерфейс AI Studio.

{% endnote %}

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