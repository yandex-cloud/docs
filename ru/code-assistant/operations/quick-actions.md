---
title: Быстрые действия в {{ ca-full-name }}
description: Как использовать быстрые действия в {{ ca-name }}.
---

# Быстрые действия в {{ ca-full-name }}

{% include [quick-actions-description](../../_includes/code-assistant/quick-actions-description.md) %}

{% include [ide-function-difference](../../_includes/code-assistant/ide-function-difference.md) %}

{% include [vscode-ui-language](../../_includes/code-assistant/vscode-ui-language.md) %}

## Сгенерировать тесты {#test}

{% list tabs group=ide %}

- Visual Studio Code {#vscode}

  В линзе или лампочке рядом с блоком кода, для которого вы хотите сформировать тесты, нажмите **{{ ca-full-name }}: Generate Tests**.

  Также вы можете установить курсор в блоке кода, для которого вы хотите сформировать тесты, правой кнопкой мыши вызвать контекстное меню и выбрать **{{ ca-full-name }}** → **Generate Tests**.

  Тесты отобразятся в новом чате.

- IDE от JetBrains {#jb}

  Над блоком кода, для которого вы хотите сформировать тесты, нажмите **{{ ca-full-name }}: Generate Tests**.

  Тесты отобразятся в новом чате.

{% endlist %}

## Сгенерировать документацию {#docs}

{% list tabs group=ide %}

- Visual Studio Code {#vscode}

  В линзе или лампочке рядом с блоком кода, для которого вы хотите сформировать документацию, нажмите **{{ ca-full-name }}: Generate Docs**.

  Также вы можете установить курсор в блоке кода, для которого вы хотите сформировать документацию, правой кнопкой мыши вызвать контекстное меню и выбрать **{{ ca-full-name }}** → **Generate Docs**.

  Документация будет предложена в виде комментария к блоку кода. Чтобы принять или отклонить комментарий, нажмите **Accept** (сочетание клавиш **Ctrl** + **Y** в Windows/Linux или **Command** + **Y** в macOS) или **Reject** (сочетание клавиш **Ctrl** + **N** в Windows/Linux или **Command** + **N** в macOS).

- IDE от JetBrains {#jb}

  Над блоком кода, для которого вы хотите сформировать документацию, нажмите **{{ ca-full-name }}: Generate Docs**.

  Документация отобразится в новом чате.

{% endlist %}

## Предложить улучшения кода {#provide-improvements}

{% include [only-in-vscode](../../_includes/code-assistant/only-in-vscode.md) %}

{% list tabs group=ide %}

- Visual Studio Code {#vscode}

  1. Выделите блок кода, для которого вы хотите запросить улучшения.
  1. Правой кнопкой мыши вызовите контекстное меню и выберите **{{ ca-full-name }}** → **Refactor code**.

  Отредактированный код и объяснения отобразятся в новом чате.

{% endlist %}

## Отправить блок кода в чат {#send-to-chat}

{% include [only-in-vscode](../../_includes/code-assistant/only-in-vscode.md) %}

{% list tabs group=ide %}

- Visual Studio Code {#vscode}

  1. Выделите блок кода.
  1. Правой кнопкой мыши вызовите контекстное меню и выберите **{{ ca-full-name }}** → **Add Selection to Chat**.

      Также вы можете использовать сочетание клавиш **Ctrl** + **I** в Windows/Linux или **Command** + **I** в macOS.

{% endlist %}

## Сформировать сообщение для коммита {#commit}

{% include [only-in-vscode](../../_includes/code-assistant/only-in-vscode.md) %}

{% list tabs group=ide %}

- Visual Studio Code {#vscode}

  Поддерживается только система контроля версий [git](https://git-scm.com/).

  В редакторе правой кнопкой мыши вызовите контекстное меню и выберите **{{ ca-full-name }}** → **Commit Description**.

  Краткий отчет об изменениях и сообщение для коммита отобразятся в новом чате.

{% endlist %}

## Настроить действия, отображаемые в линзах и лампочках {#set-actions}

{% include [only-in-vscode](../../_includes/code-assistant/only-in-vscode.md) %}

{% list tabs group=ide %}

- Visual Studio Code {#vscode}

  1. В линзе над блоком кода нажмите ![image](../../_assets/console-icons/xmark.svg).
  1. В открывшемся окне с настройками выберите, какие действия отображать в линзах, а какие — в лампочках. 

{% endlist %}

## Вызвать автодополнение кода {#autocompletion}

{% include [only-in-vscode](../../_includes/code-assistant/only-in-vscode.md) %}

{% list tabs group=ide %}

- Visual Studio Code {#vscode}

  1. Установите курсор в месте, в котором вы хотите вызвать автодополнение.
  1. Правой кнопкой мыши вызовите контекстное меню и выберите **{{ ca-full-name }}** → **Suggest code**.

Вы также можете использовать сочетание клавиш **Ctrl** + **Enter**.

{% endlist %}

## См. также {#see-also}

* [{#T}](../index.md)
* [{#T}](../concepts/index.md)
* [{#T}](../operations/chat.md)