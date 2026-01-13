---
title: Integration with the {{ license-manager }} API
description: Follow this guide to set up integration with the {{ license-manager }} API.
---

# Integration with the {{ license-manager }} API

If you created a [subscription](../concepts/subscription.md) within one of these service plans:
* `Subscription`: Set up integration with the [{{ license-manager }} API](../license-manager/api-ref/quickstart.md) for your subscription to work properly.
* `PAYG`: User will automatically switch to this service plan as soon as they unlink the subscription from a resource or as soon as the subscription expires. You can set up integration with the [{{ license-manager }} API](../license-manager/api-ref/quickstart.md) if required.

To set up integration with the {{ license-manager }} SaaS API, see [this guide](../license-manager/saas/api-ref/quickstart.md).

{% list tabs group=service %}

- {{ compute-name }} {#compute}

    1. {% include [lmi-step-1](../../_includes/marketplace/lmi-step-1.md) %}

    1. Implement the following steps in your product code:

        1. {% include [lmi-step-2](../../_includes/marketplace/lmi-step-2.md) %}

        1. {% include [lmi-step-3](../../_includes/marketplace/lmi-step-3.md) %}

- {{ managed-k8s-name }} {#managed-k8s}

    1. {% include [lmi-step-1](../../_includes/marketplace/lmi-step-1.md) %}

    1. Implement the following steps in your product code:

        1. Getting the ID of application installation to the {{ k8s }} cluster and linking it to the subscription. [Sample code](https://github.com/yandex-cloud-examples/yc-marketplace-k8s-check-licenses/tree/main).

        1. {% include [lmi-step-2](../../_includes/marketplace/lmi-step-2.md) %}

        1. {% include [lmi-step-3](../../_includes/marketplace/lmi-step-3.md) %}

- {{ cloud-apps-name }} {#cloud-apps}

    1. {% include [lmi-step-1](../../_includes/marketplace/lmi-step-1.md) %}

    1. Implement the following steps in your product code:

        1. {% include [lmi-step-2](../../_includes/marketplace/lmi-step-2.md) %}

        1. {% include [lmi-step-3](../../_includes/marketplace/lmi-step-3.md) %}

{% endlist %}

## Integration testing {#test}

For code examples and a test server you can use to check the {{ license-manager }} API integration, see [this GitHub repository](https://github.com/yandex-cloud-examples/yc-marketplace-api-usage-examples/blob/main/licensemanager/README.md).
