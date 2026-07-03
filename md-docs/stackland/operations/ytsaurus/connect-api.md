[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Stackland](../../index.md) > [Пошаговые инструкции](../index.md) > Базы данных > YTsaurus > Подключиться к HTTP-прокси

# Подключиться к HTTP-прокси YTsaurus

После [включения компонента](enable.md) HTTP-прокси YTsaurus публикуется на адресе `https://api.ytsaurus.<домен_системы>`. Прокси принимает запросы через [YTsaurus CLI](https://ytsaurus.tech/docs/ru/api/cli/install), [Python SDK](https://ytsaurus.tech/docs/ru/api/python/start) и другие клиенты YTsaurus.

## Получить адрес HTTP-прокси {#get-url}

```bash
kubectl -n stackland-ytsaurus get ingress yt-http-proxies -o jsonpath='{.spec.rules[0].host}'
```

## Получить токен администратора {#get-token}

Для аутентификации в HTTP-прокси используется токен из Secret `ytadminsec`. См. инструкцию [Получить пароль и токен администратора](get-admin-credentials.md).

Запишите токен в переменную окружения:

```bash
export YT_TOKEN=$(kubectl -n stackland-ytsaurus get secret ytadminsec -o jsonpath='{.data.token}' | base64 -d)
```

## Подключиться через YTsaurus CLI {#yt-cli}

1. Установите YTsaurus CLI по [официальной инструкции](https://ytsaurus.tech/docs/ru/api/cli/install).
1. Задайте адрес прокси в переменной окружения `YT_PROXY`:

    ```bash
    export YT_PROXY=https://api.ytsaurus.<домен_системы>
    ```

1. Проверьте подключение:

    ```bash
    yt list /
    ```

    Команда возвращает содержимое корневого каталога Cypress.

## Подключиться через Python SDK {#python-sdk}

1. Установите [YTsaurus Python SDK](https://ytsaurus.tech/docs/ru/api/python/start).
1. Подключитесь к кластеру:

    ```python
    import os
    import yt.wrapper as yt

    client = yt.YtClient(
        proxy="https://api.ytsaurus.<домен_системы>",
        token=os.environ["YT_TOKEN"],
    )

    print(client.list("/"))
    ```

## Что дальше {#what-is-next}

* [Документация YTsaurus CLI](https://ytsaurus.tech/docs/ru/api/cli/cli).
* [Документация Python SDK](https://ytsaurus.tech/docs/ru/api/python/userdoc).
* [Открыть веб-интерфейс YTsaurus](connect-ui.md).