---
title: Как подключиться к хосту кластера {{ dataproc-full-name }} через {{ oslogin }}
description: Следуя данной инструкции, вы сможете подключиться к хосту {{ dataproc-name }} через {{ oslogin }}.
---

# Подключение к хосту {{ dataproc-name }} через {{ oslogin }} 

{% note warning %}

Включить доступ к хостам через {{ oslogin }} можно только при [создании кластера](cluster-create.md).

{% endnote %}

[{{ oslogin }}](../../organization/concepts/os-login.md) используется вместо SSH-ключей для доступа к виртуальным машинам {{ yandex-cloud }}.

Подключиться к хостам кластера {{ dataproc-name }} через {{ oslogin }} можно с помощью [стандартного SSH-клиента](connect-oslogin.md#os-login-ssh) или [{{ yandex-cloud }} CLI](connect-oslogin.md#os-login-cli).

Перед подключением:

1. [Включите доступ через {{ oslogin }}](../../organization/operations/os-login-access.md) на уровне организации.
1. [Настройте группы безопасности](security-groups.md).
1. Назначьте пользователю или [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), от имени которого выполняется подключение, одну из ролей:
    
    * `compute.osLogin`;
    * `compute.osAdminLogin`.
  
    При подключении с помощью {{ yandex-cloud }} CLI дополнительно необходима роль `compute.operator`.

1. {% include [cli-install](../../_includes/cli-install.md) %}

## Подключитесь с помощью стандартного SSH-клиента {#os-login-ssh}

1. [Экспортируйте сертификат](../../compute/operations/vm-connect/os-login-export-certificate.md) {{ oslogin }}.

   {% note info %}

   Сертификат действителен один час, потом его нужно экспортировать заново.

   {% endnote %}

   Сертификат включает публичную и приватную части. Сохраните путь к приватной части `Identity` — он понадобится для подключения к хосту.

1. Узнайте IP-адрес хоста {{ dataproc-name }}:

    1. Получите список хостов:

       ```bash
       {{ yc-dp }} cluster list-hosts <имя_или_идентификатор_кластера>
       ```

       Идентификатор и имя кластера можно получить со [списком кластеров](cluster-list.md#list) в каталоге.

       Результат:

       ```bash
       +------------------------------------------------------+----------------------+------------+----------------------+--------+
       |                         NAME                         | COMPUTE INSTANCE ID  |    ROLE    |    SUBCLUSTER ID     | HEALTH |
       +------------------------------------------------------+----------------------+------------+----------------------+--------+
       | rc1a-dataproc-d-q8659net********.mdb.yandexcloud.net | fhmr7sd33fl8******** | DATANODE   | c9qaps7qjj2d******** | ALIVE  |
       | rc1a-dataproc-m-hhhifdgl********.mdb.yandexcloud.net | fhmg686pspri******** | MASTERNODE | c9q7aen26lid******** | ALIVE  |
       +------------------------------------------------------+----------------------+------------+----------------------+--------+
       ```

       Сохраните идентификатор ВМ из столбца `COMPUTE INSTANCE ID`, соответствующий нужному хосту.

   1. Получите информацию о ВМ:

      ```bash
      yc compute instance get <идентификатор_ВМ>
      ```

      Результат:

      ```yml
      ...
      primary_v4_address:
        address: <внутренний_IP-адрес>
        one_to_one_nat:
          address: <внешний_IP-адрес>
          ip_version: IPV4
      ...
      ```

      Если подключаетесь к хосту из интернета, сохраните внешний IP-адрес, а если с промежуточной ВМ — внутренний IP-адрес.

1. Подключитесь к хосту:

    ```bash
    ssh -i <путь_к_файлу_сертификата> <логин_пользователя>@<IP-адрес_хоста>
    ```

    Где:

    * `<путь_к_файлу_сертификата>` — путь к сохраненному ранее файлу `Identity` сертификата. Например: `/home/user1/.ssh/yc-cloud-id-b1gia87mbaom********-orgusername`.
    * `<логин_пользователя>` — логин, заданный для этого пользователя в [профиле {{ oslogin }}](../../organization/concepts/os-login.md#os-login-profiles). Логин также указывается в конце имени экспортированного сертификата {{ oslogin }}. В примере выше это `orgusername`.
    * `<IP-адрес_хоста>` — полученный ранее адрес хоста.

    При первом подключении к хосту появится предупреждение о неизвестном хосте:

    ```text
    The authenticity of host '158.160.**.** (158.160.**.**)' can't be established.
    ECDSA key fingerprint is SHA256:PoaSwqxRc8g6iOXtiH7ayGHpSN0MXwUfWHk********.
    Are you sure you want to continue connecting (yes/no)?
    ```

    Введите в терминале слово `yes` и нажмите **Enter**.  

## Подключитесь с помощью CLI {#os-login-cli}

1. Получите список хостов {{ dataproc-name }}:

   ```bash
   {{ yc-dp }} cluster list-hosts <имя_или_идентификатор_кластера>
   ```

   Идентификатор и имя кластера можно получить со [списком кластеров](cluster-list.md#list) в каталоге.

   Результат:

   ```bash
   +------------------------------------------------------+----------------------+------------+----------------------+--------+
   |                         NAME                         | COMPUTE INSTANCE ID  |    ROLE    |    SUBCLUSTER ID     | HEALTH |
   +------------------------------------------------------+----------------------+------------+----------------------+--------+
   | rc1a-dataproc-d-q8659net********.mdb.yandexcloud.net | fhmr7sd33fl8******** | DATANODE   | c9qaps7qjj2d******** | ALIVE  |
   | rc1a-dataproc-m-hhhifdgl********.mdb.yandexcloud.net | fhmg686pspri******** | MASTERNODE | c9q7aen26lid******** | ALIVE  |
   +------------------------------------------------------+----------------------+------------+----------------------+--------+
   ```

   Сохраните идентификатор ВМ из столбца `COMPUTE INSTANCE ID`, соответствующий нужному хосту.

1. Подключитесь к хосту:

    ```bash
    yc compute ssh --id <идентификатор_ВМ>
    ```