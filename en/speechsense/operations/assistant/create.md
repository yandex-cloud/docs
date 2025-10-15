---
title: Creating an assistant
description: Follow this guide to create an assistant for your project.
---

# Creating an assistant

You can only create an [assistant](../../concepts/assistants.md) in a project. To do this, you need the `{{ roles-speechsense-admin }}` or `{{ roles-speechsense-editor }}` role in the project.

## Creating an assistant {#new-assistant}

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select a project.
1. Open the **Assistants** tab.
1. Click **Create assistant**.
1. Configure the new assistant:

   * Optionally, enter a name and description for the assistant.
   * Under **Instruction**:
      * Enter the text of your instruction. You can use ready-made templates if needed.
      * Select the model that the assistant will use.
      * Optionally, add a [knowledge base](../../concepts/assistants.md#tools) the assistant will use while following instructions.
      * Click **Refine instruction**. The system will refine your instruction based on the selected model.
   * Under **Result**, add one or more fields that will be used to record and distribute values found in conversations according to the instruction:
      * Enter a name for the field.
      * Select the field type.
      * As a description, provide the information from the instruction to track in this field.
   
   {% note tip %}
   
   To use ready-made templates for the **Instruction** and **Result** sections, click **Templates** under **Instruction** and select the appropriate template.
   
   {% endnote %}

1. Enable the **Usage** section to activate the assistant. 

   {% note warning %}

    [Charges](../../pricing.md) for using the assistant will apply as soon as you enable it. Assistant usage can only be enabled manually in the project.
   
   {% endnote %}

   Select the conversations for the assistant to analyze:
   * **All conversations**: The assistant will analyze all conversations in the project.
   * **Selected conversations**: The assistant will only analyze conversations matching the criteria defined in the filters.
      Add the required filters by clicking ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-ui-talkanalytics.common.add-filter }}**.

1. Under **Testing**, you can test the assistant on a sample of conversations before creating it. To do this, add the required filters by clicking ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-ui-talkanalytics.common.add-filter }}**.

1. Click **Create**.
   
   