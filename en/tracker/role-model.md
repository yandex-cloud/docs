# Roles and access rights in {{ tracker-name }}

{{ tracker-full-name }} is one of the [services](../organization/manage-services.md) you can connect to your company {{ yandex-cloud }}. The organization's admin who enabled {{ tracker-name }} also becomes [the admin of {{ tracker-name }}](#admin).

{% note info %}

If a user creates a new company when [activating {{ tracker-name }}](enable-tracker.md), they become the organization's owner and admin in {{ tracker-name }}.

{% endnote %}

The admin can add other users to {{ tracker-name }} and configure their access rights. To learn more about adding users, see [{#T}](add-users.md).

## Managing access {#access-management}

There are two types of user access rights to {{ tracker-name }}:

* Global access to {{ tracker-name }}:
    * [Administrator](#admin).
    * [Employee with full access](access.md#set).
    * [Employee with <q>Read-only</q>](access.md#readonly) access.

* Access to specific elements in {{ tracker-name }}:

    * [Queues](manager/queue-access.md). Access rights to create, view, and edit issues can be configured by the queue owner or another user who is granted access to [queue settings](manager/edit-queue-general.md).

       You can grant access to issues within a queue to individual users or specific groups and roles:
        * **Access**: Users listed in the **Access** field of an issue.
        * **Follower**: Users who subscribed to the issue.
        * **Reporter**: The person who created the issue.
        * **Assignee**: The person assigned to the issue.
        * **Queue owner**.
        * **Queue team members**: Users added to the [queue team](manager/queue-team.md).

        You can use [components](manager/queue-access.md#section_tbh_cs5_qbb) to limit user access to specific issues within a queue.

    * [Filters](user/create-filter.md#nastroit-dostup-k-filtru) and [dashboards](user/share-dashboard.md#section_k2z_1nk_pz). Access rights to filters and dashboards can be configured by the their owner or another user who received access rights from the owner.

{% note info %}

When managing the [{{ tracker-full-name }} API](about-api.md), all app requests are carried out on behalf of the {{ tracker-name }} user. To perform actions via the API, the user on whose behalf the requests are made must have sufficient rights in {{ tracker-name }}.

For more information about granting apps access to the {{ tracker-full-name }} API, see [{#T}](concepts/access.md).

{% endnote %}

## Access levels {#roles}

A user's access level applies to all pages in {{ tracker-name }}. The access level determines the actions available to users, such as creating and editing issues, or changing the {{ tracker-name }} settings. Access levels are [configured by the admin](access.md).

#### Administrator {#admin}

The administrator has access to all {{ tracker-name }} elements. By default, the {{ tracker-name }} admin is the user who created the [company {{ yandex-cloud}}](../organization/).

If you wish to grant admin rights to other users, use [{{ ya-360 }}](https://yandex.ru/support/business/admin.html).

Actions available to admins:

* Adding [users](add-users.md) to {{ tracker-name }} and configuring their [access levels](access.md).

* Managing {{ tracker-name }} settings: creating new [statuses](manager/workflow-status-edit.md#create-status), [resolutions](manager/create-resolution.md#create-resolution) and [issue types](manager/add-ticket-type.md#create-ticket-type), configuring [global issue fields](user/create-param.md#section_global_field), and adding [repositories](manager/add-repository.md).

* Managing [queue settings](manager/edit-queue-general.md).

* Linking {{ tracker-name }} [billing accounts](billing-account.md) used to pay for services.

    {% note alert %}

    By default, a billing account can only be managed by its owner. To grant [access](../billing/security/) to a billing account to other users, use [Billing](../billing/).

    {% endnote %}

To create and edit issues, the admin also needs [full access](#full-access) to {{ tracker-name }}.

#### Employees with full access {#full-access}

Employees with full access rights can use all {{ tracker-full-name }} features.

{% note info %}

If you company has 6 or more employees with full access rights, you will need to make monthly [payments](pricing.md) for the service. Smaller teams can use {{ tracker-name }} for free provided that no more than 5 users are allowed to create and edit issues.

{% endnote %}

Actions available to users:

* [Creating](user/create-ticket.md) and [editing](user/edit-ticket.md) issues.
* Searching for issues using the [filter builder](user/create-filter.md) and the [query language](user/query-filter.md).
* Adding [comments](user/comments.md).
* Creating and configuring [queues](queue-intro.md).
This includes creating [auto actions](user/autoactions.md), [triggers](user/trigger.md), and [macros](manager/create-macroses.md) in queues.
* Managing [issue boards](user/agile.md) and [dashboards](user/dashboard.md).
* Configuring the [interface](user/personal.md) and [notifications](user/notifications.md).

#### Users with <q>Read-only access</q> {#read-only}

Users with <q>Read-only</q> access rights can use features related to viewing issues in {{ tracker-name }}. These users don't have to pay for the service.

If the [admin](#admin) has access to {{ tracker-name }} in <q>Read-only mode</q>, they can change their account's access settings on their own.

Actions available in <q>Read-only mode</q>:

* Viewing issues, [dashboards](user/dashboard.md), and [issue boards](manager/agile.md#sec_boards).
* Searching for issues using the [filter builder](user/create-filter.md) and the [query language](user/query-filter.md).
* Viewing [queue pages](manager/quick-filters.md), [statistics](manager/statistics.md), and more.
* Configuring the [interface](user/personal.md) and [notifications](user/notifications.md).

