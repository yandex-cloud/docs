# Creating a queue for a development team

Each team has their own established way of planning their workload, solving issues, and releasing products. If you need {{ tracker-name }} to set up a familiar workflow for the team, use an [issue queue](queue-intro.md). A queue is an area shared by related issues being worked on under a single product or pipeline.

We recommend setting up a standalone queue for each team. You can also create several queues if you want to split the workflow into multiple pipelines. For instance, this can be useful if your development team has multiple assigned sub-teams, each performing their own issues independently.

To create a queue for the development team, do the following:

{% if audience == "external" %}

1. If your organization doesn't have {{ tracker-name }} yet, [activate it](enable-tracker.md).

1. Make sure all members of the development team have [full access to {{ tracker-name }}](access.md).

{% endif %}

1. [Create an issue queue.](manager/create-queue.md) Select a [queue template](manager/workflows.md) with statuses and issue types that are best suited to your workflow:

    - <q>Basic development model</q>: This template contains issue types and statuses that are most commonly used when developing programs and apps. A [simple issue board](#board_types) is created when you select this template.

    - <q>Software development as a service</q>: This template provides an issue type called <q>Project</q> and a status that lets you coordinate approval of your performance with the client.

    - <q>Scrum</q>: This template is suitable for teams that work with [Scrum]({{ link-wiki-scrum }}). A [<q>Scrum</q> issue board](manager/agile.md#sec_boards.md) is created when you select this template.

    - <q>Kanban</q>: This template is suitable for teams that work with [Kanban]({{ link-wiki-kanban }}). A [simple <q>Kanban</q> issue board](manager/agile.md#sec_boards.md) is created when you select this template.

    {% note info %}

    If you selected a queue template without an associated issue board, you can [create one later](manager/create-agile-board.md).

    {% endnote %}

1. If you want to change the list of issue statuses available to your queue, go to the queue settings, simply copy the [basic workflow](manager/add-workflow.md) and [edit it](manager/workflow-status-edit.md).

1. Add the employees who will be working on your product to your [queue team](manager/queue-team.md).

1. You can also configure [access rights to issues within the queue](manager/queue-access.md) if needed. For example, you can allow certain user groups to create or view issues in the queue or prevent them from doing so.

