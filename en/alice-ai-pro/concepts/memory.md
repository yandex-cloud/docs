---
title: Cross-chat memory
description: Learn how {{ alice-ai-pro-name.i }} saves useful information from one chat to use it in another.
---

# Cross-chat memory

The memory feature helps {{ alice-ai-pro-name.d }} employ useful information from previous dialogs in new chats. This information includes, e.g., your text format preferences, terms, or long-term context.

Memory is not an exact correspondence copy. From relevant chats, {{ alice-ai-pro-name.i }} filters out information that may be useful in the future. Due to memory background updates, new information may not appear right away.

## Memory vs. chat context {#memory-and-context}

#|
||  | **Cross-chat memory** | **Chat context** ||
|| Purpose | It transfers useful information from previous tasks to new chats. | It helps {{ alice-ai-pro-name.d }} make use of the current correspondence and results in a particular chat. ||
|| Scope | New chats, if memory is enabled for them. | Current chat. When creating a branch, context is copied to a new chat. ||
|| How to manage | Enable or disable in the settings and for individual chats. | Compress the correspondence history or create a new branch. ||
|#

In the interface, the context size is called **chat memory**. This indicator does not show the cross-chat memory size.

## Enabling or disabling memory {#enable}

1. Open **Settings**.
1. Select **Experimental functions**.
1. Enable or disable **Memory**.

If you disable memory, new chats will not make use of previously saved information, and chats will not add new information to the memory. Disabling memory neither deletes saved information nor removes it from an open chat.

## Setting up memory for an individual chat {#configure-chat}

Prior to starting a chat:

1. In the input field, enter `/` and select **Memory**.
1. Select suitable options:

   - **Use memory**: Make use of previously saved information in this chat.
   - **Add to memory**: Allow using this chat for creating memory in the future.

The **Use memory** setting is selected when starting a chat, and it cannot be changed afterwards. You can change the **Add to memory** setting after starting a dialog by selecting the **Memory** command again.

{% note info %}

Do not use memory as a single source of critical rules or exact data. If the information is critical for a particular task, repeat it in the request or add it to the project's files.

{% endnote %}

## Use cases {#examples}

Enable memory if you regularly ask {{ alice-ai-pro-name.v }} to prepare materials in one format or if you work on a long-running task in multiple chats.

Disable the **Add to memory** option for an individual chat if the dialog should not affect future chats.

#### Useful links {#see-also}

- [{#T}](limits.md)
- [{#T}](../operations/manage-chat-context.md)
