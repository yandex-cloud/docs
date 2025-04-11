Specify the selection criteria for dialogs:

* Select a period.
* Optionally, use ![image](../../../_assets/console-icons/plus.svg) next to the **{{ ui-key.yc-ui-talkanalytics.common.period }}** field to select the filters. For more information about filters, see [{#T}](../../../speechsense/concepts/dialogs.md#filters).
* Select a semantic attribute from the drop-down list. In the right-hand section, select one of the search [suggestions](../../../speechsense/concepts/tags.md#suggestions) or enter your own phrase.

    To use semantic attributes, the filtered results must include at least 100 dialogs. You can see the number of dialogs that match the filters in the search bar on the right. {{ speechsense-name }} analyzes these dialogs and offers search suggestions.

    If more than 1,000 dialogs match the filter, 1,000 random dialogs are selected to create a list of suggestions from. In the bottom-right corner of the list, click **{{ ui-key.yc-ui-talkanalytics.neuro-tags.refresh-suggestions }}** for {{ speechsense-name }} to analyze another 1,000 random dialogs.

* Set the minimum probability percentage at which to assign a tag to a dialog.

    During the search, a probability is calculated for each dialog, which indicates the match rate of the dialog text. The higher the probability, the better the dialog matches the search query.
