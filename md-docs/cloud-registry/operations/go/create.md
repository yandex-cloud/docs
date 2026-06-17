# Создать Go-модуль

В этой инструкции описано, как создать Go-модуль и подготовить ZIP-архив для последующей загрузки в реестр Cloud Registry.

Подробнее о работе с Go-модулями в официальной документации [Go Modules Reference](https://go.dev/ref/mod).

## Структура Go-модуля {#module-structure}

Пример структуры проекта:

```
mymodule/                # Корневая директория Go-модуля
│
├── go.mod               # Определяет Go-модуль и его зависимости
├── go.sum               # Контрольные суммы зависимостей
├── main.go              # Точка входа (для исполняемых Go-модулей)
│
├── pkg/                 # Публичные пакеты
│   └── utils/
│       └── utils.go
│
└── internal/            # Приватные пакеты (недоступны извне Go-модуля)
    └── config/
        └── config.go
```

## Создание Go-модуля {#create-module}

1. Установите [Go](https://go.dev/doc/install).

1. Создайте директорию Go-модуля и перейдите в нее:

    ```bash
    mkdir mymodule && cd mymodule
    ```

1. Инициализируйте Go-модуль, указав полный путь, по которому он будет доступен в реестре:

    ```bash
    go mod init registry.yandexcloud.net/go/<идентификатор_реестра>/mymodule
    ```

    В корне проекта появится файл `go.mod`:

    ```text
    module registry.yandexcloud.net/go/<идентификатор_реестра>/mymodule

    go 1.21
    ```

1. Добавьте код Go-модуля. Например, создайте файл `hello.go`:

    ```bash
    cat > hello.go << 'EOF'
    package mymodule

    func Hello() string {
        return "Hello from my module!"
    }
    EOF
    ```

1. При наличии внешних зависимостей синхронизируйте `go.mod` и `go.sum`:

    ```bash
    go mod tidy
    ```

## Подготовка ZIP-архива для публикации {#prepare-zip}

Go CLI не поддерживает публикацию модулей напрямую. Для загрузки в реестр Cloud Registry подготовьте ZIP-архив, структура которого соответствует [Module zip files](https://go.dev/ref/mod#zip-files): каждый файл внутри архива должен иметь префикс пути вида `<полный_путь_модуля>@<версия>/`, где `<полный_путь_модуля>` совпадает с именем Go-модуля, указанным в `go.mod`.

{% note warning %}

Максимальный размер ZIP-архива — 500 МБ.

{% endnote %}

1. Находясь в корне Go-модуля, соберите ZIP-архив, подставив идентификатор вашего реестра, имя и версию Go-модуля:

    ```bash
    find . -type f | bsdtar -a -cf ../mymodule-v1.0.0.zip \
        -s '|^\./|registry.yandexcloud.net/go/<идентификатор_реестра>/mymodule@v1.0.0/|' -T -
    ```

    {% note info %}

    Утилита `bsdtar` входит в состав [libarchive](https://www.libarchive.org/). В macOS она предустановлена. В Debian и Ubuntu установите пакет `libarchive-tools`:

    ```bash
    sudo apt install libarchive-tools
    ```

    {% endnote %}

1. Проверьте структуру архива:

    ```bash
    unzip -l ../mymodule-v1.0.0.zip
    ```

    Результат:

    ```text
    Archive:  ../mymodule-v1.0.0.zip
      Length      Date    Time    Name
    ---------  ---------- -----   ----
           74  2026-06-13 12:00   registry.yandexcloud.net/go/<идентификатор_реестра>/mymodule@v1.0.0/go.mod
          112  2026-06-13 12:00   registry.yandexcloud.net/go/<идентификатор_реестра>/mymodule@v1.0.0/hello.go
    ---------                     -------
          186                     2 files
    ```

## Что дальше {#what-is-next}

* [Загрузить Go-модуль в реестр](push.md)
* [Скачать Go-модуль из реестра Cloud Registry](pull.md)