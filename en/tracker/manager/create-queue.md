# Creating queues

Each issue belongs to one of the queues. Issues with a common theme are usually grouped together in a queue. They might be issues for a specific project, department, or team.



## Creating a queue {#section_mvh_5yb_gz}

{% note warning %}

The user who created the queue becomes its owner. The owner can configure the queue on their own or grant other users [access to edit queue settings](queue-access#set-access).

{% endnote %}

To create a new queue:

1. On the top panel in {{ tracker-name }}, select **Queues** → **+ Create queue**.

1. Select the queue template. All templates fall under one of the categories below based on their issue types and statuses:
    - **Development**: For issues related to software development and testing.
    - **Working with people and documents**: For issues related to tech support, HR, and document approval.
    - **Creating products and services**: For service projects and production issues.

    For more information about templates and their settings, see [{#T}](workflows.md).

    You can also [copy a queue](#section_rhb_jjb_mfb) or [create a queue manually](#section_cg3_wpq_w1b).

1. Enter the name of the queue.

1. Enter a [queue key](#key). The key can consist only of Latin letters and must not contain spaces or special symbols.

    Try to use keys that reflect the purpose of the queue. For example, the `HR` key is suitable for issues in the Human Resources department, while `SUPPORT` is good for Support issues.

    {% note warning %}

    The queue key must be unique. You can't assign a queue key that's already been used for a queue that has been deleted.

    {% endnote %}

1. Click **Create**. Your new queue appears in the **Queues** menu on the top panel in {{ tracker-name }}.

1. You can change [issue types and statuses](workflow.md) in the queue and configure its parameters if needed.

## Queue key {#key}

The queue key is a unique code that can be used to identify a queue. For example, `HR` or `SUPPORT`.

Each issue in the queue is assigned an issue key comprised of a queue key and an issue index.

The queue key can be used to:

- Search for issues by specifying the queue key in [filter conditions](../user/create-filter.md) and in the [query language](../user/query-filter.md).
- Directly access your queue at: `({{ link-tracker-example-2 }})`.

## Copying a queue {#section_rhb_jjb_mfb}

If you want to apply settings used in an existing queue, just copy the queue:

1. Switch to queue creation mode and click **Copy queue**.

1. Enter the name of your new queue.

1. Enter a [queue key](#key). The key can consist only of Latin letters and must not contain spaces or special symbols.

    Try to use keys that reflect the purpose of the queue. For example, the `HR` key is suitable for issues in the Human Resources department, while `SUPPORT` is good for Support issues.

    {% note warning %}

    The queue key must be unique. You can't assign a queue key that's already been used for a queue that has been deleted.

    {% endnote %}

1. Enter the key or name of the original queue.

1. Click **Create**. Your new queue appears in the **Queues** menu on the top panel in {{ tracker-name }}.

1. You can change [issue types and statuses](workflow.md) in the queue and configure its parameters if needed.

## Creating a queue manually {#section_cg3_wpq_w1b}

If none of the preset queue types fit your issues, you can set all
parameters for your new queue manually:

1. Enter the name of the queue.

1. Enter a [queue key](#key). The key can consist only of Latin letters and must not contain spaces or special symbols.

    Try to use keys that reflect the purpose of the queue. For example, the `HR` key is suitable for issues in the Human Resources department, while `SUPPORT` is good for Support issues.

    {% note warning %}

    The queue key must be unique. You can't assign a queue key that's already been used for a queue that has been deleted.

    {% endnote %}

1. Fill in the description of the queue. The description is displayed on the **Description** tab on the queue page.

1. Assign the owner of the queue. The owner can change the queue settings.

1. Choose the [queue team](queue-team.md) members. Just start typing the login, username, or department name and select one of the suggested options.
Fill in the list of team members if you want to [configure special access rights for them](queue-access.md) or assign issues to them faster.

1. Configure [notifications about issue changes](subscriptions.md) for a particular queue.

1. Set up [issue types and statuses](workflow.md) for your queue.

1. Configure the queue's [general settings](edit-queue-general.md). Example:
    - Default issue type and priority.
    - **Required fields for the queue**: Issue fields that are always displayed on the issue page, regardless of [user settings](../user/edit-ticket.md#section_jqw_ppn_jz).


    - **Show "Commits" tab**: Show or hide the **Commits** tab on the queue and issue pages. The tab displays all commits linked to your issue.

1. Configure [advanced queue features](queue-advanced.md). For example, create projects and components or set up automated recurring actions with issues.

