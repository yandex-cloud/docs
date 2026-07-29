[Документация Yandex Cloud](../../../../../index.md) > [Yandex Serverless Integrations](../../../../index.md) > [Концепции](../../../index.md) > Workflows > [Спецификация YaWL](../index.md) > Управляющие шаги > Fail

# Fail

{% note info %}

На данный момент Workflows поддерживается в двух интерфейсах — [Yandex Cloud](https://console.yandex.cloud/link/serverless-integrations/workflows/workflows) и [Yandex AI Studio](https://aistudio.yandex.ru/platform/link//workflows). При этом:

* рабочие процессы, [созданные в интерфейсе Yandex Cloud](../../../../operations/workflows/workflow/create-constructor.md), автоматически _доступны_ в интерфейсе AI Studio;
* рабочие процессы, созданные в интерфейсе AI Studio, _недоступны_ в интерфейсе Yandex Cloud.

С 3 сентября 2026 года Workflows перестанет поддерживаться в интерфейсе Yandex Cloud. Для создания рабочих процессов и управления ими используйте интерфейс AI Studio.

{% endnote %}

Завершает запуск рабочего процесса с ошибкой. Если находится внутри [Foreach](foreach.md) или [Parallel](parallel.md), завершает весь запуск, а не только текущую ветку выполнения.

Имя поля | Тип | Обязательное | Поддерживается [шаблонизация](../../templating.md) | Описание
--- | --- | --- | --- | ---
`errorMessage` | `string` | Да | Да | Сообщение об ошибке.