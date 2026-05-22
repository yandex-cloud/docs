# Политики перезапуска Docker-контейнера

В описании [Docker-контейнера](https://yandex.cloud/ru/blog/posts/2022/03/docker-containers) можно указать политики перезапуска:
* `Always` — всегда перезапускать Docker-контейнер при его остановке. Если Docker-контейнер остановлен вручную, он будет перезапущен только при перезапуске Docker-демона.
* `Never` — не перезапускать Docker-контейнер автоматически.
* `OnFailure` — перезапускать Docker-контейнер только если Docker-контейнер завершил работу с ненулевым кодом возврата.

В случае, если описание Docker-контейнера в метаданных изменилось при перезагрузке ВМ, установленная политика перезапуска не учитывается и запускается Docker-контейнер, соответствующий новому описанию.

## Примеры использования {#examples}

* [Передача логов с Container Optimized Image в Yandex Cloud Logging](../tutorials/coi-fluent-bit-logging.md)
* [Запуск контейнерного приложения в Yandex Serverless Containers](../tutorials/deploy-app-container.md)
* [Создание ВМ с Container Optimized Image и несколькими Docker-контейнерами](../tutorials/docker-compose.md)
* [Создание группы виртуальных машин с Container Optimized Image и несколькими Docker-контейнерами](../tutorials/ig-with-containers.md)