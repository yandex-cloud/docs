---
title: Troubleshooting
description: Troubleshooting common issues with projects, chats, files, and plugins in {{ alice-ai-pro-name.p }}.
---

# Troubleshooting

## {{ alice-ai-pro-name.i }} is restoring the connection {#reconnecting}

Wait for the connection to be restored. If it has not been restored, refresh the page and repeat the action.

## Failed to open a chat {#chat-unavailable}

Refresh the page or try to reopen the chat. If other chats open correctly, create a new chat and continue the task there.

## Project unavailable {#project-unavailable}

If the workspace is unavailable or deleted, contact your organization administrator. Deleting the project from the list will not restore access.

## File upload failure {#file-upload}

Check the file size and number. The size of a single file cannot exceed 25 MB. You can attach up to 20 files per message.

Retry upload. If the error persists, update the page and reattach the file.

## Speech recognition failure {#voice-input}

Make sure the microphone access is enabled and retry recording the audio message. If voice input is unavailable, type your message.

## Failed to load a plugin catalog {#plugin-catalog}

Refresh the page and reopen the catalog. If the catalog does not contain the required plugin, it may be unavailable in your workspace. Contact your organization administrator.

## Chat context is reaching limit {#chat-context}

Open the **Chat memory** indicator and [compress the message history](../operations/manage-chat-context.md#compact). When the context size is used up, the chat will stop receiving new messages.

## Limit is approached {#rate-limit}

Open the chat status and check how much remains of the 5-hour and weekly limits. If one of the limits is depleted, wait until the specified update time or ask your organization's administrator to change the subscription type.

## Scheduled task failure {#scheduled-task}

Open the task and check its status, time of the next execution, and time zone. If the task is suspended, resume it.

Find the execution you need in the history. For an execution with the **Error** status, check the error message. If the execution requires attention, navigate to the task chat and complete the requested action.

To check the task without waiting for the next scheduled execution, run it manually.

#### Useful links {#see-also}

- [{#T}](../concepts/limits.md)
- [{#T}](../operations/chats.md)
- [{#T}](../operations/manage-chat-context.md)
- [{#T}](../operations/scheduled-tasks.md)
