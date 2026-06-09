# Как создать бота в Telegram


В этом руководстве вы создадите [бота](../../../glossary/chat-bot.md) для Telegram с помощью serverless-технологий. Бот сможет отвечать на сообщения и отправлять изображения.

Для хранения статических ресурсов используется [Yandex Object Storage](../../../storage/index.md). [Yandex API Gateway](../../../api-gateway/index.md) принимает запросы пользователей и перенаправляет их для обработки в [Yandex Cloud Functions](../../../functions/index.md).


<iframe width="640" height="360" src="https://runtime.strm.yandex.ru/player/video/vplvjsucpfkw2e4zdzy2?autoplay=0&mute=0" allow="autoplay; fullscreen; picture-in-picture; encrypted-media" frameborder="0" scrolling="no"></iframe>

[Смотреть видео на YouTube](https://www.youtube.com/watch?v=C2Ahit2EBo0).



Вы можете создать инфраструктуру для Telegram-бота с помощью одного из инструментов:

* [Консоль управления](console.md) — используйте этот способ, чтобы пошагово создать сокращатель ссылок в консоли управления Yandex Cloud.
* [Terraform](terraform.md) — используйте этот способ, чтобы упростить создание ресурсов и управление ими, используя подход «инфраструктура как код» (IaC). Скачайте пример конфигурации Terraform с репозитория SourceCraft, а затем разверните инфраструктуру с помощью [Terraform-провайдера Yandex Cloud](../../../terraform/index.md).