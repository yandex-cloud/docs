# Использование сервисного аккаунта с профилем {{ oslogin }} для управления ВМ с помощью Ansible

Чтобы управлять [виртуальными машинами](../../compute/concepts/vm.md) с помощью [Ansible](https://www.ansible.com/), вы можете использовать [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), для которого создан [профиль {{ oslogin }}](../../organization/concepts/os-login.md#os-login-profiles) c SSH-ключом. Такая конфигурация позволит иметь отдельную учетную запись для управления ВМ через Ansible с возможностью отзыва SSH-ключа по времени или вручную. 

Кроме этого, такая конфигурация позволяет временно повышать привилегии этой учетной записи путем назначения сервисному аккаунту дополнительных [ролей](../../iam/concepts/access-control/roles.md). Например, для использования директивы `become` в задачах Ansible потребуется временно назначить сервисному аккаунту [роль](../../compute/security/index.md#compute-osadminlogin) `compute.osAdminLogin`.

Чтобы настроить сервисный аккаунт для управления ВМ с помощью Ansible:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте сервисный аккаунт с SSH-ключом в профиле {{ oslogin }}](#create-ssh-key).
1. [Настройте Ansible для работы от имени сервисного аккаунта](#configure-ansible).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Подготовьте окружение {#prepare}

1. {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. [Создайте](../../compute/operations/vm-create/create-linux-vm.md) виртуальную машину из публичного образа с включенным доступом по {{ oslogin }}, например, [Ubuntu 22.04 LTS OS Login](/marketplace/products/yc/ubuntu-2204-lts-oslogin).
1. В настройках вашей организации [включите](../../organization/operations/os-login-access.md) доступ по {{ oslogin }} при помощи SSH-ключей.
1. [Установите](https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html) Ansible.

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки создаваемой в руководстве инфраструктуры входят:
* плата за постоянно запущенную виртуальную машину (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за использование публичного IP-адреса (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).

## Создайте сервисный аккаунт с SSH-ключом в профиле {{ oslogin }} {#create-ssh-key}

1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт `my-ansible-sa` и [назначьте](../../iam/operations/sa/assign-role-for-sa) ему [роль](../../compute/security/index.md#compute-oslogin) `compute.osLogin`.
1. Создайте пару [SSH-ключей](../../glossary/ssh-keygen.md) типа `ed25519`, которые сервисный аккаунт будет использовать для подключения к виртуальным машинам:

    ```bash
    ssh-keygen \
      -t ed25519 \
      -f <путь>/id_yc-sa-my-ansible-sa
    ```
    
    Где: `-f` — имя создаваемого SSH-ключа и путь к директории, в которую будут сохранены файлы с закрытой и открытой частями ключа. Например, `-f /home/user/ansible-key/id_yc-sa-my-ansible-sa`.

    В результате в заданной директории будут созданы 2 файла SSH-ключа: `id_yc-sa-my-ansible-sa` и `id_yc-sa-my-ansible-sa.pub`.

1. Добавьте созданный SSH-ключ в профиль {{ oslogin }} сервисного аккаунта `my-ansible-sa`:
    {% note warning %}

    Убедитесь что версия yc >= 0.121.0    

    {% endnote %}

    {% list tabs group=instructions %}

    - CLI {#cli}

      ```bash
      yc organization-manager oslogin user-ssh-key create \
        --name <имя_ключа> \
        --organization-id <идентификатор_организации> \
        --subject-id <идентификатор_сервисного_аккаунта> \
        --data "<публичный_SSH-ключ>" \
        --expires-at <срок_действия_ключа>

      ```
      Где:
      * `--name` — имя загружаемого ключа, например, `ssh-my-ansible-sa`.
      * `--organization-id` — [идентификатор](../../organization/operations/organization-get-id.md) организации, к которой относится сервисный аккаунт `my-ansible-sa`.
      * `--subject-id` — [идентификатор](../../iam/operations/sa/get-id.md) сервисного аккаунта, в профиль которого добавляется SSH-ключ.
      * `--data` — содержимое файла с публичной частью SSH-ключа (`id_yc-sa-my-ansible-sa.pub`).
      * `--expires-at` — срок действия загружаемого ключа. Необязательный параметр. Если параметр не задан, у ключа будет неограниченный срок действия.

          Значение может задаваться в двух форматах:
          * дата окончания действия ключа в формате [ISO 8601](https://ru.wikipedia.org/wiki/ISO_8601), например, `YYYY-MM-DDT00:00:00Z`;
          * срок действия ключа в часах и минутах, например `1h` или `3h30m`.

      Результат:

      ```text
      id: bpfejaidgt9u********
      subject_id: ajeqdl8mdv12********
      data: ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOra4Rg9OpwS5cozMHDGpdp6ug/jYUnWtTFD********
      name: ssh-my-ansible-sa
      fingerprint: SHA256:gkEtFdaTmT7PK4/fCrZqnSjFDBsvLeNfkAR********
      organization_id: bpfaidqca8vd********
      created_at: "2024-06-21T10:10:11.946355750Z"
      expires_at: "2024-06-21T20:10:11.380653492Z"
      ```

      Подробнее о команде `yc organization-manager oslogin user-ssh-key create` читайте в [справочнике CLI](../../cli/cli-ref/managed-services/organization-manager/oslogin/user-ssh-key/create.md).

    {% endlist %}

    {% note tip %}
    
    В целях безопасности рекомендуется периодически ротировать SSH-ключи. Использовать SSH-ключ с неограниченным сроком действия небезопасно.

    {% endnote %}

1. Проверьте возможность входа на ВМ с помощью профиля {{ oslogin }} сервисного аккаунта:

    ```bash
    ssh yc-sa-my-ansible-sa@<IP-адрес_ВМ> -i <путь_к_закрытому_SSH-ключу>
    ```
 
    Где:
    * `<IP-адрес_ВМ>` — [публичный IP-адрес](../../vpc/concepts/address.md#public-addresses) виртуальной машины с включенным доступом по {{ oslogin }}.
    * `<путь_к_закрытому_SSH-ключу>` — путь к файлу, содержащему закрытую часть созданного ранее SSH-ключа. Например, `/home/user/ansible-key/id_yc-sa-my-ansible-sa`.

## Настройте Ansible для работы от имени сервисного аккаунта {#configure-ansible}

Убедитесь, что Ansible может подключаться к виртуальной машине от имени созданного сервисного аккаунта. Для этого создайте Inventory-файл и проверьте его с помощью Ansible-модуля `ansible.builtin.ping`: 

1. Создайте файл `inventory.ini` с группой `yc` :

    ```ini
    [yc:vars]
    ansible_connection=ssh
    ansible_user=yc-sa-my-ansible-sa
    ansible_ssh_private_key_file=<путь_к_закрытому_SSH-ключу>

    [yc]
    <IP-адрес_ВМ>
    ```
    Где:
    * `<путь_к_закрытому_SSH-ключу>` — путь к файлу, содержащему закрытую часть созданного ранее SSH-ключа. Например, `/home/user/ansible-key/id_yc-sa-my-ansible-sa`.
    * `<IP-адрес_ВМ>` — публичный IP-адрес виртуальной машины с включенным доступом по {{ oslogin }}.

1. Запустите Ansible с модулем `ansible.builtin.ping`:

    ```bash
    ansible -i inventory.ini -m ping yc
    ```

    Результат:
    ```text
    158.160.**.*** | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
    }
    ```

Соединение с ВМ установлено. Теперь вы можете управлять виртуальными машинами с помощью Ansible от имени сервисного аккаунта с профилем {{ oslogin }} и SSH-ключом, ограниченным по времени действия.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
1. [Удалите](../../compute/operations/vm-control/vm-delete.md) виртуальную машину.
1. При необходимости [удалите](../../iam/operations/sa/delete.md) сервисный аккаунт.
