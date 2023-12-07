# How to create a queue

Each issue belongs to a queue. Queues are usually created for issues that belong to the same subject. These can be issues of a project, department, or team.


## Creating a queue {#create}

{% note warning %}

The user who created the queue becomes its owner. The owner either configures the queue themselves or assigns the [access to change the queue parameters](queue-access#set-access) to other users.

{% endnote %}

To create a new queue:

1. In the left-hand panel, select ![](../../_assets/tracker/svg/queues.svg) **{{ ui-key.startrek.ui_components_TrackerSearch.queues }}** → **New queue**.

1. Select queue template Depending on the issue types and statuses, templates belong to one of the categories:

   * **Development**: For issues related to software development and testing.
   * **Working with people and documents**: For issues related to tech support, HR, and document approval.
   * **Creating products and services**: For service projects and production issues.

   For more information about templates and their settings, see [{#T}](workflows.md).

   You can also [copy a queue](#section_rhb_jjb_mfb) or [create a queue manually](#section_cg3_wpq_w1b).

1. Enter the name of the queue.

1. Enter a [key for the queue](#key). A key can only include Latin characters without spaces or special characters.

   Try using the keys that reflect the purpose of the queue. For example, the `HR` key is suitable for issues in the Human Resources department, while `SUPPORT` is good for Support issues.

   {% note warning %}

   The queue key must be unique. You can't assign to a new queue the key that was assigned to a previously deleted queue.

   {% endnote %}

1. Click **Create**. Your new queue will appear in the **Queues** menu in the {{ tracker-name }} top panel.

1. You can [change issue types and statuses](workflow.md) in the queue and configure its parameters if needed.

## Queue key {#key}

A queue key is a unique code that enables you to identify the queue. For example, `HR` or `SUPPORT`.

Each issue in the queue is assigned an issue key that consists of the queue key and a sequential number.

You can use the queue key in order to:

- Search for issues by specifying the queue key in [filter conditions](../user/create-filter.md) and in the [query language](../user/query-filter.md).
- Directly access your queue at: `({{ link-tracker-example-2 }})`.

## Copying a queue {#section_rhb_jjb_mfb}

If you want to use the settings of an existing queue, copy the queue:

1. In the left-hand panel, select ![](../../_assets/tracker/svg/queues.svg) **{{ ui-key.startrek.ui_components_TrackerSearch.queues }}** → **New queue**.

1. Click **Copy queue**.

1. Enter the name of the new queue.

1. Enter a [key for the queue](#key). A key can only include Latin characters without spaces or special characters.

   Try using the keys that reflect the purpose of the queue. For example, the `HR` key is suitable for issues in the Human Resources department, while `SUPPORT` is good for Support issues.

   {% note warning %}

   The queue key must be unique. You can't assign to a new queue the key that was assigned to a previously deleted queue.

   {% endnote %}

1. Enter the key or name of the source queue.

1. Click **Create**. Your new queue will appear in the **Queues** menu in the {{ tracker-name }} top panel.

1. You can [change issue types and statuses](workflow.md) in the queue and configure its parameters if needed.

## Creating a queue manually {#create-manual}

If none of the preset queue types fit your issues, you can set all parameters for your new queue manually:

1. In the left-hand panel, select ![](../../_assets/tracker/svg/queues.svg) **{{ ui-key.startrek.ui_components_TrackerSearch.queues }}** → **New queue**.

1. Click **Configure the queue manually**.

1. Enter a [key for the queue](#key). A key can only include Latin characters without spaces or special characters.

   Try using the keys that reflect the purpose of the queue. For example, the `HR` key is suitable for issues in the Human Resources department, while `SUPPORT` is good for Support issues.

   {% note warning %}

   The queue key must be unique. You can't assign to a new queue the key that was assigned to a previously deleted queue.

   {% endnote %}

1. Enter the description of the queue. The description is displayed on the **Description** tab on the queue page.

1. Assign the owner for the queue. The owner can change the queue settings.

1. Choose the [queue team](queue-team.md) members. Just start typing the login, username, or department name and select one of the suggested options.

   Fill in the list of team members if you want to [configure special access rights for them](queue-access.md) or assign issues to them faster.

1. Configure [notifications about issue changes for a particular queue](subscriptions.md).

1. Set up [issue types and statuses](workflow.md) for your queue.

1. Configure the [queue's general settings](edit-queue-general.md). e.g.:

   * The type and priority of issues by default.

   * **Required fields for the queue**: Issue fields that are always displayed on the issue page, regardless of [user settings](../user/edit-ticket.md#edit-fields).


   * **Show "Commits" tab**: Show or hide the **Commits** tab on the queue and issue pages. The tab shows all commits linked to issues.

1. Set up [advanced issue management features](queue-advanced.md): for example, create projects and components or enable automation for routine actions with issues.
