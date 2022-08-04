# Editing and deleting a board

## Editing a board {#section_ft1_3l3_3z}

1. Go to the board's page.

1. In the upper-right corner, click ![](../../_assets/tracker/edit-agile.png).

1. Configure general board settings: {#board-settings}

    | Parameter | Description |
    | -------- | -------- |
    | **Name** | Board name. |
    | **Allow changing issue order** | Enabling this option lets you change the issue order by dragging across the board. |
    | **Issue creation queue** | Queue key. You can create issues for this queue right on the board page. |
    | **Filter settings** | Filter settings are used to automatically add issues with the desired parameters to the board. Here are two ways to set a filter:<br/><ul><li>Go to the **Condition** tab and set filter settings.</li><li>Go to the **Query** tab and set the necessary conditions using the query language.</li></ul> |
    | **Board type** | You won't be able to change the board type after [creating it](create-agile-board.md). |

1. Use the **Columns** tab to customize the settings and appearance of your board's columns:

    - Creating columns: Click **Add column** to the right of the board's column list.

    - Renaming columns: Click ![](../../_assets/tracker/button-edit.png) to the right of the column name. To save your changes, click ![](../../_assets/tracker/approve-checkmark.png).

    - Changing the location of a column on the board: Drag the column where you need it.

    - Setting the maximum number of issues per column: Specify a value in the **Maximum issues per column** field.

    - Changing column statuses: Take the status block from another column or the **Unused statuses** list and drag it to your column.

    - Deleting a status from a column: Click ![](../../_assets/tracker/delete-agile-status.png) next to the status name.

    - Deleting columns: Click ![](../../_assets/tracker/delete-agile-column.png).

1. For **Scrum** boards, go to the **Poker** tab and [set the issue estimation scale](planning-poker.md#section_scale).

1. Click **Save**.

## Customizing the appearance of issue cards {#sec_layout}

You can customize the appearance of issue cards so that only relevant issue settings are displayed on the board. You can also use this feature to quickly find issues with specific tags and components by color.

#### Selecting issue fields {#card_fields}

The issue card only displays values for the required fields by default, such the key, name, assignee, and some others. If you want to display additional fields on issue cards, do the following:

1. In the upper-right corner of the board page, click ![](../../_assets/tracker/edit-agile.png).

1. Go to the **Card view** tab.

1. Click **Add field** and select issue fields you wish to add to the issue card.

    You can see a preview of the card with filled in fields in the upper-right corner of the page.

1. To remove an additional field from the card, to the right of the field name, click ![](../../_assets/tracker/delete-agile-column.png) to the right of the field name.

    To remove all additional fields, click **Remove additional fields** at the bottom of the page.

    You cannot remove required fields.

1. Click **Save**.

#### Highlight tags and components.

If you want to make certain tags or components stand out on the board, you can put colored labels on them. To configure this feature:

1. In the upper-right corner of the board page, click ![](../../_assets/tracker/edit-agile.png).

1. Go to the **Card view** tab.

1. To configure colored labels for tags:

    1. [Add](#card_fields) the **Tags** field if it isn't in the list.

    1. Click **Choose colors** under the **Tags** field.

    1. Start typing the name of the tag in the window that opens. Matching tags will be displayed.

    1. Choose the tags you want to label. Colors will be assigned automatically for the selected tags.

    1. If you want to change a label's color, click ![](../../_assets/tracker/edit-tag.png) and choose another color.

    1. If you want to remove a colored label, click ![](../../_assets/tracker/edit-tag.png) on it and choose **Remove from list**.

    You can see a preview of the card with colored labels in the upper-right corner of the page.

1. You can also configure colored labels for your components the same way as for tags.

1. Click **Save**.

## Deleting a board {#section_qfj_wz1_cgb}

You can delete boards that you don't need. This will leave all its issues intact.

To delete a board:

1. Go to the board's page.

1. In the upper-right corner, click ![](../../_assets/tracker/edit-agile.png).

1. Click **Delete board** at the bottom of the page.

1. Confirm the deletion.

