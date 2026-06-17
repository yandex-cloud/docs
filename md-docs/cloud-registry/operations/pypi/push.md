# Загрузить Python-пакет в локальный реестр Cloud Registry

Инструкция описывает, как загрузить [Python-пакет](../../concepts/artifacts/python.md) в [локальный реестр](../../concepts/registry.md#local-registry).

Для загрузки Python-пакета в реестр необходима [роль](../../security/index.md#cloud-registry-artifacts-pusher) `cloud-registry.artifacts.pusher` или выше.

{% list tabs group=python_tools %}

- pip + twine {#pip-twine}

  1. Если у вас еще нет собранного пакета, [создайте](create.md) его.

  1. Загрузите пакет: 
      
      ```bash
      export LOCAL_REG_ID="<идентификатор_реестра>"
      export IAM_TOKEN="<IAM-токен>"

      twine upload \
      --repository-url "https://registry.yandexcloud.net/pypi/$LOCAL_REG_ID/legacy/" \
      --username iam \
      --password "$IAM_TOKEN" \
      dist/*
      ```

      Или [настройте](installation.md) аутентификацию с помощью файла `~/.pypirc`:

      ```ini
      [distutils]
      index-servers = cloud-registry

      [cloud-registry]
      repository = https://registry.yandexcloud.net/pypi/<идентификатор_реестра>/legacy/
      username = iam
      password = <IAM-токен>
      ```

      Где:
      * `<идентификатор_реестра>` — идентификатор вашего локального реестра.
      * `username` — тип токена: `iam` или `api_key`.
      * `password` — значение соответствующего токена.

      ```bash
      python3 -m twine upload --repository cloud-registry dist/*
      ```
      
      Результат:

      ```text
      Uploading distributions to https://registry.yandexcloud.net/pypi/e5o6a2blpkb6********/legacy/
      Uploading my_package-0.0.1-py3-none-any.whl
      100% ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 4.5/4.5 kB • 00:00 • ?
      Uploading my_package-0.0.1.tar.gz
      100% ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 3.8/3.8 kB • 00:00 • ?
      ```

- Poetry {#poetry}

  1. Если у вас еще нет собранного пакета, [создайте](create.md) его.

  1. Настройте репозиторий для публикации:

      ```bash
      poetry config repositories.cloud-registry https://registry.yandexcloud.net/pypi/<идентификатор_реестра>/legacy/
      ```

  1. Настройте аутентификацию:

      ```bash
      poetry config http-basic.cloud-registry iam "$(yc iam create-token)"
      ```

      Где:

        * `iam` — тип токена. Вместо `iam` можно использовать `api_key`.
        * `<идентификатор_реестра>` — идентификатор вашего локального реестра.

  1. Загрузите пакет в реестр:

      ```bash
      poetry publish -r cloud-registry
      ```

      Результат:

      ```text
      Publishing my_package (0.0.1) to cloud-registry
       - Uploading my_package-0.0.1-py3-none-any.whl 100%
       - Uploading my_package-0.0.1.tar.gz 100%
      ```

- uv {#uv}

  1. Если у вас еще нет собранного пакета, [создайте](create.md) его.

  1. Загрузите пакет: 
      
      ```bash
      export LOCAL_REG_ID="<идентификатор_реестра>"
      export IAM_TOKEN="<IAM-токен>"

      uv publish \
        --publish-url "https://registry.yandexcloud.net/pypi/$LOCAL_REG_ID/legacy/" \
        --username iam \
        --password "$IAM_TOKEN" \
        dist/*
      ```

      Или cоздайте файл `uv.toml` в корне проекта:

      ```toml
      [publish]
      url = "https://registry.yandexcloud.net/pypi/<идентификатор_реестра>/legacy/"
      username = "iam"
      password = "<IAM-токен>"
      ```

      Где:
      * `<идентификатор_реестра>` — идентификатор вашего локального реестра.
      * `username` — тип токена: `iam` или `api_key`.
      * `password` — значение соответствующего токена.

      ```bash
      uv publish
      ```

      Результат:

      ```text
      Uploading my_package-0.0.1-py3-none-any.whl (4.5 KB)
      Uploading my_package-0.0.1.tar.gz (3.8 KB)
      ```

{% endlist %}

#### Полезные ссылки {#see-also}

* [Создать Python-пакет](create.md)
* [Скачать Python-пакет из реестра Cloud Registry](pull.md)
* [Примеры работы с PyPI-реестрами](examples.md)