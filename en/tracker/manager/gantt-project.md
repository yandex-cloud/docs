# Gantt chart in {{ tracker-name }} projects 

A project's Gantt chart in {{ tracker-name }} is a tool for calendar planning of work on project issues. The Gantt chart shows all the project's issues and links between them.

To go to the Gantt chart:

1. In the left panel, select ![](../../_assets/tracker/svg/project.svg)&nbsp;**Projects** or follow the [direct link]({{ link-tracker }}pages/projects) and open the project page.

1. Go to the **Gantt chart** tab.

   * The list of project issues is on the left of the chart, showing the priority, type, and name for each issue. You can [set up the list display](#tasks-view).
   * The start and end dates for the issues are shown on the chart as bars plotted along the time axis. The beginning of each bar corresponds to the issue's start date, and its end corresponds to the deadline, that is, the date by which the issue should be completed.
   * Errors between issues denote links: <q>Dependent issue — Blocker</q>.

1. To set up the time scale for the project schedule, in the bottom-right corner of the chart, select **Week**, **Months**, or **Quarter**. The scale settings persist after refreshing the page or opening the chart again.

{% note tip %}

You can also open the calendar as a [Gantt chart for all projects](./my-projects.md#gantt-projects) you have access to.

{% endnote %}

## Updating links between issues {#links}

* To add a <q>Dependent issue – Blocking issue</q> [link](../user/links.md), hover over the blocking issue to see points on the right and left of the bar.

   * To make the selected issue dependent, click the point on the left and drag it to the blocking issue.

   * To make the selected issue blocking, click the point on the right and drag it to the dependent issue.

   {% note info %}

   Links between issues are shown as arrows from the dependent issue to the blocker if the start date and deadline are specified and the <q>Dependent issue – Blocking issue</q> link is set up.

   If the dependent issue deadline is earlier than that of the blocking issue, the arrow is red. You can enable [automatic update of start dates and deadlines](#timing) for dependent issues.

   {% endnote %}

* To delete a link between issues, click the link arrow, then select![](../../_assets/tracker/svg/del-link.svg) **Delete link**.

* If an issue has blockers outside the current project, you will see the ![](../../_assets/tracker/svg/blocker.svg) icon with the number of blocking issues to the left of the issue bar. To delete a link between issues like this, click ![](../../_assets/tracker/svg/blocker.svg) and select ![](../../_assets/tracker/svg/del-link.svg) **Delete link**.

## Changing issue deadlines {#timing}

* If the issue start dates and deadlines are not shown on the chart, hover the mouse pointer over the chart next to the issue name, position the bar along the time axis, and click the left mouse button.

* To shift the start date and deadline by the same value, drag the bar along the time access.

* To change the issue duration, drag the left edge of the bar (the start date) or the right edge of the bar (deadline).

* To set up automatic update of start dates and deadlines for dependent issues, go to ![](../../_assets/tracker/svg/gantt-settings-button.svg)&nbsp;**Chart settings** and enable **Automatically move the deadline of the dependent issue when the blocking issue deadline changes**. If the blocker deadline is later than the start date of the dependent issue, this start date is shifted based on the blocker's new deadline.

* To set up automatic update of start dates and deadlines for the parent issue, go to ![](../../_assets/tracker/svg/gantt-settings-button.svg)&nbsp;**Chart settings** and enable **Automatically extend the deadlines of the parent issue based on the deadlines of sub-issues**. If the deadline of a sub-issue is later than that of the parent issue, it is shifted based on the new deadline of the sub-issue.

* If no deadline is set for the parent issue, a hint (blue bar) is displayed next to it on the chart depending on the deadlines of all sub-issues.

## Assigning an issue {#assigned}

On the Gantt chart, you can appoint or change the issue's assignee.

For this, on the issue bar, click the user icon and select the name of the employee to be set as the assignee.

{% note info %}

If you do not see the user icon, go to ![](../../_assets/tracker/svg/gantt-settings-button.svg)&nbsp;**Chart settings** and select the **assignee** item in **Show on the issue bar**.

{% endnote %}

## Setting up the chart {#settings}

Above the timeline on the right, click ![](../../_assets/tracker/svg/gantt-settings-button.svg)&nbsp;**Chart settings** and select a setting in **Show on the issue bar**:

* To show the issue name on the issue bar, select the **name** item.

* To show the assignee icon on the issue bar, select the **assignee** item.

* To have the missed deadline property (the difference between the deadline and the current date) highlighted in red on the chart, select **missed deadline**.

* To hide link arrows on the chart, select **hide links**.

## Setting up the display of the issue list section {#tasks-view}

* To select the fields you want to see in the issue list table to the left of the chart, click ![](../../_assets/tracker/svg/settings-old.svg). Select the relevant fields and click **Apply**.

{% include [task-list-settings](../../_includes/tracker/task-list-settings.md) %}

* To resize a column in the section, click and hold its edge and then change the width.

* To hide the issue list section, click ![](../../_assets/tracker/svg/close-block.svg).
