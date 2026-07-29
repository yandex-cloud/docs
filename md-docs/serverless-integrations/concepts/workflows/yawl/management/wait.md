[Документация Yandex Cloud](../../../../../index.md) > [Yandex Serverless Integrations](../../../../index.md) > [Концепции](../../../index.md) > Workflows > [Спецификация YaWL](../index.md) > Управляющие шаги > Wait

# Wait

{% note info %}

На данный момент Workflows поддерживается в двух интерфейсах — [Yandex Cloud](https://console.yandex.cloud/link/serverless-integrations/workflows/workflows) и [Yandex AI Studio](https://aistudio.yandex.ru/platform/link//workflows). При этом:

* рабочие процессы, [созданные в интерфейсе Yandex Cloud](../../../../operations/workflows/workflow/create-constructor.md), автоматически _доступны_ в интерфейсе AI Studio;
* рабочие процессы, созданные в интерфейсе AI Studio, _недоступны_ в интерфейсе Yandex Cloud.

С 3 сентября 2026 года Workflows перестанет поддерживаться в интерфейсе Yandex Cloud. Для создания рабочих процессов и управления ими используйте интерфейс AI Studio.

{% endnote %}

Ждет промежуток времени или до временной метки. Если время ожидания отрицательное или равно нулю, а также если временная метка уже прошла, шаг завершится мгновенно.

Имя поля | Тип | Обязательное | Поддерживается шаблонизация | Описание
--- | --- | --- | --- | ---
`duration` | `string` | Нет | Да | Длительность ожидания в секундах.
`until` | `string` | Нет | Да | Временная метка в формате [ISO 8601](https://ru.wikipedia.org/wiki/ISO_8601). Например, `2024-12-23T18:25:43.511Z`.
`next` | `string` | Нет | Нет | Идентификатор следующего шага.