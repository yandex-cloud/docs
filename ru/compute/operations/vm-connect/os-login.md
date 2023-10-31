# Подключиться к виртуальной машине через OS Login

{% include notitle [preview](../../../_includes/note-preview-by-request.md) %}

[OS Login](../../../organization/concepts/os-login.md) используется для предоставления пользователям доступа к ВМ по SSH c помощью {{ iam-short-name }}. Для доступа к ВМ, которая поддерживает OS Login на уровне операционной системы, [назначьте](../../../iam/operations/roles/grant.md) пользователю роль `compute.osLogin` или `compute.osAdminLogin`.

{% note info %}

Вы не сможете подключиться к ВМ с включенным доступом через OS Login с помощью [пары SSH-ключей](./ssh.md#creating-ssh-keys). При этом рекомендуется в любом случае указывать SSH-ключи при создании ВМ: так вы сможете [подключиться к ВМ по SSH](./ssh.md#vm-connect), если отключите для нее доступ через OS Login.

{% endnote %}

1. Включите [доступ через OS Login](../../../organization/operations/os-login-access.md) на уровне организации.
1. Подготовьте OS Login на виртуальной машине:

   {% list tabs %}

   - Использовать образ с поддержкой OS Login

     [Создайте ВМ из подготовленного образа](../../../compute/operations/images-with-pre-installed-software/create.md) с поддержкой доступа через OS Login. Такие образы доступны в [{{ marketplace-full-name }}](/marketplace) и содержат `OS Login` в названии. При создании ВМ включите опцию **Доступ через OS Login** или установите в [метаданных](../../concepts/vm-metadata.md) параметр `enable-oslogin` в значение `true`.

   - Установить самостоятельно

     Вы можете установить агента OS Login самостоятельно, если вам не подходит образ из [{{ marketplace-name }}](/marketplace) с предустановленным агентом OS Login, например:

     * вы используете собственный образ не на основе образов из {{ marketplace-name }};
     * виртуальная машина уже развернута и вам необходимо установить на нее агента OS Login.

     Чтобы установить агента OS Login:

     1. [Скачайте](https://storage.yandexcloud.net/mk8s/binaries/google_guest_agent-20230601.00.linux-amd64.tar.gz) последнюю версию исполняемого файла или соберите его из [исходного кода на Github](https://github.com/yandex-cloud/yandex-cloud-guest-agent).

        {% note info %}

        При скачивании файла проверьте его хэш-сумму: `33f526d1b52e24b38b2e2836a67ea32f0ecdd23e90aeb2a7bee12bd52637716a`.

        {% endnote %}

     1. Запустите исполняемый файл и убедитесь, что компоненты установились корректно.
     1. [Создайте ВМ из собственного образа](../../../compute/operations/vm-create/create-from-user-image.md). При создании ВМ включите опцию **Доступ через OS Login** или установите в [метаданных](../../concepts/vm-metadata.md) параметр `enable-oslogin` в значение `true`.

     При возникновении проблем обратитесь в [техническую поддержку]({{ link-console-support }}).

   {% endlist %}

1. Подключитесь к ВМ:

   {% list tabs %}

   - CLI

     {% include [cli-install](../../../_includes/cli-install.md) %}

     {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

     1. Посмотрите описание команды CLI для подключения к ВМ:

        ```bash
        yc compute ssh --help
        ```

     1. Получите список всех ВМ в каталоге по умолчанию:

        ```bash
        yc compute instance list
        ```

        Результат:

        ```text
        +----------------------+-----------------+---------------+---------+----------------------+
        |          ID          |       NAME      |    ZONE ID    | STATUS  |     DESCRIPTION      |
        +----------------------+-----------------+---------------+---------+----------------------+
        | fhm0b28lgf********** | first-instance  | ru-central1-a | RUNNING | my first vm via CLI  |
        | fhm9gk85nj********** | second-instance | ru-central1-a | RUNNING | my second vm via CLI |
        +----------------------+-----------------+---------------+---------+----------------------+
        ```

     1. Подключитесь к ВМ:

        ```bash
        yc compute ssh --name <имя_ВМ>
        ```

   {% endlist %}
