---
title: 'Testing a tag '
description: Follow this guide to test a project tag.
---

# Testing a tag

You can test a tag when creating or editing it. The test shows what dialogs you can add this tag to.

To test a tag:

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. Navigate to the **{{ ui-key.yc-ui-talkanalytics.dialogs.classifiers }}** tab.
1. If you want to create or test a new tag, click ![icon](../../../../_assets/console-icons/tag.svg) **{{ ui-key.yc-ui-talkanalytics.tags.create-tag-key-value }}**, set the [semantic](./create-sense-tag.md#new-tag) or [dictionary](./create-dictionary-tag.md#new-tag) tag parameters, and enable **Test tag**.
1. If you want to test an existing tag, open the tag, click **{{ ui-key.yc-ui-talkanalytics.common.edit }}**, and enable the **Test tag** option.
1. Specify the test data:

    * Select the dialog selection period.
    * (Optional) Use the ![icon](../../../../_assets/console-icons/plus.svg) button next to the **Period** field to select the filters. For more information about filters, see [{#T}](../../../../speechsense/concepts/dialogs.md#filters).

This will display the dialogs matching the search phrase criteria specified for the tag and the filters set for the test. For dictionary tags, the search for key phrases is conducted through the whole dialog. For semantic tags, {{ speechsense-name }} analyzes the dialogs again to see how close it is semantically to the search query in the context of the selected semantic attribute.

The **Summarization** option makes it possible to display the summarization data {{ yagpt-name }} generates for each dialog.

[Semantic tags](../../../../speechsense/concepts/tags.md#sense-tags) additionally show the probability value for how closely the dialog matches the search criteria. A search selection includes a maximum of 1,000 random dialogs with different probabilities (high, average, low). The higher the probability, the better the dialog matches the search query. The **Use value** button allows you to set the specified probability as the **Probability** field value: the tag will trigger for the dialog if its probability is at least as high as this value.

To test a tag using the new criteria, make the required changes and click **Apply** in the test section.

Do one of the following to navigate to a dialog:

* In the dialog row on the right, click ![icon](../../../../_assets/console-icons/arrow-up-right-from-square.svg).
* In the dialog row on the right, click ![icon](../../../../_assets/console-icons/ellipsis.svg) → **Go to dialog**.
