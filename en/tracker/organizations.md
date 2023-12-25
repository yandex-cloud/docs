# {{ ya-360 }} will no longer be free of charge

Starting April 17, 2023, the free {{ ya-360 }} version will be running with certain [restrictions]({{ link-ya-360-notfree }}). In this tutorial, you will learn how to continue using {{ tracker-name }} if you do not need the {{ ya-360 }} services.

## Who will be affected by the changes? {#affect}

The [changes]({{ link-ya-360-notfree }}) will affect all {{ tracker-name }} users with a free-of-charge organization in {{ ya-360 }}.

To see what organizations your {{ tracker-name }} is linked to, click ![](../_assets/tracker/svg/admin.svg) **Admin settings** → ![](../_assets/tracker/svg/organizations.svg) [**{{ ui-key.startrek.ui_components_page-admin_PageAdmin.menu-item-orgs }}**]({{ link-tracker }}admin/orgs) in the left-hand panel. To check if you pay for an organization in {{ ya-360 }}, click **{{ ui-key.startrek.ui_components_page-admin_OrgMainInfoPane.org-manage-button }}** in the section with the appropriate organization and go to **Payment and service plan**.

{% cut "Why do I have an organization in {{ ya-360 }} if I only had {{ org-full-name }} set up?" %}

Previously, organizations in {{ org-full-name }} did not support managing {{ tracker-name }} user groups. That is why a {{ ya-360 }} organization was automatically created for an organization in {{ org-full-name }} and the settings of the users of these organizations were synced.

{% endcut %}

## What will change? {#changes}

### For {{ ya-360 }}

On April 17, 2023, {{ ya-360 }} will suggest that the owners of free-of-charge organizations switch to the paid service plan they will be charged for separately from {{ tracker-name }} [services](./pricing.md).

Unless you switch to the paid service plan, the following changes take effect starting April 18, 2023:
* You will no longer be able to edit the lists of organization members in {{ ya-360 }}.
* If you used your organization in {{ ya-360 }} for managing groups in {{ org-full-name }}, the groups will no longer be synced.

### For {{ org-full-name }}

Starting March 2023, {{ org-full-name }} will support user group management in {{ tracker-name }}.

{{ org-full-name }} administrators will also be administrators in {{ tracker-name }} (the `organization-manager.admin` and `organization-manager.organizations.owner` [roles](../organization/security/index.md#admin)). You will be able to appoint an administrator by [granting](../organization/security/index.md) a user the `tracker.admin` role.

{{ org-full-name }} will remain free of charge.

### For {{ tracker-name }}

The {{ tracker-name }} interface will allow you to choose which organization to use.

## What should I do on April 17, 2023? {#what-to-do}

If it is important to you that the organization management service remains free of charge, enable the {{ org-full-name }} organization in the {{ tracker-name }} interface and disable {{ ya-360 }}. We will send an email with detailed instructions to {{ tracker-name }} administrators in March 2023.

If you need to use the {{ ya-360 }} features, switch to the paid service plan.

You can also enable both organizations and take advantage of each of them. To help you decide, we made a [comparison of organization service features](./cloud-vs-360.md#features).

## I have a question {#support}

If you still have questions, please contact our [technical support](troubleshooting.md).

