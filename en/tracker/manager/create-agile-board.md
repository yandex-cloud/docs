# Creating a board

To create a board:

1. On the top panel in {{ tracker-name }}, select **Boards** → **New board**.

1. Choose your board type:

    - **Basic** boards let you arrange issues in columns based on their status.

        This board is a good choice if you're new to Agile tools and want to test them out.

        {% note info %}

        To create an issue board in the new interface, enable the **Try new boards** option. To learn about working with new issue boards, see [{#T}](agile-new.md).

        {% endnote %}

    - **Scrum** boards display statuses and provide [sprint](agile.md#dlen_sprint) management tools, [issue estimation](planning-poker.md), and [burn down charts](agile.md#dlen_burndown).

        Choose this board if you use the Scrum methodology.

    - **Kanban** boards are similar to basic boards, but all issues with the **Open** status are automatically moved to the [**Backlog**](agile.md#dlen_backlog) column.

        Choose this board if your team manages a large number of issues (for example, you work in support).

    {% note alert %}

    You won't be able to change the board type after creating a board.

    {% endnote %}

1. Enter the board name:

1. If you want issues with certain parameters to appear on the board, enable the **Add issues automatically** option and set the filters so that only issues with the desired parameters are displayed. You will be able to change them later.

    For example, you can specify a queue so that all issues from this queue are automatically displayed on the board.

    {% note info %}

    You can't set a filter using local fields when creating a board. You can do this later on the [edit page](edit-agile-board.md#section_ft1_3l3_3z) by using the [query language](../user/query-filter.md).

    {% endnote %}

    If you don't enable the **Add issues automatically** option, you will have to add issues to the board [manually](../user/agile.md#section_psd_wl4_vgb).

1. Specify your issue creation queue. This will allow you to easily create issues for the queue right on the board page.

1. Click **Create**. The new board appears in the **Board** menu on the top panel in {{ tracker-name }}.

1. You can also [customize the columns and appearance of the issue card](edit-agile-board.md) if needed.

