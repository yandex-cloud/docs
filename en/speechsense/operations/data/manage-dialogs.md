# Working with dialogs

When in a [dialog](../../concepts/dialogs.md), you can get detailed information about the dialog, listen to the conversation audio, and look up the customer's text chat with the agent or bot.

## Viewing a list of dialogs {#list-dialogs}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.

By default, the **{{ ui-key.yc-ui-talkanalytics.dialogs.dialogs }}** tab shows 100 most recent dialogs. To see the previous dialogs, click **{{ ui-key.yc-ui-talkanalytics.common.show-more }}** at the end of the list.

## Finding dialogs {#search-dialogs}

Use the following to search for dialogs:
* [Filters](#filters-dialogs)
* [Full-text search](#full-text-search)
* [Dictionary search](#dictionary-search)
* [Semantic search](#sense-search)

### Filters {#filters-dialogs}

To apply a filter to dialogs:

To get more information about each dialog, [customize the columns](#set-columns).

You can use [filters](#filters-dialogs) and the [search bar](#find-dialogs) to search for dialogs.

## Customizing column display {#set-columns}

By default, not all columns are displayed in the dialog list. You can display additional columns, hide the ones you do not need, and reorder them.

To customize column display:

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. In the title row for the list of dialogs, click ![image](../../../_assets/console-icons/gear.svg). This will open the list of all columns.
1. Do one of the following in the list of columns:

    * Check any additional columns you want displayed.
    * Uncheck columns you do not need to hide them. Some columns cannot be hidden, so you cannot uncheck them.
    * To reorder columns, click ![image](../../../_assets/console-icons/grip.svg) to the left of the column name and drag the column to a new position in the list.

1. Click **Apply**.

## Finding dialogs using filters {#filters-dialogs}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. In the **{{ ui-key.yc-ui-talkanalytics.dialogs.dialogs }}** tab, click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-ui-talkanalytics.common.add-filter }}**.
1. Select the required filter and enter its value.
1. Click **{{ ui-key.yc-ui-talkanalytics.common.apply }}**.

You can add multiple filters. They will be combined by the logical `AND` operation to find the dialogs satisfying all the conditions that were specified.

### Full-text search {#full-text-search}

Full-text search allows you to find dialogs containing a specific word or phrase. The better the dialog text matches the search query and the more frequently it occurs, the higher is the dialog placed in the search results.

To perform a search:

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. Navigate to the **{{ ui-key.yc-ui-talkanalytics.dialogs.dialogs }}** tab.
1. In the drop-down list above the search bar, select ![image](../../../_assets/console-icons/square-dashed-text.svg) **{{ ui-key.yc-ui-talkanalytics.dialogs.search.text.title }}**.
1. Enter the text fragment you are looking for in the search bar.
1. Optionally, to refine your search results, select the channel you want to search in from the drop-down list below the search bar: **{{ ui-key.yc-ui-talkanalytics.dialogs.all-participants }}**, **{{ ui-key.yc-ui-talkanalytics.dialogs.operator }}**, or **{{ ui-key.yc-ui-talkanalytics.dialogs.client }}**.
1. Click **{{ ui-key.yacloud.common.search }}**.

### Dictionary search {#dictionary-search}

The dictionary search allows you to find dialogs containing one or more specified key phrases.

To perform a search:

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. Navigate to the **{{ ui-key.yc-ui-talkanalytics.dialogs.dialogs }}** tab.
1. In the drop-down list above the search bar, select ![image](../../../_assets/console-icons/square-dashed-letter-t.svg) **{{ ui-key.yc-ui-talkanalytics.dialogs.search.dictionary.title }}**.
1. Enter a key phrase or phrases in the search bar. Use a new row for each one.
1. (Optional) To refine your search results:

   * Select the channel you want to search in from the drop-down list: **{{ ui-key.yc-ui-talkanalytics.dialogs.all-participants }}**, **{{ ui-key.yc-ui-talkanalytics.dialogs.operator }}**, or **{{ ui-key.yc-ui-talkanalytics.dialogs.client }}**.
   * Select the allowable distance between words in the key phrase.
   * Enable **{{ ui-key.yc-ui-talkanalytics.dialogs.exact-match-by-key-phrases }}**.
1. Click **{{ ui-key.yacloud.common.search }}**.

### Semantic search {#sense-search}

The semantic search allows you to find dialogs that match the meaning of the search query in the context of the selected [semantic attribute](../../concepts/reports/sense-attributes.md). The search results will only contain dialogs matching the search query, arranged in descending order of the likelihood of matching.

To perform a search:

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. Navigate to the **{{ ui-key.yc-ui-talkanalytics.dialogs.dialogs }}** tab.
1. In the drop-down list above the search bar, select ![image](../../../_assets/console-icons/neuro-tag.svg) **{{ ui-key.yc-ui-talkanalytics.dialogs.search.neuro.title }}**.
1. Select one of the semantic attributes from the drop-down list.
1. In the search bar, select a search query from the auto [suggestions](../../concepts/tags.md#suggestions) or enter it manually.

   If there are more than 1,000 dialogs in the project, {{ speechsense-name }} will analyze only 1,000 random dialogs to generate suggestions. If not happy with the auto suggestions, you can click **{{ ui-key.yacloud.common.update }}**. {{ speechsense-name }} will select 1,000 more random dialogs, analyze them, and generate new suggestions.

1. Click **{{ ui-key.yacloud.common.search }}**.

## Viewing a dialog {#view-dialog}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. [Find the dialog you need](#search-dialogs).
1. Open the dialog in one of the following ways:

    * To open a dialog preview, click the dialog line.
    * To open the dialog in a new window, click ![image](../../../_assets/console-icons/arrow-up-right-from-square.svg) on the right in the dialog line.

The dialog page displays the following information:

* Metadata such as agent and customer names, call or message date, dialog language.
* Conversation audio (only for audio).
* Conversation contents on the **{{ ui-key.yc-ui-talkanalytics.dialogs.dialog }}** tab.
* Semantic analysis of the conversation on the **{{ ui-key.yc-ui-talkanalytics.projects.sumarization }}** tab.
* [Tags](../../concepts/tags.md) assigned to the dialog.

To learn more, see [{#T}](../../concepts/dialogs.md#details).

## Example of searching dialogs by time period and text fragment {#example-find-dialogs-by-period-and-text}

Search criteria:

* Period: `10.11.2023 - 16.11.2023`.
* Contains the customer's utterance: `good service`.

Follow these steps:

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. In the **{{ ui-key.yc-ui-talkanalytics.dialogs.dialogs }}** tab, enter `good service` in the search bar.
1. To the right of the search bar, select the **{{ ui-key.yc-ui-talkanalytics.dialogs.client }}** channel from the drop-down list.
1. Click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-ui-talkanalytics.common.add-filter }}**.
1. In the **{{ ui-key.yc-ui-talkanalytics.dialogs.common-metadata }}** group, select the **Start date** filter. As the filter value, specify the `10.11.2023 - 16.11.2023` date range.
1. Click **{{ ui-key.yc-ui-talkanalytics.common.apply }}**.

The filtered dialogs will be displayed as a result.

Example of ranking dialogs depending on the found text fragments:

#|
|| **No.** | **Dialog date** | **Dialog fragment** ||
|| 1 | 16.11.2023 | thank you for `good service` ||
|| 2 | 13.11.2023 | `good` equipment and `service` ||
|| 3 | 15.11.2023 | full system `service` ||
|#
