[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for YTsaurus](../index.md) > [Пошаговые инструкции](index.md) > Подключение к кластеру

# Подключение к кластеру YTsaurus

К кластеру YTsaurus можно подключиться:

* С виртуальных машин Yandex Cloud.
* Через интернет по HTTPS.

## Примеры строк подключения {#connection-string}

**Примеры для Linux проверялись в следующем окружении:**
* Виртуальная машина в Yandex Cloud с Ubuntu 20.04 LTS.
* Bash: `5.0.16`.
* Python: `3.8.2`; pip3: `20.0.2`.

### Bash {#bash}

Перед подключением:

1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).
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
     yc managed-ytsaurus cluster get-configuration <имя_или_идентификатор_кластера> --private
     ```

     {% cut "Пример конфигурационного файла" %}
     
     ```bash
     {
       auth_class = {
         module_name = "yc_managed_ytsaurus_auth";
         class_name = "IamTokenAuth";
       };
       proxy = {
         url = "http://hp.<идентификатор_кластера_YTsaurus>.ytsaurus.mdb.yandexcloud.net:32100";
         network_name = "external";
         http_proxy_role = "default";
       }
     }
     ```

     {% endcut %}

     Конфигурационный файл будет сохранен по пути `~/.yt/config`.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Выполните запрос списка содержимого корневого каталога:

      ```bash
      yt list /
      ```

- Подключение из интернета {#from-internet}

  1. Получите конфигурационный файл доступа с помощью команды YC CLI:

     ```bash
     yc managed-ytsaurus cluster get-configuration <имя_или_идентификатор_кластера>
     ```

     {% cut "Пример конфигурационного файла" %}
     
     ```bash
     {
       auth_class = {
         module_name = "yc_managed_ytsaurus_auth";
         class_name = "IamTokenAuth";
       };
       proxy = {
         url = "https://proxy.<идентификатор_кластера_YTsaurus>.ytsaurus.yandexcloud.net";
         enable_proxy_discovery = %false;
       }
     }
     ```
     
     {% endcut %}
     
     Конфигурационный файл будет сохранен по пути `~/.yt/config`.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Выполните запрос списка содержимого корневого каталога:

      ```bash
      yt list /
      ```

{% endlist %}

### Python {#python}

Перед подключением:

1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).
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
          proxy="http://hp.<идентификатор_кластера_YTsaurus>.ytsaurus.mdb.yandexcloud.net:32100",
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
          proxy="https://proxy.<идентификатор_кластера_YTsaurus>.ytsaurus.yandexcloud.net",
          config=with_iam_token_auth(config={"proxy": {"enable_proxy_discovery": False}}),
      )

      client.list("/")
      ```

  1. Подключение:

      ```bash
      python3 connect.py
      ```

{% endlist %}