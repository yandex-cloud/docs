# Migrating to {{ tracker-name }}

{% note warning %}

Only the company administrator can transfer data to {{ tracker-name }}.

{% endnote %}

If you are already using a project management service, use the API to transfer your data to {{ tracker-name }}:

1. Make sure that you are logged in to {{ tracker-name }} with an administrator account.

1. Get [API access](concepts/access.md).

1. [Create queues](manager/create-queue.md) to import your issues to.

1. Configure the queue:

    - Add [issue types and resolutions](manager/add-ticket-type.md).

    - Set up [statuses](manager/workflow.md).

    - Create [versions](manager/versions.md) and [components](manager/components.md).

1. If necessary, create [issue boards](manager/create-agile-board.md) and [sprints](manager/create-agile-sprint.md).

1. Import data to {{ tracker-name }} [using the API](concepts/import/import-ticket.md).