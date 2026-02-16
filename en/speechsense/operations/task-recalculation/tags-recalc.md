---
title: Creating a tag recalculation task in {{ speechsense-full-name }}
description: Follow this guide to create a tag recalculation task in {{ speechsense-name }}.
---

# Tag recalculation

To start tag recalculation in your dialogs for a specific period manually, create a tag recalculation task. Proceed as follows:

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. Go to the **{{ ui-key.yc-ui-talkanalytics.tags.tags }}** tab and select the tags you need to recalculate in dialogs manually.
   
   {% note info %}
   
   If the tag has [dependent tags](../../concepts/tags.md#dependent-tags), they will also be recalculated.
   
   {% endnote %}
   
   
1. Click **{{ ui-key.yc-ui-talkanalytics.tags.reinit }}** at the bottom of the page.
1. Next, specify the dialog recalculation period and click **{{ ui-key.yc-ui-talkanalytics.common.create }}**.


## Canceling a tag recalculation task {#cancel-recalc}

You can cancel tag recalculation only if the task's status is **In queue** or **Recalculation underway**. Proceed as follows:

1. Navigate to the **{{ ui-key.yc-ui-talkanalytics.reinit.tab.title }}** tab.
1. Click ![image](../../../_assets/options-grey.svg) to the right of the task and select **{{ ui-key.yc-ui-talkanalytics.reinit.action.cancel.title }}**.

