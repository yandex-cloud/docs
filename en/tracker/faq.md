# General questions about {{ tracker-name }}


## How to migrate data from {{ ya-360 }} to {{ org-full-name }}

Since {{release-date }} 2021, when connecting {{ tracker-full-name }}, an organization is created automatically in {{ org-full-name }}. The administrator can add to the organization an [identity federation](../organization/add-federation.md) so that employees can use their work accounts to log in to {{ tracker-name }}. {{ tracker-name }} usage is charged through [{{ billing-name }}](../billing/).

If {{ tracker-name }} is connected to {{release-date }}, the service is linked to an organization in {{ ya-360 }}. We will gradually migrate all organizations from {{ ya-360 }} to {{ org-full-name }} with no effort needed from your organization's administrator. We will notify your administrator about migrating to {{ org-full-name }} in advance.


## How to use {{ tracker-name }} on a mobile device {#mobile}

The {{ tracker-name }} mobile app is available:

- In the [Google Play]({{ mobile-google-link }}) for mobile devices running Android version 8.0 and higher.

- In the [App Store]({{ mobile-apple-link }}) for mobile devices running iOS 11.0 and higher.

- In [Huawei AppGallery]({{ mobile-huawei-link }}), for mobile devices running HarmonyOS.

- As an [APK file]({{ mobile-apk-link }}) for Android.

[Learn more about the mobile app](mobile.md).


## How to add colleagues to {{ tracker-name }} {#section_yvw_tyk_nbb}

You can [invite your colleagues who have Yandex accounts to {{ tracker-name }}](add-users.md#invite_user) directly from the service interface.

If your company has a corporate user management system (for example, Active Directory), you can [set up identity federation](add-users.md#federation) to authenticate via SSO so that your colleagues can use their work accounts to [log in to {{ tracker-name }}](user/login.md).

To make sure that the added users can create and edit issues, you need to [set up full access for them](access.md#set).

## How to grant or revoke full access in {{ tracker-name }} {#full-access}

You can [manage user access](access.md#set) in the {{ tracker-name }} interface under <q>{{ ui-key.startrek.blocks-desktop_b-head.cloud-burger-users-licenses }}</q>.

Note that your total payment for using the service depends on the maximum number of users that had full access to {{ tracker-name }} during a given month. That is why first we recommend to [revoke access](disable-tracker.md) from the uses that no longer need it and then to grant access to [new users](add-users.md).

## Can you help us with implementation or migration from another service? {#migration}

We will help you select a proper partner for {{ tracker-name }} implementation. If you want to [connect more than 100 users to {{ tracker-name }}](add-users.md), we will refund you part of the implementation cost.


## How to delete an issue {#section_z1d_r1l_nbb}

You cannot delete an issue, but you can close it with an appropriate resolution. For example, duplicate issues can be closed with the <q>{{ ui-key.startrek.blocks-desktop_b-table-related-issues.relation-is-duplicated-by }}</q> resolution, while issues created by mistake can be closed with the <q>{{ ui-key.startrek.ui_components_queue-admin-tab-workflows_StatusTypeSelector.status-canceled-name }}</q> resolution. For more information about issues, see [Working with issues](user/ticket-in-progress.md).


{% note tip %}

You can [delete a queue](manager/delete-queue.md) and all the issues in it: [Move](user/move-ticket.md) the issues you don't need to a special queue and then delete it.

{% endnote %}

## How to delete a queue {#section_z1d_r1l_nbb}

Only the user who has access to editing the queue parameters can delete the queue. Usually, this is the queue [administrator](role-model.md) or owner.

To delete a queue:

1. Open the [queue page](user/queue.md).

1. To the left of the queue name, select ![](../_assets/tracker/icon-settings.png) → **{{ ui-key.startrek.blocks-desktop_page-admin.breadcrumbs-title }}**.

1. Click the **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_main.title }}** tab.

1. Click **{{ ui-key.startrek.ui_components_page-queue-admin_QueueActionsMenu.remove-queue-action }}**.

1. Confirm the deletion.

For more information about deleting a queue, see [Deleting a queue](manager/delete-queue.md).


## Can an issue have multiple assignees? {#section_jlb_yyk_nbb}

An issue can only have one assignee at a time. There are several ways to organize the work of multiple people:

- If multiple users work on an issue one after another, change the assignee as the issue progresses.
- If multiple users work on an issue at the same time, split the issue into sub-issues and specify an assignee for each sub-issue.

For more information about issues, see [Working with issues](user/ticket-in-progress.md).

## I don't have access to an issue {#section_xgr_zng_4bb}

Access permissions for issues are determined by the [queue settings](manager/queue-access.md).

If you do not have sufficient rights to access the queue page and its issues, contact the  queue owner or [admin](role-model.md). The name of the queue owner is usually specified in the access restriction message.

If you can access the queue page but some of the issues remain inaccessible, these issues may include [components with limited access](manager/queue-access.md#access-components). Make sure also to contact the queue owner.

## How can I find the queue owner? {#section_hgc_xyk_nbb}

The owner is specified on the **{{ ui-key.startrek.ui_components_IssueTabs.description-tab }}** tab on the queue page. For more information, see [List of queue issues](user/queue.md).

## Why can't I use widgets grouped by the <q>{{ ui-key.startrek-backend.fields.issue.summary-key-value }}</q> field? {#section_del_widget}

The **{{ ui-key.startrek-backend.fields.issue.summary-key-value }}** field includes the issue name: this is an arbitrary value the user comes up with. The names are almost always unique. If you try to build a table where rows or columns are grouped by a set of unique values (the **{{ ui-key.startrek-backend.fields.issue.summary-key-value }}** field), the result would be cumbersome and uninformative.

Do not use the **{{ ui-key.startrek-backend.fields.issue.summary-key-value }}** field to group data in rows or columns of [pivot tables](user/widgets.md#section_esm_vjp_pz), or as a key parameter to build [issue statistics](user/widgets.md#statistika-po-zadacham). We will soon disable data aggregation or grouping by the **{{ ui-key.startrek-backend.fields.issue.summary-key-value }}** field in widgets. All the widgets with such grouping will be deleted later.

If you have any widgets with grouping by the **{{ ui-key.startrek-backend.fields.issue.summary-key-value }}** field and you want to preserve them, you can:
* Replace your widget with a [new widget with an issue list](#replace_widget).
* [Create an additional field](#create_new_field) in your issues and store there the data you need to build grouped widgets.

### Create a new widget {#replace_widget}

If you need a simple issue list, replace your widget with an [issue list widget](user/widgets#section_ll1_zdp_pz). To do this:

1. Create a new [<q>Issues</q> widget](user/widgets#section_ll1_zdp_pz).

1. Fill in the **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-filter }}** field in the same manner as in your previous widget.

1. In the **{{ ui-key.startrek.blocks-desktop_b-dashboard-widget.title-fields }}** field, select the issue parameters to be shown in the table.

1. Fill in the remaining fields and save the new widget.

1. Delete the previous widget.

### Create an additional field and set up grouping for it {#create_new_field}

If you add keywords to issue names to use them for grouping issues in widgets, we recommend creating a separate field for such keywords. Then instead of the **{{ ui-key.startrek-backend.fields.issue.summary-key-value }}** field, you can use this new field for grouping.

1. [Create a new field](user/create-param.md) to store data that you add to the **{{ ui-key.startrek-backend.fields.issue.summary-key-value }}** field.

1. When creating issues, enter the data needed to build the widget into the new field immediately.

1. In your existing issues, move the data to the new field by an [automatic action](user/create-autoaction):

   1. Select the **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_autoaction-editor.type-toggle--update }}** type.

   1. Under **{{ ui-key.startrek.blocks-desktop_filter-edit-modal.filter--title }}**, click **{{ ui-key.startrek.blocks-desktop_issues-filter.action--add-field }}**, select **{{ ui-key.startrek.blocks-desktop_page-admin-tab_type_fields.field-type--issue }}**, and specify the issue name (the keyword used for grouping in the widget).

   1. Click **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin-tab_type_autoaction-editor.action_add-action }}** and select **{{ ui-key.startrek.blocks-desktop_trigger-action.select-action--field }}**. Then select the previously created field and copy the issue name to it.

   1. Create similar automatic actions for every possible keyword.

1. If you use an external source to create an issue (for example, [{{ forms-full-name }}](../forms/create-task.md)) when setting up [integration](manager/forms-integration.md), save the widget data to a new field.

1. [Edit](user/edit-dashboard.md#section_xz4_bk4_mz) the old widget: use the new field instead of the **{{ ui-key.startrek.ui_components_dashboard.summary-field-name }}** field in the settings.


## I still have questions. Who do I ask them to? {#other-questions}

{{ tracker-name }} users can ask their questions on the [technical support page]({{ link-tracker-support }}). You can also discuss your topics of interest in our Telegram community: [https://t.me/yandextracker](https://t.me/yandextracker).
