---
title: Permissions and data access
description: Learn when {{ alice-ai-pro-name.i }} requests permission for actions and about the difference between permission modes.
---

# Permissions and data access

To perform a task, {{ alice-ai-pro-name.d }} may need to run a command, access the internet, or edit the workspace files. The *permission mode* decides which actions {{ alice-ai-pro-name.i }} performs by itself, and which ones only after the user's confirmation.

The following modes are available:

* **Ask for permission**: {{ alice-ai-pro-name.i }} asks for a confirmation before it accesses the internet and edits files outside the current project.
* **Approve for me**: {{ alice-ai-pro-name.i }} checks the actions and asks for a confirmation if the action is potentially unsafe.

The **Approve for me** mode is selected by default.

## Confirming actions {#approve-actions}

Before confirming, check which action {{ alice-ai-pro-name.i }} is about to perform and what data will be used for it. If the request seems unexpected or unrelated to your task, decline it and get the task clarified in the chat.

Potentially unsafe actions may include, for example, deleting or overwriting files, transmitting data over the internet, or executing a command which alters the workspace settings.

When using the plugin, keep in mind that it may require data from the chat to execute a request. Do not transmit confidential information unless it is required for the task and permitted by your organization's policies.

## Use cases {#examples}

Select the **Ask for permission** mode if you want to review {{ alice-ai-pro-name.r }} actions. For everyday tasks, you can keep the default **Approve for me** mode: {{ alice-ai-pro-name.i }} will ask for a confirmation if the action is potentially unsafe.

#### Useful links {#see-also}

- [{#T}](workplace-project-chat.md)
- [{#T}](plugins.md)
