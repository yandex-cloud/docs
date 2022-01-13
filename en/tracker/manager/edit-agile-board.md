# Editing and deleting a board

## Edit a board {#section_ft1_3l3_3z}

1. Go to the board's page.

1. In the upper-right corner, click ![](../../_assets/tracker/edit-agile.png).

1. Configure the board's general settings: {#board-settings}

    | Parameter | Description |
    | -------- | -------- |
    | **Name** | Board name. |
    | **Allow changing issue order** | Enabling this option lets you change the issue order by dragging across the board. |
    | **Issue creation queue** | Queue key. You can create issues for this queue right on the board page. |
    | **Filter settings** | Filter settings are used to automatically add issues with the desired parameters to the board. There are multiple ways to set up filters:<br/><br/>- Set your filters on the **Condition** tab.<br/>- Set your filters using the query language on the **Query** tab. |
    | **Board type** | After [creating a board](create-agile-board.md), you won't be able to change its type. |

1. Use the **Columns** tab to customize the settings and appearance of your board's columns:

    - Create columns: Click **Add column** to the right of the board's column list.

    - Rename columns: Click ![](../../_assets/tracker/button-edit.png) to the right of the column name. To save changes, click ![](../../_assets/tracker/approve-checkmark.png).

    - Change the location of the column on the board: Drag the column where you need it.

    - Set the maximum number of issues per column: Input a value into the **Maximum number of issues per column** field.

    - Change column statuses: Take the status block from another column or the **Unused statuses** list and drag it to your column.

    - Delete a status from a column: Click ![](../../_assets/tracker/delete-agile-status.png) next to the status name.

    - Delete statuses: Click ![](../../_assets/tracker/delete-agile-column.png) to the right of the field name.

1. For **Scrum** boards, go to the **Poker** tab and [set up your issue scoring system](planning-poker.md#section_scale).

1. Click **Save**.

## Customize the appearance of issue cards {#sec_layout}

You can customize the appearance of issue cards so that only relevant issue settings are displayed on the board. You can also use this feature to quickly find issues with the desired tags and components via color coding.

#### Select issue fields {#card_fields}

The issue card only displays values for the required fields by default, such the key, name, assignee, and some others. If you want to display additional fields on issue cards, do the following:

1. On the board page in the upper-right corner, click ![](../../_assets/tracker/edit-agile.png).

1. Go to the **Card view** tab.

1. Click **Add field** and select the issue fields you wish to add to the issue card.

    You can see a preview of the card with filled in fields in the upper-right corner of the page.

1. To remove an additional field from the card, click ![](../../_assets/tracker/delete-agile-column.png) to the right of the field name.

    To remove all additional fields, click the **Remove additional fields** button at the bottom of the page.

    You cannot remove required fields.

1. Click **Save**.

#### Highlight tags and components.

If you want to make certain tags or components stand out on the board, you can put colored labels on them. To configure this feature:

1. On the board page in the upper-right corner, click ![](../../_assets/tracker/edit-agile.png).

1. Go to the **Card view** tab.

1. To configure colored labels for tags:

    1. [Add](#card_fields) the **Tags** field if it's not on the list.

    1. Click **Choose colors** under the **Tags** field.

    1. Start typing the tag's name in the window that opens. Matching tags will be displayed.

    1. Choose the tags you want to label. Colors will be assigned automatically for the selected tags.

    1. If you want to change a label's color, click ![](../../_assets/tracker/edit-tag.png) and choose another color.

    1. If you want to remove a colored label, click ![](../../_assets/tracker/edit-tag.png) and choose **Remove from list**.

    You can see a preview of the card with colored labels in the upper-right corner of the page.

1. You can also configure colored labels for your components the same way as for tags.

1. Click **Save**.

## Delete a board {#section_qfj_wz1_cgb}

You can delete the boards you don't need. This will leave all its issues intact.

To delete a board:

1. Go to the board's page.

1. In the upper-right corner, click ![](../../_assets/tracker/edit-agile.png).

1. Click **Delete board** at the bottom of the page.

1. Confirm the deletion.