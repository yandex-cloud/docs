---
title: How to edit or delete a board in {{ tracker-full-name }}
description: In this tutorial, you will learn how to edit or delete a board in {{ tracker-name }}.
---

# Editing or deleting a board

## Editing a board {#board-settings}

1. Go to the board page.

1. In the top-right corner, click ![](../../_assets/tracker/edit-agile.png).

1. Configure general board settings:

   | Parameter | Description |
   | -------- | -------- |
   | **Name** | Board name. |
   | **Allow changing the order of issues** | If the option is enabled, the order of issues on the board can be changed by dragging issues. |
   | **Queue for creating issues** | Queue key You can create issues in this queue directly from the board page. |
   | **Filter settings** | Settings of the filter used to add issues with certain parameters automatically on the board. There are multiple ways to set up filters:<br/><ul><li>Set your filters in the **Conditions** tab.</li><li>Set your filters using the query language on the **Query** tab.</li></ul> |
   | **Board type** | You will not be able to change board type after you [create a board](create-agile-board.md). |

1. Use the **Columns** tab to customize the settings and appearance of your board's columns:

   - Creating columns: Click **Add column** to the right of the board's column list.

   - Renaming columns: click the ![](../../_assets/tracker/button-edit.png) button to the right of the column name. To save your changes, click ![](../../_assets/tracker/approve-checkmark.png).

   - Changing the location of a column on the board: Drag the column where you need it.

   - Setting the maximum number of issues per column: Specify a value in the **Maximum number of issues per column** field.

   - Changing column statuses: Take the status block from another column or the **Unused statuses** list and drag it to your column.

   - Deleting a status from the column: click the ![](../../_assets/tracker/delete-agile-status.png) icon next to the status name.

   - Deleting column: Click ![](../../_assets/tracker/delete-agile-column.png).

1. For **Scrum** boards, go to the **Planning poker** tab and [set the issue estimation scale](planning-poker.md#section_scale).

1. Click **Save**.

## Customizing the appearance of issue cards {#sec_layout}

You can customize the appearance of issue cards so that only relevant issue settings are displayed on the board. You can also use this feature to quickly find issues with specific tags and components by color.

#### Selecting issue fields {#card_fields}

By default, the issue card displays the values of required fields: key, name, assignee, and some others. To set up the display of additional fields on the issue card:

1. In the top-right corner of the board page, click ![](../../_assets/tracker/edit-agile.png).

1. Go to the **Card view** tab.

1. Click **Add field** and select issue fields you want to add to the issue card.

   An example of the issue card with the added fields is shown in the upper-right corner of the page.

1. To remove an additional field from the card, to the right of the field name, click ![](../../_assets/tracker/delete-agile-column.png).

   To remove all additional fields, click **Remove additional fields** at the bottom of the page.

   You can't delete required fields.

1. Click **Save**.

#### Highlighting tags and components in colors

To make the issues with certain tags or components stand out on the board, highlight tags and components in colors.

1. In the top-right corner of the board page, click ![](../../_assets/tracker/edit-agile.png).

1. Go to the **Card view** tab.

1. To set up colors for tags:

   1. [Add](#card_fields) the **Tags** field if it is not in the list.

   1. Click **Choose colors** under the **Tags** field.

   1. Start typing the name of the tag in the window that opens. A list of the found tags will be shown.

   1. Select the tags that you want to color, in the list. Colors will be automatically assigned to the selected tags.

   1. If you want to change a tag's color, click ![](../../_assets/tracker/edit-tag.png) on the label, then select a color.

   1. To delete a colored tag, click ![](../../_assets/tracker/edit-tag.png) on the label, then select **Remove from list**.

   An example of the issue card with added color tags is shown in the upper-right corner of the page.

1. Same as for tags, set up the color labels for components.

1. Click **Save**.

## Deleting a board {#section_qfj_wz1_cgb}

You can delete boards that you don't need. All the issues present on the board are preserved.

* Only the creator of the board can delete it. If the creator leaves the company, you can rename the board.

* However, you can't delete an auxiliary board created by an auxiliary account.

To delete a board:

1. Go to the board page.

1. In the top-right corner, click ![](../../_assets/tracker/edit-agile.png).

1. Click **Delete board** at the bottom of the page.

1. Confirm the deletion.
