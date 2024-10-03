---
title: How to create a board in {{ tracker-full-name }}
description: Follow this guide to create a board.
---

# Creating a board in {{ tracker-name }}

To create a board:

1. In the {{ tracker-name }} top panel, select **Boards** → **New board**.

1. Select the board type.

   - **Basic** boards allow you to arrange issues in columns based on their status.

        This board is a good choice if you're new to Agile tools and want to test them out.

        {% note info %}

        To create a board with the new interface, enable **Try new boards**. On how to work with the new board version, see [{#T}](agile-new.md).

        {% endnote %}

   - **Scrum** boards allow you to display statuses and offer [sprint](agile.md#dlen_sprint) management tools, [issue estimation](planning-poker.md), and [burn down charts](agile.md#dlen_burndown).

        Select this board if you are using the Scrum methodology.

   - **Kanban** boards are similar to basic boards, but all issues with the **Open** status are automatically moved to the [**{{ ui-key.startrek.ui_components_agile_backlog_BacklogIssue.backlog-default-column }}**](agile.md#dlen_backlog) column.

        Select this board if your team deals with a massive flow of issues (for example, to support customers).

   {% note alert %}

   You will not be able to change board type after you create a board.

   {% endnote %}

1. Enter the board name.

1. If you want issues with certain parameters to appear on the board, enable the **Add issues automatically** option and set the filters so that only issues with the desired parameters are displayed. You can change the conditions later.

   For example, you can specify a queue, and all the issues from this queue will automatically be added to the board.

   {% note info %}

   You cannot specify a filter with local fields when creating a board. You can do this later, on the [editing page](edit-agile-board.md#board-settings), using the [query language](../user/query-filter.md).

   {% endnote %}

   If you do not enable the **Add issues automatically** option, you will have to [add issues to the board manually](../user/agile.md#add-tasks).

1. Specify the queue where the issues will be created. This way, you can quickly create issues in this queue directly from the board page.

1. Click **{{ ui-key.startrek.ui_components_agile_agile-board_AgileBoardCreateModal.submit-btn }}**. The new board appears in the **Boards** menu in the {{ tracker-name }} top panel.

1. You can also [customize the columns and appearance of the issue card](edit-agile-board.md) if needed.
