# General questions

{% if audience == "external" %}

## How to migrate from {{ ya-360 }} to {{ org-full-name }}

Starting from {{release-date }} 2021, once you activate {{ tracker-full-name }}, an organization is automatically created in {{ org-full-name }}. Your organization's admin can connect [identity federation]({{ link-org-add-federation }}) to it so that your employees can log in to {{ tracker-name }} using their corporate accounts. You're charged for using {{ tracker-name }} through [{{ yandex-cloud }} billing](../billing/index.yaml).

If you activated {{ tracker-name }} before {{release-date }}, the service is linked to your company in {{ ya-360 }}. We'll gradually move all companies from {{ ya-360 }} to {{ org-full-name }}. No action is required from the organization's admin. We'll notify an organization's admin in advance before carrying out migration to {{ org-full-name }}.

{% endif %}

## How to use {{ tracker-name }} on mobile devices {#mobile}

The {{ tracker-name }} mobile app is available:

- In [Google Play]({{ mobile-google-link }}) for mobile devices running Android version 8.0 and higher.

- In the [App Store]({{ mobile-apple-link }}) for mobile devices running iOS 11.0 and higher.

[Learn more about the mobile app.](mobile.md)

{% if audience == "external" %}

## Adding colleagues to {{ tracker-name }} {#section_yvw_tyk_nbb}

You can [invite your colleagues to {{ tracker-name }}](add-users.md#invite_user) via the service interface provided that they have Yandex accounts.

If your company already uses a different account management system (such as Active Directory), you can [set up identity federation](add-users.md#federation) to enable SSO authentication. Then your colleagues will be able to [log in {{ tracker-name }}](user/login.md) with their accounts.

If you wish to grant issue creation and editing rights to the users you add, you need to [set up full access](access.md#set).

## Granting and revoking full access to {{ tracker-name }} {#full-access}

[You can manage user access](access.md#set) via the {{ tracker-name }} interface in the <q>Manage users</q> section.

Please note that the payment amount for using the service is determined by the maximum number of users granted full access to {{ tracker-name }} within a month. That is why we recommend that you first [disable access](disable-tracker.md) for users who don't need it and then grant access to [new users](add-users.md).

## Do you help users with integration or migration from a different platform? {#migration}

We will help you choose a suitable partner to integrate {{ tracker-name }}. If you want to [enable {{ tracker-name }}](add-users.md) for over 100 users, we will reimburse part of the integration costs.

{% endif %}

## How to delete an issue {#section_z1d_r1l_nbb}

You can't delete an issue, but you can close it with an appropriate resolution. For example, duplicate issues can be closed with the <q>Duplicate</q> resolution, while issues created by mistake can be closed with the <q>Canceled</q> resolution. For more information about issues, see [Working with issues](user/ticket-in-progress.md).

{% if audience == "external" %}

{% note tip %}

You can [delete a queue](manager/delete-queue.md) and all issues in it. [Move](user/move-ticket.md) the issues you don't need to a special queue and then delete it.

{% endnote %}

## How to delete a queue {#section_hk4_r1l_nbb}

Only a user with access to editing queue settings can delete a queue. Usually, this is the [admin](role-model.md) or queue owner.

To delete a queue:

1. Open the [queue page](user/queue.md).

1. To the left of the queue name, select ![](../_assets/tracker/icon-settings.png) → **Configure**.

1. Go to the **Basic settings** tab.

1. Click **Delete queue**.

1. Confirm the deletion.

For more information about deleting a queue, see [Deleting a queue](manager/delete-queue.md).

{% endif %}

## Can an issue have multiple assignees? {#section_jlb_yyk_nbb}

An issue can only have one assignee at a time. There are several ways to organize the work of multiple people:

- If multiple people are working on the issue in turn, change the assignee at different points while the issue is in progress.
- If multiple people are working on the issue simultaneously, divide it into sub-issues and assign each one to a different person.

For more information about issues, see [Working with issues](user/ticket-in-progress.md).

## I don't have access to an issue {#section_xgr_zng_4bb}

Access permissions to issues are determined by the [queue settings](manager/queue-access.md).

If you do not have sufficient rights to access the queue page and its issues, contact the queue owner {% if audience == "external" %} or [admin](role-model.md){% endif %}. The queue owner's name is usually mentioned in the access restriction message.

If you can access the queue page but some of the issues remain inaccessible, these issues may include [components with limited access](manager/queue-access.md#section_tbh_cs5_qbb). If this is the case, please contact the queue owner.

## How can I find the queue owner? {#section_hgc_xyk_nbb}

The owner is specified on the **Description** tab on the queue page. For more information, see [List of queue issues](user/queue.md).

## Why can't widgets be grouped by the <q>Issue</q> field? {#section_del_widget}

The **Issue** field displays the issue name, which is a user-generated value. Issue names are usually unique. If you compose a table where rows or columns are grouped by unique values (like in the **Issue** field), it will be too large and not very informative.

When creating new widgets, don't use the **Issue** field when grouping data by rows or columns in [pivot tables](user/widgets.md#section_esm_vjp_pz) or as a key parameter when composing [issue statistics](user/widgets.md#statistika-po-zadacham). Grouping by the **Issue** field for widgets will soon be disabled. All widgets using this kind of grouping will be removed.

If you have widgets that utilize grouping by the **Issue** field and you wish to retain them, here is what you can do:

* Replace your widget with a [new widget that displays an issue list](#replace_widget);
* [Create an extra field](#create_new_field) for your issues and store your widget data there.

### Creating a new widget {#replace_widget}

If you need a simple issue list, replace your widget with an [issue list widget](user/widgets#section_ll1_zdp_pz). To do this:

1. Create a new [widget for <q>Issues</q>](user/widgets#section_ll1_zdp_pz).

1. Fill in the **Filter** field in the same way you did for your previous widget.

1. Use the **Columns** field to select issue parameters you want to display in the table.

1. Fill out the remaining fields and save your new widget.

1. Remove the old widget.

### Creating and grouping by an additional field {#create_new_field}

If you add key phrases you use for grouping in widgets to the issue names, we recommend creating a separate field for them. Then you can set up grouping by the new field instead of the **Issue** field.

1. [Create a new field](user/create-param.md) to store the information you usually put in the **Issue** field.

1. When creating a new issue, enter the data for widget creation directly into the new field.

1. For existing issues, transfer your information to the new field using [auto actions](user/create-autoaction):

   1. Select **Issue update**.

   1. Go to **Filter parameters**, click **Add condition**, select **Issue**, and enter the issue name (a key phrase used for grouping in the widget).

   1. Click **Add new action** and choose **Update fields**. Then select a field you created and paste the issue name there.

   1. Create similar auto actions for all possible key phrases.

1. If you're creating issues using an external source (such as [{{ forms-full-name }}](../forms/create-task.md)), save the information required for widget creation into a new field when you set up [integration](manager/forms-integration.md).

1. [Edit](user/edit-dashboard.md#section_xz4_bk4_mz) the old widget: specify a new field to use instead of the **Issue** field in settings.

{% if audience == "external" %}

## I still have some questions. Who do I contact? {#other-questions}

{{ tracker-name }} users can ask questions on the [technical support page]({{ link-tracker-support }}). You can also join the discussion in our Telegram community: [https://t.me/yandextracker](https://t.me/yandextracker).

{% endif %}

