---
title: Managing chat context
description: Track context usage, compress chat history, and create branches in {{ alice-ai-pro-name.p }}.
---

# Managing chat context

Chat context comprises messages and other information {{ alice-ai-pro-name.i }} considers to continue a conversation. The size of chat context is limited. When you hit that limit, the chat will no longer accept new messages.

In the interface, the context size is referred to as **chat memory**. This indicator is scoped strictly to the current chat and must not be confused with [cross-chat memory](../concepts/memory.md).

## Tracking context usage {#check}

1. Open a chat.
1. At the bottom of the input field, click the circular **Chat memory** indicator.

The menu will display the percentage of your used context. When you approach the context limit, the indicator will show a warning.

## Chat history compaction {#compact}

Compaction saves essential information from your previous conversation as a summary to make room for new messages. Use it when you want to keep working on your current task within the same chat.

1. Click the **Chat memory** indicator.
1. Select **Compress chat history**.
1. Wait for compaction to complete and proceed with your conversation.

{{ alice-ai-pro-name.i }} can also automatically compress history if a conversation becomes too long. A message about compaction will appear in the chat history.

{% note warning %}

Some conversation details may be missing from the compacted context. Make sure to save important results to files, and if relevant, restate your requirements in a new message.

{% endnote %}

## Creating a new branch {#branch}

Branching creates a new chat that inherits context from your current conversation without losing the original thread. The two chats are independent of each other.

1. Click the **Chat memory** indicator.
1. Select **Create new branch**.

Branch your chat if you want to try a different approach to a task without starting a new conversation. To free up context space and continue with the same conversation, use chat history compaction.

#### Useful links {#see-also}

- [{#T}](../concepts/limits.md)
- [{#T}](../concepts/memory.md)
- [{#T}](chats.md)
