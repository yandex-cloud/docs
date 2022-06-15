{% if product == "yandex-cloud" %}

Before working, you need to register in {{yandex-cloud }} and create a billing account:

1. Go to the [management console]({{ link-console-main }}). Then log in to {{ yandex-cloud }} or sign up if don't already have an account.
1. [On the billing page]({{ link-console-billing }}), make sure you linked a {% if audience != "internal" %}[billing account](../../billing/concepts/billing-account.md){% else %}billing account{% endif %}, and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you don't have a billing account, {% if audience != "internal" %}[create one](../../billing/quickstart/index.md){% else %}create one{% endif %}.

If you have an active billing account, you can create or select a folder to run your VM in from the [{{ yandex-cloud }} page]({{ link-console-cloud }}).

{% endif %}

{% if product == "cloud-il" %}

Before working, you need to register in {{yandex-cloud }}. Go to the [management console]({{ link-console-main }}). Then log in to {{ yandex-cloud }} or sign up if don't already have an account.

Thereafter you can create or select a folder to run your infrastructure in from the [{{ yandex-cloud }} page]({{ link-console-cloud }}).

{% endif %}

{% if audience != "internal" %}[Learn more about clouds and folders](../../resource-manager/concepts/resources-hierarchy.md).{% endif %}