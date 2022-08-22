# Pricing policy

{% if product == "cloud-il" %}

At the [Preview](../overview/concepts/launch-stages.md) stage, Microsoft products can be used free of charge.

{% include [windows-trial](../_includes/compute/windows-trial.md) %}

{% endif %}

{% if product == "yandex-cloud" %}

## Service plans {#plans}

There are multiple plans for Microsoft products in {{ yandex-cloud }}:

* _PAYG (Pay As You Go)_: You're only charged for actual usage. {{ price-per-hour-count-per-second }}
* _Monthly_: You're charged for using a product on a monthly basis. In the first month, you only pay for the days after the purchase. Licenses are assigned to specific VMs. If you re-create a VM, you'll have to purchase a new license.
* _BYOL (Bring Your Own License)_: Pricing that is available for some products and lets you run software on the {{ yandex-cloud }} infrastructure using licenses purchased from third-party providers (sellers). You're only charged for using {{ yandex-cloud }} resources. This lets you buy your own licenses and manage them. For more information about license mobility in {{ yandex-cloud }}, see [Microsoft licenses](licensing.md#mobility).

## Computing resources {#compute}

The total cost depends on the resources used. Learn more about {{ compute-name }} pricing at [{#T}](../compute/pricing.md).

## Minimum configuration {#config}

The minimum configuration required for running the selected product is set automatically. You can calculate the cost of the desired configuration using the [calculator]({{ link-cloud-calculator }}).

{% endif %}