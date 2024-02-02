# Projects

The project is any kind of activity that has some established goals and timeframes.

In {{ tracker-name }}, projects are sets of issues that have a common goal. Projects are not linked to issue queues. That is why you can use projects to group issues from different teams focused on the same goal.

You can combine multiple projects into a [project portfolio](portfolio.md).

## Getting started {#quick-start}

To start working on a project in {{ tracker-name }}, [create](create-project.md) a new project and add issues. Projects may include issues from different queues.

Plan your work and manage your timeframes using a [Gantt chart](../gantt/project.md). Use [milestones](milestones.md) to track a project's progress and monitor its deadlines.

## Project page {#page}

In the new {{ tracker-name }} interface, you can open any projects available to you from the navigation panel on the left: click ![](../../_assets/tracker/svg/project.svg)&nbsp;**Projects** or follow the [direct link]({{ link-tracker }}pages/projects/list) and select a project from the list.

The project page shows the details of the team, goals, and issues of the project:

* **About the project** tab. It includes the project description, status, timeframes, names of the author and employee responsible for the project, the list of its team members, comments, customers, [milestones](milestones.md), and tags.

* **Issue lists** tab. The list shows both open issues and closed issues. You can filter the issue list. For more information, see [{#T}](project-list.md).

* **Gantt chart** tab. Your schedule of resolving project issues. The Gantt chart specifies the timeframes of the issues and relationships between them. For more information, see [{#T}](../gantt/project.md).

* **Issue boards** tab. A virtual board with cards that makes it easy to track statuses of project issues. For more information, see [{#T}](./boards-project.md).

   {% note info %}

   The project board is also shown under ![](../../_assets/tracker/svg/boards.svg)&nbsp;**{{ ui-key.startrek.ui_components_NavigationBar.boards }}** in the left-hand panel. By default, this dashboard is named <q>`<Project name>` project dashboard</q>.

   {% endnote %}

You can track your project indicator in the top-right corner of the project page. The indicator is filled depending on the number of closed issues.

To restrict access to the project, click the lock icon in the top-right corner and select **Members only**. In this case, the project will only be available to the users listed in the fields: **Participants**, **Reporter**, **Clients**, and **Responsible**.
