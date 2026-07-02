[Документация Yandex Cloud](../../index.md) > [Yandex Container Solution](../index.md) > Концепции > Образ Container Optimized Image

# Образ Container Optimized Image

_Container Optimized Image_ — [образ](../../compute/concepts/image.md) виртуальной машины, оптимизированный для запуска [Docker-контейнеров](https://yandex.cloud/ru/blog/posts/2022/03/docker-containers). Образ включает в себя: Ubuntu LTS, Docker и демона для запуска Docker-контейнеров.

Образ интегрирован с платформой Yandex Cloud, это позволяет:
* Запускать Docker-контейнер сразу после создания ВМ из консоли управления или CLI.
* Обновлять запущенный Docker-контейнер с минимальным временем простоя.
* Получать доступ к открытым сетевым портам Docker-контейнера без дополнительных настроек.

Подробнее о работе с Container Optimized Image читайте в разделе [Создание ВМ с Container Optimized Image](../tutorials/vm-create.md).