---
title: Creating an assistant recalculation task in {{ speechsense-full-name }}
description: Follow this guide to create an assistant recalculation task in {{ speechsense-name }}.
---

# Assistant recalculation

To start assistant recalculation in your dialogs for a specific period, create a recalculation task. Proceed as follows:

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. Go to the **{{ ui-key.yc-ui-talkanalytics.assistants.assistants }}** tab and select the assistants to recalculate in your dialogs.

   {% note info %}
   
   If the assistants you specify analyze the selected dialogues using tag-based filtering, the algorithm will additionally prompt you to recalculate the tags. [Semantic Pro tags](../../concepts/tags.md#sense-pro-tags) can be recalculated at an additional fee.
   
   {% endnote %}
   
   
1. Click **{{ ui-key.yc-ui-talkanalytics.tags.reinit }}** at the bottom of the page.
1. Next, specify the dialog recalculation period and click **{{ ui-key.yc-ui-talkanalytics.common.create }}**.


## Canceling an assistant recalculation task {#cancel-recalc}

You can cancel assistant recalculation only if the task's status is **In queue** or **Recalculation underway**. Proceed as follows:

1. Navigate to the **{{ ui-key.yc-ui-talkanalytics.reinit.tab.title }}** tab.
1. Click ![image](../../../_assets/options-grey.svg) to the right of the task and select **{{ ui-key.yc-ui-talkanalytics.reinit.action.cancel.title }}**.