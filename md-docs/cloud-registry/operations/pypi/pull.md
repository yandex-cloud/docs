# Скачать Python-пакет из реестра {{ cloud-registry-name }}

Для скачивания [Python-пакета](../../concepts/artifacts/python.md) необходима [роль](../../security/index.md#cloud-registry-artifacts-puller) `cloud-registry.artifacts.puller` или выше.

{% list tabs group=python_tools %}

- pip {#pip}

  1. Задайте переменные для аутентификации:
     
     ```bash
     export IAM_TOKEN="<IAM-токен>"
     export LOCAL_REG_ID="<идентификатор_реестра>"   
     export REMOTE_REG_ID="<идентификатор_удаленного_реестра>"  
     export VIRTUAL_REG_ID="<идентификатор_виртуального_реестра>"
     ```  
  
  1. Скачайте Python-пакет из [реестра](../../concepts/registry.md):

      ```bash
      pip install <имя_пакета> \
        --index-url https://iam:$IAM_TOKEN@{{ cloud-registry }}/pypi/$LOCAL_REG_ID/simple/
      ```

      Где:
      * `$IAM_TOKEN` — IAM-токен для аутентификации.
      * `<идентификатор_реестра>` — идентификатор вашего реестра.
      * `<имя_пакета>` — имя устанавливаемого пакета.

      Результат:

      ```text
      Collecting my_package
        Downloading https://{{ cloud-registry }}/pypi/e5o6a2blpkb6********/simple/my-package/my_package-0.0.1-py3-none-any.whl (4.5 kB)
      Installing collected packages: my_package
      Successfully installed my_package-0.0.1
      ```

  1. Проверьте, что пакет действительно установлен:

      ```bash
      python3 -m pip list | grep my_package
      ```

      Результат:

      ```text
      my_package    0.0.1
      ```

- Poetry {#poetry}

  1. Задайте переменные для аутентификации:
     
     ```bash
     export IAM_TOKEN="<IAM-токен>"
     export LOCAL_REG_ID="<идентификатор_реестра>"   
     export REMOTE_REG_ID="<идентификатор_удаленного_реестра>"  
     export VIRTUAL_REG_ID="<идентификатор_виртуального_реестра>"
     ``` 

  1. Добавьте источник пакетов:

      ```bash
      poetry config http-basic.cloud-registry iam $IAM_TOKEN
      poetry init  # жми Enter на все вопросы
      poetry source add cloud-registry https://iam:$IAM_TOKEN@{{ cloud-registry }}/pypi/$LOCAL_REG_ID/simple/
      ```

  1. Скачайте пакет:

      ```bash
      poetry add <имя_пакета> --source cloud-registry
      ```

      Результат:

      ```text
      Using version ^0.0.1 for my_package

      Updating dependencies
      Resolving dependencies... (0.1s)

      Package operations: 1 install, 0 updates, 0 removals

        - Installing my_package (0.0.1)

      Writing lock file
      ```

- uv {#uv}

  1. Задайте переменные для аутентификации:

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     export LOCAL_REG_ID="<идентификатор_реестра>"   
     export REMOTE_REG_ID="<идентификатор_удаленного_реестра>"  
     export VIRTUAL_REG_ID="<идентификатор_виртуального_реестра>"
     ``` 

  1. Скачайте пакет:

      ```bash
      uv pip install <имя_пакета> \
        --index-url https://iam:$IAM_TOKEN@{{ cloud-registry }}/pypi/$LOCAL_REG_ID/simple/ 
      ```

      Результат:

      ```text
      Resolved 1 package in 0.5s
      Downloaded 1 package in 0.2s
      Installed 1 package in 0.1s
       + my_package==0.0.1
      ```

{% endlist %}

## Установка из разных типов реестров {#registry-types}

### Локальный реестр {#local-registry}

[Локальный реестр](../../concepts/registry.md#local-registry) содержит пакеты, созданные и опубликованные внутри вашей организации.

1. Создайте переменные окружения в зависимости от способа аутентификации:
   
   {% list tabs group=registry_auth %}
   
   - IAM-токен {#iam-token}
   
     1. Получите [IAM-токен](../../../iam/concepts/authorization/iam-token.md) для [аккаунта на Яндексе](../../../iam/operations/iam-token/create.md) или [сервисного аккаунта](../../../iam/operations/iam-token/create-for-sa.md), от имени которого вы будете выполнять аутентификацию.
     1. Создайте переменные окружения `REGISTRY_USERNAME` и `REGISTRY_PASSWORD`:
   
         ```bash
         export REGISTRY_USERNAME="iam"
         export REGISTRY_PASSWORD="<IAM-токен>"
         ```
   
         Где:
   
         * `REGISTRY_USERNAME` — способ аутентификации.
         * `REGISTRY_PASSWORD` — тело полученного ранее IAM-токена.
   
     {% note info %}
   
     [Время жизни](../../../iam/concepts/authorization/iam-token.md#lifetime) IAM-токена — не больше {{ iam-token-lifetime }}.
   
     {% endnote %}
   
   - API-ключ {#api-key}
   
     1. [Создайте](../../../iam/operations/authentication/manage-api-keys.md#create-api-key) API-ключ для [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md), от имени которого вы будете выполнять аутентификацию.
     1. Создайте переменные окружения `REGISTRY_USERNAME` и `REGISTRY_PASSWORD`:
   
         ```bash
         export REGISTRY_USERNAME="api_key"
         export REGISTRY_PASSWORD="<API-ключ>"
         ```
   
         Где:
   
         * `REGISTRY_USERNAME` — способ аутентификации.
         * `REGISTRY_PASSWORD` — тело созданного ранее [API-ключа](../../../iam/concepts/authorization/api-key.md).
   
     {% note info %}
   
     [Время жизни](../../../iam/concepts/authorization/api-key.md#scoped-api-keys) API-ключа ограничивается вручную при создании.
   
     {% endnote %}
   
   {% endlist %}

1. Установите пакет из локального реестра:

    {% list tabs group=registry_auth %}

    - IAM-токен {#iam-token}

      ```bash
      pip install <имя_пакета> \
        --index-url https://$REGISTRY_USERNAME:$REGISTRY_PASSWORD@{{ cloud-registry }}/pypi/<идентификатор_реестра>/simple/ \
        --no-cache
      ```

      Где:

      * `<идентификатор_реестра>` — идентификатор вашего локального реестра.
      * `<имя_пакета>` — имя устанавливаемого пакета.

    - API-ключ {#api-key}

      ```bash
      pip install <имя_пакета> \
        --index-url https://$REGISTRY_USERNAME:$REGISTRY_PASSWORD@{{ cloud-registry }}/pypi/<идентификатор_реестра>/simple/ \
        --no-cache
      ```

      Где:

      * `<идентификатор_реестра>` — идентификатор вашего локального реестра.
      * `<имя_пакета>` — имя устанавливаемого пакета.

    {% endlist %}

Пример:

```bash
pip install <имя_пакета> \
  --index-url https://iam:$(yc iam create-token)@{{ cloud-registry }}/pypi/e5o6a2blpkb6********/simple/
```

### Удаленный реестр {#remote-registry}

[Удаленный реестр](../../concepts/registry.md#remote-registry) действует как прокси для публичных репозиториев, таких как [PyPI](https://pypi.org/). Удаленные реестры кешируют пакеты локально после первого обращения.

1. Создайте переменные окружения в зависимости от способа аутентификации:
   
   {% list tabs group=registry_auth %}
   
   - IAM-токен {#iam-token}
   
     1. Получите [IAM-токен](../../../iam/concepts/authorization/iam-token.md) для [аккаунта на Яндексе](../../../iam/operations/iam-token/create.md) или [сервисного аккаунта](../../../iam/operations/iam-token/create-for-sa.md), от имени которого вы будете выполнять аутентификацию.
     1. Создайте переменные окружения `REGISTRY_USERNAME` и `REGISTRY_PASSWORD`:
   
         ```bash
         export REGISTRY_USERNAME="iam"
         export REGISTRY_PASSWORD="<IAM-токен>"
         ```
   
         Где:
   
         * `REGISTRY_USERNAME` — способ аутентификации.
         * `REGISTRY_PASSWORD` — тело полученного ранее IAM-токена.
   
     {% note info %}
   
     [Время жизни](../../../iam/concepts/authorization/iam-token.md#lifetime) IAM-токена — не больше {{ iam-token-lifetime }}.
   
     {% endnote %}
   
   - API-ключ {#api-key}
   
     1. [Создайте](../../../iam/operations/authentication/manage-api-keys.md#create-api-key) API-ключ для [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md), от имени которого вы будете выполнять аутентификацию.
     1. Создайте переменные окружения `REGISTRY_USERNAME` и `REGISTRY_PASSWORD`:
   
         ```bash
         export REGISTRY_USERNAME="api_key"
         export REGISTRY_PASSWORD="<API-ключ>"
         ```
   
         Где:
   
         * `REGISTRY_USERNAME` — способ аутентификации.
         * `REGISTRY_PASSWORD` — тело созданного ранее [API-ключа](../../../iam/concepts/authorization/api-key.md).
   
     {% note info %}
   
     [Время жизни](../../../iam/concepts/authorization/api-key.md#scoped-api-keys) API-ключа ограничивается вручную при создании.
   
     {% endnote %}
   
   {% endlist %}

1. Установите пакет из удаленного реестра:

    {% list tabs group=registry_auth %}

    - IAM-токен {#iam-token}

      ```bash
      pip install <имя_пакета> \
        --index-url https://$REGISTRY_USERNAME:$REGISTRY_PASSWORD@{{ cloud-registry }}/pypi/<идентификатор_реестра>/simple/ \
        --no-cache
      ```

      Где:

      * `<идентификатор_реестра>` — идентификатор вашего удаленного реестра.
      * `<имя_пакета>` — имя устанавливаемого пакета из публичного PyPI.

    - API-ключ {#api-key}

      ```bash
      pip install <имя_пакета> \
        --index-url https://$REGISTRY_USERNAME:$REGISTRY_PASSWORD@{{ cloud-registry }}/pypi/<идентификатор_реестра>/simple/ \
        --no-cache
      ```

      Где:

      * `<идентификатор_реестра>` — идентификатор вашего удаленного реестра.
      * `<имя_пакета>` — имя устанавливаемого пакета из публичного PyPI.

    {% endlist %}

Пример:

```bash
pip install pytest==9.0.1 \
  --index-url https://iam:$(yc iam create-token)@{{ cloud-registry }}/pypi/e5o6a2blpkb6********/simple/
```

При первом обращении пакет будет загружен из публичного PyPI и сохранен в кеш. При последующих установках пакет будет загружаться из кеша.

### Виртуальный реестр {#virtual-registry}

[Виртуальный реестр](../../concepts/registry.md#virtual-registry) объединяет несколько локальных и удаленных реестров под одним именем, предоставляя единую точку входа для поиска и установки пакетов.

1. Создайте переменные окружения в зависимости от способа аутентификации:
   
   {% list tabs group=registry_auth %}
   
   - IAM-токен {#iam-token}
   
     1. Получите [IAM-токен](../../../iam/concepts/authorization/iam-token.md) для [аккаунта на Яндексе](../../../iam/operations/iam-token/create.md) или [сервисного аккаунта](../../../iam/operations/iam-token/create-for-sa.md), от имени которого вы будете выполнять аутентификацию.
     1. Создайте переменные окружения `REGISTRY_USERNAME` и `REGISTRY_PASSWORD`:
   
         ```bash
         export REGISTRY_USERNAME="iam"
         export REGISTRY_PASSWORD="<IAM-токен>"
         ```
   
         Где:
   
         * `REGISTRY_USERNAME` — способ аутентификации.
         * `REGISTRY_PASSWORD` — тело полученного ранее IAM-токена.
   
     {% note info %}
   
     [Время жизни](../../../iam/concepts/authorization/iam-token.md#lifetime) IAM-токена — не больше {{ iam-token-lifetime }}.
   
     {% endnote %}
   
   - API-ключ {#api-key}
   
     1. [Создайте](../../../iam/operations/authentication/manage-api-keys.md#create-api-key) API-ключ для [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md), от имени которого вы будете выполнять аутентификацию.
     1. Создайте переменные окружения `REGISTRY_USERNAME` и `REGISTRY_PASSWORD`:
   
         ```bash
         export REGISTRY_USERNAME="api_key"
         export REGISTRY_PASSWORD="<API-ключ>"
         ```
   
         Где:
   
         * `REGISTRY_USERNAME` — способ аутентификации.
         * `REGISTRY_PASSWORD` — тело созданного ранее [API-ключа](../../../iam/concepts/authorization/api-key.md).
   
     {% note info %}
   
     [Время жизни](../../../iam/concepts/authorization/api-key.md#scoped-api-keys) API-ключа ограничивается вручную при создании.
   
     {% endnote %}
   
   {% endlist %}

1. Установите пакет из виртуального реестра:

    {% list tabs group=registry_auth %}

    - IAM-токен {#iam-token}

      ```bash
      pip install <имя_пакета> \
        --index-url https://$REGISTRY_USERNAME:$REGISTRY_PASSWORD@{{ cloud-registry }}/pypi/<идентификатор_реестра>/simple/ \
        --no-cache
      ```

      Где:

      * `<идентификатор_реестра>` — идентификатор вашего виртуального реестра.
      * `<имя_пакета>` — имя устанавливаемого пакета.

    - API-ключ {#api-key}

      ```bash
      pip install <имя_пакета> \
        --index-url https://$REGISTRY_USERNAME:$REGISTRY_PASSWORD@{{ cloud-registry }}/pypi/<идентификатор_реестра>/simple/ \
        --no-cache
      ```

      Где:

      * `<идентификатор_реестра>` — идентификатор вашего виртуального реестра.
      * `<имя_пакета>` — имя устанавливаемого пакета.

    {% endlist %}

Пример:

```bash
pip install <имя_пакета> \
  --index-url https://iam:$(yc iam create-token)@{{ cloud-registry }}/pypi/e5o6a2blpkb6********/simple/
```

Виртуальный реестр автоматически выполнит поиск пакета во всех подключенных локальных и удаленных реестрах в порядке их приоритета.

## Установка пакетов с зависимостями из разных источников {#mixed-sources}

Если вам нужно установить пакет из вашего реестра, а его зависимости — из публичного PyPI, используйте параметр `--extra-index-url`:

```bash
pip install <имя_пакета> \
  --index-url https://iam:$(yc iam create-token)@{{ cloud-registry }}/pypi/<идентификатор_реестра>/simple/ \
  --extra-index-url https://pypi.org/simple/ 
```

Где:
* `--index-url` — основной источник пакетов (ваш реестр).
* `--extra-index-url` — дополнительный источник для зависимостей (публичный PyPI).

#### См. также {#see-also}

* [{#T}](installation.md)
* [{#T}](push.md)
* [{#T}](examples.md)