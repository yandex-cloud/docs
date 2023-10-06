# Editing or deleting a board

## Editing a board {#board-settings}

1. Go to the board page.

1. In the upper-right corner, click ![](../../_assets/tracker/edit-agile.png).

1. Configure general board settings:

   | Parameter | Description |
   -------- | --------
   | **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_main.name }}** | Board name. |
   | **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_main.use-ranking }}** | If the option is enabled, the order of issues on the board can be changed by dragging issues. |
   | **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_main.default-queue }}** | Queue key You can create issues in this queue directly from the board page. |
   | **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_main.filter-title }}** | Settings of the filter used to add issues with certain parameters automatically on the board. There are multiple ways to set up filters:<br/><ul><li>Set your filters on the **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_main.filter-type-conditions }}** tab.</li><li>Set your filters using the query language on the **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_main.filter-type-query }}** tab.</li></ul> |
   | **Board type** |You will not be able to change board type after you [create a board](create-agile-board.md). |

1. Use the **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin.tab-title--columns }}** tab to customize the settings and appearance of your board's columns:

   - Creating columns: Click **{{ ui-key.startrek.ui_components_agile_agile-board_AgileBoardAddColumnButton.new-column-button }}** to the right of the board's column list.

   - Renaming columns: click the ![](../../_assets/tracker/button-edit.png) button to the right of the column name. To save your changes, click ![](../../_assets/tracker/approve-checkmark.png).

   - Changing the location of a column on the board: Drag the column where you need it.

   - Setting the maximum number of issues per column: Specify a value in the **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_columns.issues-limit }}** field.

   - Changing column statuses: Take the status block from another column or the **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_columns.status-list-title }}** list and drag it to your column.

   - Deleting a status from the column: click the ![](../../_assets/tracker/delete-agile-status.png) icon next to the status name.

   - Deleting column: Click ![](../../_assets/tracker/delete-agile-column.png).

1. For **{{ ui-key.startrek.components_QueuePresetOnboarding.preset-name--scrum-development-preset }}** boards, go to the **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_poker.title }}** tab and [set the issue estimation scale](planning-poker.md#section_scale).

1. Click **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_main.save-btn }}**.

## Customizing the appearance of issue cards {#sec_layout}

You can customize the appearance of issue cards so that only relevant issue settings are displayed on the board. You can also use this feature to quickly find issues with specific tags and components by color.

#### Selecting issue fields {#card_fields}

By default, the issue card displays the values of required fields: key, name, assignee, and some others. To set up the display of additional fields on the issue card:

1. In the upper-right corner of the board page, click ![](../../_assets/tracker/edit-agile.png).

1. Go to the **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_card-settings.title }}** tab.

1. Click **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_card-settings.action_add-field }}** and select issue fields you wish to add to the issue card.

   An example of the issue card with the added fields is shown in the upper-right corner of the page.

1. To remove an additional field from the card, to the right of the field name, click ![](../../_assets/tracker/delete-agile-column.png).

   To remove all additional fields, click **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_card-settings.action_remove-all }}** at the bottom of the page.

   You can't delete required fields.

1. Click **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_main.save-btn }}**.

#### Highlighting tags and components in colors

To make the issues with certain tags or components stand out on the board, highlight tags and components in colors.

1. In the upper-right corner of the board page, click ![](../../_assets/tracker/edit-agile.png).

1. Go to the **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_card-settings.title }}** tab.

1. To set up colors for tags:

   1. [Add](#card_fields) the **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_card-settings.field-tags }}** field if it is not in the list.

   1. Click **{{ ui-key.startrek.blocks-desktop_st-tokens-chooser.choose-from-list-button }}** under the **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_card-settings.field-tags }}** field.

   1. Start typing the name of the tag in the window that opens. A list of the found tags will be shown.

   1. Select the tags that you want to color, in the list. Colors will be automatically assigned to the selected tags.

   1. If you want to change a tag's color, click ![](../../_assets/tracker/edit-tag.png) on the label, then select a color.

   1. To delete a colored tag, click ![](../../_assets/tracker/edit-tag.png) on the label, then select **{{ ui-key.startrek.blocks-desktop_st-color-tokens.delete-btn }}**.

   An example of the issue card with added color tags is shown in the upper-right corner of the page.

1. Same as for tags, set up the color labels for components.

1. Click **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_main.save-btn }}**.

## Deleting a board {#section_qfj_wz1_cgb}

You can delete boards that you don't need. All the issues present on the board are preserved.

* Only the creator of the board can delete it. If the creator leaves the company, you can rename the board.

* However, you can't delete an auxiliary board created by an auxiliary account.

To delete a board:

1. Go to the board page.

1. In the upper-right corner, click ![](../../_assets/tracker/edit-agile.png).

1. Click **{{ ui-key.startrek.blocks-desktop_b-page-agile-admin-tab_type_main.delete-btn }}** at the bottom of the page.

1. Confirm the deletion.
