# Grant

Grant: Discount given {% if product == "yandex-cloud" %}to a sole proprietor, a business, or an individual {% endif %}on use of any {{ yandex-cloud }} services. The discount amount corresponds to the grant amount. The discount is applied to the total cost of services consumed.

{% if product == "yandex-cloud" %}

{% note info %}

You cannot use grants to top up [personal accounts](personal-account.md).

{% endnote %}

{% endif %}

{% include [currency](../_includes/currency.md) %}

## Initial grant {#start}
When [creating your first billing account](../quickstart/index.md), you are provided with an initial grant. For more information about the size of the initial grant and conditions for its use, see the document [Getting started](../../getting-started/usage-grant.md).

{% note info %}

Each {% if product == "yandex-cloud" %}individual, sole proprietor, or business{% endif %}{% if product == "yandex-cloud" %}client of {{ yandex-cloud }}{% endif %} can be given only one initial grant.

{% endnote %}

## Additional grants {#additional}
Additional grants can be provided by decision of a {{ yandex-cloud }} manager, or if you request them from support. You can view the amount of additional grants and their validity period in the management console.

{% if product == "yandex-cloud" %}

{% if lang == "ru" %}

## Grants for charity foundations {#foundations-grants}
Charity foundations can receive grants for {{ yandex-cloud }} services. For information about the terms of receiving grants, see the [Terms of Providing Services for Non-Profit Organizations](https://yandex.ru/legal/ngo_terms/?lang=ru).

To get a grant, please complete an application on the [Services for charity foundations](https://help.yandex.ru/business) page. Provide information about the organization and specify in the **Organization mission** field:
* The objectives you plan to achieve using {{ yandex-cloud }} services.
* Contact information (email and phone number).

Once your application is reviewed, you will be contacted to work out the details. Please have documentary evidence of your organization's activities available.

{% endif %}

{% endif %}

## Using grants {#how-to-use}
The grant priority depends on its validity period: the earlier it expires, the earlier the grant is used.