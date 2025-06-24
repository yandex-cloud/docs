{% include [syntax-support](syntax-support.md) %}

{% include [auto-manual-modes](auto-manual-modes.md) %}

How to work with {{ ca-name }}:

1. Open the IDE and create a test file named `server.cpp` with the following contents:

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

1. In the `int main()` section, start typing something, e.g., `//create socket`. See the {{ ca-name }} suggestion:

    ```cpp
    ...
    int main() {

    //create socket
    int sockfd = socket(AF_INET, SOCK_STREAM, 0);

    }
    ```

1. Select an action for the suggestion:

    {% list tabs group=ide %}

    - Visual Studio Code {#vscode}

      {% include [actions-with-suggestions](actions-with-suggestions.md) %}

      * If there are multiple suggestions, you can switch between them using **Alt** + **[** and **Alt** + **]** for Windows or Linux or **Option** + **[** and **Option** + **]** for macOS.

    - JetBrains IDE {#jb}

      * Click **Tab** to accept the suggestion.
      * To discard the suggestion, press **Esc**. 

    {% endlist %}

You can also watch our [{{ ca-name }} here](https://sourcecraft.dev/portal/code-assistant/) video tutorial .