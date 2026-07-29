[Документация Yandex Cloud](../../../../../index.md) > [Yandex Serverless Integrations](../../../../index.md) > [Концепции](../../../index.md) > Workflows > [Спецификация YaWL](../index.md) > Управляющие шаги > NoOp

# NoOp

{% note info %}

На данный момент Workflows поддерживается в двух интерфейсах — [Yandex Cloud](https://console.yandex.cloud/link/serverless-integrations/workflows/workflows) и [Yandex AI Studio](https://aistudio.yandex.ru/platform/link//workflows). При этом:

* рабочие процессы, [созданные в интерфейсе Yandex Cloud](../../../../operations/workflows/workflow/create-constructor.md), автоматически _доступны_ в интерфейсе AI Studio;
* рабочие процессы, созданные в интерфейсе AI Studio, _недоступны_ в интерфейсе Yandex Cloud.

С 3 сентября 2026 года Workflows перестанет поддерживаться в интерфейсе Yandex Cloud. Для создания рабочих процессов и управления ими используйте интерфейс AI Studio.

{% endnote %}

Шаг, который ничего не делает. Нужен, например, чтобы успешно завершить пайплайн, если в [Switch](switch.md) выполнилось условие из поля `default`, или сделать заглушку на месте одного из шагов на этапе прототипирования.

Имя поля | Тип | Обязательное | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | ---
`output` | `string` | Нет | Да | jq-шаблон, фильтрующий выходные данные шага, которые добавляются в [состояние рабочего процесса](../../workflow.md#state).
`next` | `string` | Нет | Нет | Идентификатор следующего шага.