# Sprints

{{ tracker-name }} can help you utilize the Scrum workflow approach. With this approach, your work is split into sprints, that is, development iterations of a certain duration. In the beginning of each iteration, the issues are evaluated and planned for the upcoming sprint.

{% note warning %}

Sprints are enabled by default on boards with a **backlog and sprints**. If you want to use sprints on a **Basic board**, [enable a backlog on it](backlog.md#add-backlog).

{% endnote %}

## Planning a sprint {#planning}

#### Step 1. Evaluate the effort needed to complete the issues

Evaluate the effort for the backlog issues. The effort is measured in **Story Points** that determine the relative complexity of the project's issues. Each team decides internally how to define the effort needed to complete their issues. You can specify the estimated effort on the [issue page](../user/edit-ticket.md#edit-fields) in the **Story Points** field.

Use [Planning Poker on the issue board](poker.md) to assess the complexity of issues within your team.

#### Step 2. Create a new sprint {#create_sprint}

After you create an issue board in the **Backlog** tab, it already has the first sprint created. If you have not planned it yet, proceed to the next step. If your first sprint is already completed and you want to create a new one:

1. Click **+ Create sprint** in the **Backlog** tab to the right of the board.

1. Enter a name for the sprint, its duration, and start and end time. To start working on the sprint immediately, leave the **Take to work** option enabled.

1. Click **Create sprint**.

#### Step 3. Add issues to the sprint

There are several ways to add an issue to a sprint:

- In the **Backlog** tab, drag an issue from the **Backlog** column to the sprint's column.

- On the issue page, enter the board name or ID in the **{{ ui-key.startrek-backend.fields.issue.boards }}** field of the left-hand panel and select the appropriate sprint in the **{{ ui-key.startrek-backend.fields.issue.sprint }}** field under **{{ ui-key.startrek-backend.fields.issue.fields.agile }}**.

- To quickly add multiple issues, use [bulk edits](agile-new-issues.md#bulk): click ![](../../_assets/tracker/svg/actions.svg) → **Select** in an issue card on the board and then click other issues you want to add to the sprint. Once you select all issues, click **Add to sprint** in the board's bottom panel and select the one you need.

## Editing a sprint {#sprint-edit}

To edit a sprint:

1. To the right of the sprint header, click ![](../../_assets/horizontal-ellipsis.svg) → ![](../../_assets/tracker/svg/icon-edit.svg) **Edit**.

1. In the window that opens, you can rename the sprint, change its duration and start and end time, as well as enable the **Take to work** option.

1. To save your changes, tap **Edit sprint**.

## Changing sprint status {#sprint-status}

When all the sprint issues are planned and the sprint date has arrived, click **Start** in the board's **Backlog** tab next to the sprint.

Once you complete your work on the sprint, click **Complete** next to it. If the sprint has any incomplete issues, you will be prompted to leave them in the current sprint, return them to the backlog, or move them to a new sprint that can be created immediately. As soon as all the issues are completed, the sprint will be displayed under **Finished sprints**.
