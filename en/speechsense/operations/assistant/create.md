---
title: Creating an assistant
description: Follow this guide to create an assistant for your project.
---

# Creating an assistant

You can only create an [assistant](../../concepts/assistants.md) in a [project](../../concepts/resources-hierarchy.md#project). To do this, you need the `{{ roles-speechsense-admin }}` or `{{ roles-speechsense-editor }}` role in the project.

## Creating an assistant {#new-assistant}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. Select the **{{ ui-key.yc-ui-talkanalytics.assistants.assistants }}** tab.
1. Click **{{ ui-key.yc-ui-talkanalytics.assistants.create-assistant-key-value }}**.
1. Configure the new assistant:

   * Optionally, enter a name and description for the assistant.
   * Under **{{ ui-key.yc-ui-talkanalytics.assistants.prompt }}**:
      * Enter the text of your instruction. You can use ready-made templates if needed.
      * Select the model that the assistant will use.
      * Optionally, add a [knowledge base](../../concepts/assistants.md#tools) the assistant will use while following instructions.
      * Click **{{ ui-key.yc-ui-talkanalytics.assistants.generate-prompt-key-value }}**. The system will refine your instruction based on the selected model.
   * Under **{{ ui-key.yc-ui-talkanalytics.assistants.result-key-value }}**, add one or more fields. These fields will be used to record and distribute all the values found in dialogs as per the instruction:
      * Enter a name for the field.
      * Select the field type.
      * As a description, provide the information from the instruction to track in this field.
   
   {% note tip %}
   
   To use ready-made templates for the **{{ ui-key.yc-ui-talkanalytics.assistants.prompt }}** and **{{ ui-key.yc-ui-talkanalytics.assistants.result-key-value }}** sections, click **{{ ui-key.yc-ui-talkanalytics.assistants.templates }}** under **{{ ui-key.yc-ui-talkanalytics.assistants.prompt }}** and select a suitable template.
   
   {% endnote %}

1. Enable the **{{ ui-key.yc-ui-talkanalytics.assistants.applying }}** section to activate the assistant. 

   {% note warning %}

   Once the assistant is activated, you start [paying](../../pricing.md) for it. The assistant feature in your project is activated manually. The assistant analyzes only the dialogs uploaded after it is activated.

   {% endnote %}

   Select the dialogs you want the assistant to analyze:
   * **{{ ui-key.yc-ui-talkanalytics.assistants.all-dialogs-key-value }}**: All dialogs in the project.
   * **{{ ui-key.yc-ui-talkanalytics.assistants.filtered-dialogs-key-value }}**: Only dialogs that satisfy the filtering criteria.
      Add the necessary filters by clicking ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-ui-talkanalytics.common.add-filter }}**.

1. Under **{{ ui-key.yc-ui-talkanalytics.assistants.testing-key-value }}**, you can test the assistant on a selection of dialogs before you create it. Do it by adding the necessary filters using the ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-ui-talkanalytics.common.add-filter }}** button.

1. Click **{{ ui-key.yc-ui-talkanalytics.common.create }}**.
   
   