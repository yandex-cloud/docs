# Репозиторий в Container Registry

_Репозиторий_ — набор Docker-образов с одинаковым именем. Обычно в одном репозитории находятся несколько версий одного Docker-образа. Для работы с версиями внутри репозитория используются теги и хеш. Подробнее читайте в разделе [Docker-образ](docker-image.md).

Репозиторий определяется комбинацией `<идентификатор_реестра>/<имя_Docker-образа>`.

* В командах Docker CLI необходимо использовать полное имя, включающее в себя адрес Container Registry:

  ```bash
  docker push cr.yandex/<идентификатор_реестра>/<имя_Docker-образа>
  ```

* В командах Yandex Cloud CLI необходимо использовать имя репозитория без адреса Container Registry:

  ```bash
  yc container image list --repository-name=<идентификатор_реестра>/<имя_Docker-образа>
  ```

Для репозитория можно задать [политику автоматического удаления Docker-образов](lifecycle-policy.md), в соответствии с которой Docker-образы будут удаляться автоматически.

## Примеры использования {#examples}

* [Запуск Docker-образа на виртуальной машине](../tutorials/run-docker-on-vm/index.md)
* [Подпись и проверка Docker-образов Container Registry в Yandex Managed Service for Kubernetes](../tutorials/sign-cr-with-cosign.md)
* [Настройка отказоустойчивой архитектуры в Yandex Cloud](../tutorials/fault-tolerance.md)
* [Развертывание gRPC-сервиса на основе Docker-образа](../tutorials/grpc-node.md)
* [Запуск контейнерного приложения в Yandex Serverless Containers](../tutorials/deploy-app-container.md)