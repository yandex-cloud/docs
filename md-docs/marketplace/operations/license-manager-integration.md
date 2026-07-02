[Документация Yandex Cloud](../../index.md) > [Yandex Cloud Marketplace](../index.md) > Партнерам > Пошаговые инструкции > Интеграция с License Manager API

# Интеграция с License Manager API

Если вы создали [подписку](../concepts/subscription.md) внутри тарифа:
* `Subscription`, вам необходимо настроить интеграцию с [License Manager API](../license-manager/api-ref/quickstart.md), чтобы подписка работала корректно.
* `PAYG`, пользователь автоматически перейдет на этот тариф, когда отвяжет подписку от ресурса или срок действия подписки закончится. При необходимости вы можете настроить интеграцию с [License Manager API](../license-manager/api-ref/quickstart.md).

Как настроить интеграцию с License Manager SaaS API, читайте в [Как начать работать с Marketplace License Manager SaaS API](../license-manager/saas/api-ref/quickstart.md).

{% list tabs group=service %}

- Compute Cloud {#compute}

    1. Получите идентификатор шаблона подписки (`license_template_id`).
       
       Идентификатор шаблона подписки можно посмотреть в кабинете партнера Cloud Marketplace. Используйте идентификатор в коде продукта, чтобы управлять подпиской.

    1. В коде вашего продукта реализуйте следующие шаги:

        1. Периодическая проверка того, что подписка активна.
           
           Получить актуальную информацию о подписке можно с помощью метода REST API [list](../license-manager/api-ref/Instance/list.md) для ресурса [Instance](../license-manager/api-ref/Instance/index.md) или вызова gRPC API [InstanceService/List](../license-manager/api-ref/grpc/Instance/list.md).
           
           {% note info %}
           
           Учитывайте, что пользователь может отвязать один ресурс от подписки и привязать к ней другой. Ваш код должен корректно обрабатывать такие случаи.
           
           {% endnote %}

        1. Организация бизнес-логики обработки подписок: учет потребления, ограничения по времени, количеству пользователей и т.п.

- Managed Service for Kubernetes {#managed-k8s}

    1. Получите идентификатор шаблона подписки (`license_template_id`).
       
       Идентификатор шаблона подписки можно посмотреть в кабинете партнера Cloud Marketplace. Используйте идентификатор в коде продукта, чтобы управлять подпиской.

    1. В коде вашего продукта реализуйте следующие шаги:

        1. Получение идентификатора установки приложения в кластер Kubernetes и привязка его к подписке. [Пример кода](https://github.com/yandex-cloud-examples/yc-marketplace-k8s-check-licenses/tree/main).

        1. Периодическая проверка того, что подписка активна.
           
           Получить актуальную информацию о подписке можно с помощью метода REST API [list](../license-manager/api-ref/Instance/list.md) для ресурса [Instance](../license-manager/api-ref/Instance/index.md) или вызова gRPC API [InstanceService/List](../license-manager/api-ref/grpc/Instance/list.md).
           
           {% note info %}
           
           Учитывайте, что пользователь может отвязать один ресурс от подписки и привязать к ней другой. Ваш код должен корректно обрабатывать такие случаи.
           
           {% endnote %}

        1. Организация бизнес-логики обработки подписок: учет потребления, ограничения по времени, количеству пользователей и т.п.

- Cloud Apps {#cloud-apps}

    1. Получите идентификатор шаблона подписки (`license_template_id`).
       
       Идентификатор шаблона подписки можно посмотреть в кабинете партнера Cloud Marketplace. Используйте идентификатор в коде продукта, чтобы управлять подпиской.

    1. В коде вашего продукта реализуйте следующие шаги:

        1. Периодическая проверка того, что подписка активна.
           
           Получить актуальную информацию о подписке можно с помощью метода REST API [list](../license-manager/api-ref/Instance/list.md) для ресурса [Instance](../license-manager/api-ref/Instance/index.md) или вызова gRPC API [InstanceService/List](../license-manager/api-ref/grpc/Instance/list.md).
           
           {% note info %}
           
           Учитывайте, что пользователь может отвязать один ресурс от подписки и привязать к ней другой. Ваш код должен корректно обрабатывать такие случаи.
           
           {% endnote %}

        1. Организация бизнес-логики обработки подписок: учет потребления, ограничения по времени, количеству пользователей и т.п.

{% endlist %}

## Тестирование интеграции {#test}

Примеры кода и тестовый сервер для проверки работы интеграции с License Manager API доступны в [репозитории на GitHub](https://github.com/yandex-cloud-examples/yc-marketplace-api-usage-examples/blob/main/licensemanager/README.md).