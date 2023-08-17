# Roles and access rights in {{ tracker-name }}

{{ tracker-full-name }} is a [service](../organization/manage-services.md) that can be enabled for your organization in {{ yandex-cloud }}. The organization's administrator who enabled {{ tracker-name }} also becomes an [administrator in {{ tracker-name }}](#admin).

{% note info %}

If a user creates a new organization when [enabling {{ tracker-name }}](enable-tracker.md), they become the organization owner and {{ tracker-name }} administrator.

{% endnote %}

The administrator can add other users to {{ tracker-name }} or set up access rights for them. For more information about adding users, see [{#T}](add-users.md).

## Access management {#access-management}

User rights in {{ tracker-name }} are classified into two types:

* Global level of access to {{ tracker-name }}:
   * [Administrator](#admin).
   * [Employee with full access](access.md#set).
   * [Employee with the <q>Read</q> access](access.md#readonly).

* Rights of access to individual elements of the {{ tracker-name }} structure:
   * [Queue issues](manager/queue-access.md). The rights to create, view, and edit issues can be set up by the queue owner or another user permitted by the owner to edit the [queue settings](manager/edit-queue-general.md).

      You can set up access to issues in your queue for individual users, groups, and roles:
        * **Access**: Users listed in the **Access** field of an issue.
        * **Follower**: Users who subscribed to the issue.
        * **Reporter**: The person who created the issue.
        * **Assignee**: The person assigned to the issue.
        * **Queue owner**.
        * **Queue team members**: Users added to the [queue team](manager/queue-team.md).

        To limit access of users to specific issues inside the queue, you can use [components](manager/queue-access.md#access-components).

   * [Filters](user/create-filter.md#nastroit-dostup-k-filtru) and [dashboards](user/share-dashboard.md#section_k2z_1nk_pz). Rights to access filters and dashboards can be set up by their owner or another user permitted by the owner.

{% note info %}

When using the [{{ tracker-full-name }} API](about-api.md), the application requests are run on behalf of the {{ tracker-name }} user. To run certain actions over the API, the user on whose behalf the request is executed should have relevant rights in {{ tracker-name }}.

To learn more about granting applications the rights for the {{ tracker-full-name }} API, see [{#T}](concepts/access.md).

{% endnote %}

## Levels of access {#roles}

The user's access level applies throughout the {{ tracker-name }} organization structure. The access level determines which actions the user can execute: create or edit issues, change the {{ tracker-name }} settings. The access levels assigned to users are [set up by the administrator](access.md).

#### Administrator {#admin}

The administrator has access to all the elements of the {{ tracker-name }} structure. By default, the {{ tracker-name }} administrator is the user who created the [{{ yandex-cloud }} organization](../organization/).

To assign other employees as administrators, use [{{ yandex-360 }}](https://yandex.ru/support/business/admin.html).

Actions available to the administrator:

* Adding [users](add-users.md) to {{ tracker-name }} and setting up the [access level](access.md) for them.
* Managing {{ tracker-name }} settings: creating new [statuses](manager/workflow-status-edit.md#create-status), [resolutions](manager/create-resolution.md#create-resolution), and [issue types](manager/add-ticket-type.md#create-ticket-type), setting up [global fields](user/create-param.md#section_global_field) in issues, adding [repositories](manager/add-repository.md).
* Managing [queue settings](manager/edit-queue-general.md).
* Linking to {{ tracker-name }} a [billing account](billing-account.md) to pay for the services.

   {% note alert %}

   Only the billing account owner has access to managing the billing account by default. For other users, [access](../billing/security/) to the billing account can be provided via the [Billing service](../billing/).

   {% endnote %}


To create and edit issues, the administrator also needs [full access](#full-access) to {{ tracker-name }}.

#### Employees with full access {#full-access}

The employees with full access can enjoy all the features of {{ tracker-full-name }}.

{% note info %}

If you have six or more users with full access in your organization, you'll need to [pay](pricing.md) for the service monthly. Small teams can use {{ tracker-name }} free-of-charge, if no more than five employees would create or edit issues.

{% endnote %}

Actions available to employees:

* [Create](user/create-ticket.md) and [edit](user/edit-ticket.md) issues.
* Search for issues using the [filter builder](user/create-filter.md) and [query language](user/query-filter.md).
* Adding [comments](user/comments.md).
* Creating and configuring [queues](queue-intro.md).
   Including creation of [automatic actions](user/autoactions.md), [triggers](user/trigger.md), and [macros](manager/create-macroses.md) in the queue.
* Using [issue boards](user/agile.md) and [dashboards](user/dashboard.md).
* Setting up the [interface](user/personal.md) and [notifications](user/notifications.md).

#### Employees with the <q>Read</q> access {#read-only}

The employees who work in the <q>Read</q> mode, can enjoy the features related to viewing issues in {{ tracker-name }}. You don't pay for the service use by such users.

If the [administrator](#admin) has <q>Read</q> access to {{ tracker-name }}, they themselves can edit access rights for their account.

Actions available in the <q>Read only</q> mode:

* View issues, [dashboards](user/dashboard.md), and [issue boards](manager/agile.md#sec_boards).
* Search for issues using the [filter builder](user/create-filter.md) and [query language](user/query-filter.md).
* View [queue pages](manager/quick-filters.md), [statistics](manager/statistics.md), and more.
* Setting up the [interface](user/personal.md) and [notifications](user/notifications.md).