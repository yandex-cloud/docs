# Особенности работы с сетью

В Container Optimized Image [Docker-контейнеры](https://yandex.cloud/ru/blog/posts/2022/03/docker-containers) запускаются с использованием сетевого интерфейса хоста. Все порты, открытые в Docker-контейнере, будут открыты и на хосте.

Все порты хоста открыты в интернет, что позволяет автоматически получать доступ к портам запущенного Docker-контейнера.

## Примеры использования {#examples}

* [Настройка вывода информации из Docker-контейнера в серийный порт](../tutorials/serial-port.md)
* [Запуск контейнерного приложения в Yandex Serverless Containers](../tutorials/deploy-app-container.md)
* [Передача логов с Container Optimized Image в Yandex Cloud Logging](../tutorials/coi-fluent-bit-logging.md)