# Подключение к хосту Yandex Data Processing через OS Login 

{% note warning %}

Включить доступ к хостам через OS Login можно только при [создании кластера](cluster-create.md).

{% endnote %}

[OS Login](../../organization/concepts/os-login.md) используется вместо SSH-ключей для доступа к виртуальным машинам Yandex Cloud.

Подключиться к хостам кластера Yandex Data Processing через OS Login можно с помощью [стандартного SSH-клиента](connect-oslogin.md#os-login-ssh) или [Yandex Cloud CLI](connect-oslogin.md#os-login-cli).

Перед подключением:

1. [Включите доступ через OS Login](../../organization/operations/os-login-access.md) на уровне организации.
1. [Настройте группы безопасности](security-groups.md).
1. Назначьте пользователю или [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), от имени которого выполняется подключение, необходимые роли:
    
   * [роль](../../compute/security/index.md#compute-oslogin) `compute.osLogin` или `compute.osAdminLogin`.
   * [роль](../../resource-manager/security/index.md#resource-manager-auditor) `resource-manager.auditor` или выше на каталог, в котором размещена виртуальная машина.
   * [роль](../../compute/security/index.md#compute-operator) `compute.operator` для подключении с помощью Yandex Cloud CLI.

1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

## Подключитесь с помощью стандартного SSH-клиента {#os-login-ssh}

1. [Экспортируйте сертификат](../../compute/operations/vm-connect/os-login-export-certificate.md) OS Login.

   {% note info %}

   Сертификат действителен один час, потом его нужно экспортировать заново.

   {% endnote %}

   Сертификат включает публичную и приватную части. Сохраните путь к приватной части `Identity` — он понадобится для подключения к хосту.

1. Узнайте IP-адрес хоста Yandex Data Processing:

    1. Получите список хостов:

       ```bash
       yc dataproc cluster list-hosts <имя_или_идентификатор_кластера>
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
    * `<логин_пользователя>` — логин, заданный для этого пользователя в [профиле OS Login](../../organization/concepts/os-login.md#os-login-profiles). Логин также указывается в конце имени экспортированного сертификата OS Login. В примере выше это `orgusername`.

        {% note info %}

        Для сервисных аккаунтов [профили OS Login](../../organization/concepts/os-login.md#os-login-profiles) не создаются автоматически. Чтобы подключаться к ВМ или узлу Kubernetes от имени сервисного аккаунта, [вручную создайте](../../organization/operations/os-login-profile-create.md) для него профиль OS Login.

        {% endnote %}

    * `<IP-адрес_хоста>` — полученный ранее адрес хоста.

    При первом подключении к хосту появится предупреждение о неизвестном хосте:

    ```text
    The authenticity of host '158.160.**.** (158.160.**.**)' can't be established.
    ECDSA key fingerprint is SHA256:PoaSwqxRc8g6iOXtiH7ayGHpSN0MXwUfWHk********.
    Are you sure you want to continue connecting (yes/no)?
    ```

    Введите в терминале слово `yes` и нажмите **Enter**.  

## Подключитесь с помощью CLI {#os-login-cli}

1. Получите список хостов Yandex Data Processing:

   ```bash
   yc dataproc cluster list-hosts <имя_или_идентификатор_кластера>
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

    {% note info %}

    Для сервисных аккаунтов [профили OS Login](../../organization/concepts/os-login.md#os-login-profiles) не создаются автоматически. Чтобы подключаться к ВМ или узлу Kubernetes от имени сервисного аккаунта, [вручную создайте](../../organization/operations/os-login-profile-create.md) для него профиль OS Login.

    {% endnote %}