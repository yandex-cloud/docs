---
title: Selecting a model and operating mode
description: Learn how to select a model and operating mode for a task in {{ alice-ai-pro-name.p }}.
---

# Selecting a model and operating mode

Before sending a message, you can select the artificial intelligence model and its operating mode. The model determines how {{ alice-ai-pro-name.i }} will process the request, while the operating mode decides how deep the model will analyze the task before responding.

In a standard chat, these settings are grouped under the **Model and operating mode** menu. When you create a scheduled task, they are named **Model** and **Reasoning**.

The model's operating mode is not linked to the [planning mode](../operations/formulate-task.md#plan). The operating mode decides the depth of analysis, while the planning mode first helps you coordinate the steps of the task.

## Available models {#available-models}

The set of models depends on the subscription for the workspace. The organization administrator can further restrict access to specific models. The interface displays only the models available to you at the workspace you select.

If the model you are looking for is not on the list, contact the organization's administrator.

## Operating modes {#reasoning-effort}

The potentially available model operating modes are: **Low**, **Medium**, **High**, and **Very high**. The exact set of modes depends on the model you select.

- **Low** will suit simple tasks, such as editing a short text or creating a list.
- **Medium** is the versatile option for everyday tasks.
- **High** and **Very high** will do well in complex tasks requiring the model to match multiple conditions, study materials, or perform a number of related actions. These modes may take longer to respond.

A higher mode will not necessarily improve the result in a simple task. It affects the depth of analysis but does not decide the length of the response. Specify the requirements for the size and format of the result in your request.

## Selecting a model and operating mode {#select}

1. At the bottom of the input field, open the **Model and operating mode** menu.
1. Select a model.
1. Select one of the operating modes available for it.
1. Describe your task and send the message.

You can edit the setting you select prior to your next message. If, after you change the model, the previous mode is unavailable, {{ alice-ai-pro-name.i }} will pick a supported one.

## Use cases {#examples}

To translate a short text or make a list, start with **Low** or **Medium**. To compare several documents, create a detailed plan, or solve a problem with multiple conditions, try **High**.

#### Useful links {#see-also}

- [{#T}](../operations/formulate-task.md)
- [{#T}](../operations/chats.md)
- [{#T}](../operations/scheduled-tasks.md)
- [{#T}](limits.md)
