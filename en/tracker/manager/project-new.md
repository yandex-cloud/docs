# Projects

The project is any kind of activity that has some established goals and timeframes.

In {{ tracker-name }}, projects are sets of issues that have a common goal. Projects aren't linked to issue queues. That's why projects are helpful when you need to group issues from different teams focused on the same goal.

## Getting started {#quick-start}

To start working on a project in {{ tracker-name }}, [create](create-project.md) a new project and add issues. Projects may include issues from different queues.

Plan your work and manage your timeframes using a [Gantt chart](../gantt/project.md).

## The project page {#page}

In the new {{ tracker-name }} interface, you can open any project available to you from the navigation panel on the left: click ![](../../_assets/tracker/svg/project.svg)&nbsp;**{{ ui-key.startrek.blocks-desktop_b-queues-info.projects }}** or follow the [direct link]({{ link-tracker }}pages/projects) and select a project from the list.

The project page shows the details of the team, goals, and issues of the project:

* **{{ ui-key.startrek.ui_components_projects_HeaderTabs.description-tab }}** tab. It includes the project description, status, timeframes, names of the author and employee responsible for the project, the list of its team members, comments, customers, and tags.

* **{{ ui-key.startrek.ui_components_projects_HeaderTabs.issues-tab }}** tab. The list shows both open issues and closed issues. You can filter the issue list. For more information, see [{#T}](project-list.md).

* **{{ ui-key.startrek.ui_components_projects_HeaderTabs.gantt-tab }}** tab. Your schedule of resolving project issues. The Gantt chart specifies the timeframes of the issues and relationships between them. For more information, see [{#T}](../gantt/project.md).

* **{{ ui-key.startrek.ui_components_projects_HeaderTabs.board-tab }}** tab. A virtual board with cards that makes it easy to track statuses of project issues. For more information, see [{#T}](./boards-project.md).

   {% note info %}

   The project board is also shown under ![](../../_assets/tracker/svg/boards.svg)&nbsp;**{{ ui-key.startrek.ui_components_NavigationBar.boards }}** in the left-hand panel. By default, this dashboard is named <q>`<Project name>` project dashboard</q>.

   {% endnote %}

You can track your project indicator in the upper-right corner of the project page. The indicator is filled depending on the number of closed issues.

To restrict access to the project, in the top-right corner of the page, click the lock icon and select **{{ ui-key.startrek.ui_components_ProjectAccessButton.private-access }}**. Doing so will make the project only available to the users listed in the **{{ ui-key.startrek.ui_components_Project.sidebar-param-title--teamUsers }}**, **{{ ui-key.startrek.ui_components_Project.sidebar-param-title--createdBy }}**, **{{ ui-key.startrek.ui_components_Project.sidebar-param-title--clients }}**, and **{{ ui-key.startrek.ui_components_Project.sidebar-param-title--lead }}** fields.
