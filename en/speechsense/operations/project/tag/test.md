---
title: 'Testing a tag '
description: Follow this guide to test a project tag.
---

# Testing a tag

You can test a tag when creating or editing it. The test shows what dialogs you can add this tag to.

{% include [note-pro](../../../../_includes/speechsense/tag/note-pro.md) %}

To test a tag:

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. Navigate to the **{{ ui-key.yc-ui-talkanalytics.tags.tags }}** tab.
1. If you want to create or test a new tag, click ![icon](../../../../_assets/console-icons/tag.svg) **{{ ui-key.yc-ui-talkanalytics.tags.create-tag-key-value }}**, set the [semantic](create-sense-tag.md#new-tag), [semantic Pro](create-sense-pro-tag.md#new-tag) or [dictionary](create-dictionary-tag.md#new-tag) tag parameters, and enable the **{{ ui-key.yc-ui-talkanalytics.neuro-tags.test-tag }}** option for a dictionary tag or **{{ ui-key.yc-ui-talkanalytics.neuro-tags.testing-dataset }}**, for a semantic or semantic Pro one.
1. If you want to test an existing tag, open the tag, click **{{ ui-key.yc-ui-talkanalytics.common.edit }}**, and enable the **{{ ui-key.yc-ui-talkanalytics.neuro-tags.test-tag }}** option for a dictionary tag or **{{ ui-key.yc-ui-talkanalytics.neuro-tags.testing-dataset }}**, for a semantic or semantic Pro one.
1. Specify the test data:

    * Select the dialog selection period.
    * Optionally, use ![icon](../../../../_assets/console-icons/plus.svg) next to the **{{ ui-key.yc-ui-talkanalytics.common.period }}** field to select the filters. For more information about filters, see [{#T}](../../../concepts/dialogs.md#filters).

This will display the dialogs matching the search phrase criteria specified for the tag and the filters set for the test. For dictionary tags, the search for key phrases is conducted through the whole dialog. For semantic tags, {{ speechsense-name }} analyzes the dialogs again to see how close it is semantically to the search query in the context of the selected semantic attribute.

The **{{ ui-key.yc-ui-talkanalytics.statements.summary }}** option makes it possible to display the summarization data {{ yagpt-name }} generates for each dialog.

[Semantic tags](../../../concepts/tags.md#sense-tags) additionally show the probability value for how closely the dialog matches the search criteria. A search selection includes a maximum of 1,000 random dialogs with different probabilities (high, average, low). The higher the probability, the better the dialog matches the search query. Select the **{{ ui-key.yc-ui-talkanalytics.neuro-tags.confidence-key-value }}** field value: the tag will trigger for the dialog if its probability is at or above this value.

[Semantic Pro tags](../../../concepts/tags.md#sense-pro-tags) display an applicability rating which indicates whether the tag is applicable to the found dialog.

{% include [note-pro](../../../../_includes/speechsense/tag/test-pro-additional.md) %}

To test a tag against the new criteria, make the required changes and click **{{ ui-key.yc-ui-talkanalytics.common.apply }}** in the test section.

Do one of the following to navigate to a dialog:

* In the dialog row on the right, click ![icon](../../../../_assets/console-icons/arrow-up-right-from-square.svg).
* In the dialog row on the right, click ![icon](../../../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yc-ui-talkanalytics.dialogs.open-dialog }}**.
