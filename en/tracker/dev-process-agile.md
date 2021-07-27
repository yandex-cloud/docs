---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Use Agile methodologies

If your team's work is organized around [Agile software development]({{ link-wiki-agile }}), it can be a good idea to try issue boards in {{ tracker-name }}. Boards help you keep track of tasks laid out for the team (such as during daily meetups). Issues are displayed on the board as cards sorted into columns based on their status.


![](../_assets/tracker/agile-board-c.png)

If you [chose to create a queue](#create) using the <q>Basic development</q>, <q>Scrum</q>, or <q>Kanban</q> templates, an issue board sharing the queue's name will also be created automatically. The board will display all issues contained in your queue.

You can also [create multiple issue boards](manager/create-agile-board.md). This can be useful if you have multiple work groups or issue types:

1. On the top panel in {{ tracker-name }}, choose **Boards** → **Create board**.

1. Select the [board type](#board_types).

1. Enable the **Add issues automatically** option and set the filters so that only issues with the needed parameters are displayed.

    For example, you can set up filters in such a way so that all issues from your queue are displayed on the board, or only issues with certain [components](manager/components.md) or assignees are displayed, and so on.

    ![](../_assets/tracker/dev-process-board-filter.png)

### Board types in{{ tracker-name }} {#board_types}

{{ tracker-name }} has multiple board types:

- <q>Basic</q>. This board has the least features, displays the team's issues and issue statuses.

- <q>Kanban</q>. This board is similar to the basic board, but all issues with the **Open** status are automatically moved to the [**Backlog**](manager/agile.md#dlen_backlog) column.

- <q>Scrum</q>. In addition to displaying issue statuses, this board lets you manage [sprints](manager/agile.md#dlen_sprint), [rate issues](manager/planning-poker.md), and view [burn down charts](manager/agile.md#dlen_burndown).

### Scrum board tools

The <q>Scrum</q> board offers tools to help organize your workflow according to the [Scrum]({{ link-wiki-scrum }}) methodology:

- **Sprints**

    Scrum implies that your workflow is broken down into smaller cycles called sprints. A sprint usually lasts one or two weeks. Please try planning your sprints in a way that lets your team solve all scheduled issues in the allotted time. You should also gauge your issues with [planning poker](#poker) to visualize your workload more clearly beforehand.

    To [schedule a sprint in {{ tracker-name }}](manager/create-agile-sprint.md):

    - Click **Sprints** in the upper-right corner of the issue board.

    - [Create a sprint](manager/create-agile-sprint.md#create_sprint) and set its start and end dates.

    - Add issues to your sprint: drag them from the **Backlog** column to the sprint issue list. Alternatively, you can specify a sprint in the **Agile** → **Sprint** field on the issue page.

    If you want the board to only display issues related to a specific sprint, select that sprint at the top of the page. To track the issue completion speed for issues in a sprint, use a [burn down chart](#burndown).

- **Planning poker** {#poker}

    To accurately gauge the workload for the upcoming sprint, you need to be able to evaluate its issue complexity. To do this, Scrum uses [Planning Poker]({{ link-wiki-poker }}). This method lets each member of your team score issues on their complexity independently, discuss the results, and finally pin down the total score. This scoring method usually involves relative issue complexity grades called [Story Points](manager/agile.md#dlen_sp).

    You can [use planning poker in {{ tracker-name }}](manager/planning-poker.md):

    - To [assess your issues](manager/planning-poker.md#section_estimate), ask your team members to go to the poker page. To do this, click **Poker** in the upper-right corner of the issue board.

    - You can also [set the issue rating scale](manager/planning-poker.md#section_estimate) and [specify rules for calculating the final score](manager/planning-poker.md#section_calc) in the board settings.

- **Burn down chart** {#burndown}

    The burn down chart shows the issue completion speed and remaining workload in a single [sprint](manager/agile.md#dlen_sprint). Burn down charts are useful for evaluating whether the team will be able to solve the planned issues in time.

    The chart's vertical axis shows the total workload left in [Story Points](manager/agile.md#dlen_sp), while the horizontal axis shows time. The ideal burndown chart should be as close as possible to a straight line that starts at the point with the most amount of work during the first day (total workload volume within a sprint) and ends at the zero point during the last day of the sprint.

    To [view the burn down chart in {{ tracker-name }}](manager/burndown.md), click **Burn down chart** in the upper-right corner of the issue board.

### Issue decomposition

Agile development strategies decompose issues as follows:

- Larger tasks that cannot be completed within a single sprint are called Epics.

- Epics are then broken down into <q>User Stories</q>, which are finalized product features that can be implemented in a single sprint

- User Stories are then broken down into standalone issues, such as designing the interface, or backend and frontend development.

To accommodate a system like that, the [<q>Scrum</q> queue template](manager/workflows.md#sec_scrum) provides Epic and Story issue types. If you [chose to create a queue](#create) using a template that does not have the Epic and Story issue types, you can [add them in the queue settings](manager/add-ticket-type.md).

