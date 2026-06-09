# Особенности работы с дисками

## Работа с загрузочным диском {#boot-disk}

При [создании](../tutorials/vm-create.md) виртуальной машины с Container Optimized Image учитывайте следующие особенности:
* Невозможно создать загрузочный диск из [снимка диска](../../compute/concepts/snapshot.md).
* По умолчанию создается диск, размер которого равен размеру образа. Поэтому на ВМ с Container Optimized Image может возникнуть проблема недостаточного свободного места при развертывании [Docker-контейнера](https://yandex.cloud/ru/blog/posts/2022/03/docker-containers). Чтобы этого избежать, укажите необходимый размер загрузочного диска с помощью параметра `--create-boot-disk size=<размер_диска_гб>`.

   Чтобы узнать минимальный размер загрузочного диска, необходимый для установки образа, выполните команду:
   * `yc compute image get-latest-from-family container-optimized-image --folder-id standard-images` — если устанавливаете образ Container Optimized Image;
   * `yc compute image get-latest-from-family container-optimized-image-gpu --folder-id standard-images` — если устанавливаете образ Container Optimized Image GPU.
   
   Минимальный размер загрузочного диска указан в параметре `min_disk_size`.

### Примеры использования {#examples-boot-disk}

* [Создание ВМ с Container Optimized Image и несколькими Docker-контейнерами](../tutorials/docker-compose.md)
* [Запуск контейнерного приложения в Yandex Serverless Containers](../tutorials/deploy-app-container.md)

## Работа с дополнительными дисками {#second-disk}

Вы можете [смонтировать](../tutorials/vm-create-with-second-disk.md) дополнительный диск внутрь контейнера, используя раздел-расширение `x-yc-disks` в [спецификации Docker Compose](coi-specifications.md#compose-spec):
* Для монтирования диска внутрь ВМ с Container Optimized Image и поиска по дереву `/dev/disk/by-id/virtio-...` используется `device-name` диска. Если при подключении диска к ВМ не указать этот параметр, может возникнуть [ошибка монтирования](../error/index.md#disk-mount).
* При использовании дополнительного диска, разбитого на разделы, в [спецификации Docker Compose](coi-specifications.md#compose-spec-example) используйте параметр `partition: x`, где `x` — номер раздела для монтирования.

### Примеры использования {#examples-second-disk}

* [Создание ВМ с Container Optimized Image и дополнительным томом для Docker-контейнера](../tutorials/vm-create-with-second-disk.md)