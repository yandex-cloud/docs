---
title: Работа с {{ ca-full-name }} в режиме чата
description: Как использовать {{ ca-name }} в режиме чата.
---

# Чат в {{ ca-full-name }}

{% include [chat-description](../../_includes/code-assistant/chat-description.md) %}

{% include [ide-function-difference](../../_includes/code-assistant/ide-function-difference.md) %}

{% include [vscode-ui-language](../../_includes/code-assistant/vscode-ui-language.md) %}

## Отправка сообщения {#sending}

{% list tabs group=ide %}

- Visual Studio Code {#vscode}

  **Открыть чат** {#open-chat-vs}

  1. На левой панели редактора нажмите кнопку ![image](../../_assets/code-assistant/chat-logo.svg) **{{ ca-full-name }}**.

      Если у вас много плагинов, кнопка чата может быть скрыта в меню ![image](../../_assets/console-icons/ellipsis.svg).

      Также вы можете использовать сочетание клавиш **Ctrl** + **L** в Windows/Linux или **Command** + **L** в macOS.
  1. Изучите представленные в блоке **{{ ca-name }} School** примеры запросов.
   
      Чтобы обновить примеры, нажмите кнопку ![image](../../_assets/console-icons/arrow-rotate-right.svg).

      Чтобы использовать пример, нажмите на него.

  **Отправить сообщение** {#send-message-vs}

  В окне для ввода сообщения напишите запрос AI-помощнику и нажмите кнопку ![image](../../_assets/console-icons/logo-yandex-messenger.svg) или **Enter**.

  Чтобы перейти на новую строку в сообщении, используйте сочетание клавиш **Ctrl** + **Enter** в Windows/Linux или **Command** + **Enter** в macOS. 

  Чтобы переназначить перенос строки на **Enter**, а отправку сообщения — на **Ctrl**/**Command** + **Enter**, наведите указатель на ![image](../../_assets/console-icons/logo-yandex-messenger.svg) и выберите во всплывающем окне нужный вариант.

  {% include [context-chat](../../_includes/code-assistant/context-chat.md) %}

  **Прекратить генерацию ответа** {#stop-generation-vs}

  {% include [stop-generating](../../_includes/code-assistant/stop-generating.md) %}

  **Оценить ответ** {#rate-answer-vs}

  {% include [thumbs-up-down](../../_includes/code-assistant/thumbs-up-down.md) %}

  **Вывести предыдущее обращение к AI-помощнику** {#previous-message-vs}

  В окне для ввода сообщения нажмите кнопку ![image](../../_assets/console-icons/clock-arrow-rotate-left.svg).

- IDE от JetBrains {#jb}

  **Открыть чат** {#open-chat-jb}

  На правой панели редактора нажмите кнопку ![image](../../_assets/code-assistant/chat-logo.svg) **{{ ca-full-name }} Chat**.

  **Отправить сообщение** {#send-message-jb}

  В окне для ввода сообщения напишите запрос AI-помощнику и нажмите кнопку ![image](../../_assets/code-assistant/jb-icon-send.svg) или **Enter**.

  Чтобы перейти на новую строку в сообщении, используйте сочетание клавиш **Shift** + **Enter**. 

  {% include [context-chat](../../_includes/code-assistant/context-chat.md) %}

  **Прекратить генерацию ответа** {#stop-generation-jb}

  {% include [stop-generating](../../_includes/code-assistant/stop-generating.md) %}

  **Оценить ответ** {#rate-answer-jb}

  {% include [thumbs-up-down](../../_includes/code-assistant/thumbs-up-down.md) %}

{% endlist %}

## История чата {#chat-history}

{% list tabs group=ide %}

- Visual Studio Code {#vscode}

  **Открыть новый чат** {#new-chat-vs}

  На верхней панели чата нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **New chat**.

  **Посмотреть список чатов** {#list-chat-vs}

  На верхней панели чата нажмите кнопку ![image](../../_assets/console-icons/clock-arrow-rotate-left.svg) **History**.

  В открывшемся списке выберите чат, к которому вы хотите вернуться.

  Для чатов автоматически формируются названия. Чтобы переименовать чат, напротив него нажмите кнопку ![image](../../_assets/console-icons/pencil.svg), введите новое название и нажмите кнопку **Enter**.

  Чтобы удалить чат из списка, напротив чата нажмите кнопку ![image](../../_assets/console-icons/xmark.svg).

- IDE от JetBrains {#jb}

  **Очистить чат** {#new-chat-jb}

  На верхней панели чата нажмите кнопку ![image](../../_assets/code-assistant/jb-icon-clean-chat.svg) **Clean Chat**.

{% endlist %}

## Блоки кода {#codeblocks}

{% list tabs group=ide %}

- Visual Studio Code {#vscode}

  **Скопировать код из чата** {#copy-code-vs}

  Наведите указатель на блок кода и в правом верхнем углу нажмите ![image](../../_assets/code-assistant/copy.svg).

  **Вставить код из чата в открытую вкладку** {#paste-code-vs}

  Наведите указатель на блок кода и в правом верхнем углу нажмите ![image](../../_assets/console-icons/file-arrow-right.svg).

- IDE от JetBrains {#jb}

  **Скопировать код из чата** {#copy-code-jb}

  В правом верхнем углу блока кода нажмите ![image](../../_assets/code-assistant/jb-icon-copy.svg).

{% endlist %}

## Настройки {{ ca-full-name }} {#open-settings}

{% include [only-in-vscode](../../_includes/code-assistant/only-in-vscode.md) %}

{% list tabs group=ide %}

- Visual Studio Code {#vscode}

  На верхней панели чата нажмите кнопку ![image](../../_assets/console-icons/gear.svg) **Settings**.

{% endlist %}

## См. также {#see-also}

* [{#T}](../index.md)
* [{#T}](../concepts/index.md)
* [{#T}](../operations/quick-actions.md)