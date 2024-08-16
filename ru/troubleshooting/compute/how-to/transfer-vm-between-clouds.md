# Как перенести виртуальную машину между разными каталогами или облаками


## Описание задачи {#case-description}

Необходимо перенести виртуальную машину из одного облака или каталога в другое облако или каталог.

## Решение {#case-resolution}

{% list tabs %}

- Перенос между облаками

    Для переноса ВМ между облаками выполните следующие действия:

    1. [Создайте образ из диска нужной ВМ](../../../compute/operations/image-create/create-from-disk.md).
    1. [Добавьте {{ iam-short-name }}-пользователя](../../../iam/operations/users/create.md) в облако с образом, который вы хотите перенести.
    1. [Назначьте {{ iam-short-name }}-пользователю минимально необходимые роли](../../../iam/operations/roles/grant.md) `{{ roles-cloud-member }}` и `{{ roles-image-user }}`.
    1. [Настройте](../../../cli/quickstart.md) утилиту YC CLI для пользователя в целевом облаке.
    1. Получите идентификатор вашего образа. Для этого в [Консоли управления]({{ link-console-main }}) найдите поле **{{ ui-key.yacloud.common.id }}** на вкладке **{{ ui-key.yacloud.compute.images.label_title }}** или получите его с помощью YC CLI командой `yc compute image list`.
    1. Получите идентификатор облака, в котором расположен оригинальный образ. Для этого в [Консоли управления]({{ link-console-main }}) найдите поле **{{ ui-key.yacloud.common.id }}** или получите его с помощью YC CLI командой `yc resource-manager cloud list`.
    1. Создайте новый образ в целевом облаке используя YC CLI:

    ```
    yc compute image create --name <имя_нового_образа> \
    --source-image-id <id_оригинального_образа> \
    --cloud-id <id_облака_где_расположен_оригинальный_образ>
    ```

    После выполнения этих действий [создайте новую виртуальную машину](../../../compute/operations/vm-create/create-from-user-image.md#create-vm-from-image) из полученного образа.

- Перенос между каталогами

    Для изменения каталога ВМ в CLI выполните следующие действия:

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
            | fhmXXXXXXXXXXXXXXXXX | first-instance  | {{ region-id }}-a | RUNNING | my first vm via CLI  |
            | fhmXXXXXXXXXXXXXXXXX | second-instance | {{ region-id }}-a | RUNNING | my second vm via CLI |
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
            | b1gXXXXXXXXXXXXXXXXX | my-folder          |                  | ACTIVE |
            | b1gXXXXXXXXXXXXXXXXX | default            |                  | ACTIVE |
            +----------------------+--------------------+------------------+--------+
            ```

        1. Посмотрите описание команды CLI для переноса виртуальной машины:

            ```bash
            yc compute instance move --help
            ```

        1. Перенесите виртуальную машину в другой каталог со следующими параметрами: 

            * в параметре `id` укажите идентификатор виртуальной машины, например `fhmXXXXXXXXXXXXXXXXX`;
            * в параметре `destination-folder-id` укажите идентификатор целевого каталога, например `b1gXXXXXXXXXXXXXXXXX`.

            ```bash
            yc compute instance move \
                --id fhmXXXXXXXXXXXXXXXXX \
                --destination-folder-id b1gXXXXXXXXXXXXXXXXX
            ```

            Подробнее о команде `yc compute instance move` можно узнать в [справочнике CLI](../../../cli/cli-ref/managed-services/compute/instance/move.md).

{% endlist %}