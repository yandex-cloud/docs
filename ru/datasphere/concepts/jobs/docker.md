# Docker-образы в заданиях

По умолчанию [задания](./index.md) {{ ds-jobs }} используют публичный образ `nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04` с предустановленным менеджером пакетов conda, Python 3.10 и другими дополнительными пакетами. Этот образ хранится в кеше {{ ml-platform-name }}, поэтому запуск заданий в окружении по умолчанию будет самым быстрым.

Вы также можете запускать задания на любом другом Docker-образе, указав его в секции `env` файла конфигурации задания. Это может быть:

* системный образ {{ ml-platform-name }}
  
  ```text
  env:
    docker: system-python-3-10   # Системный образ Python 3.10
  ```

* пользовательский Docker-образ, доступный в проекте задания
 
  ```text
  env:
    docker: <идентификатор_Docker-образа>  # Идентификатор вида b1gxxxxxxxxxxxxxxxxx
  ```

  {% note warning %}

  При использовании Docker-образа проекта в окружение задания не попадут библиотеки, установленные в ноутбуке.

  {% endnote %}

* произвольный образ из внешнего источника

  Вы можете использовать любой реестр образов ([{{ container-registry-full-name }}](https://cloud.yandex.ru/ru/services/container-registry), [Docker Hub](https://hub.docker.com/), [Docker — Private Registries](https://www.geeksforgeeks.org/docker-private-registries/) и т.п.), указав логин и пароль для доступа к образу.
  
  ```text
  env:
    docker:
      image: <путь_к_образу>
      username: <логин>
      password:
        secret-id: <идентификатор_секрета_проекта>
  ```

  Где:

  * `<путь_к_образу>` — полный путь к образу в реестре контейнеров, например `cr.yandex/b1g**********/myenv:0.1`.
  * `<логин>` — логин для доступа к вашему реестру. Для аутентификации в {{ container-registry-full-name }} используйте [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) и [авторизованный ключ](../../../container-registry/operations/authentication.md#sa-json).
  * `<идентификатор_секрета_проекта>` — идентификатор секрета с паролем. Секрет должен быть [создан](../../operations/data/secrets.md#create) в проекте {{ ml-platform-name }}. 

  Если вы используете публичный образ, данные для аутентификации можно не указывать:

  ```text
  env:
    docker:
      image: ubuntu:focal
  ```

#### Смотри также {#see-also}

* [{#T}](index.md).
* [{#T}](cli.md).
* [{#T}](environment.md).
* [{#T}](../../operations/projects/work-with-jobs.md).
* [GitHub-репозиторий](https://github.com/yandex-cloud-examples/yc-datasphere-jobs-examples) с примерами для запуска заданий.