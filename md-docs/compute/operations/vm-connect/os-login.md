# Подключиться к виртуальной машине по {{ oslogin }}

[{{ oslogin }}](../../../organization/concepts/os-login.md) используется для предоставления пользователям и [сервисным аккаунтам](../../../iam/concepts/users/service-accounts.md) доступа к [виртуальным машинам](../../concepts/vm.md#project), полагаясь только на механизмы [сервиса {{ iam-full-name }}](../../../iam/concepts/index.md), без необходимости загружать SSH-ключи на каждую новую ВМ при ее создании.

{% note warning %}

Для сервисных аккаунтов [профили {{ oslogin }}](../../../organization/concepts/os-login.md#os-login-profiles) не создаются автоматически. Чтобы подключаться к ВМ или узлу {{ k8s }} от имени сервисного аккаунта, [вручную создайте](../../../organization/operations/os-login-profile-create.md) для него профиль {{ oslogin }}.

{% endnote %}

## Перед началом работы {#before-you-begin}

Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

При необходимости [создайте](os-login-create-vm.md) новую виртуальную машину с поддержкой {{ oslogin }} или [настройте](enable-os-login.md) доступ по {{ oslogin }} для существующей ВМ.

{% note info %}

Чтобы подключиться к виртуальной машине или узлу {{ k8s }} с включенным доступом по {{ oslogin }} пользователю или [сервисному аккаунту](../../../iam/concepts/users/service-accounts.md), от имени которого выполняется подключение, должны быть назначены роли:

* [роль](../../security/index.md#compute-oslogin) `compute.osLogin` или `compute.osAdminLogin`.
* [роль](../../../resource-manager/security/index.md#resource-manager-auditor) `resource-manager.auditor` и выше на каталог, в котором размещена виртуальная машина или узел {{ k8s }}.
* [роль](../../security/index.md#compute-operator) `compute.operator` для подключении с помощью {{ yandex-cloud }} CLI.

{% endnote %}

## Подключиться с помощью стандартного SSH-клиента {#connect-with-ssh-client}

Подключиться к виртуальной машине с включенным доступом по {{ oslogin }} можно с помощью стандартного [SSH](../../../glossary/ssh-keygen.md)-клиента как по SSH-ключу, [сохраненному](../../../organization/operations/add-ssh.md) в профиле {{ oslogin }} пользователя или сервисного аккаунта в организации, так и по короткоживущему экспортированному SSH-сертификату этого пользователя или сервисного аккаунта.

{% list tabs group=os_login_type %}

- По SSH-ключу {#ssh-key}

  Чтобы подключиться к ВМ через {{ oslogin }} по SSH-ключу с помощью стандартного SSH-клиента:
  
  1. [Включите](../../../organization/operations/os-login-access.md) доступ по {{ oslogin }} на уровне организации.
     
     Чтобы подключиться к ВМ по {{ oslogin }} с SSH-ключом, включите опцию **{{ ui-key.yacloud_org.form.oslogin-settings.title_user-ssh-key-settings }}**.
     
     Чтобы пользователи могли самостоятельно добавлять SSH-ключи в свои профили {{ oslogin }}, включите опцию **{{ ui-key.yacloud_org.form.oslogin-settings.title_allow-edit-own-keys }}**.
     
     {% note info %}
     
     Загружать SSH-ключи в [профили {{ oslogin }}](../../../organization/concepts/os-login.md#os-login-profiles) сервисных аккаунтов могут только пользователи [с аккаунтом на Яндексе](../../../iam/concepts/users/accounts.md#passport), [федеративные](../../../iam/concepts/users/accounts.md#saml-federation) или [локальные](../../../iam/concepts/users/accounts.md#local) пользователи, которым назначена [роль](../../../organization/security/index.md#organization-manager-osLogins-admin) `organization-manager.osLogins.admin` или выше.
     
     {% endnote %}
  1. [Создайте](ssh.md#creating-ssh-keys) пару SSH-ключей и [добавьте](../../../organization/operations/add-ssh.md) публичный ключ в профиль {{ oslogin }} пользователя или [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md). Запомните расположение закрытого SSH-ключа, оно понадобится при подключении к ВМ.
  1. Получите идентификатор организации, в которой находится нужный [профиль {{ oslogin }}](../../../organization/concepts/os-login.md#os-login-profiles) пользователя или [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md):
     
     ```bash
     yc organization-manager organization list
     ```
     
     Результат:
     
     ```text
     +----------------------+-------------------------+-------------------------+
     |          ID          |          NAME           |          TITLE          |
     +----------------------+-------------------------+-------------------------+
     | bpf1smsil5q0******** | sample-organization1    | Organization 1          |
     | bpf2c65rqcl8******** | sample-organization2    | Organization 2          |
     | bpf6dne49ue8******** | sample-organization3    | Organization 3          |
     +----------------------+-------------------------+-------------------------+
     ```
  1. Получите список логинов в [профилях {{ oslogin }}](../../../organization/concepts/os-login.md#os-login-profiles) пользователей и сервисных аккаунтов нужной организации, указав ее идентификатор:
     
     ```bash
     yc organization-manager os-login profile list \
       --organization-id <идентификатор_организации>
     ```
     
     Результат:
     
     ```text
     +----------------------+----------------------+-----------+----------------------+----------------------+------------+
     |          ID          |        LOGIN         |    UID    |   ORGANIZATION ID    |      SUBJECT ID      | IS DEFAULT |
     +----------------------+----------------------+-----------+----------------------+----------------------+------------+
     | aje1eb5qm7jb******** | yc-sa-my-service-acc | 487816044 | bpfaidqca8vd******** | ajevnu4u2q3m******** | true       |
     | ajegs81t2k9s******** | user1                | 760684761 | bpfaidqca8vd******** | aje7b4u65nb6******** | true       |
     | ajej57b2kf0t******** | user2                |      1011 | bpfaidqca8vd******** | ajei280a73vc******** | true       |
     +----------------------+----------------------+-----------+----------------------+----------------------+------------+
     ```
     
     Сохраните значение поля `LOGIN` для нужного пользователя или сервисного аккаунта — оно понадобится позднее.
     
     {% note info %}
     
     Минимально необходимая роль, позволяющая просматривать список профилей {{ oslogin }} пользователей — [роль](../../../organization/security/index.md#organization-manager-osLogins-viewer) `organization-manager.osLogins.viewer`, назначенная на организацию. Информацию о других ролях, позволяющих просматривать список профилей {{ oslogin }}, см. в разделе [Управление доступом в {{ org-full-name }}](../../../organization/security/index.md#service-roles).
     
     {% endnote %}
  1. Получите список всех ВМ в каталоге по умолчанию:
     
     ```bash
     yc compute instance list
     ```
     
     Результат:
     
     ```text
     +----------------------+-----------------+---------------+---------+---------------+--------------+
     |          ID          |       NAME      |    ZONE ID    | STATUS  |  EXTERNAL IP  | INTERNAL IP  |
     +----------------------+-----------------+---------------+---------+---------------+--------------+
     | fhm0b28lgf********** | first-instance  | {{ region-id }}-a | RUNNING | 158.160.**.** | 192.168.0.8  |
     | fhm9gk85nj********** | second-instance | {{ region-id }}-a | RUNNING | 51.250.**.*** | 192.168.0.12 |
     +----------------------+-----------------+---------------+---------+---------------+--------------+
     ```
  
      Сохраните публичный IP-адрес (значение поля `EXTERNAL IP`) виртуальной машины, к которой вы хотите подключиться.
  1. Подключитесь к ВМ:
  
      ```bash
      ssh -i <путь_к_файлу_закрытого-SSH-ключа> \
        -l <логин_пользователя_или_сервисного_аккаунта> <публичный_IP-адрес_ВМ>
      ```
  
      Где:
  
      * `<путь_к_файлу_закрытого-SSH-ключа>` — путь к файлу, в котором сохранен закрытый SSH-ключ. Например: `/home/user1/.ssh/id_ed25519`. 
      * `<логин_пользователя_или_сервисного_аккаунта>` — полученный ранее логин пользователя или сервисного аккаунта, заданный в профиле {{ oslogin }}.
      * `<публичный_IP-адрес_ВМ>` — сохраненный ранее публичный адрес виртуальной машины.
  
      При первом подключении к ВМ появится предупреждение о неизвестном хосте:
  
      ```text
      The authenticity of host '158.160.**.** (158.160.**.**)' can't be established.
      ECDSA key fingerprint is SHA256:PoaSwqxRc8g6iOXtiH7ayGHpSN0MXwUfWHk********.
      Are you sure you want to continue connecting (yes/no)?
      ```
  
      В терминале введите слово `yes` и нажмите **Enter**.

- По SSH-сертификату {#ssh-cert}

  Чтобы подключиться к ВМ через {{ oslogin }} по SSH-сертификату с помощью стандартного SSH-клиента:
  
  1. [Включите](../../../organization/operations/os-login-access.md) доступ по {{ oslogin }} на уровне организации.
     
     Чтобы подключиться к ВМ по {{ oslogin }} с SSH-сертификатом, включите опцию **{{ ui-key.yacloud_org.form.oslogin-settings.title_ssh-certificate-settings }}**.
  1. [Экспортируйте](os-login-export-certificate.md) SSH-сертификат на локальный компьютер.
  1. Получите идентификатор организации, в которой находится нужный [профиль {{ oslogin }}](../../../organization/concepts/os-login.md#os-login-profiles) пользователя или [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md):
     
     ```bash
     yc organization-manager organization list
     ```
     
     Результат:
     
     ```text
     +----------------------+-------------------------+-------------------------+
     |          ID          |          NAME           |          TITLE          |
     +----------------------+-------------------------+-------------------------+
     | bpf1smsil5q0******** | sample-organization1    | Organization 1          |
     | bpf2c65rqcl8******** | sample-organization2    | Organization 2          |
     | bpf6dne49ue8******** | sample-organization3    | Organization 3          |
     +----------------------+-------------------------+-------------------------+
     ```
  1. Получите список логинов в [профилях {{ oslogin }}](../../../organization/concepts/os-login.md#os-login-profiles) пользователей и сервисных аккаунтов нужной организации, указав ее идентификатор:
     
     ```bash
     yc organization-manager os-login profile list \
       --organization-id <идентификатор_организации>
     ```
     
     Результат:
     
     ```text
     +----------------------+----------------------+-----------+----------------------+----------------------+------------+
     |          ID          |        LOGIN         |    UID    |   ORGANIZATION ID    |      SUBJECT ID      | IS DEFAULT |
     +----------------------+----------------------+-----------+----------------------+----------------------+------------+
     | aje1eb5qm7jb******** | yc-sa-my-service-acc | 487816044 | bpfaidqca8vd******** | ajevnu4u2q3m******** | true       |
     | ajegs81t2k9s******** | user1                | 760684761 | bpfaidqca8vd******** | aje7b4u65nb6******** | true       |
     | ajej57b2kf0t******** | user2                |      1011 | bpfaidqca8vd******** | ajei280a73vc******** | true       |
     +----------------------+----------------------+-----------+----------------------+----------------------+------------+
     ```
     
     Сохраните значение поля `LOGIN` для нужного пользователя или сервисного аккаунта — оно понадобится позднее.
     
     {% note info %}
     
     Минимально необходимая роль, позволяющая просматривать список профилей {{ oslogin }} пользователей — [роль](../../../organization/security/index.md#organization-manager-osLogins-viewer) `organization-manager.osLogins.viewer`, назначенная на организацию. Информацию о других ролях, позволяющих просматривать список профилей {{ oslogin }}, см. в разделе [Управление доступом в {{ org-full-name }}](../../../organization/security/index.md#service-roles).
     
     {% endnote %}
  1. Получите список всех ВМ в каталоге по умолчанию:
     
     ```bash
     yc compute instance list
     ```
     
     Результат:
     
     ```text
     +----------------------+-----------------+---------------+---------+---------------+--------------+
     |          ID          |       NAME      |    ZONE ID    | STATUS  |  EXTERNAL IP  | INTERNAL IP  |
     +----------------------+-----------------+---------------+---------+---------------+--------------+
     | fhm0b28lgf********** | first-instance  | {{ region-id }}-a | RUNNING | 158.160.**.** | 192.168.0.8  |
     | fhm9gk85nj********** | second-instance | {{ region-id }}-a | RUNNING | 51.250.**.*** | 192.168.0.12 |
     +----------------------+-----------------+---------------+---------+---------------+--------------+
     ```
  
      Сохраните публичный IP-адрес (значение поля `EXTERNAL IP`) виртуальной машины, к которой вы хотите подключиться.
  1. Подключитесь к ВМ:
  
      ```bash
      ssh -i <путь_к_файлу_сертификата> \
        -l <логин_пользователя_или_сервисного_аккаунта> <публичный_IP-адрес_ВМ>
      ```
  
      Где:
  
      * `<путь_к_файлу_сертификата>` — путь к экспортированному ранее файлу `Identity` сертификата. Например: `/home/user1/.ssh/yc-cloud-id-b1gia87mbaom********-orgusername`.
      * `<логин_пользователя_или_сервисного_аккаунта>` — полученный ранее логин пользователя или [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md), заданный в профиле {{ oslogin }}.
      * `<публичный_IP-адрес_ВМ>` — сохраненный ранее публичный адрес виртуальной машины.
  
      Команду для подключения к ВМ вы также можете посмотреть в [консоли управления]({{ link-console-main }}) на странице **{{ ui-key.yacloud.compute.instance.overview.label_title }}** нужной ВМ в блоке **{{ ui-key.yacloud.compute.instance.overview.field_access }}**: раскройте секцию **{{ ui-key.yacloud.compute.instance.overview.label_ssh-connect-card-title }}** и выберите вкладку **{{ ui-key.yacloud.compute.instance.overview.label_cert-connect-tab }}**.
  
      При первом подключении к ВМ появится предупреждение о неизвестном хосте:
  
      ```text
      The authenticity of host '158.160.**.** (158.160.**.**)' can't be established.
      ECDSA key fingerprint is SHA256:PoaSwqxRc8g6iOXtiH7ayGHpSN0MXwUfWHk********.
      Are you sure you want to continue connecting (yes/no)?
      ```
  
      В терминале введите слово `yes` и нажмите **Enter**.

  {% note info %}
  
  Сертификат действителен один час. По истечении этого времени для подключения к ВМ необходимо [экспортировать](os-login-export-certificate.md) новый сертификат.
  
  {% endnote %}

{% endlist %}

Произойдет подключение к указанной виртуальной машине. Если это ваше первое подключение, в операционной системе ВМ будет создан новый профиль пользователя.

## Подключиться с помощью {{ yandex-cloud }} CLI {#connect-with-yc-cli}

Подключиться к виртуальной машине с включенным доступом по {{ oslogin }} можно с помощью [{{ yandex-cloud }} CLI](../../../cli/quickstart.md) как по [SSH](../../../glossary/ssh-keygen.md)-ключу, [сохраненному](../../../organization/operations/add-ssh.md) в профиле пользователя или сервисного аккаунта в организации, так и по SSH-сертификату этого пользователя или сервисного аккаунта.

{% list tabs group=os_login_type %}

- По SSH-ключу {#ssh-key}

  Чтобы подключиться к ВМ через {{ oslogin }} по SSH-ключу с помощью {{ yandex-cloud }} CLI:
  
  1. [Включите](../../../organization/operations/os-login-access.md) доступ по {{ oslogin }} на уровне организации.
     
     Чтобы подключиться к ВМ по {{ oslogin }} с SSH-ключом, включите опцию **{{ ui-key.yacloud_org.form.oslogin-settings.title_user-ssh-key-settings }}**.
     
     Чтобы пользователи могли самостоятельно добавлять SSH-ключи в свои профили {{ oslogin }}, включите опцию **{{ ui-key.yacloud_org.form.oslogin-settings.title_allow-edit-own-keys }}**.
     
     {% note info %}
     
     Загружать SSH-ключи в [профили {{ oslogin }}](../../../organization/concepts/os-login.md#os-login-profiles) сервисных аккаунтов могут только пользователи [с аккаунтом на Яндексе](../../../iam/concepts/users/accounts.md#passport), [федеративные](../../../iam/concepts/users/accounts.md#saml-federation) или [локальные](../../../iam/concepts/users/accounts.md#local) пользователи, которым назначена [роль](../../../organization/security/index.md#organization-manager-osLogins-admin) `organization-manager.osLogins.admin` или выше.
     
     {% endnote %}
  1. [Создайте](ssh.md#creating-ssh-keys) пару SSH-ключей и [добавьте](../../../organization/operations/add-ssh.md) публичный ключ в профиль {{ oslogin }} пользователя или [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md). Запомните расположение закрытого SSH-ключа, оно понадобится при подключении к ВМ.
  1. Посмотрите описание команды CLI для подключения к ВМ:
  
      ```bash
      yc compute ssh --help
      ```
  1. Получите идентификатор организации, в которой находится нужный [профиль {{ oslogin }}](../../../organization/concepts/os-login.md#os-login-profiles) пользователя или [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md):
     
     ```bash
     yc organization-manager organization list
     ```
     
     Результат:
     
     ```text
     +----------------------+-------------------------+-------------------------+
     |          ID          |          NAME           |          TITLE          |
     +----------------------+-------------------------+-------------------------+
     | bpf1smsil5q0******** | sample-organization1    | Organization 1          |
     | bpf2c65rqcl8******** | sample-organization2    | Organization 2          |
     | bpf6dne49ue8******** | sample-organization3    | Organization 3          |
     +----------------------+-------------------------+-------------------------+
     ```
  1. Получите список логинов в [профилях {{ oslogin }}](../../../organization/concepts/os-login.md#os-login-profiles) пользователей и сервисных аккаунтов нужной организации, указав ее идентификатор:
     
     ```bash
     yc organization-manager os-login profile list \
       --organization-id <идентификатор_организации>
     ```
     
     Результат:
     
     ```text
     +----------------------+----------------------+-----------+----------------------+----------------------+------------+
     |          ID          |        LOGIN         |    UID    |   ORGANIZATION ID    |      SUBJECT ID      | IS DEFAULT |
     +----------------------+----------------------+-----------+----------------------+----------------------+------------+
     | aje1eb5qm7jb******** | yc-sa-my-service-acc | 487816044 | bpfaidqca8vd******** | ajevnu4u2q3m******** | true       |
     | ajegs81t2k9s******** | user1                | 760684761 | bpfaidqca8vd******** | aje7b4u65nb6******** | true       |
     | ajej57b2kf0t******** | user2                |      1011 | bpfaidqca8vd******** | ajei280a73vc******** | true       |
     +----------------------+----------------------+-----------+----------------------+----------------------+------------+
     ```
     
     Сохраните значение поля `LOGIN` для нужного пользователя или сервисного аккаунта — оно понадобится позднее.
     
     {% note info %}
     
     Минимально необходимая роль, позволяющая просматривать список профилей {{ oslogin }} пользователей — [роль](../../../organization/security/index.md#organization-manager-osLogins-viewer) `organization-manager.osLogins.viewer`, назначенная на организацию. Информацию о других ролях, позволяющих просматривать список профилей {{ oslogin }}, см. в разделе [Управление доступом в {{ org-full-name }}](../../../organization/security/index.md#service-roles).
     
     {% endnote %}
  1. Получите список всех ВМ в каталоге по умолчанию:
     
     ```bash
     yc compute instance list
     ```
     
     Результат:
     
     ```text
     +----------------------+-----------------+---------------+---------+---------------+--------------+
     |          ID          |       NAME      |    ZONE ID    | STATUS  |  EXTERNAL IP  | INTERNAL IP  |
     +----------------------+-----------------+---------------+---------+---------------+--------------+
     | fhm0b28lgf********** | first-instance  | {{ region-id }}-a | RUNNING | 158.160.**.** | 192.168.0.8  |
     | fhm9gk85nj********** | second-instance | {{ region-id }}-a | RUNNING | 51.250.**.*** | 192.168.0.12 |
     +----------------------+-----------------+---------------+---------+---------------+--------------+
     ```
  1. Подключитесь к ВМ:
  
      ```bash
      yc compute ssh \
        --name <имя_ВМ> \
        --identity-file <путь_к_файлу_закрытого_SSH_ключа> \
        --login <логин_пользователя_или_сервисного_аккаунта> \
        --internal-address
      ```
  
      Где:
      * `--name` — полученное ранее имя виртуальной машины. Вместо имени ВМ можно указать ее идентификатор, для этого используйте параметр `--id`.
      * `--identity-file` — путь к файлу закрытого SSH-ключа. Например: `/home/user1/.ssh/id_ed25519`.
      * `--login` — полученный ранее логин пользователя или сервисного аккаунта, заданный в профиле {{ oslogin }}. Необязательный параметр. Если параметр не задан, для подключения будет использован логин, который указан в [профиле {{ oslogin }}](../../../organization/concepts/os-login.md#os-login-profiles) по умолчанию для пользователя или сервисного аккаунта, авторизованного в текущий момент в профиле {{ yandex-cloud }} CLI.
      * `--internal-address` — для подключения по внутреннему IP-адресу. Необязательный параметр.
  
      Команду для подключения к ВМ вы также можете посмотреть в [консоли управления]({{ link-console-main }}) на странице **{{ ui-key.yacloud.compute.instance.overview.label_title }}** нужной ВМ в блоке **Подключение к виртуальной машине**: раскройте секцию **Подключиться с помощью CLI-интерфейса {{ yandex-cloud }}** и выберите вкладку **По SSH-ключу**.

- По SSH-сертификату {#ssh-cert}

  Чтобы подключиться к ВМ через {{ oslogin }} по SSH-сертификату с помощью {{ yandex-cloud }} CLI:
  
  1. [Включите](../../../organization/operations/os-login-access.md) доступ по {{ oslogin }} на уровне организации.
     
     Чтобы подключиться к ВМ по {{ oslogin }} с SSH-сертификатом, включите опцию **{{ ui-key.yacloud_org.form.oslogin-settings.title_ssh-certificate-settings }}**.
  1. Посмотрите описание команды CLI для подключения к ВМ:
  
      ```bash
      yc compute ssh --help
      ```
  1. Получите идентификатор организации, в которой находится нужный [профиль {{ oslogin }}](../../../organization/concepts/os-login.md#os-login-profiles) пользователя или [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md):
     
     ```bash
     yc organization-manager organization list
     ```
     
     Результат:
     
     ```text
     +----------------------+-------------------------+-------------------------+
     |          ID          |          NAME           |          TITLE          |
     +----------------------+-------------------------+-------------------------+
     | bpf1smsil5q0******** | sample-organization1    | Organization 1          |
     | bpf2c65rqcl8******** | sample-organization2    | Organization 2          |
     | bpf6dne49ue8******** | sample-organization3    | Organization 3          |
     +----------------------+-------------------------+-------------------------+
     ```
  1. Получите список логинов в [профилях {{ oslogin }}](../../../organization/concepts/os-login.md#os-login-profiles) пользователей и сервисных аккаунтов нужной организации, указав ее идентификатор:
     
     ```bash
     yc organization-manager os-login profile list \
       --organization-id <идентификатор_организации>
     ```
     
     Результат:
     
     ```text
     +----------------------+----------------------+-----------+----------------------+----------------------+------------+
     |          ID          |        LOGIN         |    UID    |   ORGANIZATION ID    |      SUBJECT ID      | IS DEFAULT |
     +----------------------+----------------------+-----------+----------------------+----------------------+------------+
     | aje1eb5qm7jb******** | yc-sa-my-service-acc | 487816044 | bpfaidqca8vd******** | ajevnu4u2q3m******** | true       |
     | ajegs81t2k9s******** | user1                | 760684761 | bpfaidqca8vd******** | aje7b4u65nb6******** | true       |
     | ajej57b2kf0t******** | user2                |      1011 | bpfaidqca8vd******** | ajei280a73vc******** | true       |
     +----------------------+----------------------+-----------+----------------------+----------------------+------------+
     ```
     
     Сохраните значение поля `LOGIN` для нужного пользователя или сервисного аккаунта — оно понадобится позднее.
     
     {% note info %}
     
     Минимально необходимая роль, позволяющая просматривать список профилей {{ oslogin }} пользователей — [роль](../../../organization/security/index.md#organization-manager-osLogins-viewer) `organization-manager.osLogins.viewer`, назначенная на организацию. Информацию о других ролях, позволяющих просматривать список профилей {{ oslogin }}, см. в разделе [Управление доступом в {{ org-full-name }}](../../../organization/security/index.md#service-roles).
     
     {% endnote %}
  1. Получите список всех ВМ в каталоге по умолчанию:
     
     ```bash
     yc compute instance list
     ```
     
     Результат:
     
     ```text
     +----------------------+-----------------+---------------+---------+---------------+--------------+
     |          ID          |       NAME      |    ZONE ID    | STATUS  |  EXTERNAL IP  | INTERNAL IP  |
     +----------------------+-----------------+---------------+---------+---------------+--------------+
     | fhm0b28lgf********** | first-instance  | {{ region-id }}-a | RUNNING | 158.160.**.** | 192.168.0.8  |
     | fhm9gk85nj********** | second-instance | {{ region-id }}-a | RUNNING | 51.250.**.*** | 192.168.0.12 |
     +----------------------+-----------------+---------------+---------+---------------+--------------+
     ```
  1. Подключитесь к ВМ:
  
      ```bash
      yc compute ssh \
        --name <имя_ВМ>
        --login <логин_пользователя_или_сервисного_аккаунта>
        --internal-address
      ```
  
      Где:
      * `--name` — полученное ранее имя виртуальной машины. Вместо имени ВМ можно указать ее идентификатор, для этого используйте параметр `--id`.
      * `--login` — полученный ранее логин пользователя или сервисного аккаунта, заданный в профиле {{ oslogin }}. Необязательный параметр. Если параметр не задан, для подключения будет использован SSH-сертификат пользователя или сервисного аккаунта, авторизованного в текущий момент в профиле {{ yandex-cloud }} CLI.
      * `--internal-address` — для подключения по внутреннему IP-адресу. Необязательный параметр.
  
      Команду для подключения к ВМ вы также можете посмотреть в [консоли управления]({{ link-console-main }}) на странице **{{ ui-key.yacloud.compute.instance.overview.label_title }}** нужной ВМ в блоке **{{ ui-key.yacloud.compute.instance.overview.field_access }}**: раскройте секцию **{{ ui-key.yacloud.compute.instance.overview.label_cli-connect-card-title }}** и выберите вкладку **{{ ui-key.yacloud.compute.instance.overview.label_cert-connect-tab }}**.

{% endlist %}

Произойдет подключение к указанной виртуальной машине. Если это ваше первое подключение, в операционной системе ВМ будет создан новый профиль пользователя.

#### См. также {#see-also}

* [{#T}](../../../organization/operations/os-login-access.md)
* [{#T}](../../../organization/operations/add-ssh.md)
* [{#T}](os-login-export-certificate.md)
* [Подключиться к узлу {{ k8s }} через {{ oslogin }}](../../../managed-kubernetes/operations/node-connect-oslogin.md)
* [Использовать сервисный аккаунт с профилем {{ oslogin }} для управления ВМ с помощью Ansible](../../../tutorials/security/sa-oslogin-ansible.md)