### Bash {#bash}

Перед подключением:

1. {% include [cli-install](../cli-install.md) %}
1. Установите YTsaurus CLI по [инструкции](https://ytsaurus.tech/docs/ru/api/cli/install).
1. Установите зависимости:

    ```bash
    sudo apt update && sudo apt install -y python3 python3-pip && \
    pip3 install ytsaurus-client-yc-auth
    ```

{% list tabs group=connection %}

- Подключение с пользовательской ВМ {#from-yandex-vm}

  1. Получите конфигурационный файл доступа с помощью команды YC CLI:

     ```bash
     {{ yc-ytsaurus }} cluster get-configuration <имя_или_идентификатор_кластера> --private
     ```

     {% cut "Пример конфигурационного файла" %}
     
     ```bash
     {
       auth_class = {
         module_name = "yc_managed_ytsaurus_auth";
         class_name = "IamTokenAuth";
       };
       proxy = {
         url = "http://hp.<идентификатор_кластера_{{ ytsaurus-name }}>.ytsaurus.mdb.yandexcloud.net:32100";
         network_name = "external";
         http_proxy_role = "default";
       }
     }
     ```

     {% endcut %}

     Конфигурационный файл будет сохранен по пути `~/.yt/config`.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](../../managed-ytsaurus/operations/cluster-list.md#list-clusters).

  1. Выполните запрос списка содержимого корневого каталога:

      ```bash
      yt list /
      ```

- Подключение из интернета {#from-internet}

  1. Получите конфигурационный файл доступа с помощью команды YC CLI:

     ```bash
     {{ yc-ytsaurus }} cluster get-configuration <имя_или_идентификатор_кластера>
     ```

     {% cut "Пример конфигурационного файла" %}
     
     ```bash
     {
       auth_class = {
         module_name = "yc_managed_ytsaurus_auth";
         class_name = "IamTokenAuth";
       };
       proxy = {
         url = "https://proxy.<идентификатор_кластера_{{ ytsaurus-name }}>.ytsaurus.yandexcloud.net";
         enable_proxy_discovery = %false;
       }
     }
     ```
     
     {% endcut %}
     
     Конфигурационный файл будет сохранен по пути `~/.yt/config`.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](../../managed-ytsaurus/operations/cluster-list.md#list-clusters).

  1. Выполните запрос списка содержимого корневого каталога:

      ```bash
      yt list /
      ```

{% endlist %}

### Python {#python}

Перед подключением:

1. {% include [cli-install](../cli-install.md) %}
1. Установите YTsaurus CLI по [инструкции](https://ytsaurus.tech/docs/ru/api/cli/install).
1. Установите зависимости:

    ```bash
    sudo apt update && sudo apt install -y python3 python3-pip && \
    pip3 install ytsaurus-client-yc-auth
    ```

{% list tabs group=connection %}

- Подключение с пользовательской ВМ {#from-yandex-vm}

  1. Пример кода:

      `connect.py`

      ```python
      import yt.wrapper as yt
      from yc_managed_ytsaurus_auth import with_iam_token_auth

      client = yt.YtClient(
          proxy="http://hp.<идентификатор_кластера_{{ ytsaurus-name }}>.ytsaurus.mdb.yandexcloud.net:32100",
          config=with_iam_token_auth(
              config={"proxy": {"network_name": "external", "http_proxy_role": "default"}}
          ),
      )

      client.list("/")
      ```

  1. Подключение:

      ```bash
      python3 connect.py
      ```

- Подключение из интернета {#from-internet}

  1. Пример кода:

      `connect.py`

      ```python
      import yt.wrapper as yt
      from yc_managed_ytsaurus_auth import with_iam_token_auth

      client = yt.YtClient(
          proxy="https://proxy.<идентификатор_кластера_{{ ytsaurus-name }}>.ytsaurus.yandexcloud.net",
          config=with_iam_token_auth(config={"proxy": {"enable_proxy_discovery": False}}),
      )

      client.list("/")
      ```

  1. Подключение:

      ```bash
      python3 connect.py
      ```

{% endlist %}
