In the **Semantic attribute setting** window that opens, specify the period to pick the dialogs for to configure the semantic attribute. Add filters as needed. As a result, you will see the number of dialogs in the selection.

{{ speechsense-name }} will analyze the specified selection of dialogs and generate [suggestions](../../../../speechsense/concepts/tags.md#suggestions) for the specified semantic attribute. This requires at least 100 dialogs; otherwise, {{ speechsense-name }} will not be able to conduct a reliable analysis. There are no restrictions on the maximum number; however, if the selection contains more than 1,000 dialogs, {{ speechsense-name }} will randomly select only 1,000 dialogs for analysis.

If there is not enough or too much data in the selection, adjust the period and your filters.   

{% note info %}

The period and filters you set in the **Semantic attribute setting** window are only used to select dialogs for semantic attribute configuration and do not affect the filtering of dialogs for the report.

{% endnote %}
