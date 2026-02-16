---
title: Интеграция с {{ license-manager }} API
description: Следуя данной инструкции, вы сможете настроить интеграцию с {{ license-manager }} API.
---

# Интеграция с {{ license-manager }} API

Если вы создали [подписку](../concepts/subscription.md) внутри тарифа:
* `Subscription`, вам необходимо настроить интеграцию с [{{ license-manager }} API](../license-manager/api-ref/quickstart.md), чтобы подписка работала корректно.
* `PAYG`, пользователь автоматически перейдет на этот тариф, когда отвяжет подписку от ресурса или срок действия подписки закончится. При необходимости вы можете настроить интеграцию с [{{ license-manager }} API](../license-manager/api-ref/quickstart.md).

Чтобы настроить интеграцию с {{ license-manager }} SaaS API, см. [{#T}](../license-manager/saas/api-ref/quickstart.md).

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

{% endlist %}

## Тестирование интеграции {#test}

Примеры кода и тестовый сервер для проверки работы интеграции с {{ license-manager }} API доступны в [репозитории на GitHub](https://github.com/yandex-cloud-examples/yc-marketplace-api-usage-examples/blob/main/licensemanager/README.md).
