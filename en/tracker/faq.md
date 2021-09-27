# Troubleshooting


## How to migrate from Yandex.Connect to {{ org-full-name }}

Starting from {{release-date }} 2021, once you activate {{ tracker-full-name }}, an organization is automatically created in {{ org-full-name }}. Your organization's admin can connect [identity federation]({{ link-org-add-federation }}) to it so that your employees can log in to {{ tracker-name }} using their corporate accounts. You're charged for using {{ tracker-name }} through [{{ yandex-cloud }} billing](../billing/index.yaml).

If you activated {{ tracker-name }} before {{release-date }}, the service is linked to your company in Yandex.Connect. We'll move all organizations from Yandex.Connect to {{ org-full-name }} stepwise without involving their admins. We'll notify an organization's admin in advance before carrying out migration to {{ org-full-name }}.

## How to use {{ tracker-name }} on mobile devices {#mobile}

The {{ tracker-name }} mobile app is available:

- In [Google Play]({{ mobile-google-link }}) for mobile devices powered by Android 8.0 or newer versions.

- In the [App Store]({{ mobile-apple-link }}) for mobile devices powered by iOS 11.0 or newer versions.

For more information see [{#T}](mobile.md).


## How to add users to {{ tracker-name }} {#section_yvw_tyk_nbb}

To enable your employees to use {{ tracker-name }}:

1. [Add them to {{ tracker-name }}](enable-tracker.md#add-users). You can invite users with Yandex accounts or create an identity federation so that your company's employees can log in to {{ tracker-name }} with their corporate accounts.

1. Set up [full access to {{ tracker-name }}](enable-tracker.md#access) for the employees.

## How to delete an issue {#section_z1d_r1l_nbb}

You can&apos;t delete an issue, but you can close it with an appropriate resolution. For example, duplicate issues can be closed with the resolution `Duplicate`, and issues created by mistake can be closed with the resolution `Cancelled`. For more information about issues, see [Working with issues](user/ticket-in-progress.md).


{% note tip %}

You can [delete a queue](manager/delete-queue.md) and all issues in it. [Move](user/edit-ticket.md#section_xwx_qpn_jz) the issues you don't need to a special queue and then delete it.

{% endnote %}


## How to delete a queue {#section_hk4_r1l_nbb}

Only a user with access to editing queue settings can delete a queue. This is usually the administrator or owner of the queue.

To delete a queue:

1. Open the [queue page](user/queue.md).

1. To the left of the queue name, select ![](../_assets/tracker/icon-settings.png) → **Administration**.

1. Go to the **Basic settings** tab.

1. Click **Delete queue**.

1. Confirm the deletion.

For more information about deleting a queue, see [Delete a queue](manager/delete-queue.md).

## Can an issue have multiple assignees? {#section_jlb_yyk_nbb}

An issue can only have one assignee at a time. There are several ways to organize the work of multiple people:

- If multiple people are working on the issue in turn, change the assignee at different points while the issue is in progress.
- If multiple people are working on the issue simultaneously, divide it into sub-issues and assign each one to a different person.

For more information about issues, see [Working with issues](user/ticket-in-progress.md).

## I don't have access to an issue {#section_xgr_zng_4bb}

The access permissions for issues are determined by the [queue settings](manager/queue-access.md).

If you don't have sufficient rights to access the queue page and its issues, contact the queue owneror your organization's administrator. The queue owner's name is usually mentioned in the access restriction message.

If you can access the queue page but some of the issues remain unaccessible, some of the issues may include [components with limited access](manager/queue-access.md#section_tbh_cs5_qbb). If this is the case, please contact the queue owner.

## How can I find the queue owner? {#section_hgc_xyk_nbb}

The owner is listed on the **Description** tab on the queue page. For more information, see [List of queue issues](user/queue.md).