# Burndown charts

A burndown chart in {{ tracker-name }} is a chart that shows how fast work is done in **story points** in a [sprint](create-agile-sprint.md). It helps you daily estimate team workload and dynamics of completing sprint issues. By analyzing such a chart, you can decide on changing the workload for the sprint and adding new members to the team.

{% cut "What a burndown chart looks like" %}

The horizontal axis shows sprint days and the vertical axis shows the total workload left in **story points**. A dashed line on the chart is the [planned convergence](#burndown-plan), while the blue one is the [actual](#burndown-fact) convergence.

![](../../_assets/tracker/diagram-burndown.png =750x318)

{% endcut %}

## Limitations of a burndown chart {#restrictions}

1. Burndown charts are designed for Scrum teams. Use a burndown chart if you work in short iterations known as sprints and all issues in a sprint are estimated in **story points**.

1. Sprints in {{ tracker-name }} are only enabled on boards with a **Backlog and sprints**. If you want to use a burndown chart on a **Basic board**, [enable a backlog on it](backlog.md#add-backlog).

1. Burndown charts are only available for the current and upcoming sprints.

## Planned convergence {#burndown-plan}

Planned convergence is plotted when a sprint starts; it shows a steady decrease in the planned amount of **story points** during a sprint. This a benchmark that you can use to compare the actual decrease in the scope of work to and adjust the workload and resources of your team.

The planned convergence line starts on the first day of the sprint in the point corresponding to the total amount of work for all sprint issues in **story points**. The line then goes down stepwise and ends at zero on the last day of the sprint. The chart has a step-like structure because it includes weekends when the amount of work does not decrease.

The total amount of **story points** is set exactly at the start of a sprint: you specify it when [creating](create-agile-sprint.md#create_sprint) a new sprint. If new issues are added during the sprint, this starting point will not change.

## Actual convergence {#burndown-fact}

Actual convergence indicates the actual completion velocity for issues planned in a sprint. An actual convergence chart is updated each new day of the sprint. The amount of **story points** may both decrease and increase:

* The amount of **story points** increases if new issues are added to the sprint after its start. In this case, the actual convergence line will be above the planned convergence one.

* The amount of **story points** decreases if a sprint issue is closed as **Resolved** or removed from the sprint.

The scope of work in sprints may also expand or reduce due to issue re-estimation.

## Working with burndown charts {#burndown-work-tips}

1. To view the current sprint chart, open the board **with a backlog and sprints** and go to the **Burn down chart** tab.

1. To estimate your team work for a day, hover over a point on the actual convergence chart for that day. A pop-up window will show how the amount of **story points** changed for each issue. Changes are registered at the beginning of each working day and compared to the previous one.

1. You can go to sprint issues from a burndown chart. To do this, click a point on the burndown chart. This will fix the pop-up window so that you can open issues from it by clicking their names.

1. To analyze how the team worked during a sprint, compare the actual convergence line to the planned convergence line:
   * If the lines slightly diverge, the team successfully manages the planned amount of work and completes the sprint issues in time.
   * If the actual convergence line is above the planned convergence one, the team progress is slower than it was planned. In this case, we recommend adding more employees for the sprint, or review the priorities and remove certain issues from the sprint.
   * If the actual convergence line is below the planned convergence one, the team quickly manages the issues and may complete the planned amount of work sooner than the sprint end date. In this case, you may try increasing the workload for the next sprint.
