---
title: "Как подключиться к виртуальной машине через OS Login"
description: "Следуя данной инструкции, вы сможете подключиться к виртуальной машине через OS Login."
---

# Подключиться к виртуальной машине через OS Login

{% include notitle [preview](../../../_includes/note-preview-by-request.md) %}

[OS Login](../../../organization/concepts/os-login.md) используется для предоставления пользователям доступа к ВМ по SSH c помощью {{ iam-short-name }}. Для доступа к ВМ, которая поддерживает OS Login на уровне операционной системы, [назначьте](../../../iam/operations/roles/grant.md) пользователю роль `compute.osLogin` или `compute.osAdminLogin`.

К ВМ с включенным доступом через OS Login нельзя подключиться с помощью [пары SSH-ключей](./ssh.md#creating-ssh-keys).

## Перед началом работы {#before-you-begin}

1. Включите [доступ через OS Login](../../../organization/operations/os-login-access.md) на уровне организации.
1. При необходимости [создайте](./os-login-create-vm.md) новую виртуальную машину с поддержкой OS Login или [настройте](./enable-os-login.md) доступ через OS Login для существующей ВМ.

## Подключиться к ВМ через OS Login c помощью CLI {#connect-via-cli}

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
    | fhm0b28lgf********** | first-instance  | {{ region-id }}-a | RUNNING | my first vm via CLI  |
    | fhm9gk85nj********** | second-instance | {{ region-id }}-a | RUNNING | my second vm via CLI |
    +----------------------+-----------------+---------------+---------+----------------------+
    ```

1. Подключитесь к ВМ, указав ее имя. Команда для подключения зависит от версии ОС Linux, установленной на виртуальной машине:

   * **Debian, Ubuntu 20.04+**

      ```bash
      yc compute ssh \
          --name <имя_ВМ>
      ```

      При подключении через OS Login вместо имени ВМ можно указать ее идентификатор:

      ```bash
      yc compute ssh \
          --id <идентификатор_ВМ>
      ```

   * **CentOS 7, Ubuntu 18.04**

      ```bash
      yc compute ssh \
          --name <имя_ВМ> \
          -o "PubkeyAcceptedKeyTypes=+ssh-rsa-cert-v01@openssh.com"
      ```

      При подключении через OS Login вместо имени ВМ можно указать ее идентификатор:

      ```bash
      yc compute ssh \
          --id <идентификатор_ВМ> \
          -o "PubkeyAcceptedKeyTypes=+ssh-rsa-cert-v01@openssh.com"
      ```

## Подключиться к ВМ по SSH с помощью сертификата OS Login {#connect-via-exported-certificate}

{% include [oslogin-connect-with-exported-cert](../../../_includes/compute/oslogin-connect-with-exported-cert.md) %}