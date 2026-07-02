[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Registry](../../index.md) > [Пошаговые инструкции](../index.md) > Управление артефактами > Python-артефакт > Примеры работы с PyPI-реестрами

# Примеры работы с PyPI-реестрами

В этом разделе приведены пошаговые примеры для различных типов PyPI-реестров.

## Создание и использование реестров {#registry-examples}

### Локальный реестр {#local}

1. Создайте реестр:

    ```bash
    yc cloud-registry registry create \
      --name my-pypi-local \
      --registry-kind pypi \
      --registry-type local \
      --description "Local PyPI registry"
    ```

    Результат:

    ```text
    id: e5o6a2blpkb6********
    name: my-pypi-local
    kind: PYPI
    type: LOCAL
    ```

1. Создайте пакет:

    ```bash
    mkdir -p my_package/my_package
    cd my_package
    ```

    Создайте файл `my_package/__init__.py`:

    ```python
    def hello():
        return "Hello from my package!"
    ```

    Создайте `pyproject.toml`:

    ```toml
    [build-system]
    requires = ["setuptools"]

    [project]
    name = "my_package"
    version = "0.0.1"
    authors = [{ name="Example Author", email="author@example.com" }]
    description = "A small example package"
    readme = "README.md"
    requires-python = ">=3.9"
    classifiers = [
        "Programming Language :: Python :: 3",
        "Operating System :: OS Independent",
    ]
    ```

    Создайте `README.md`:

    ```markdown
    # My Package
    Это пример Python-пакета.
    ```

1. [Настройте](installation.md) аутентификацию:

    Создайте `~/.pypirc`:

    ```text
    [distutils]
    index-servers = cloud-registry

    [cloud-registry]
    repository = https://registry.yandexcloud.net/pypi/e5o6a2b********/legacy/
    username = iam
    password = <IAM-токен>
    ```

1. Соберите пакет и опубликуйте:

    ```bash
    python3 -m venv my-venv && source my-venv/bin/activate
    python3 -m pip install build twine
    python3 -m build
    python3 -m twine upload --repository cloud-registry dist/*
    ```

1. Установите пакет:

    ```bash
    pip install my_package \
      --index-url https://iam:$(yc iam create-token)@registry.yandexcloud.net/pypi/e5o6a2blpkb6********/simple/ \
      --no-cache
    ```

    Проверка:

    ```python
    python3 -c "from my_package import hello; print(hello())"
    # Hello from my package!
    ```

### Удаленный реестр {#remote}

1. Создайте реестр:

    ```bash
    yc cloud-registry registry create \
      --name my-pypi-remote \
      --registry-kind pypi \
      --registry-type remote \
      --description "Remote PyPI proxy" \
      --properties source=@pypi
    ```

    Результат:

    ```text
    id: e5o7b3cmqlc7********
    name: my-pypi-remote
    kind: PYPI
    type: REMOTE
    ```

1. Установите пакет (первый раз):

    При первой установке пакет загружается из публичного PyPI и сохраняется в кеш:

    ```bash
    pip install pytest==9.0.1 \
      --index-url https://iam:$(yc iam create-token)@registry.yandexcloud.net/pypi/e5o7b3cmqlc7********/simple/ \
      --no-cache
    ```

1. Установите пакет (повторно):

    При повторной установке пакет загружается из кеша:

    ```bash
    pip install pytest==9.0.1 \
      --index-url https://iam:$(yc iam create-token)@registry.yandexcloud.net/pypi/e5o7b3cmqlc7********/simple/ \
      --no-cache
    ```

1. Установите другой пакет:

    ```bash
    pip install requests==2.31.0 \
      --index-url https://iam:$(yc iam create-token)@registry.yandexcloud.net/pypi/e5o7b3cmqlc7********/simple/ \
      --no-cache
    ```

{% note info %}

Все установленные пакеты кешируются в реестре. При следующей установке они будут загружаться из кеша.

{% endnote %}

### Виртуальный реестр {#virtual}

1. Создайте реестр:

    Объедините локальный (`cn1mfr50********`) и удаленный (`cn1ihsdl********`) реестры:

    ```bash
    yc cloud-registry registry create \
      --name my-pypi-virtual \
      --description "Виртуальный реестр" \
      --registry-kind pypi \
      --registry-type virtual \
      --properties "readOnly=false,deploymentRegistryId=cn1mfr50********,registryIds=cn1mfr50********;cn1ihsdl********"
    ```

    Результат:

    ```text
    id: e5o9d5eosne9********
    name: my-pypi-virtual
    kind: PYPI
    type: VIRTUAL
    ```

1. Установите внутренний пакет:

    Виртуальный реестр сначала ищет в локальном реестре:

    ```bash
    pip install my_package \
      --index-url https://iam:$(yc iam create-token)@registry.yandexcloud.net/pypi/e5o9d5eosne9********/simple/ \
      --no-cache
    ```

1. Установите публичный пакет:

    Если пакет не найден в локальном, ищет в удаленном:

    ```bash
    pip install pytest==9.0.1 \
      --index-url https://iam:$(yc iam create-token)@registry.yandexcloud.net/pypi/e5o9d5eosne9********/simple/ \
      --no-cache
    ```

1. Установите несколько пакетов:

    ```bash
    pip install my_package pytest==9.0.1 requests==2.31.0 \
      --index-url https://iam:$(yc iam create-token)@registry.yandexcloud.net/pypi/e5o9d5eosne9********/simple/ \
      --no-cache
    ```

#### Полезные ссылки {#see-also}

* [Создать Python-пакет](create.md)
* [Загрузить Python-пакет в локальный реестр Cloud Registry](push.md)
* [Скачать Python-пакет из реестра Cloud Registry](pull.md)
* [Политика жизненного цикла в Yandex Cloud Registry](../../concepts/lifecycle-policy.md)
* [Настройка политик жизненного цикла](../../tutorials/lifecycle-policy-examples.md)