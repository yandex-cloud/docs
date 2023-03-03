{% if product == "yandex-cloud" %}

Before you start, sign up for {{ yandex-cloud }} and create a billing account:

1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or register if you don't have an account yet.
1. [On the billing page]({{ link-console-billing }}), make sure you linked a {% if audience != "internal" %}[billing account](../../billing/concepts/billing-account.md){% else %}billing account{% endif %} and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you don't have a billing account, {% if audience != "internal" %}[create one](../../billing/quickstart/index.md){% else %}create one{% endif %}.

If you have an active billing account, you can go to the [cloud page]({{ link-console-cloud }}) to create or select a folder to run your infrastructure.

{% endif %}

{% if product == "cloud-il" %}

Before you start, sign up for {{ yandex-cloud }}. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or register if you don't have an account yet.

Thereafter you can create or select a folder to run your infrastructure in from the [{{ yandex-cloud }} page]({{ link-console-cloud }}).

{% endif %}

{% if audience != "internal" %}[Learn more about clouds and folders](../../resource-manager/concepts/resources-hierarchy.md).{% endif %}
