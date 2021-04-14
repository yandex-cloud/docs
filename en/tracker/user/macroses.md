# Running a macro

In {{ tracker-name }}, macros are scripted algorithms that can be executed on the issue page. You can use macros to automate repeating actions. Macros let you change {% if audience == "internal" %} issue fields, create automated comments, and send{% else %} messages{% endif %}.

{% note info %}

Each {{ tracker-name }} queue has its own set of macros. If you didn't find an appropriate macro, [create one](../manager/create-macroses.md#section_inq_5b1_x2b).

{% endnote %}

To run a macro:

1. Open the issue page.

1. Go to the comment field.

1. Select a macro from the drop-down **Macros** list.
You can select multiple macros at the same time. If multiple macros change the same field, only the last executed change will be applied.

{% if audience == "internal" %}1. To send a message using a macro, go to the **Message** tab and [configure its fields](../user/comments.md#section_zpd_ph5_wdb).{% endif %}

1. To execute the macro, click **Send**.
