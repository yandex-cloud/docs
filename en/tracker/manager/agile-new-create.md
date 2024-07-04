---
title: "How to create boards in {{ tracker-full-name }}"
description: "In this tutorial, you will learn how to create a board in {{ tracker-name }}."
---

# Creating a board in {{ tracker-name }}

## Creating a basic board {#basic}

**{{ ui-key.startrek.ui_components_agile_agile-board_AgileBoardCreateModal.board-type--simple }}** can be used by any teams and allow issues to be arranged in columns based on their status.

To create a basic board:

1. In the left-hand panel, click **Boards** → **Create board**.

1. Select the **{{ ui-key.startrek.ui_components_agile_agile-board_AgileBoardCreateModal.board-type--simple }}** board type and click **{{ ui-key.startrek.ui_components_agile_agile-board_AgileBoardCreateModal.submit-btn }}**. This will create a new board named **New board**. This board field is editable, so you can change its value and rename the board.

It already has some columns with **Open**, **In progress**, and **Closed** statuses. You can delete the columns, add other ones, or create custom columns not associated with issue statuses.

After [adding issues to the board](agile-new-set-board.md#add-task), you can customize the layout of issue cards, group and filter issues, and move them across the board columns. Basic boards allow you to [enable a backlog](backlog.md#add-backlog) to convert your board to **{{ ui-key.startrek.ui_components_agile_agile-board_AgileBoardCreateModal.board-type--scrum }}** format. No rollback is possible.

## Creating a board with a backlog and sprints {#backlog-and-sprints}

**{{ ui-key.startrek.ui_components_agile_agile-board_AgileBoardCreateModal.board-type--scrum }}** boards are good for Agile teams and allow creating a [backlog](backlog.md), managing [sprints](create-agile-sprint.md), [estimating issue complexity](poker.md), and analyzing [burn down charts](burndown-diagram.md).

To create a board with a backlog and sprints:

1. In the left-hand panel, click **Boards** → **Create board**.

1. Select the **{{ ui-key.startrek.ui_components_agile_agile-board_AgileBoardCreateModal.board-type--scrum }}** board type and click **{{ ui-key.startrek.ui_components_agile_agile-board_AgileBoardCreateModal.submit-btn }}**. This will create a new board named **New board**. This board field is editable, so you can change its value and rename the board.

It consists of three tabs:
* Backlog: Use it to create an issue backlog and sprints.
* Board: Use it to sort backlog issues by [status](agile-new-columns.md#status) or [custom column](agile-new-columns.md#user-columns) (this tab is similar to **Basic board**).
* Burndown chart: Shows the issue completion rate and the remaining amount of work within a single sprint.

After [adding issues to a backlog](backlog.md#add-new-backlog), you can plan sprints, customize the layout of issue cards, group and filter board issues, and analyze their completion rate.
