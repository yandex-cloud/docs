---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# How to create a queue

Each issue belongs to one of the queues. Issues with a common theme are usually grouped together in a queue. They might be issues for a specific project, department, or team.


## Create a queue {#section_mvh_5yb_gz}

To create a new queue:

1. On the top panel in {{ tracker-name }}, choose **Queues** → **+ Create queue**.

1. Select the queue template. All templates fall under one of the categories below based on their issue types and statuses:
    - **Development**: For issues related to software development and testing.
    - **Working with people and documents**: For issues related to tech support, HR, and document approval.
    - **Creating products and services**: For service projects and production issues.

    To learn more about templates and configuring them, see [{#T}](workflows.md).

    You can also [copy a queue](#section_rhb_jjb_mfb) or [create a queue manually](#section_cg3_wpq_w1b).

1. Enter a unique [key for the queue](#key). The key can consist only of Latin letters and must not contain spaces or special symbols. If you delete a queue, you can't reuse its key.

    {% note tip %}

    Try to use keys that reflect the purpose of the queue. For example, the key `HR` is suitable for Human Resources issues, while `SUPPORT` is good for support issues.

    {% endnote %}

1. Enter the name of the queue.

1. Click **Create**. The new queue is accessible from the **Queues** menu on the top panel in {{ tracker-name }}.

1. You can [change issue types and statuses](workflow.md) in the queue and configure its parameters if needed.

## Queue key {#key}

The queue key is a unique code that can be used to identify a queue. For example: `HR` or `SUPPORT`.

Each issue in the queue is assigned an issue key comprised of a queue key and an issue index.

The queue key can be used to:

- Search for issues by specifying the queue key in [filter parameters](../user/create-filter.md) and in the [query language](../user/query-filter.md).
- Directly access the queue at: `({{ link-tracker-example-2 }})`.

## Copy a queue {#section_rhb_jjb_mfb}

If you want to apply settings used in an existing queue, just copy the queue:

1. Switch to the queue creation mode and click **Copy queue**.

1. Enter a unique [key for the queue](#key).

1. Enter the name of your new queue.

1. Enter the key or name of the original queue.

1. Click **Create**. The new queue is accessible from the **Queues** menu on the top panel in {{ tracker-name }}.

1. You can [change issue types and statuses](workflow.md) in the queue and configure its parameters if needed.

## Create a queue manually {#section_cg3_wpq_w1b}

If none of the preset queue types are suitable for your issues, you can set all
parameters for the new queue manually:

1. Enter a unique [key for the queue](#key). The key can consist only of Latin letters and must not contain spaces or special symbols. If you delete a queue, you can't reuse its key.

    {% note tip %}

    Try to use keys that reflect the purpose of the queue. For example, the key `HR` is suitable for Human Resources issues, while `SUPPORT` is good for support issues.

    {% endnote %}

1. Enter the name of the queue.

1. Fill in the description of the queue. The description is displayed on the queue page on the **Description** tab.

1. Assign the owner of the queue. The owner can change the queue settings.

1. Chose the [queue team](queue-team.md) members. Just start typing the login, username, or department name and select one of the suggested options.
You need to fill in the list of team members if you want to [configure special access rights for them](queue-access.md) or assign issues to them faster.

1. Configure [notifications about issue changes](subscriptions.md) for a particular queue.

1. Set up [issue types and statuses](workflow.md) for your queue.

1. Configure [general queue settings](edit-queue-general.md). Example:
    - Default issue type and priority.
    - **Required fields for the queue**: Issue fields that are always displayed on the issue page, regardless of [user settings](../user/edit-ticket.md#section_jqw_ppn_jz).

    - **Show "Commits" tab**: Show or hide the **Commits** tab on the queue and issue pages. The tab displays all commits linked to your issue.

1. Configure [advanced queue features](queue-advanced.md). For example, create projects and components or set up automated recurring actions with issues.

