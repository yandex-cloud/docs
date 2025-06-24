---
title: Running {{ ca-full-name }} in chat mode
description: How to use {{ ca-name }} in chat mode.
---

# {{ ca-full-name }} chat

{% include [chat-description](../../_includes/code-assistant/chat-description.md) %}

{% include [ide-function-difference](../../_includes/code-assistant/ide-function-difference.md) %}

{% include [vscode-ui-language](../../_includes/code-assistant/vscode-ui-language.md) %}

## Sending messages {#sending}

{% list tabs group=ide %}

- Visual Studio Code {#vscode}

  **Opening a chat** {#open-chat-vs}

  1. Click ![image](../../_assets/code-assistant/chat-logo.svg) **{{ ca-full-name }}** in the editor’s left panel.

      If you have many plugins, the chat button may be hidden in the ![image](../../_assets/console-icons/ellipsis.svg) menu.

      Alternatively, use **Ctrl** + **L** in Windows/Linux or **Command** + **L** in macOS.
  1. See the examples of queries under **{{ ca-name }} School**.
   
      Click ![image](../../_assets/console-icons/arrow-rotate-right.svg) to update the examples.

      Click an example to use it.

  **Sending a message** {#send-message-vs}

  Write your request to the AI assistant in the message input window and click ![image](../../_assets/console-icons/logo-yandex-messenger.svg) or press **Enter**.

  For a line break in the message, press **Ctrl** + **Enter** for Windows or Linux or **Command** + **Enter** for macOS. 

  To reassign line break to **Enter** and message sending to **Ctrl**/**Command** + **Enter**, hover over ![image](../../_assets/console-icons/logo-yandex-messenger.svg) and select the right option in the pop-up window.

  {% include [context-chat](../../_includes/code-assistant/context-chat.md) %}

  **Stopping response generation** {#stop-generation-vs}

  {% include [stop-generating](../../_includes/code-assistant/stop-generating.md) %}

  **Rating a response** {#rate-answer-vs}

  {% include [thumbs-up-down](../../_includes/code-assistant/thumbs-up-down.md) %}

  **Displaying previous request to the AI assistant** {#previous-message-vs}

  In the message input window, click ![image](../../_assets/console-icons/clock-arrow-rotate-left.svg).

- JetBrains IDE {#jb}

  **Opening a chat** {#open-chat-jb}

  In the editor's right-hand panel, click ![image](../../_assets/code-assistant/chat-logo.svg) **{{ ca-full-name }} Chat**.

  **Sending a message** {#send-message-jb}

  Write your request to the AI assistant in the message input window and click ![image](../../_assets/code-assistant/jb-icon-send.svg) or press **Enter**.

  For a line break in the message, press **Shift** + **Enter**. 

  {% include [context-chat](../../_includes/code-assistant/context-chat.md) %}

  **Stopping response generation** {#stop-generation-jb}

  {% include [stop-generating](../../_includes/code-assistant/stop-generating.md) %}

  **Rating the response** {#rate-answer-jb}

  {% include [thumbs-up-down](../../_includes/code-assistant/thumbs-up-down.md) %}

{% endlist %}

## Chat history {#chat-history}

{% list tabs group=ide %}

- Visual Studio Code {#vscode}

  **Opening a new chat** {#new-chat-vs}

  Click ![image](../../_assets/console-icons/plus.svg) **New chat** in the chat's top panel.

  **Viewing the list of chats** {#list-chat-vs}

  Click ![image](../../_assets/console-icons/clock-arrow-rotate-left.svg) **History** in the chat's top panel.

  From the list that opens, select the chat you want to go back to.

  The names for chats are created automatically. To rename a chat, click the ![image](../../_assets/console-icons/pencil.svg) button next to it, enter a new name, and press **Enter**.

  To delete a chat from the list, click the ![image](../../_assets/console-icons/xmark.svg) button next to it.

- JetBrains IDE {#jb}

  **Clearing a chat** {#new-chat-jb}

  Click ![image](../../_assets/code-assistant/jb-icon-clean-chat.svg) **Clean Chat** in the chat's top panel.

{% endlist %}

## Code blocks {#codeblocks}

{% list tabs group=ide %}

- Visual Studio Code {#vscode}

  **Copying code from a chat** {#copy-code-vs}

  Hover over the code block and click ![image](../../_assets/code-assistant/copy.svg) in the top-right corner.

  **Pasting code from a chat into an open tab** {#paste-code-vs}

  Hover over the code block and click ![image](../../_assets/console-icons/file-arrow-right.svg) in the top-right corner.

- JetBrains IDE {#jb}

  **Copying code from a chat** {#copy-code-jb}

  Click ![image](../../_assets/code-assistant/jb-icon-copy.svg) in the top-right corner of the code block.

{% endlist %}

## {{ ca-full-name }} settings {#open-settings}

{% include [only-in-vscode](../../_includes/code-assistant/only-in-vscode.md) %}

{% list tabs group=ide %}

- Visual Studio Code {#vscode}

  Click ![image](../../_assets/console-icons/gear.svg) **Settings** in the chat's top panel.

{% endlist %}

## See also {#see-also}

* [{#T}](../index.md)
* [{#T}](../concepts/index.md)
* [{#T}](../operations/quick-actions.md)