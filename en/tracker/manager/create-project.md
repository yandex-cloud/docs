# Creating project

## Creating a project {#create}

You can create a project from scratch or based on an issue.

### New project {#new-project}

To create a project:

1. In the left panel, select ![](../../_assets/tracker/svg/project.svg)&nbsp;**Projects**, then click **Create project**.

1. Enter a name for the project. Try to make it short and clear to give a clue to the project.

1. On the **About the project** tab, add the information:

   * Project description: what are you working on and what goals you have.
   * Attachments: working materials of the project.
   * Checklist: a list of milestones or goals of the project.
   * **Status**: Specify the current stage of the project.
   * **Start date** and **End date**.
   * **Responsible**, **Clients**, and **Participants**: start typing the name or login of the employee and select a relevant option from the list.
   * **Tags**: Add or select the tags that would make it easier to find the project.

1. [Add](#add-tickets) issues to the project. You can add issues from the project page or from the issue page, as well as by using [bulk editing](bulk-change.md).

   The project isn't linked to any issue queue: that's why you can add issues to it from any queue that you have access to. Access to project issues depends on the [access settings](../user/queue.md) of the queue that the issue belongs to.

   {% note info %}

   * You can't add the same issue to multiple projects.
   * You can add no more than 2000 issues to a project.

   {% endnote %}

1. A new project is available to all the organization's employees by default. To restrict access to the project, in the upper-right corner of the page, click the lock icon and select **Members only**. In this case, the project will only be available to the users listed in the fields: **Participants**, **Reporter**, **Clients**, and **Responsible**.

### Converting an issue to a project {#convert-from-task}

The converted issue will be added to a project and the new project will show its parameters:
* Name, description, checklist
* Start date and end date.
* Reporter, assignee, and followers.

Issue comments are converted to project comments and displayed in the **About the project** tab.

To create a project based on an issue:

1. Open the issue page. The issue shouldn't belong to another project. To delete an issue from the project, clear the **Project** field on the right panel.

1. In the top right corner, select **Actions** → **Convert to project** and click **Convert**.

## Adding issues to a project {#add-tickets}

#### From the project page {#from-project}

1. Go to the **Issue list** tab, then click **Add issue**.

1. To create a new issue:

   1. Select **New issue**.
   1. Select the name of the issue, select the queue, then click **Enter**.

1. To add an existing issue:

   1. Select **Existing issue**.
   1. Start typing the issue's key or name, then pick the option you need from the list.

#### From the issue page {#from-ticket}

1. Open the issue page.

1. Click the **Project** field on the right-hand panel. If you don't see the **Project** field, add it by clicking **Add parameters**.

1. Start typing the project's name in the **Project** field and pick the option you need from the list of suggestions.

#### Adding multiple issues {#from-bulk}

1. Select the issues you need using [filters](../user/create-filter.md).

1. Select the issues that you want to add to the project.

1. In the bottom panel, click ![](../../_assets/horizontal-ellipsis.svg), then select **Add to project**.

1. Start typing the project's name and pick the option you need from the list that appears.

1. Wait for the issues to be processed.

#### Importing issues {#from-import}

1. Open your project page.

1. In the upper-right corner, click **Import issues**.

1. Click ![](../../_assets/tracker/svg/add-task.svg)&nbsp;**Add parameters** and specify an issue selection criterion.

1. Click **Import** and wait until your issues are imported.

## Deleting a project {#delete}

{% note alert %}

Both the project's reporter and the user specified in the **Responsible** field can delete the project.

{% endnote %}

To delete a project:

1. In the left panel, select ![](../../_assets/tracker/svg/project.svg)&nbsp;**Projects** or follow the [direct link]({{ link-tracker }}pages/projects) and open the project page.

1. In the upper-right corner of the page, click ![](../../_assets/horizontal-ellipsis.svg)and select **Delete project**.
