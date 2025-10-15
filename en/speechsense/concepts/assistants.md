---
title: Assistants in {{ speechsense-full-name }}
description: In this article, you will learn about assistants in {{ speechsense-name }}.
---

# Assistants in {{ speechsense-name }}

An **assistant** is an AI assistant created in {{ speechsense-name }}. It can automatically analyze dialogs and complete various tasks based on the provided instructions. Assistants are part of the {{ speechsense-name }} resource hierarchy and are created at the project level.

## Basic assistant settings {#properties}

When creating an assistant, you need to provide the following settings:

* **Instructions**: Plain text description of your assistant’s behavior and tasks.

   Instructions must include the request context and the task for the model. The more specific your instruction, the more accurate the model output.

* **Model**: LLM to use for the assistant.
* **Output**: Output fields to write the extracted information to.

You can also set dialog filtering conditions and test the assistant before you start [using](#use) it.

Assistants have restrictions on the number of characters. Learn more in [Quotas and limits](limits.md).

### Knowledge base {#tools}

You can add a knowledge base as an additional tool to enhance your assistant’s capabilities. The assistant will use the knowledge base information to complete the instructions.

{{ speechsense-name }} supports uploading PDF files for the knowledge base. The following restrictions apply:
* Maximum file size: 30 MB.
* Maximum number of files in one knowledge base per assistant: 10.
* You cannot edit a knowledge base.

You can use the same knowledge base with multiple assistants within a single space.

## Dialog analysis {#analysis}

Assistants are designed to analyze dialogs in a project based on the instructions you provide. An assistant can help with the following tasks:

* Extracting key information from dialogs.
* Classifying dialogs by different criteria.
* Generation or calculation of metrics.
* Detection of behavior patterns in customers and agents.

## Using an assistant {#use}

You need to manually enable an assistant in your project. [Charges](../pricing.md) for using the assistant will apply as soon as you enable it.

## Advantages {#advantages}

1. Automated analysis. 

   Reduced manual effort when analyzing large amounts of dialogs.

1. Flexible configuration. 
   
   Performance tailored to various business tasks using instructions.

1. AI integration.
   
   Use of state-of-the-art models for deep insights into the dialog context.

To create, update, or delete an assistant, follow [this guide](../operations/index.md#assistant).