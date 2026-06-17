# Скачать Go-модуль из реестра Cloud Registry

Для скачивания [Go-модуля](../../concepts/artifacts/go.md) необходима [роль](../../security/index.md#cloud-registry-artifacts-puller) `cloud-registry.artifacts.puller` или выше.

Загрузка Go-модулей выполняется штатной командой `go` — реестр Cloud Registry работает как Go-прокси и реализует [Module Proxy Protocol](https://go.dev/ref/mod#goproxy-protocol).

## Настройка окружения {#setup}

1. Укажите реестр как прокси Go-модулей и отключите проверку контрольных сумм через публичную [Go checksum database](https://sum.golang.org/) для Go-модулей из вашего реестра:

    ```bash
    export GOPROXY=https://registry.yandexcloud.net/go/<идентификатор_реестра>,https://proxy.golang.org,direct
    export GONOSUMDB=registry.yandexcloud.net/*
    ```

    Где:

    * `GOPROXY` — список Go-прокси через запятую. Команда `go` ищет Go-модуль последовательно в каждом источнике:
        * `https://registry.yandexcloud.net/go/<идентификатор_реестра>` — ваш реестр Cloud Registry;
        * `https://proxy.golang.org` — публичный Go-прокси для модулей из открытых репозиториев;
        * `direct` — прямое обращение к VCS-репозиторию (например, GitHub), если Go-модуль не найден ни в одном из прокси.
    * `GONOSUMDB` — шаблоны путей Go-модулей, для которых пропускается проверка контрольных сумм.

1. Передайте учетные данные для аутентификации в реестре. Команда `go` поддерживает только Basic-аутентификацию, рекомендуемый способ передачи учетных данных — файл `~/.netrc`.

    {% list tabs group=registry_auth %}

    - IAM-токен {#iam-token}

        Добавьте в файл `~/.netrc` строку:

        ```text
        machine registry.yandexcloud.net login iam password <IAM-токен>
        ```

    - API-ключ {#api-key}

        Добавьте в файл `~/.netrc` строку:

        ```text
        machine registry.yandexcloud.net login api_key password <API-ключ>
        ```

    {% endlist %}

    {% note info %}

    Файл `~/.netrc` должен быть доступен на чтение только владельцу. Установите права доступа:

    ```bash
    chmod 600 ~/.netrc
    ```

    {% endnote %}

## Добавление Go-модуля в проект {#add-module}

1. Перейдите в корень Go-проекта, в котором находится файл `go.mod`.

1. Добавьте Go-модуль нужной версии:

    ```bash
    go get registry.yandexcloud.net/go/<идентификатор_реестра>/<имя_модуля>@<версия>
    ```

    Например:

    ```bash
    go get registry.yandexcloud.net/go/e5o6a2blpkb6********/mymodule@v1.0.0
    ```

    Команда скачает Go-модуль в локальный кеш и добавит запись о нем в `go.mod` и `go.sum`:

    ```text
    go: added registry.yandexcloud.net/go/e5o6a2blpkb6********/mymodule v1.0.0
    ```

1. (Опционально) Если Go-модуль уже используется в коде через директиву `import`, синхронизируйте `go.mod` и `go.sum`:

    ```bash
    go mod tidy
    ```

1. (Опционально) Скачайте все зависимости проекта в локальный кеш без сборки:

    ```bash
    go mod download
    ```

#### Полезные ссылки {#see-also}

* [Загрузить Go-модуль в реестр](push.md)
* [Создать Go-модуль](create.md)