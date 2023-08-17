# Перенос ВМ между разными каталогами или облаками


## Описание задачи {#case-description}

Нужно перенести виртуальную машину из одного облака или каталога в другое облако или каталог.

## Решение {#case-resolution}

{% list tabs %}

- Перенос между облаками

    Для переноса ВМ между облаками следует выполнить следующие действия:

    1. [Создайте образ из диска нужной ВМ](../../../compute/operations/image-create/create-from-disk.md);
    2. [Добавьте IAM-пользователя](../../../iam/operations/users/create.md) в облако с образом, который вы хотите перенести;
    3. [Назначьте IAM-пользователю минимально необходимые роли](../../../iam/operations/roles/grant.md) `resource-manager.clouds.member` и `compute.images.user`.
    4. [Настройте](../../../cli/quickstart.md) утилиту YC CLI для пользователя в целевом облаке.
    5. Получите ID вашего образа. Для этого в веб-интерфейсе найдите поле **ID** на вкладке **Образы**, либо получите ID с помощью утилиты YC CLI командой `yc compute image list` ;
    6. Получите ID облака в котором расположен оригинальный образ. Для этого в веб-интерфейсе найдите поле **Идентификатор** на начальной странице облака, либо получите ID с помощью утилиты YC CLI командой `yc resource-manager cloud list`;
    7. Создать новый образ в целевом облаке используя утилиту YC CLI:

    ```
    yc compute image create --name <имя_нового_образа> \
    --source-image-id <id_оригинального_образа> \
    --cloud-id <id_облака_где_расположен_оригинальный_образ>
    ```

    После выполнения этих действий [создайте новую виртуальную машину](../../../compute/operations/vm-create/create-from-user-image.md#create-vm-from-image) из полученного образа.

- Перенос между каталогами

    Чтобы изменить каталог виртуальной машины, выполните следующие действия:

    * в CLI:

        {% include [cli-install](../../../_includes/cli-install.md) %}

        {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

        1. Получите список всех виртуальных машин в каталоге по умолчанию:

            ```bash
            yc compute instance list
            ```

            Результат:

            ```bash
            +----------------------+-----------------+---------------+---------+----------------------+
            |          ID          |       NAME      |    ZONE ID    | STATUS  |     DESCRIPTION      |
            +----------------------+-----------------+---------------+---------+----------------------+
            | fhm0b28lgfp4tkoa3jl6 | first-instance  | {{ region-id }}-a | RUNNING | my first vm via CLI  |
            | fhm9gk85nj7gcoji2f8s | second-instance | {{ region-id }}-a | RUNNING | my second vm via CLI |
            +----------------------+-----------------+---------------+---------+----------------------+
            ```      

        1. Получите список всех каталогов в облаке по умолчанию:

            ```bash
            yc resource-manager folder list
            ```

            Результат:

            ```bash
            +----------------------+--------------------+------------------+--------+
            |          ID          |        NAME        |      LABELS      | STATUS |
            +----------------------+--------------------+------------------+--------+
            | b1gd129pp9ha0vnvf5g7 | my-folder          |                  | ACTIVE |
            | b1g66mft1vopnevbn57j | default            |                  | ACTIVE |
            +----------------------+--------------------+------------------+--------+
            ```

        1. Посмотрите описание команды CLI для переноса виртуальной машины:

            ```bash
            yc compute instance move --help
            ```

        1. Перенесите виртуальную машину в другой каталог со следующими параметрами: 

            * в параметре `id` укажите идентификатор виртуальной машины, например `fhm0b28lgfp4tkoa3jl6`;
            * в параметре `destination-folder-id` укажите идентификатор целевого каталога, например `b1gd129pp9ha0vnvf5g7`.

            ```bash
            yc compute instance move \
                --id fhm0b28lgfp4tkoa3jl6 \
                --destination-folder-id b1gd129pp9ha0vnvf5g7
            ```

            Подробнее о команде `yc compute instance move` см. в [справочнике CLI](../../../cli/cli-ref/managed-services/compute/instance/move.md).

{% endlist %}