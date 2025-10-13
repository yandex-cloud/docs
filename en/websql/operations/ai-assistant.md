---
title: Using an AI assistant for analytics in {{ websql-name }}
description: This guide describes how to use an AI assistant to analyze databases and optimize queries in the {{ websql-full-name }} interface.
---

# Analytics and optimization with AI assistant

{% include [preview-pp](../../_includes/preview-pp.md) %}

{{ websql-name }} features an integrated [AI assistant](../../ai-studio/concepts/assistant/index.md) you can use to do the following:

* Generate database queries from natural language descriptions.
* Fix and optimize queries directly from the editor.
* Analyze database structures.

For example, to analyze a database, do the following:

1. Under ![image](../../_assets/console-icons/folder-tree.svg) [**Connections**]({{ websql-link }}), select the connection and the database.

1. In the left-hand panel, click ![sparkles-fill](../../_assets/console-icons/sparkles-fill.svg) **AI assistant**.

1. In the window that opens, click the suggested prompt: `Review the current database`. This will invoke a chat with an AI assistant. The assistant will analyze the database structure and send the results in the chat.

1. Review the results. Use the chat to ask follow-up questions or further explore the results. Keep in mind that the AI assistant may occasionally make mistakes, so always verify critical information.

{% note tip %}

Each chat session with the AI Assistant is saved, so you can always return to a previous conversation. To do this, in the left-hand panel, click ![sparkles-fill](../../_assets/console-icons/sparkles-fill.svg) **AI assistant**, then click ![bars](../../_assets/console-icons/bars.svg) in the top-left corner of the window that opens. You will be directed to a chat management page where you can view your chat history and manage existing conversations.

{% endnote %}

