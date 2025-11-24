---
title: Using an AI assistant for analytics in {{ websql-name }}
description: This guide describes how to use an AI assistant to analyze databases and optimize queries in the {{ websql-full-name }} interface.
---

# Analytics and optimization with AI assistant

{% note info %}

{% include [preview-pp](../../_includes/preview-pp.md) %}

{% endnote %}

{{ websql-name }} features an integrated [AI assistant](../../ai-studio/concepts/assistant/index.md) you can use to:

* [Generate SQL queries](#db-query) from natural language descriptions.
* [Fix](#query-fix) SQL queries from your [query editor](query-executor.md).
* [Optimize](#query-opt) SQL queries from your [query editor](query-executor.md).
* Perform a [database overview](#db-overview).
* Conduct [database index analysis](#db-index-analysis).

{% note warning %}

The AI assistant can make mistakes. Always check its suggestions for validity.

{% endnote %}

## Generating database queries {#db-query}

The AI assistant can generate SQL queries based on natural language descriptions, for example:

> Find all users who have not placed any orders in the last 30 days.

> Create a test table named `test` and populate it with 10 entries.

Queries follow the syntax and structure of the database you select.

The AI assistant does not execute SQL queries. Execute them using one of these methods:

* Click **Execute query** below the generated SQL query. This will automatically execute the query in the [query editor](query-executor.md).
* Copy the query from the AI assistant's response and execute it manually.

## Fixing and optimizing database queries {#db-query-optimization}

The AI assistant can [fix](#query-fix) and [optimize](#query-opt) SQL queries from your [query editor](query-executor.md) based on the syntax and structure of the database you select. You can also fix and optimize other SQL queries to the selected database by forwarding them directly into the [chat](#chats).

### Fixing {#query-fix}

1. Open [{{ websql-full-name }}]({{ websql-link }}).
1. Connect to the database of your choice in the ![image](../../_assets/console-icons/folder-tree.svg) **Connections** section.
1. In the left-hand panel, select ![sparkles-fill](../../_assets/console-icons/sparkles-fill.svg) **AI assistant**. The AI assistant window will open.
1. Type `Fix errors in this query` and click ![arrow-up](../../_assets/console-icons/arrow-up.svg).
  
    This will create a new [chat](#chats) where the AI assistant will help you correct the SQL query from the [query editor](query-executor.md). If no query is present in the editor, the assistant will prompt you to enter the SQL query you want fixed.

### Optimizing {#query-opt}

1. Open [{{ websql-full-name }}]({{ websql-link }}).
1. Connect to the database of your choice in the ![image](../../_assets/console-icons/folder-tree.svg) **Connections** section.
1. In the left-hand panel, select ![sparkles-fill](../../_assets/console-icons/sparkles-fill.svg) **AI assistant**. The AI assistant window will open.
1. In the AI assistant window, click the suggested message: `Optimize SQL query`.
    
    This will create a new [chat](#chats) where the AI assistant will help you optimize the SQL query from the [query editor](query-executor.md). If there is no query in the editor, the assistant will prompt you to enter the SQL query you want optimized.

## Database analysis {#db-analysis}

The AI assistant helps with [database overview](#db-overview) and [index analysis](#db-index-analysis).

### Database overview {#db-overview}

1. Open [{{ websql-full-name }}]({{ websql-link }}).
1. Connect to the database of your choice in the ![image](../../_assets/console-icons/folder-tree.svg) **Connections** section.
1. In the left-hand panel, select ![sparkles-fill](../../_assets/console-icons/sparkles-fill.svg) **AI assistant**. The AI assistant window will open.
1. In the AI assistant window, click the suggested message: `Review current database`.
    
    This will create a new [chat](#chats) where the AI assistant will overview the selected database.

### Database index analysis {#db-index-analysis}

1. Open [{{ websql-full-name }}]({{ websql-link }}).
1. Connect to the database of your choice in the ![image](../../_assets/console-icons/folder-tree.svg) **Connections** section.
1. In the left-hand panel, select ![sparkles-fill](../../_assets/console-icons/sparkles-fill.svg) **AI assistant**. The AI assistant window will open.
1. In the AI assistant window, click the suggested message: `Analyze database indexes`.
    
    This will create a new [chat](#chats) where the AI assistant will analyze the indexes of the selected database and give some optimization recommendations.

## Chat management {#chats}

The AI assistant can help you [create chats](#chat-create). Chats are not associated with any connection or database; however, the AI assistant's responses are guided by the context of the selected database.

Each chat session gets saved, so you can always [return](#chat-history) to it if you need to.

If you no longer need a chat, you can [delete](#chat-delete) it.

### Creating a new chat {#chat-create}

1. Open [{{ websql-full-name }}]({{ websql-link }}).
1. Connect to the database of your choice in the ![image](../../_assets/console-icons/folder-tree.svg) **Connections** section.
1. In the left-hand panel, select ![sparkles-fill](../../_assets/console-icons/sparkles-fill.svg) **AI assistant**. The AI assistant window will open.
1. To start a new chat with the AI assistant, type a message and click ![arrow-up](../../_assets/console-icons/arrow-up.svg).

### Viewing chat history {#chat-history}

1. Open [{{ websql-full-name }}]({{ websql-link }}).
1. Connect to the database of your choice in the ![image](../../_assets/console-icons/folder-tree.svg) **Connections** section.
1. In the left-hand panel, select ![sparkles-fill](../../_assets/console-icons/sparkles-fill.svg) **AI assistant**. The AI assistant window will open.
1. In the top-left corner of the AI assistant window, click ![bars](../../_assets/console-icons/bars.svg). You will be directed to the chat management page.
    
    The page offers the history of your chats with the AI assistant.

### Deleting a chat {#chat-delete}

1. Open [{{ websql-full-name }}]({{ websql-link }}).
1. Connect to the database of your choice in the ![image](../../_assets/console-icons/folder-tree.svg) **Connections** section.
1. In the left-hand panel, select ![sparkles-fill](../../_assets/console-icons/sparkles-fill.svg) **AI assistant**. The AI assistant window will open.
1. In the top-left corner of the AI assistant window, click ![bars](../../_assets/console-icons/bars.svg). You will be directed to the chat management page.
1. Click ![trash-bin](../../_assets/console-icons/trash-bin.svg) next to the chat.