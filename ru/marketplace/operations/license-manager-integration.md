# Интеграция с {{ license-manager }} API

Если вы создали [подписку](../concepts/subscription.md) внутри тарифа:
* `Subscription`, вам необходимо настроить интеграцию с [{{ license-manager }} API](../license-manager/api-ref/index.md), чтобы подписка работала корректно.
* `PAYG`, пользователь автоматически перейдет на этот тариф, когда отвяжет подписку от ресурса или срок действия подписки закончится. При необходимости вы можете настроить интеграцию с {{ license-manager }} API.

{% list tabs group=service %}

- {{ compute-name }} {#compute}

    1. {% include [lmi-step-1](../../_includes/marketplace/lmi-step-1.md) %}

    1. В коде вашего продукта реализуйте следующие шаги:

        1. {% include [lmi-step-2](../../_includes/marketplace/lmi-step-2.md) %}

        1. {% include [lmi-step-3](../../_includes/marketplace/lmi-step-3.md) %}

- {{ managed-k8s-name }} {#managed-k8s}

    1. {% include [lmi-step-1](../../_includes/marketplace/lmi-step-1.md) %}

    1. В коде вашего продукта реализуйте следующие шаги:

        1. Получение идентификатора установки приложения в кластер {{ k8s }} и привязка его к подписке. [Пример кода](https://github.com/yandex-cloud-examples/yc-marketplace-k8s-check-licenses/tree/main).

        1. {% include [lmi-step-2](../../_includes/marketplace/lmi-step-2.md) %}

        1. {% include [lmi-step-3](../../_includes/marketplace/lmi-step-3.md) %}

- {{ cloud-apps-name }} {#cloud-apps}

    1. {% include [lmi-step-1](../../_includes/marketplace/lmi-step-1.md) %}

    1. В коде вашего продукта реализуйте следующие шаги:

        1. {% include [lmi-step-2](../../_includes/marketplace/lmi-step-2.md) %}

        1. {% include [lmi-step-3](../../_includes/marketplace/lmi-step-3.md) %}

- SaaS {#saas}
    
    1. Создайте [сервисный аккаунт](../../iam/operations/sa/create.md), от имени которого будете проверять активность подписок, купленных пользователями, и привязывать такие подписки к сервису:
        1. Авторизуйтесь в [кабинете партнера {{ marketplace-short-name }}]({{ link-cloud-partners }}).
        1. Откройте раздел **{{ ui-key.yacloud_portal.portal.publisher-users }}**.
        1. Нажмите **{{ ui-key.yacloud_portal.acl.common.action_via-federation }}**.
        1. В открывшемся окне укажите [идентификатор сервисного аккаунта](../../iam/operations/sa/get-id.md) и нажмите **{{ ui-key.yacloud_portal.common.action_add }}**.
        1. Найдите сервисный аккаунт в списке и нажмите ![image](../../_assets/marketplace/three_dots.png) → **{{ ui-key.yacloud_portal.common.action_change }}**.
        1. В открывшемся окне нажмите **+ Добавить роль**, выберите `license-manager.saasSubscriptionSupervisor` и нажмите **Сохранить**.
    
    1. Аутентифицируйтесь в {{ license-manager }} API от имени сервисного аккаунта. Для аутентификации используйте [IAM-токен](../../iam/concepts/authorization/iam-token.md).

    1. Создайте страницу, на которую нужно перенаправить пользователя во время привязки купленной им подписки к сервису.

        При перенаправлении пользователя на такую страницу в строке запроса, в параметре `token`, передается JWT-токен (`instanceToken`), сгенерированный {{ yandex-cloud }}. JWT-токен действует 15 минут и содержит:
        * идентификатор подписки, которую купил пользователь (`license_instance_id`);
        * идентификатор шаблона подписки, который вы создали в кабинете партнера (`license_template_id`).

    1. Пока действует JWT-токен, на созданной странице авторизуйте пользователя и присвойте ему уникальный идентификатор (`resourceId`). Уникальный идентификатор пользователя (`resourceId`) необходимо сгенерировать самостоятельно в коде продукта.

    1. Привяжите уникальный идентификатор пользователя (`resourceId`) к купленной пользователем подписке (`license_instance_id`).

        Привязать идентификатор к подписке можно с помощью метода REST API [ensure](../license-manager/saas/api-ref/Lock/ensure.md) для ресурса [Lock](../license-manager/saas/api-ref/Lock/index.md) или вызова gRPC API [LockService/Ensure](../license-manager/saas/api-ref/grpc/Lock/ensure.md).

        Передайте в запросе JWT-токен (`instanceToken`) и уникальный идентификатор пользователя (`resourceId`). В [ответе](../license-manager/saas/api-ref/Lock/ensure.md#yandex.cloud.operation.Operation) вы получите идентификатор привязки (`lock_id`) — он находится в параметре `metadata`. Если в ответе ошибка, значит, подписка не привязалась к сервису и нужно попросить пользователя заново пройти все шаги.

    1. Организуйте периодическую проверку того, что привязка подписки активна. Используйте для этого идентификатор привязки (`lock_id`), полученный на предыдущем шаге.

       Получить актуальную информацию о привязке подписки можно с помощью метода REST API [get](../license-manager/saas/api-ref/Lock/get.md) для ресурса [Lock](../license-manager/saas/api-ref/Lock/index.md) или вызова gRPC API [LockService/Get](../license-manager/saas/api-ref/grpc/Lock/get.md).

       В ответе должен возвращаться активный ресурс Lock, для которого `state = LOCKED`, а время окончания действия подписки `end_time` находится в будущем.

       {% note info %}

       Учитывайте, что пользователь может отвязать одну подписку от сервиса и привязать к нему другую. Ваш код должен корректно обрабатывать такие случаи.

       {% endnote %}

    1. Организуйте бизнес-логику обработки подписок: учет потребления, ограничения по времени, количеству пользователей и т.п.

{% endlist %}

## Тестирование интеграции {#test}

Примеры кода и тестовый сервер для проверки работы интеграции с {{ license-manager }} API доступны в [репозитории на GitHub](https://github.com/yandex-cloud-examples/yc-marketplace-api-usage-examples/blob/main/licensemanager/README.md).
