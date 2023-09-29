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
|| **Single Sign-On (SSO)** | Supported.  | Supported. [Learn more](../organization/concepts/add-federation.md) ||
|| **Organizations per user on the {{ ya-360 }} domain** | Users with domain accounts may only belong to the organization this domain is connected for. | Users with domain accounts may belong to any organization. ||
|| **Connecting a domain** | You can connect a domain for an organization. | You cannot connect a domain. ||
|| **Groups** | Support for hierarchy-based divisions and one-level groups. | You can only set up [one-level groups](../organization/operations/manage-groups.md) of users. ||
|| **Organization administrator privileges** | The {{ ya-360 }} administrator becomes an administrator in {{ tracker-name }}. | Starting March 2023, {{ org-full-name }} administrators will also be administrators in {{ tracker-name }}. You will also be able to appoint administrators by [granting](../organization/security/index.md) them the `tracker.admin` role. ||
|| **Additional features** | {{ ya-360 }} services | [{{ yandex-cloud }} services]({{ link-cloud-services }}) ||
|#

## Selecting an organization for {{ tracker-name }} {#connect}

Starting April 17, 2023, you will be able to choose which service to use:

* To continue using both services, you will need to pay for {{ ya-360 }} usage based on the [selected service plan]({{ link-ya-360-tariffs }}). {{ tracker-name }} usage is paid for [separately](./pricing.md).

   {% note info %}

   If you do not submit payment for using {{ ya-360 }}, {{ tracker-name }} will continue running, but you will not be able to edit the list of your organization members.

   {% endnote %}

* To only use {{ org-full-name }}, you will need to disable the {{ ya-360 }} organization in the {{ tracker-name }} interface.

   {% note info %}

   If your organization is only running in {{ ya-360 }}, you will also be able to activate {{ org-full-name }}.

   {% endnote %}

* To only use {{ ya-360 }}, you will need to disable the {{ org-full-name }} organization in the {{ tracker-name }} interface.

## Switching from {{ ya-360 }} to {{ org-full-name }} {#reconnect}

A {{ ya-360 }} organization administrator can change an organization for {{ tracker-name }} and switch to {{ org-full-name }}.

* If you already have an organization enabled in {{ org-full-name }}, you will be switched to it automatically with no additional actions required. You can check this by going to ![](../_assets/tracker/svg/admin.svg) **{{ ui-key.startrek.blocks-desktop_page-admin.breadcrumbs-title }}** → ![](../_assets/tracker/svg/organizations.svg) [**{{ ui-key.startrek.ui_components_page-admin_PageAdmin.menu-item-orgs }}**]({{ link-tracker }}admin/orgs).

* If you have a {{ org-full-name }} organization you want to switch to, but it is linked to a different {{ tracker-name }}, {{ wiki-name }}, or {{ forms-name }}, contact [support](troubleshooting.md). This is required because, when switching organizations, all data will be deleted.

The steps below can only be completed by a {{ ya-360 }} organization administrator who will also become a {{ org-full-name }} organization administrator.

1. If you do not have an organization in {{ org-full-name }}, create one following [this guide](../organization/operations/enable-org.md). If you already have an organization, skip this step.

1. In {{ tracker-name }}, click ![](../_assets/tracker/svg/admin.svg) **{{ ui-key.startrek.blocks-desktop_page-admin.breadcrumbs-title }}** → ![](../_assets/tracker/svg/organizations.svg) [**{{ ui-key.startrek.ui_components_page-admin_PageAdmin.menu-item-orgs }}**]({{ link-tracker }}admin/orgs) in the left-hand panel. In the {{ org-full-name }} organizations section, click **{{ ui-key.startrek.ui_components_page-admin_OrgPanes_DirectoryOrgPane.domain-task-action }}** and select the organization you need. Wait until the users and groups from {{ org-full-name }} are synced in {{ tracker-name }}, which may take up to 30 minutes.

1. In {{ org-full-name }}, add [users](../organization/operations/manage-users.md) and [groups](../organization/operations/manage-groups.md) in the same way as in {{ ya-360 }}. A group name in {{ tracker-name }} is generated as per the **{{ ui-key.startrek.blocks-desktop_b-form-new-component.desc }}** field value or, if it is not provided, the **{{ ui-key.startrek.blocks-desktop_b-form-new-component.name }}** field value.

   {% note info %}

   Users registered in both organizations with the same credentials will be able to continue using {{ tracker-name }} without any changes. For other users in the new organization, you will need to reconfigure access rights to {{ tracker-name }}, queues, filters, dashboards, {{ wiki-name }} pages, and forms in {{ forms-name }}.

   {% endnote %}

1. Set up roles in {{ org-full-name }}: if your organization had other administrators, [grant them roles](../organization/security/index.md#add-role), such as `admin` or `tracker.admin`.

1. In {{ tracker-name }}, set up [access permissions](./access.md) for the users or groups.

   {% note info %}

   In the group access settings, under ![](../_assets/tracker/svg/admin.svg) **{{ ui-key.startrek.blocks-desktop_page-admin.breadcrumbs-title }}** → [**{{ ui-key.startrek.ui_components_page-admin_PageAdmin.menu-item-groups }}**]({{ link-tracker }}admin/groups), you will see two **All employees** groups: one with the {{ ya-360 }} organization employees and the other with the employees from both organizations.

   {% endnote %}

If you do not need the {{ ya-360 }} organization, do not delete it just yet; we will notify you as soon as this is required. The steps described above are enough to avoid switching to the {{ ya-360 }} paid plan.


If you still have questions, please contact our [technical support](troubleshooting.md).