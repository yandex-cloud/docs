# Интеграция с {{ license-manager }} API

Если вы создали [подписку](../concepts/subscription.md) внутри тарифа:
* `Subscription`, вам необходимо настроить интеграцию с [{{ license-manager }} API](../license-manager/api-ref/index.md), чтобы подписка работала корректно.
* `PAYG`, пользователь автоматически перейдет на этот тариф, когда отвяжет подписку от ресурса или срок действия подписки закончится. При необходимости вы можете настроить интеграцию с {{ license-manager }} API.

{% list tabs %}

- {{ compute-name }}

    1. {% include [lmi-step-1](../../_includes/marketplace/lmi-step-1.md) %}

    1. В коде вашего продукта реализуйте следующие шаги:

        1. {% include [lmi-step-2](../../_includes/marketplace/lmi-step-2.md) %}

        1. {% include [lmi-step-3](../../_includes/marketplace/lmi-step-3.md) %}

- {{ managed-k8s-name }}

    1. {% include [lmi-step-1](../../_includes/marketplace/lmi-step-1.md) %}

    1. В коде вашего продукта реализуйте следующие шаги:

        1. Получение идентификатора установки приложения в кластер {{ k8s }} и привязка его к подписке. [Пример кода](https://github.com/yandex-cloud-examples/yc-marketplace-k8s-check-licenses/tree/main).

        1. {% include [lmi-step-2](../../_includes/marketplace/lmi-step-2.md) %}

        1. {% include [lmi-step-3](../../_includes/marketplace/lmi-step-3.md) %}

- {{ cloud-apps-name }}

    1. {% include [lmi-step-1](../../_includes/marketplace/lmi-step-1.md) %}

    1. В коде вашего продукта реализуйте следующие шаги:

        1. {% include [lmi-step-2](../../_includes/marketplace/lmi-step-2.md) %}

        1. {% include [lmi-step-3](../../_includes/marketplace/lmi-step-3.md) %}

- SaaS

    1. Создайте:

        * страницу, на которую нужно перенаправить пользователя. При перенаправлении пользователя в строке запроса, в параметре `token`, будет передаваться токен, сгенерированный {{ yandex-cloud }}. Токен действует 10 минут. За это время авторизуйте пользователя и присвойте ему уникальный идентификатор, который после нужно привязать к подписке.
        * [сервисный аккаунт](../../iam/operations/sa/create.md). Чтобы от его имени уникальный идентификатор пользователя привязывался к подписке:
            1. Авторизуйтесь в [кабинете партнера {{ marketplace-short-name }}]({{ link-cloud-partners }}).
            1. Откройте раздел **{{ ui-key.yacloud_portal.portal.publisher-users }}**.
            1. Нажмите **{{ ui-key.yacloud_portal.acl.common.action_via-federation }}**.
            1. В открывшемся окне укажите [идентификатор сервисного аккаунта](../../iam/operations/sa/get-id.md) и нажмите **{{ ui-key.yacloud_portal.common.action_add }}**.
            1. Найдите сервисный аккаунт в списке и нажмите ![image](../../_assets/marketplace/three_dots.png) → **{{ ui-key.yacloud_portal.common.action_change }}**.
            1. В открывшемся окне нажмите **+ Добавить роль**, выберите `license-manager.saasSubscriptionSupervisor` и нажмите **Сохранить**.
            1. Аутентифицируйтесь в {{ license-manager }} API от имени сервисного аккаунта. Для аутентификации используйте [API-ключ](../../iam/concepts/authorization/api-key.md).

    1. {% include [lmi-step-1](../../_includes/marketplace/lmi-step-1.md) %}

    1. В коде вашего продукта реализуйте следующие шаги:

        1. Получение уникального идентификатора пользователя, который нужно привязать к подписке.

        1. Привязка уникального идентификатора пользователя к подписке.

            Привязать идентификатор к подписке можно с помощью метода REST API [ensure](../license-manager/saas/api-ref/Lock/ensure.md) для ресурса [Lock](../license-manager/saas/api-ref/Lock/index.md) или вызова gRPC API [LockService/Ensure](../license-manager/saas/api-ref/grpc/lock_service.md#Ensure).

        1. Периодическая проверка того, что подписка активна.

            Получить актуальную информацию о подписке можно с помощью метода REST API [list](../license-manager/api-ref/Instance/list.md) для ресурса [Instance](../license-manager/api-ref/Instance/index.md) или вызова gRPC API [InstanceService/List](../license-manager/api-ref/grpc/instance_service.md#List).

            {% note info %}

            Учитывайте, что пользователь может отвязать один идентификатор от подписки и привязать к ней другой. Ваш код должен корректно обрабатывать такие случаи.

            {% endnote %}

        1. {% include [lmi-step-3](../../_includes/marketplace/lmi-step-3.md) %}

{% endlist %}
