# Requirements for {{ yandex-cloud }} account

One of the conditions of using Microsoft licensed products is providing additional user details. If they are incorrect or not given in your billing account, we'll have to discontinue access to all Microsoft services and licenses.

## Required details in billing account {#required-data}

For businesses:

* Company name.
* {% if product == "yandex-cloud" %}TIN.{% endif %}{% if product == "cloud-il" %}Tax identification number.{% endif %}
* Address.
* Country.

For individuals:

* First and last name.
* Address.
* Country.

{% if product == "cloud-il" %}

{% note info %}

To provide additional user details in your billing account contact [technical support](../support/overview.md#response-time).

{% endnote %}

{% endif %}


{% if product == "yandex-cloud" %}

## Updating details {#how-to-update}

{% note info %}

If you don't have permissions to edit the details, refer to the administrator of your billing account.

{% endnote %}

To check and update user details, follow these steps:

1. In the management console, go to [**Billing**]({{ link-console-billing }}?section=accounts).

1. Select a billing account in whose cloud you use a Microsoft product and go to the **Overview** page.

1. Make sure that the **Payer information** section contains up-to-date user details. If the details are outdated or incomplete, click **Edit data in Yandex Balance**. A page for editing payer details opens.

1. Update the details. For more information, see [Help for Yandex Balance](https://yandex.ru/support/balance/operations/change-data.html).

When deploying the product in the future, you will not need to provide the details again.

{% endif %}