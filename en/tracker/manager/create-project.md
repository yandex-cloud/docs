---
title: Managing projects in {{ tracker-full-name }}
description: In this tutorial, you will learn how to manage projects in {{ tracker-name }}.
---

# Managing projects

In this section, you will learn how to manage your projects:

* [Creating a project](#create-project)
* [Adding issues to a project](#add-tickets)
* [Adding links for a project](#links)
* [Deleting a project](#delete)

## Creating a project {#create-project}

You can create a project from scratch or based on an issue.

### New project {#new-project}

To create a project:

1. Go to any page a project can be created from:

   * In the left-hand panel, select ![](../../_assets/tracker/svg/project.svg)&nbsp;**Projects** and click **Create** → **Project**.
   * In the [list of portfolios and projects](my-projects.md) of the **List** tab, click **Create project** under the list.

1. Enter a name for the project. Try to make it short and clear to give a clue to the project.

1. On the **About the project** tab, add the information:

   * Project description: what are you working on and what goals you have.
   * Attachments: working materials of the project.
   * Checklist: List of milestones or goals of the project.
   * **Status**: Specify the current stage of the project.
   * **Start date** and **End date**.
   * **Responsible**, **Clients**, and **Participants**: Start typing the name or login of the employee and select a relevant option from the list.
   * **Tags**: Add or select the tags that would make it easier to find the project you need.   

1. [Add](#add-tickets) issues to the project. You can add issues from the project page or from the issue page, as well as by using [bulk editing](bulk-change.md).

   The project is not linked to any issue queue: that is why you can add issues to it from any queue that you have access to. Access to project issues depends on the [access settings](../user/queue.md) of the queue that the issue belongs to.

   {% note info %}

   You can add no more than 2,000 issues to a project.

   {% endnote %}

1. A new project is available to all the organization's employees by default. To restrict access to the project, in the top-right corner of the page, click the lock icon and select **Members only**. This will make the project available only to the users specified in the **Author**, **Person in charge**, **Customers**, **Followers**, and **Participants** fields.

### Converting an issue to a project {#convert-from-task}

The converted issue will be added to a project and the new project will show its parameters:
* Name, description, checklist.
* Start date and end date.
* Reporter, assignee, and followers.

Issue comments are converted to project comments and displayed in the **About the project** tab.

To create a project based on an issue:

1. Open the issue page. The issue should not belong to another project. To delete an issue from the project, clear the **{{ ui-key.startrek-backend.fields.issue.project-key-value }}** field in the right-hand panel.

1. In the top-right corner, select **{{ ui-key.startrek.ui_components_issue-actions_IssueMenu.title }}** → **{{ ui-key.startrek.ui_components_issue-actions_IssueMenu.convert-to-project }}**, then click **Convert**.


## Adding issues to a project {#add-tickets}

An issue may belong to multiple projects. The issue has one main project and the others are considered additional. In additional projects, you can [work](project-list.md) with the issue just like in the main project: it will appear in the issue list and on the Gantt chart. In other parts of the {{ tracker-name }} interface (dashboards, queues, filtering page, etc.), the issue will still be listed only in its main project.

{% note info %}

You can add your issue to up to 40 projects, including the main one.

{% endnote %}

### From the project page {#from-project}

1. Go to the **Issue list** tab, then click **{{ ui-key.startrek.ui_components_projects_Table.add-issue }}**.

1. To create a new issue:

   1. Select **New issue**.
   1. Select the name of the issue, select the queue, then click **Enter**. The project will become the issue's main project.

1. To add an existing issue:

   1. Select **Existing issue**.
   1. Start typing the issue's key or name, then pick the option you need from the list. If the issue has the main project, the current project will become an additional one for the issue. If the issue is not added to other projects, this project will become its main.

### From the issue page {#from-ticket}

1. Open the issue page.

1. Click the **Project** field on the right-hand panel. If you do not see the **Project** field, add it by clicking **{{ ui-key.startrek.ui_components_issues-import_IssuesImportFilters.add-parameters }}**.

1. In the **Main** or **Additional** field, start typing the project name and pick the option you need from the list. Click **Save**.

### Adding multiple issues {#from-bulk}

1. Select the issues you need using [filters](../user/create-filter.md).

1. Select the issues that you want to add to the project.

1. In the left-hand panel, click ![](../../_assets/horizontal-ellipsis.svg) and select **{{ ui-key.startrek.ui_components_IssueBulkActionPanel.add-to-projects }}**.

1. Start typing the project name and pick the option you need from the list that appears.

1. Wait for the issues to be processed.

### Importing issues {#from-import}

1. Open your project page.

1. In the top-right corner, click **Import issues**.

1. Click ![](../../_assets/tracker/svg/add-task.svg)&nbsp;**{{ ui-key.startrek.ui_components_issues-import_IssuesImportFilters.add-parameters }}** and specify an issue selection criterion.

1. Click **{{ ui-key.startrek.ui_components_issues-import_IssuesImportDialog.import }}** and wait until your issues are imported.

## Adding links for a project {#links}

You can link a project to other projects or portfolios to group entities based on a common topic or set their hierarchy.

You can find a list of linked projects and portfolios on the **About project** tab under the project description.

### Creating a link {#create-link}

To create a link to another project or portfolio:

1. Go to **About project** and click ![plus](../../_assets/console-icons/plus.svg)**Add link**.
1. Choose the appropriate link type:

   * **Depends on**: Start of work on the current project depends on the completion of another project or portfolio.
   * **Blocks**: Execution of this project blocks the start of work on another project or portfolio.

1. Choose the entity type for linking.

1. Choose an entity to create a link to:

   * **New**: To create a new entity. Choose the entity type for linking (![briefcase](../../_assets/console-icons/briefcase.svg) for a portfolio and ![folders](../../_assets/console-icons/folders.svg) for a project), enter a name, specify the deadline and click **Create**.
   * **Existing**: If a project or portfolio already exists. Specify the key and the name of the entity and select it from the list.

The link will appear in the list of linked projects and portfolios.

### Changing the link type {#change-link-type}

To change a project's link type:

1. Open your project page.
1. Go to **About project**.
1. In the **Depends on** or **Blocks** list under the project description, select the link whose type you want to change.
1. Next to the linked entity, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) → **Change link type** and choose a new type.

### Removing a link {#delete-link}

To remove a project's link:

1. Open your project page.
1. Go to **About project**.
1. In the **Depends on** or **Blocks** list under the project description, select the link you want to remove.
1. Next to the linked entity, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) → **Remove link**.

## Deleting a project {#delete}

{% note alert %}

A project can be deleted by its author or the user specified in the **Responsible** field.

{% endnote %}

To delete a project:

1. In the left-hand panel, select ![](../../_assets/tracker/svg/project.svg)&nbsp;**Projects** or follow the [direct link]({{ link-tracker }}pages/projects/list) and open the project page.

1. In the top-right corner of the page, click ![](../../_assets/horizontal-ellipsis.svg) and select **Delete project**.
