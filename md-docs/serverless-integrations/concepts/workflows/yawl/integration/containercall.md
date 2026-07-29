[Документация Yandex Cloud](../../../../../index.md) > [Yandex Serverless Integrations](../../../../index.md) > [Концепции](../../../index.md) > Workflows > [Спецификация YaWL](../index.md) > Интеграционные шаги > ContainerCall

# ContainerCall

{% note info %}

На данный момент Workflows поддерживается в двух интерфейсах — [Yandex Cloud](https://console.yandex.cloud/link/serverless-integrations/workflows/workflows) и [Yandex AI Studio](https://aistudio.yandex.ru/platform/link//workflows). При этом:

* рабочие процессы, [созданные в интерфейсе Yandex Cloud](../../../../operations/workflows/workflow/create-constructor.md), автоматически _доступны_ в интерфейсе AI Studio;
* рабочие процессы, созданные в интерфейсе AI Studio, _недоступны_ в интерфейсе Yandex Cloud.

С 3 сентября 2026 года Workflows перестанет поддерживаться в интерфейсе Yandex Cloud. Для создания рабочих процессов и управления ими используйте интерфейс AI Studio.

{% endnote %}

Вызов контейнера [Yandex Serverless Containers](../../../../../serverless-containers/index.md).

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`containerId` | `string` | Да | Нет | Нет | Идентификатор контейнера.
`path` | `string` | Нет | `""` | Да | Путь запроса.
`method` | `enum` | Нет | `GET` | Да | HTTP-метод запроса.
`body` | `string` | Нет | `""` | Да | Тело запроса.
`headers` | `map<string, string>` | Нет | `{}` | Да — в значениях заголовков | Заголовки запроса.
`query` | `map<string, string>` | Нет | `{}` | Да — в значениях query-параметров | Query-параметры запроса.