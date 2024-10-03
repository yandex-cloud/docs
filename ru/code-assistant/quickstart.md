---
title: Начало работы с {{ ca-full-name }}
description: Установите плагин {{ ca-name }} для Visual Studio Code.
---

# Как начать работать с {{ ca-full-name }}

{% include [preview-stage](../_includes/code-assistant/preview-stage.md) %}

{% include [about-service](../_includes/code-assistant/about-service.md) %}

Чтобы начать работу с сервисом:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Установите и настройте плагин](#install-plugin).
1. [Протестируйте плагин](#work-with-plugin).
1. [Управляйте плагином](#manage-plugin).

## Подготовьте облако к работе {#before-you-begin}

{% note info %}

Если у вашей [организации](../overview/roles-and-resources.md) в {{ yandex-cloud }} уже есть доступ к {{ ca-name }}, перейдите к шагу [Установите и настройте плагин](#install-plugin).

{% endnote %}

{% include [before-you-begin](../_includes/code-assistant/before-you-begin.md) %}

## Установите и настройте плагин {#install-plugin}

{% list tabs group=ide %}

- Visual Studio Code {#vscode}

  1. Скачайте [плагин {{ ca-name }}]({{ link-ca-vscode }}) для [Visual Studio Code](https://code.visualstudio.com/).

      {% include [unable-to-download](../_includes/code-assistant/unable-to-download.md) %}

  1. Установите плагин:
      1. Откройте Visual Studio Code.
      1. Откройте **Палитру Команд** (**Command Palette**), для этого используйте сочетание клавиш **Ctrl** + **Shift** + **P** в Windows/Linux или **Command** + **Shift** + **P** в macOS.
      1. Введите команду `Extensions: Install from VSIX...` и выберите файл плагина, скачанный ранее.

          Установка завершится сообщением `Завершена установка расширения` (`Completed installing extension`).

      Также вы можете установить плагин через [Visual Studio Code CLI](https://code.visualstudio.com/docs/editor/command-line) с помощью команды:

      ```bash
      code --install-extension <путь_к_плагину>
      ```

  1. Чтобы начать работать с плагином, аутентифицируйтесь в {{ yandex-cloud }}:
      1. Во всплывающем окне **No active session found. Log in please** нажмите кнопку **Go to browser**.
      1. Разрешите Visual Studio Code открыть в браузере страницу аутентификации.
      1. В браузере войдите в [консоль управления]({{ link-console-main }}) {{ yandex-cloud }}.
      1. Вернитесь обратно в Visual Studio Code. 

  Плагин включен, готов к работе и отображается на нижней панели редактора в виде кнопки ![image](../_assets/code-assistant/vsc-icon-small.svg).

- IDE от JetBrains {#jb}

  {% note warning %}

  Поддерживается работа с IDE версий 2024.1 и 2024.2.

  {% endnote %}

  1. Скачайте плагин {{ ca-name }} для своей версии [IDE от JetBrains](https://www.jetbrains.com/ides/):
      * [2024.1]({{ link-ca-jb-2024-1 }})
      * [2024.2]({{ link-ca-jb-2024-2 }})

      {% include [unable-to-download](../_includes/code-assistant/unable-to-download.md) %}

  1. Установите плагин:
      1. Откройте IDE.
      1. Откройте настройки, для этого используйте сочетание клавиш **Ctrl** + **Alt** + **S** в Windows/Linux или **Command** + **,** в macOS.
      1. Перейдите в раздел **Plugins**.
      1. Нажмите ![image](../_assets/console-icons/gear.svg) и выберите **Install Plugin from Disk...**
      1. Выберите файл плагина, скачанный ранее.
      1. Подтвердите, что вы согласны использовать плагин от стороннего разработчика и нажмите **OK**.

  1. Чтобы начать работать с плагином, аутентифицируйтесь в {{ yandex-cloud }}:
      1. Во всплывающем окне **Yandex Code Assistant OAuth** нажмите **Yandex Code Assist: Login**.
      1. В браузере войдите в [консоль управления]({{ link-console-main }}) {{ yandex-cloud }}.
      1. Вернитесь обратно в IDE. 

  Сообщение `Code Assist plugin started` означает, что плагин включен и готов к работе.

  {% note tip %}

  Если плагин не запустился, или не появляются предложения от {{ ca-name }}, попробуйте перезапустить IDE.

  {% endnote %}

{% endlist %}

## Протестируйте плагин {#work-with-plugin}

{% note info %}

Для работы {{ ca-name }} требуется постоянный доступ в интернет.

{% endnote %}

{% include [syntax-support](../_includes/code-assistant/syntax-support.md) %}

{% include [auto-manual-modes](../_includes/code-assistant/auto-manual-modes.md) %}

Пример работы с плагином:

1. Откройте IDE и создайте тестовый файл `server.cpp` со следующим содержимым:

    ```cpp
    // simple web-server to work with sockets

    #include <iostream>
    #include <string>
    #include <sys/socket.h>
    #include <netinet/in.h>
    #include <unistd.h>

    using namespace std;

    int main() {

    }
    ```

1. В блоке `int main()` начните вводить текст, например комментарий `//create socket`. Посмотрите предложение от {{ ca-name }}:

    ```cpp
    ...
    int main() {

    //create socket
    int sockfd = socket(AF_INET, SOCK_STREAM, 0);

    }
    ```

1. Выберите, что делать с предложением:

    {% list tabs group=ide %}

    - Visual Studio Code {#vscode}

      * Чтобы принять предложение, нажмите клавишу **Tab**.
      * Чтобы принять часть предложения по одному слову, используйте сочетание клавиш **Ctrl** + **→** в Windows/Linux или **Command** + **→** в macOS.
      * Чтобы отменить предложение, нажмите клавишу **Esc**.
      * Если предложений несколько, вы можете переключаться между ними с помощью сочетаний клавиш **Alt** + **[** и **Alt** + **]** в Windows/Linux или **Option** + **[** и **Option** + **]** в macOS.

    - IDE от JetBrains {#jb}

      * Чтобы принять предложение, нажмите клавишу **Tab**.
      * Чтобы отменить предложение, нажмите клавишу **Esc**. 

    {% endlist %}

Видео с демонстрацией работы плагина см. на [странице {{ ca-name }}](https://cloud.yandex.ru/services/code-assistant).

## Управляйте плагином {#manage-plugin}

### Включите или отключите автоматическую выдачу подсказок {#enable-disable-plugin}

Включение и отключение автоматической выдачи подсказок доступно только в Visual Studio Code.

{% list tabs group=ide %}

- Visual Studio Code {#vscode}

  1. На нижней панели Visual Studio Code нажмите кнопку ![image](../_assets/code-assistant/vsc-icon-small.svg).
  1. В открывшемся списке выберите ![image](../_assets/console-icons/triangle-right.svg) **Enable autotrigger** или ![image](../_assets/console-icons/stop.svg) **Disable autotrigger**.

{% endlist %}

### Обновите плагин {#update-plugin}

{% list tabs group=ide %}

- Visual Studio Code {#vscode}

  Скачайте [актуальную версию плагина {{ ca-name }}]({{ link-ca-vscode }}) для Visual Studio Code и [установите ее](#install-plugin).

- IDE от JetBrains {#jb}

  1. Скачайте актуальный плагин {{ ca-name }} для своей версии IDE от JetBrains:
      * [2024.1]({{ link-ca-jb-2024-1 }})
      * [2024.2]({{ link-ca-jb-2024-2 }})
  1. [Установите плагин](#install-plugin).

{% endlist %}

### Удалите плагин {#remove-plugin}

{% list tabs group=ide %}

- Visual Studio Code {#vscode}

  1. Откройте список установленных плагинов, для этого используйте сочетание клавиш **Ctrl** + **Shift** + **X** в Windows/Linux или **Command** + **Shift** + **X** в macOS.
  1. Напротив плагина {{ ca-full-name }} нажмите ![image](../_assets/console-icons/gear.svg) и выберите **Удалить** (**Uninstall**).

- IDE от JetBrains {#jb}

  1. Откройте настройки, для этого используйте сочетание клавиш **Ctrl** + **Alt** + **S** в Windows/Linux или **Command** + **,** в macOS.
  1. Перейдите в раздел **Plugins** и выберите плагин {{ ca-full-name }}.
  1. В блоке с описанием плагина нажмите ![image](../_assets/console-icons/chevron-down.svg) и выберите **Uninstall**.
  1. Подтвердите удаление и нажмите **OK**.

{% endlist %}

### См. также {#see-also}

* [Обзор {{ ca-name }}](./concepts/index.md)
