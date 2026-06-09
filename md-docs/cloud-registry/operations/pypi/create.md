# Создать Python-пакет

В этой инструкции описано, как создать Python-пакет для последующей загрузки в реестр {{ cloud-registry-name }}.

## Структура Python-пакета {#package-structure}

Пример структуры проекта:

```
my_package/              # Корневая директория проекта
│
├── my_package/          # Основной пакет (имя должно совпадать с именем проекта)
│   ├── __init__.py      #   Делает директорию Python-пакетом
│   └── core.py          # Основной модуль (опционально)
│
├── tests/               # Директория для тестов
│   ├── __init__.py
│   └── test_core.py     # Тесты для core.py
│
├── README.md            # Описание проекта
├── LICENSE              # Лицензия
└── pyproject.toml       # Метаданные проекта
```

## Создание пакета {#create-package}

{% list tabs group=python_tools %}

- pip + twine {#pip-twine}

    1. Подготовьте окружение:
        
        ```bash
        apt update && \
            apt-get install python3 -y && \
            apt-get install python3.12-venv -y && \
            python3 -m ensurepip --default-pip
        ```


    1. Установите инструменты для сборки:

        ```bash
        python3 -m venv my-venv && source my-venv/bin/activate
        pip install build twine
        ```

    1. Создайте структуру проекта:

        ```bash
        mkdir -p my_package/my_package
        cd my_package
        ```

    1. Создайте файл `my_package/__init__.py`:

        ```bash
        cat > my_package/__init__.py << 'EOF'
        def hello():
            print("Hello from my package!")
        EOF
        ```

    1. Создайте файл `pyproject.toml`:

        ```bash
        cat > pyproject.toml << 'EOF'
        [build-system]
        requires = ["setuptools"]
        build-backend = "setuptools.build_meta"

        [project]
        name = "my_package"
        version = "0.0.1"
        description = "A small example package"
        readme = "README.md"

        [project.scripts]
        my_package = "my_package:hello"
        EOF
        ```

    1. Создайте файл `README.md`:

        ```bash
        cat > README.md << 'EOF'
        # my_package
        A small example package.
        EOF
        ```

    1. Соберите пакет:

        ```bash
        python3 -m build
        ```

        Результат:

        ```text
        Successfully built my_package-0.0.1.tar.gz and my_package-0.0.1-py3-none-any.whl
        ```

        Собранные файлы появятся в директории `dist/`.
    
    1. Проверьте пакет: 

        ```bash
        twine check dist/*
        ```

        Результат:

        ```text
        Checking dist/my_package-0.0.1-py3-none-any.whl: PASSED
        Checking dist/my_package-0.0.1.tar.gz: PASSED
        ``` 

- Poetry {#poetry}
    
    1. Установите Poetry:

        ```bash
        curl -sSL https://install.python-poetry.org | python3 -
        ```

    1. Создайте новый проект:

        ```bash
        poetry new my_package
        cd my_package
        ```

        Poetry автоматически создаст структуру проекта с `pyproject.toml`.

    1. Отредактируйте `pyproject.toml`:

        ```toml
        [tool.poetry]
        name = "my_package"
        version = "0.0.1"
        description = "A small example package"
        authors = ["Example Author <author@example.com>"]
        readme = "README.md"

        [tool.poetry.dependencies]
        python = "^3.9"

        [build-system]
        requires = ["poetry-core"]
        build-backend = "poetry.core.masonry.api"
        ```

    1. Создайте файл `mypackage/__init__.py`:

        ```python
        def hello():
            return "Hello from my package!"
        ```

    1. Соберите пакет:

        ```bash
        poetry build
        ```

        Результат:

        ```text
        Building my_package (0.0.1)
          - Building sdist
          - Built my_package-0.0.1.tar.gz
          - Building wheel
          - Built my_package-0.0.1-py3-none-any.whl
        ```

- uv {#uv}

    1. Установите uv:
        
        ```bash
        curl -LsSf https://astral.sh/uv/install.sh | sh
        ```
        
       Или через pip:

        ```bash
        pip install uv
        ```

    1. Создайте новый проект:

        ```bash
        uv init mypackage --lib && cd mypackage
        ```

    1. Создайте виртуальное окружение:

        ```bash
        uv venv && source .venv/bin/activate
        ```

    1. Создайте файл `mypackage/__init__.py`:

        ```bash
        cat > src/mypackage/__init__.py << 'EOF'
        def hello(name: str = "World") -> str:
            return f"Hello, {name}!"

        def add(a: int, b: int) -> int:
            return a + b
        EOF
        ```

    1. Соберите пакет:

        ```bash
        uv build
        ```

        Результат:

        ```text
        Building my_package-0.0.1.tar.gz and my_package-0.0.1-py3-none-any.whl
        ```

{% endlist %}

## Что дальше {#what-is-next}

* [{#T}](push.md)
* [{#T}](pull.md)
* [{#T}](examples.md)