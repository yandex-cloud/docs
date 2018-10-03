# Создать пустой диcк

Вы можете создать пустой диск заданного размера.

---

**[!TAB Консоль управления]**

1. В консоли управления выберите каталог, в котором нужно создать диск.
2. Нажмите плитку **Yandex Compute Cloud**.
3. На странице **Виртуальные машины** перейдите на вкладку **Диски**.
4. Нажмите кнопку **Создать диск**.
5. Введите имя диска.
    Имя должно быть уникальным в рамках каталога. Имя может содержать строчные буквы латинского алфавита, цифры и дефисы. Первый символ должен быть буквой. Последний символ не должен быть дефисом. Максимальная длина имени — 63 символа.
6. Если требуется, добавьте произвольное описание диска.
7. Укажите нужный размер диска.
8. Нажмите кнопку **Сохранить диск**.

**[!TAB CLI]**

1. Посмотрите описание команд CLI для создания дисков:

    ```
    yc compute disk create --help
    ```

2. Создайте диск в каталоге, указанном в вашем профиле CLI:

    ```
    yc compute disk create \
        --name my-yc-disk \
        --size 10 \
        --description "my first disk via yc"
    ```

    Данная команда создаст диск размером 10 ГБ с именем `my-yc-disk` и описанием `my first disk via yc`.

    [!INCLUDE [name-format](../../../_includes/name-format.md)]

3. Получите список всех дисков в каталоге, указанном в вашем профиле CLI:

    ```
    yc compute disk list
    +----------------------+------------+-------------+---------------+--------+----------------------+
    |          ID          |    NAME    |    SIZE     |     ZONE      | STATUS |     DESCRIPTION      |
    +----------------------+------------+-------------+---------------+--------+----------------------+
    | fhm53hnjmvplsn5r0633 |            | 13958643712 | ru-central1-a | READY  |                      |
    | fhmc3pdo4l7uqf8hq0ad |            | 42949672960 | ru-central1-a | READY  |                      |
    | fhmj8jjlicm6g3poe32g | my-yc-disk | 10737418240 | ru-central1-a | READY  | my first disk via yc |
    +----------------------+------------+-------------+---------------+--------+----------------------+
    ```

    Получите тот же список c большим количеством деталей в формате YAML:

    ```
    yc compute disk list --format yaml

    - id: fhm53hnjmvplsn5r0633
        folder_id: b1gm3og7ei7aegv8i73m
        created_at: "2018-10-01T08:14:58Z"
        type_id: network-nvme
        zone_id: ru-central1-a
        size: "13958643712"
        product_ids:
        - f2ecl5vhsftdean0sr6s
        status: READY
        source_image_id: fd853eldm2bpgu1ii7v6
        instance_ids:
        - fhm9gk85nj7gcoji2f8s
    - id: fhmc3pdo4l7uqf8hq0ad
        folder_id: b1gm3og7ei7aegv8i73m
        created_at: "2018-10-01T08:49:38Z"
        type_id: network-nvme
        zone_id: ru-central1-a
        size: "42949672960"
        product_ids:
        - f2ermbgrfmdb7jp9js5o
        status: READY
        source_image_id: fd8d7vd1imm1hlng6qci
        instance_ids:
        - fhmq76jqs5i59fdi7d7g
    - id: fhmj8jjlicm6g3poe32g
        folder_id: b1gm3og7ei7aegv8i73m
        created_at: "2018-10-03T09:32:06Z"
        name: my-yc-disk
        description: my first disk via yc
        type_id: network-hdd
        zone_id: ru-central1-a
        size: "10737418240"
        status: READY
    ```

---
