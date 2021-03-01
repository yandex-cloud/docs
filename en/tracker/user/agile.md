# How to use the board

Issues are displayed on the board as cards with general issue parameters on them. You can [customize](../manager/edit-agile-board.md#sec_layout) the appearance of cards on the board, such as by choosing which fields to display or setting colors for highlighting tags and components.

{% note warning %}

The board only displays issues from the queues you have access to.

{% endnote %}

## Manage issues {#section_bgx_j21_2gb}

Managing issues on the board in {{ tracker-name }} is like working with stickers on a real bulletin board:

- Issue cards are arranged into columns based on their status. To change the issue status, just drag it to the corresponding column.
- If you want to place a card somewhere else in the column, just drag it to the location you want (applies only to boards with [Allow changing the order of issues](../manager/edit-agile-board.md#board-settings) enabled).
- If you want to change issue options or leave a comment, click the key and make your changes in the issue card to the right.

## Create an issue {#section_mjn_3sg_2hb}

{% note warning %}

Make sure that the issue creation queue is specified in the [board settings](../manager/edit-agile-board.md#board-settings). The new issue will be created in the specified queue.

{% endnote %}

{{ tracker-name }}  lets you quickly create issues on the board. You can create an issue directly in the sprint or place it in the backlog. You only need to specify an issue's name and type, as all the other fields can be filled in later.

#### Create an issue on the board

1. Open the issue board.

1. Click **Add issue** in the lower-right corner.

1. Enter the issue's name and specify its type.

1. Click **Create**.

The created issue will be placed in the queue you specified in the [settings](../manager/edit-agile-board.md#section_ft1_3l3_3z). To view the issue, refresh the board page.

#### Create an issue in a sprint

1. Click **Sprints** in the upper-right corner.

1. Select the sprint for your issue.

1. Enter the issue name into the field under the sprint's issue list.

1. Select the issue type and click **Create**.

The created issue will be placed in the queue you specified in the [settings](../manager/edit-agile-board.md#section_ft1_3l3_3z). To view the issue, refresh the board page.

#### Create an issue in the backlog

1. Click **Sprints** in the upper-right corner.

1. Enter the issue name in the field under the backlog's issue list.

1. Select the issue type and click **Create**.

The created issue will be placed in the queue you specified in the [settings](../manager/edit-agile-board.md#section_ft1_3l3_3z). To view the issue, refresh the board page.

## Add issues to the board {#section_psd_wl4_vgb}

{% note warning %}

Your board will only display issues if their issue statuses are enabled in board settings.

{% endnote %}

You can add issues with specific settings to your board automatically using [board filters](../manager/edit-agile-board.md#row_oqh_1j2_wgb). To add an issue to your board manually, create a new issue on the board, or add an issue to the backlog or a sprint.

#### Add issues to the backlog

1. Open the issue page.

1. Click the title of the **Boards** field in the right-hand panel. If the **Boards** field isn't present, add it by clicking **Select fields**.

1. Start typing the name of the board in the **Boards** field and pick the right option from the list that appears.

The issue will be placed on the board you've picked. To remove an issue from the board, clear the **Boards** field on the issue page.

#### Add issues to a sprint

1. Open the issue page.

1. In the **Agile** panel on the right, click the title of the **Sprint** field. If there's no **Sprint** field, add it by clicking **Select fields**.

1. Start typing the sprint's name in the field and pick the option you need from the list that appears. The Boards field will be filled in automatically.

The issue on the board will be placed in the sprint you've picked. To remove an issue from the board, clear the **Boards** field on the issue page.

#### Add multiple issues

To add multiple issues to the board at once, use the [bulk change](../manager/bulk-change.md) feature:

1. Select the issues you need using [filters](../user/filters.md).

1. Choose the issues you want to add to the board and click **Edit fields** at the bottom of the page.

1. To add an issue to a backlog, start typing the name of the board in the **Board** field and pick the one you want from the list that appears. If there's no **Board** field, add it by clicking **Select fields**.

1. To add an issue to a sprint, start typing the name of the sprint in the **Sprint** field and pick the one you want from the list that appears. The Boards field will be filled in automatically.

    If there's no **Sprint** field, add it by clicking **Select fields**.

1. Click **Continue** and wait while your issues are processed.

## Add notes to the board {#notes_add}

You can attach your own notes and comments to the columns on the board to make navigation easier for other users. Such notes can be freely edited by all users.

To attach a note to a column, do the following:

1. Open the board page.

1. Select ![](../../_assets/tracker/icon-dots.png) → **Add note** at the top of the column.

1. Enter the text for your note. To format the text, use [wiki markup](wiki-markup.md).

1. Save the changes.

You can only attach one note to each individual column. It will show up at the top of the column, visible to all users.

## Filter issues {#section_cxl_x31_2gb}

If there are too many issues on the board, you can always hide some of them using filters. You can apply multiple filters at once. Here is the list of available filters:

- By sprint. Use the upper panel to choose the sprint whose issues you want to view.

- By resolution. Use the upper panel to expand the **Resolution** menu and specify the resolutions you want to display on the board.

- By status. Use the upper panel to expand the **Status** menu and specify the statuses you want to display on the board.

- By issue key or name. Start typing an issue's key or name on the upper panel. Only the issues whose name or key contains your query will be displayed on the board.

- Quick Filters There are only two quick filters on the board by default: **Assigned to me** and **Reported by me**. To add new filters, click ![](../../_assets/tracker/edit-agile.png) on the filter panel.

## Fullscreen mode{#section_w2w_h1h_2hb}

You can switch the board to fullscreen mode. Cards are smaller in fullscreen mode, so more of them are displayed simultaneously. This mode is useful when planning or analyzing sprints.

To switch to fullscreen mode, open the board page and click ![](../../_assets/tracker/fullscreen-agile.png) next to the board name.

To exit fullscreen mode, click **Exit fullscreen** in the bottom-right corner of the page.

## Add boards to Favorites {#section_nf5_r31_2gb}

You can add boards to Favorites for quicker access. Just go to the page of the board and click ![](../../_assets/tracker/add-to-favorites.png) to the right of the board name. Your favorite boards are displayed in the **Boards** menu on the upper panel in {{ tracker-name }}.

{% if audience == "external" %}

[Contact support](../troubleshooting.md)

{% endif %}

