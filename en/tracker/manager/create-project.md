# Creating projects

{% note info %}

You can view the **Projects** section in the [beta version of the new interface{{ tracker-full-name }}](../user/personal.md#sec_beta).

{% endnote %}

## Creating a project {#create}

To create a project:

1. In the left-hand panel, select ![](../../_assets/tracker/svg/project.svg)&nbsp;**Projects** and click **Create project**.

1. Enter project name. Try to keep it short and simple so your project is easy to work with.

1. Add more information on the **About the project** tab.
   * Project description: Describe what you're working on and your goals for the project.
   * Attached files: Materials required for the project.
   * Checklist: A list of significant project stages and goals.
   * **Status**: Specify your current progress with the project.
   * **Start date** and **End date**.
   * **Responsible employee** and **Participants**: Start entering an employee's name or username and select them from the list that appears.

1. [Add](#add-tickets) issues to the project. You can add issues from the project page or the issue page. You can also use [bulk editing](bulk-change.md) to add issues.

   Projects are not linked to a specific issue queue, so you can add issues from any queue that you have access to it. Access to project issues is determined by the settings of the [queue that the issue belongs to](../user/queue.md).

   {% note info %}
   * You can't add the same issue to multiple projects.
   * You can add up to 2000 issues to a project.

   {% endnote %}

1. By default, any new project is accessible to all employees. If you wish to restrict access to the project, find the lock icon in the upper-right corner and select **Participants only**. If enabled, this will make the project only accessible to users listed in the **Participants**, **Reporter**, and **Responsible** fields.

## Adding issues to a project {#add-tickets}

#### From the project page {#from-project}

1. Go to the **Issue list** tab and click **Add issue**.

1. To create a new issue:
   1. Select **New issue**.
   1. Enter the issue name, select a queue, and press **Enter**.

1. To add an existing issue:
   1. Select **Existing issue**.
   1. Start typing the issue's name or key and pick the option you need from the list of suggestions.

#### From issue page {#from-ticket}

1. Open the issue page.

1. Click the **Project** field on the right-hand panel. If you don't see the **Project** field, add it by clicking **Add parameters**.

1. Start typing the project's name in the **Project** field and pick the option you need from the list of suggestions.

#### Adding multiple issues {#from-bulk}

1. Find the issues you need using [filters](../user/create-filter.md).

1. Select the issues you wish to add to the project.

1. On the bottom panel, click ![](../../_assets/horizontal-ellipsis.svg) and select **Add to project**.

1. Start typing the project's name and choose the option you need from the list of suggestions.

1. Wait for the issues to be processed.

## Deleting projects {#delete}

{% note alert %}

Projects can only be deleted by the project author or the user specified in the **Responsible** field.

{% endnote %}

To delete a project:

1. In the left-hand panel, select ![](../../_assets/tracker/svg/project.svg)&nbsp;**Projects** and open the project page.

1. In the upper-right corner of the page, click ![](../../_assets/horizontal-ellipsis.svg) and select **Delete project**.

