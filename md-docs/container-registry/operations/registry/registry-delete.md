# Удалить реестр

{% note info %}

Удалить можно только пустой [реестр](../../concepts/registry.md). Не забудьте [удалить Docker-образы из реестра](../docker-image/docker-image-delete.md) перед началом операции.

{% endnote %}

Для обращения к реестру используйте его идентификатор или имя. Как узнать идентификатор или имя реестра, читайте в разделе [Получение информации о реестре](../../../iot-core/operations/registry/registry-list.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы удалить реестр:
  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится реестр.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Container Registry**.
  1. Нажмите значок ![image](../../../_assets/console-icons/ellipsis-vertical.svg) в строке реестра, который требуется удалить.
  1. В открывшемся меню нажмите кнопку **Удалить**.
  1. В открывшемся окне нажмите кнопку **Удалить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  1. Удалите реестр:

     ```bash
     yc container registry delete new-reg
     ```

     Результат выполнения команды:

     ```text
     done
     ```

  1. Проверьте, что реестр действительно удален:

     ```bash
     yc container registry list
     ```

     Результат выполнения команды:

     ```text
     +----+------+-----------+
     | ID | NAME | FOLDER ID |
     +----+------+-----------+
     +----+------+-----------+
     ```

- API {#api}

  Чтобы удалить реестр, воспользуйтесь методом [delete](../../api-ref/Registry/delete.md) для ресурса [Registry](../../api-ref/Registry/index.md).

{% endlist %}