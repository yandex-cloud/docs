# Gantt charts

A project Gantt chart in {{ tracker-name }} is a tool you can use to create a calendar schedule for managing issues. Gantt charts display all issues within a project and the links between them.

To open a Gantt chart:

1. Select a project on the left-hand panel in the ![](../../_assets/tracker/svg/project.svg)&nbsp;**Projects** section.

   {% note info %}

   You can view the **Projects** section in the new interface {{ tracker-name }}. To learn about switching to the new interface, see [{#T}](project-new.md).

   {% endnote %}

1. Go to the **Gantt Chart** tab.
   * A list of project issues is displayed to the left of the diagram. It shows the priority, type, and name for each issue.
   * Issue deadlines are displayed on the diagram as bars stretched along the time axis. The start of each bar corresponds to when the issue was initiated, while the end of the bar marks the issue's deadline.
   * Arrows between issues denote the <q>Depends on — Blocker to</q> type of issue link.

1. If you wish to change the time range of the project's timeline, select **Week**, **Month**, or **Quarter** in the lower-right corner of the diagram.

## Changing issue deadlines {#timing}

* If an issue's deadlines are not displayed on the diagram, which means its start date and deadline haven't been set, hover over the diagram next to the issue name, place the issue bar at the desired spot, and click the left mouse button.

* To move both the start date and deadline, drag the issue bar along the time axis.

* To change the timeframe for the issue, pull the left end (start date) or the right end (deadline) of the bar.

* To set up automatic change of deadlines for related issues, go to **Timeline Settings** and enable the option **Automatically move deadlines for dependent issues when moving blocker deadlines**.

## Editing links {#links}

* To add a [link](../user/links.md) of the <q>Depends on — Blocker to</q> type, hover over the blocker issue bar to see dots to the left and right of the bar. Click one of the points and drag it to the dependent issue. An arrow will appear on the diagram.

   {% note info %}

   Arrows between issues are only displayed when the start date and deadline are specified and the <q>Depends on — Blocker to</q> issue links have been configured.

   {% endnote %}

* To remove links between issues, hover over the link arrow and click the X that appears.

## Setting assignees {#assigned}

You can set and change issue assignees on the Gannt chart.

To do this, click the user icon on the issue bar and select the name of the employee you want to set as the assignee.

{% note info %}

If you don't see the user icon, go to **Timeline Settings**, find the **Show on the issue bar** block, and select the **assignee** as the item you wish to display.

{% endnote %}

