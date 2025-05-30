{% include [syntax-support](syntax-support.md) %}

{% include [auto-manual-modes](auto-manual-modes.md) %}

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

      {% include [actions-with-suggestions](actions-with-suggestions.md) %}

      * Если предложений несколько, вы можете переключаться между ними с помощью сочетаний клавиш **Alt** + **[** и **Alt** + **]** в Windows/Linux или **Option** + **[** и **Option** + **]** в macOS.

    - IDE от JetBrains {#jb}

      * Чтобы принять предложение, нажмите клавишу **Tab**.
      * Чтобы отменить предложение, нажмите клавишу **Esc**. 

    {% endlist %}

Видео с демонстрацией работы плагина см. на [странице {{ ca-name }}](https://sourcecraft.dev/portal/code-assistant/).