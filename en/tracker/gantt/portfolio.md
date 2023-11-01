# Gantt chart for project portfolios

Gantt charts for {{ tracker-name }} project portfolios show nested portfolios and projects and their issues.

## Creating a chart {#sec-portfolio}

To go to the Gantt chart:

1. In the [left-hand panel]({{ link-tracker }}), select ![](../../_assets/tracker/svg/project.svg)&nbsp;**{{ ui-key.startrek.blocks-desktop_b-queues-info.projects }}** or follow the [direct link]({{ link-tracker }}pages/projects) and open the portfolio page.

1. Select the **{{ ui-key.startrek.ui_components_filter-pane_ViewModeSwitch.mode-gantt }}** tab.
   * The portfolio and project list is displayed to the left of the chart. To open the list of nested items, click ![](../../_assets/tracker/svg/arrow.svg) next to its name. The issues are displayed as a hierarchical list.
   * The portfolio, project, and issue timeframes are shown on the chart as bars plotted along the time axis. The left edge of each bar indicates the start date of work on the portfolio, project, or issue, while the end of the bar shows the portfolio, project, or issue deadline.

1. {% include [gantt-time-scale](../../_includes/tracker/gantt-time-scale.md) %}

## Moving a portfolio or project {#move}

You can move portfolios and projects, nest them in other portfolios and projects, and move them to higher levels.

To move some portfolios and projects relative to others, click ![](../../_assets/tracker/svg/range.svg) to the left of the portfolio or project, and drag them to a new position.

## Changing timeframes {#timing}

* If the portfolio or project timeframes are not shown on the chart (its start and end dates are not set), hover over the chart next to the portfolio or project name, position the portfolio or project bar along the time axis, and click the left mouse button.

* To shift the portfolio or project start and end dates by the same value, drag the bar along the time axis.

* To change the portfolio or project duration, drag the left edge of the bar (the start date) or the right edge of the bar (end date).

## Assigning an employee in charge {#assigned}

On a Gantt chart for portfolios, you can assign or change an employee in charge of a portfolio or project:

1. Click ![](../../_assets/tracker/svg/pick-user.svg) on the portfolio or project bar.

1. Enter the name of the employee in charge of a portfolio or project.

{% note info %}

If you do not see the ![](../../_assets/tracker/svg/pick-user.svg) button on the portfolio or project bar, go to ![](../../_assets/tracker/svg/gantt-settings-button.svg)&nbsp;**{{ ui-key.startrek.ui_components_Gantt.timeline-config }}** and select the **{{ ui-key.startrek.ui_components_Gantt.task-bar }}** item under **{{ ui-key.startrek.ui_components_Gantt.show-issue-assignee }}**.

{% endnote %}

In a similar way, you can also use the chart to appoint and change assignees for each project's tasks.

## Updating links between issues {#links}

{% include [gantt-links](../../_includes/tracker/gantt-links.md) %}

## Changing issue deadlines {#timing}

{% include [gantt-timing](../../_includes/tracker/gantt-timing.md) %}

* If no deadline is set for the parent issue, a hint (blue bar) is displayed next to it on the chart depending on the deadlines of all sub-issues. The start of the bar corresponds to the earliest start date of work on the sub-issues, and the end of the bar represents the latest deadline.

## Assigning an issue {#assigned}

{% include [gantt-assigned](../../_includes/tracker/gantt-assigned.md) %}

## Chart settings {#settings}

{% include [issue-bar](../../_includes/tracker/issue-bar.md) %}