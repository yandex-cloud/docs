[Документация Yandex Cloud](../../../index.md) > [Yandex Compute Cloud](../../index.md) > [Пошаговые инструкции](../index.md) > Работа на виртуальной машине > OS Login > Экспортировать SSH-сертификат

# Экспортировать SSH-сертификат

Чтобы пользователь или (с помощью [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md)) сторонний инструмент, такой как [Terraform](https://www.terraform.io/) или [Ansible](https://www.ansible.com/), мог подключиться по протоколу SSH к [виртуальным машинам Compute Cloud](../../concepts/vm.md#project), [хостам кластера Yandex Data Processing](../../../data-proc/operations/connect-oslogin.md) или [отдельным узлам в группе узлов Kubernetes](../../../managed-kubernetes/concepts/index.md#node-group) с включенным доступом по OS Login, можно использовать SSH-сертификат [пользователя организации](../../../organization/concepts/membership.md) или сервисного аккаунта. Для этого необходимо локально экспортировать SSH-сертификат и использовать его для доступа к ВМ или узлу Kubernetes с помощью стандартного SSH-клиента. Экспортированный сертификат действителен один час.

Чтобы экспортировать SSH-сертификат пользователя организации Yandex Identity Hub или [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md) на локальный компьютер:

{% list tabs group=instructions %}


- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для экспорта SSH-сертификата в локальную директорию:

      ```bash
      yc compute ssh certificate export --help
      ```
  1. Получите идентификатор организации, в которой находится нужный [профиль OS Login](../../../organization/concepts/os-login.md#os-login-profiles) пользователя или [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md):
     
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
  1. Получите список логинов в [профилях OS Login](../../../organization/concepts/os-login.md#os-login-profiles) пользователей и сервисных аккаунтов нужной организации, указав ее идентификатор:
     
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
     
     Минимально необходимая роль, позволяющая просматривать список профилей OS Login пользователей — [роль](../../../organization/security/index.md#organization-manager-osLogins-viewer) `organization-manager.osLogins.viewer`, назначенная на организацию. Информацию о других ролях, позволяющих просматривать список профилей OS Login, читайте в разделе [Управление доступом в Yandex Identity Hub](../../../organization/security/index.md#service-roles).
     
     {% endnote %}
  1. Экспортируйте сертификат:

      ```bash
      yc compute ssh certificate export \
          --login <логин_пользователя_или_сервисного_аккаунта> \
          --organization-id <идентификатор_организации> \
          --directory <путь_к_директории>
      ```

      Где:
      * `--login` — полученный ранее логин пользователя или сервисного аккаунта, заданный в профиле OS Login. Необязательный параметр. Если параметр не задан, SSH-сертификат будет выгружен для пользователя или сервисного аккаунта, авторизованного в текущий момент в профиле Yandex Cloud CLI.
      * `--organization-id` — полученный ранее [идентификатор](../../../organization/operations/organization-get-id.md) организации, из которой нужно экспортировать SSH-сертификат. Необязательный параметр. Если параметр не задан, сертификат будет выгружен из организации, к которой относится каталог по умолчанию.
      * `--directory` — путь к локальной директории, в которой будет сохранен экспортированный SSH-сертификат. Необязательный параметр. Если параметр не задан, сертификат будет по умолчанию сохранен в директории `.ssh` в домашней директории текущего пользователя компьютера (`~/.ssh/`).

      Результат:

      ```text
      Identity: /home/user1/.ssh/yc-cloud-id-b1gia87mbaom********-<логин_в_профиле_OS_Login>
      Certificate: /home/user1/.ssh/yc-cloud-id-b1gia87mbaom********-<логин_в_профиле_OS_Login>-cert.pub
      ```

      При сохранении экспортированного сертификата в директорию, отличную от директории по умолчанию, убедитесь что доступ к сохраненным файлам сертификата разрешен только текущему пользователю. При необходимости измените разрешения с помощью команды `chmod` в Linux и macOS или на вкладке **Безопасность** свойств файлов в Проводнике Windows.

{% endlist %}

С помощью экспортированного SSH-сертификата вы можете [подключиться](os-login.md#connect-with-ssh-client) к виртуальной машине Compute Cloud, кластеру Yandex Data Processing или узлу Kubernetes, для которых [настроен](../vm-control/vm-update.md#enable-oslogin-access) доступ по OS Login.

#### Полезные ссылки {#see-also}

* [Включить доступ по OS Login](../../../organization/operations/os-login-access.md)
* [Добавить SSH-ключ](../../../organization/operations/add-ssh.md)
* [Подключиться к виртуальной машине по OS Login](os-login.md)
* [Подключиться к узлу Kubernetes через OS Login](../../../managed-kubernetes/operations/node-connect-oslogin.md)
* [Подключиться к кластеру Yandex Data Processing через OS Login](../../../data-proc/operations/connect-oslogin.md)
* [Использовать сервисный аккаунт с профилем OS Login для управления ВМ с помощью Ansible](../../../tutorials/security/sa-oslogin-ansible.md)