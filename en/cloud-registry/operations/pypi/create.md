---
title: Creating a Python package
description: Follow this guide to create a Python package for pushing to {{ cloud-registry-name }}.
---

# Creating a Python package

This guide describes how to create a Python package for publishing to a {{ cloud-registry-name }}.

## Python package structure {#package-structure}

Here is an example of a project structure:

```
my_package/              # Project root directory
│
├── my_package/          # Main package (its name must match the project name)
│   ├── __init__.py      #   Makes the directory a Python package
│   └── core.py          # Main module (optional)
│
├── tests/               # Test directory
│   ├── __init__.py
│   └── test_core.py     # Tests for core.py
│
├── README.md            # Project description
├── LICENSE              # License
└── pyproject.toml       # Project metadata
```

## Creating a package {#create-package}

{% list tabs group=python_tools %}

- pip + twine {#pip-twine}

    1. Set up your environment:
        
        ```bash
        apt update && \
            apt-get install python3 -y && \
            apt-get install python3.12-venv -y && \
            python3 -m ensurepip --default-pip
        ```


    1. Install build tools:

        ```bash
        python3 -m venv my-venv && source my-venv/bin/activate
        pip install build twine
        ```

    1. Create the project structure:

        ```bash
        mkdir -p my_package/my_package
        cd my_package
        ```

    1. Create a file named `my_package/__init__.py`:

        ```bash
        cat > my_package/__init__.py << 'EOF'
        def hello():
            print("Hello from my package!")
        EOF
        ```

    1. Create a file named `pyproject.toml`:

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

    1. Create a file named `README.md`:

        ```bash
        cat > README.md << 'EOF'
        # my_package
        A small example package.
        EOF
        ```

    1. Build the package:

        ```bash
        python3 -m build
        ```

        Result:

        ```text
        Successfully built my_package-0.0.1.tar.gz and my_package-0.0.1-py3-none-any.whl
        ```

        The built files will appear in the `dist/` directory.
    
    1. Check the package: 

        ```bash
        twine check dist/*
        ```

        Result:

        ```text
        Checking dist/my_package-0.0.1-py3-none-any.whl: PASSED
        Checking dist/my_package-0.0.1.tar.gz: PASSED
        ``` 

- Poetry {#poetry}
    
    1. Install Poetry:

        ```bash
        curl -sSL https://install.python-poetry.org | python3 -
        ```

    1. Create a new project:

        ```bash
        poetry new my_package
        cd my_package
        ```

        Poetry will automatically create the project structure with a file named `pyproject.toml`.

    1. Edit `pyproject.toml`:

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

    1. Create a file named `mypackage/__init__.py`:

        ```python
        def hello():
            return "Hello from my package!"
        ```

    1. Build the package:

        ```bash
        poetry build
        ```

        Result:

        ```text
        Building my_package (0.0.1)
          - Building sdist
          - Built my_package-0.0.1.tar.gz
          - Building wheel
          - Built my_package-0.0.1-py3-none-any.whl
        ```

- uv {#uv}

    1. Install `uv`:
        
        ```bash
        curl -LsSf https://astral.sh/uv/install.sh | sh
        ```
        
       Alternatively, you can use `pip`:

        ```bash
        pip install uv
        ```

    1. Create a new project:

        ```bash
        uv init mypackage --lib && cd mypackage
        ```

    1. Create a virtual environment:

        ```bash
        uv venv && source .venv/bin/activate
        ```

    1. Create a file named `mypackage/__init__.py`:

        ```bash
        cat > src/mypackage/__init__.py << 'EOF'
        def hello(name: str = "World") -> str:
            return f"Hello, {name}!"

        def add(a: int, b: int) -> int:
            return a + b
        EOF
        ```

    1. Build the package:

        ```bash
        uv build
        ```

        Result:

        ```text
        Building my_package-0.0.1.tar.gz and my_package-0.0.1-py3-none-any.whl
        ```

{% endlist %}

## What's next {#what-is-next}

* [{#T}](push.md)
* [{#T}](pull.md)
* [{#T}](examples.md)
