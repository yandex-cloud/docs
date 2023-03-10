# Managing organizations in {{ tracker-name }}

In {{ tracker-name }}, user management is performed through organizations. There are two types of organizations: [{{ org-full-name }}](../organization/) and [{{ ya-360 }}]({{ link-ya-360 }}). Moving forward, you will be able to use both services simultaneously.

## {{ ya-360 }} and {{ org-full-name }} comparison {#features}

To make it easier for you to choose the service that suits you best, we made a comparison of {{ ya-360 }} and {{ org-full-name }} features.

#|
|| | **{{ ya-360 }}** | **{{ org-full-name }}** ||
|| **Pricing** |

Starting April 17, 2023, the free {{ ya-360 }} version will be disabled and the services will be provided on a [paid]({{ link-ya-360-notfree }}) basis only.
{{ tracker-name }} usage is paid for [separately](./pricing.md).

|

{{ org-full-name }} is completely free of charge.
{{ tracker-name }} usage is paid for [separately](./pricing.md).

||
|| **Employee accounts** | Accounts on Yandex or your enterprise domain. | Accounts on Yandex and domains delegated to {{ ya-360 }}. ||
|| **Single Sign-On (SSO)** | Supported. [Learn more]({{ link-ya-360-sso }}) | Supported. [Learn more](../organization/add-federation.md) ||
|| **Organizations per user on the {{ ya-360 }} domain** | Users with domain accounts may only belong to the organization this domain is connected for. | Users with domain accounts may belong to any organization. ||
|| **Connecting a domain** | You can [connect](https://yandex.ru/support/business/domains/add-domain.html) a domain for an organization. | You cannot connect a domain. ||
|| **Groups** | Support for [hierarchy-based divisions]({{ link-ya-360-units }}) and [one-level groups](link-ya-360-groups). | You can only set up [one-level groups](../organization/manage-groups.md) of users. ||
|| **Organization administrator privileges** | The {{ ya-360 }} administrator becomes an administrator in {{ tracker-name }}. | Starting March 2023, {{ org-full-name }} administrators will also be administrators in {{ tracker-name }}. You will also be able to appoint administrators by [granting](../organization/roles.md) them the `tracker.admin` role. ||
|| **Additional features** | [{{ ya-360 }}]({{ link-ya-360-services }}) services | [{{ yandex-cloud }}]({{ link-cloud-services }}) services ||
|#

## Selecting an organization for {{ tracker-name }} {#connect}

Starting April 17, 2023, you will be able to choose which service to use:

* To continue using both services, you will need to pay for {{ ya-360 }} usage based on the [selected service plan]({{ link-ya-360-tariffs }}). {{ tracker-name }} usage is paid for [separately](./pricing.md).

   {% note info %}

   If you do not pay for using {{ ya-360 }}, {{ tracker-name }} will continue running, but you will not be able to edit the list of your organization members.

   {% endnote %}

* To only use {{ org-full-name }}, you will need to disable the {{ ya-360 }} organization in the {{ tracker-name }} interface.

   {% note info %}

   If your organization is only running in {{ ya-360 }}, you will also be able to activate {{ org-full-name }}.

   {% endnote %}

* To only use {{ ya-360 }}, you will need to disable the {{ org-full-name }} organization in the {{ tracker-name }} interface.

## Linking {{ tracker-name }} to another organization {#reconnect}

In March 2023, administrators will be able to choose an organization when [activating](./enable-tracker.md) {{ tracker-name }}. Later on, administrators of multiple organizations will be able to change {{ tracker-name }} binding to an organization.

{% note info %}

Changing the organization {{ tracker-name }} is linked to only allowed within one organization management service: either {{ ya-360 }} or {{ org-full-name }}.

{% endnote %}

Once a new organization is linked, the current one will be disconnected from {{ tracker-name }}, {{ wiki-name }}, and {{ forms-name }}. Its data will not be lost. However, the current organization users will be marked as dismissed, the groups will be deleted, and the access rights will be revoked.

Users registered in both organizations with the same credentials will be able to continue using {{ tracker-name }} without any changes. For other users in the new organization, you will need to reconfigure access rights to {{ tracker-name }}, queues, filters, dashboards, {{ wiki-name }} pages, and forms in {{ forms-name }}.
