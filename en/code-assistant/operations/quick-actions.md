---
title: Quick actions in {{ ca-full-name }}
description: How to use quick actions in {{ ca-name }}.
---

# Quick actions in {{ ca-full-name }}

{% include [quick-actions-description](../../_includes/code-assistant/quick-actions-description.md) %}

{% include [ide-function-difference](../../_includes/code-assistant/ide-function-difference.md) %}

{% include [vscode-ui-language](../../_includes/code-assistant/vscode-ui-language.md) %}

## Generating tests {#test}

{% list tabs group=ide %}

- Visual Studio Code {#vscode}

  In the codelens or lightbulb next to the code section you want to generate tests for, click **{{ ca-full-name }}: Generate Tests**.

  Alternatively, you can right-click within the code section for which you want to generate tests and select **{{ ca-full-name }}** → **Generate Tests**.

  The generated tests will appear in a new chat.

- JetBrains IDE {#jb}

  Above the code section you want to generate tests for, click **{{ ca-full-name }}: Generate Tests**.

  The generated tests will appear in a new chat.

{% endlist %}

## Generating docs {#docs}

{% list tabs group=ide %}

- Visual Studio Code {#vscode}

  In the codelens or lightbulb next to the code section you want to generate docs for, click **{{ ca-full-name }}: Generate Docs**.

  Alternatively, you can right-click within the code section for which you want to generate docs and select **{{ ca-full-name }}** → **Generate Docs**.

  The docs will be suggested in the form of a code section comment. To accept or reject the comment, click **Accept** (**Ctrl** + **Y** in Windows/Linux or **Command** + **Y** in macOS) or **Reject** (**Ctrl** + **N** in Windows/Linux or **Command** + **N** in macOS).

- JetBrains IDE {#jb}

  Above the code section you want to generate docs for, click **{{ ca-full-name }}: Generate Docs**.

  The generated docs will appear in a new chat.

{% endlist %}

## Refactoring code {#provide-improvements}

{% include [only-in-vscode](../../_includes/code-assistant/only-in-vscode.md) %}

{% list tabs group=ide %}

- Visual Studio Code {#vscode}

  1. Select the code section you need refactored.
  1. Right-click to open the context menu and select **{{ ca-full-name }}** → **Refactor code**.

  The refactored code and explanations will appear in a new chat.

{% endlist %}

## Sending a code section to a chat {#send-to-chat}

{% include [only-in-vscode](../../_includes/code-assistant/only-in-vscode.md) %}

{% list tabs group=ide %}

- Visual Studio Code {#vscode}

  1. Select the code section.
  1. Right-click to open the context menu and select **{{ ca-full-name }}** → **Add Selection to Chat**.

      Alternatively, you can use **Ctrl** + **I** in Windows/Linux or **Command** + **I** in macOS.

{% endlist %}

## Generating a commit message {#commit}

{% include [only-in-vscode](../../_includes/code-assistant/only-in-vscode.md) %}

{% list tabs group=ide %}

- Visual Studio Code {#vscode}

  Only the [Git](https://git-scm.com/) version control system is supported.

  In the editor, right-click to open the context menu and select **{{ ca-full-name }}** → **Commit Description**.

  You will see a change summary and commit message in a new chat.

{% endlist %}

## Setting up actions displayed in code lenses and lightbulbs {#set-actions}

{% include [only-in-vscode](../../_includes/code-assistant/only-in-vscode.md) %}

{% list tabs group=ide %}

- Visual Studio Code {#vscode}

  1. In the codelens above the code section, click ![image](../../_assets/console-icons/xmark.svg).
  1. In the settings window that opens, select which actions should appear in codelenses and which in lightbulbs. 

{% endlist %}

## Invoking code autocompletion {#autocompletion}

{% include [only-in-vscode](../../_includes/code-assistant/only-in-vscode.md) %}

{% list tabs group=ide %}

- Visual Studio Code {#vscode}

  1. Position the cursor to where you want to invoke autocompletion.
  1. Right-click to open the context menu and select **{{ ca-full-name }}** → **Suggest code**.

Alternatively, you can use **Ctrl** + **Enter**.

{% endlist %}

## See also {#see-also}

* [{#T}](../index.md)
* [{#T}](../concepts/index.md)
* [{#T}](../operations/chat.md)