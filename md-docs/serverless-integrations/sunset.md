[Документация Yandex Cloud](../index.md) > [Yandex Serverless Integrations](index.md) > Serverless Integrations

# Cервис Yandex Serverless Integrations закрыт

{% note warning %}

Сервис Yandex Serverless Integrations прекратил работу 8 октября 2026 года.

{% endnote %}

## Что произошло {#what-happens}

Сервис Yandex Serverless Integrations, который объединял несколько функциональностей, прекратил работу. Сами возможности при этом сохранились в других сервисах платформы:

* Yandex Workflows переехал в [AI Studio](https://aistudio.yandex.ru/docs/ru/ai-studio/concepts/workflows/workflow). Все рабочие процессы и логика работы с ними сохранились.

* EventRouter прекратил работу. Вместо него можно использовать триггеры для функций Cloud Functions, контейнеров Serverless Containers, API-шлюзов API Gateway и рабочих процессов Workflows.

* Yandex API Gateway продолжает работать как отдельный сервис.

## Что будет с вашими данными {#data}

Резервные копии ваших данных (шины, коннекторы, правила) будут храниться до 31 января 2027 года — их можно запросить через [техническую поддержку](https://center.yandex.cloud/support).

## Миграция {#migration}

В качестве альтернативы шинам EventRouter можно использовать триггеры. Некоторые шины были перенесены автоматически, некоторые — нужно перенести самостоятельно.

Мы подготовили руководство, которое поможет при миграции: [Миграция с EventRouter на триггеры](tutorials/eventrouter-migration.md).

{% note warning %}

Мы рекомендуем перенести все шины самостоятельно. Автоматический перенос не гарантирует полную идентичность функционирования системы после миграции.

{% endnote %}

## Если у вас есть вопросы {#support}

Если у вас остались вопросы по закрытию сервиса:

* Обратитесь в [техническую поддержку](https://center.yandex.cloud/support).
* Свяжитесь с вашим аккаунт-менеджером.

Спасибо, что пользовались Yandex Serverless Integrations.