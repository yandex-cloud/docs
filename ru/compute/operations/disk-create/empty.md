# Создать пустой диcк

Вы можете создать пустой диск заданного размера.

---

**[!TAB Консоль управления]**

1. В консоли управления выберите каталог, в котором нужно создать диск.
1. Нажмите плитку **Yandex Compute Cloud**.
1. На странице **Виртуальные машины** перейдите на вкладку **Диски**.
1. Нажмите кнопку **Создать диск**.
1. Введите имя диска.

    [!INCLUDE [name-format](../../../_includes/name-format.md)]

1. Если требуется, добавьте произвольное описание диска.
1. Укажите нужный размер диска.
1. Нажмите кнопку **Сохранить диск**.

**[!TAB CLI]**

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

1. Посмотрите описание команд CLI для создания дисков:

    ```
    $ yc compute disk create --help
    ```

1. Создайте диск в каталоге по умолчанию:

    ```
    $ yc compute disk create \
        --name first-disk \
        --size 10 \
        --description "my first disk via yc"
    ```

    Данная команда создаст диск размером 10 ГБ с именем `first-disk` и описанием `my first disk via yc`.

    [!INCLUDE [name-format](../../../_includes/name-format.md)]

1. Получите список дисков в каталоге по умолчанию:

    [!INCLUDE [compute-disk-list](../../_includes_service/compute-disk-list.md)]

    Получите тот же список c большим количеством деталей в формате YAML:

    ```
    $ yc compute disk list --format yaml

    - id: fhm4aq4hvq5g3nepvt9b
        folder_id: b1gm3og7ei7aegv8i73m
        created_at: "2018-10-29T07:43:06Z"
        name: first-disk
        description: my first disk via yc
        type_id: network-hdd
        zone_id: ru-central1-a
        size: "10737418240"
        status: READY
    - id: fhmo6rdqg5folrc3lsaf
        folder_id: b1gm3og7ei7aegv8i73m
        created_at: "2018-10-29T07:33:04Z"
        name: second-disk
        description: my second disk via yc
        type_id: network-hdd
        zone_id: ru-central1-a
        size: "8589934592"
        product_ids:
        - f2en2dtd08b5la74mlde
        status: READY
        source_image_id: fdvcl0b1no2hjb423igi
        instance_ids:
        - fhm5b617fjnj44ovhcun
    ```

---
