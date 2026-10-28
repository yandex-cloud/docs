---
title: Limits and chat context
description: Learn what limits apply in {{ alice-ai-pro-name.p }} and how they are different from the individual chat context.
---

# Limits and chat context

{{ alice-ai-pro-name.p }} has two limits: a *5-hour limit* and *weekly limit*. The interface shows the percentage of the remaining limit and its update time. The limit sizes depend on the workspace subscription set up by the organization's administrator.

Both limits apply concurrently. If one of the limits is used up, you may not be able to send new requests until its update.

## Chat context {#chat-context}

*Chat context* comprises messages and other information {{ alice-ai-pro-name.i }} factors in when continuing a conversation. In the interface, the context size is called **chat memory** and shown as a percentage.

Context is not linked to the 5-hour and weekly limits. Updating the limits does not free up space in context, and compressing context does not bring back the limits.

When the context size is used up, the chat will stop receiving new messages. To continue using the chat, [compress the chat history](../operations/manage-chat-context.md#compact).

## Use cases {#examples}

If context is close to being used up for a chat, compress the history. If the 5-hour or weekly limit is almost reached, wait for its update specified in the interface, or ask the administrator to change the subscription type.

#### Useful links {#see-also}

- [{#T}](../operations/chats.md)
- [{#T}](memory.md)
- [{#T}](../operations/manage-chat-context.md)
- [{#T}](../qa/troubleshooting.md)
