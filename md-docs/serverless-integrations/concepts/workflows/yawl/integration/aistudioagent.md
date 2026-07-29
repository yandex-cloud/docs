[Документация Yandex Cloud](../../../../../index.md) > [Yandex Serverless Integrations](../../../../index.md) > [Концепции](../../../index.md) > Workflows > [Спецификация YaWL](../index.md) > Интеграционные шаги > AIStudioAgent

# AIStudioAgent

{% note info %}

На данный момент Workflows поддерживается в двух интерфейсах — [Yandex Cloud](https://console.yandex.cloud/link/serverless-integrations/workflows/workflows) и [Yandex AI Studio](https://aistudio.yandex.ru/platform/link//workflows). При этом:

* рабочие процессы, [созданные в интерфейсе Yandex Cloud](../../../../operations/workflows/workflow/create-constructor.md), автоматически _доступны_ в интерфейсе AI Studio;
* рабочие процессы, созданные в интерфейсе AI Studio, _недоступны_ в интерфейсе Yandex Cloud.

С 3 сентября 2026 года Workflows перестанет поддерживаться в интерфейсе Yandex Cloud. Для создания рабочих процессов и управления ими используйте интерфейс AI Studio.

{% endnote %}

Взаимодействие с [агентами AI Studio](https://aistudio.yandex.ru/docs/ru/ai-studio/concepts/agents/index).

Имя поля | Тип | Обязательное | Значение по умолчанию | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | --- | ---
`promptTemplateId`  | `string`              | Да  | Нет | Нет | Идентификатор агента.
`message`           | `string`              | Нет | Нет | Да  | Входящее сообщение, которое будет передано агенту вместе с промптом. Чтобы передавать полное [состояние рабочего процесса](../../workflow.md#state), необходимо указать `\(.)`.
`variables`         | `map<string,string>`  | Нет | Нет | Да  | Набор переменных для подстановки в промпт. Ключ — имя переменной, значение — значение переменной. Для значения переменной поддерживается шаблонизация.
`auto_approve` | `bool` | Нет | `false` | Нет | Если значение `true`, автоматически разрешается использовать [инструменты](https://aistudio.yandex.ru/docs/ru/ai-studio/concepts/agents/index#tools). Если для инструмента необходимо подтверждение использования, а значение параметра — `false`, шаг завершится с ошибкой.