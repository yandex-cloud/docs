# Начало работы с серийной консолью


Серийная консоль — это способ получить доступ к [виртуальной машине](../../concepts/vm.md) вне зависимости от состояния [сети](../../../vpc/concepts/network.md#network) или операционной системы. Таким образом, вы можете использовать консоль, например, для устранения неисправностей ВМ или при возникновении проблем с доступом через [SSH](../../../glossary/ssh-keygen.md).

Для работы с серийной консолью необходима [роль](../../security/index.md) `сompute.admin` или `editor`.

По умолчанию доступ к серийной консоли отключен.

{% note warning %}

Оцените риск включения доступа через серийную консоль, учитывая следующие факторы:

* ВМ будет доступна для управления из интернета даже в случае отсутствия внешнего IP-адреса. 
  Получить доступ к серийной консоли ВМ из консоли управления Yandex Cloud сможет пользователь, успешно аутентифицированный в консоли управления Yandex Cloud при наличии должных прав на ВМ. Доступ к серийной консоли ВМ из клиентского приложения [SSH](../vm-connect/ssh.md) (например, Putty) или [CLI](../../../cli/index.md) также возможен путем аутентификации через SSH-ключ. В связи с этим необходимо тщательно контролировать SSH-ключ и завершать веб-сессию для снижения рисков ее перехвата.

* Сессия будет доступна одновременно всем пользователям, имеющим право доступа к серийной консоли.
  Действия одного пользователя будут видны другим пользователям, если в это время они смотрят вывод серийной консоли.

* Незавершенная сессия может быть использована другим пользователем.

Мы рекомендуем включать серийную консоль только в случае крайней необходимости, выдавать такой доступ узкому кругу лиц и использовать стойкие пароли для доступа к ВМ.

Не забывайте [отключать доступ](disable.md) после работы с серийной консолью.

{% endnote %}

## Перед началом работы {#before-you-begin}

Перед тем, как включить доступ к серийной консоли на ВМ:
1. Подготовьте пару ключей (открытый и закрытый) для SSH-доступа на ВМ. Серийная консоль аутентифицирует пользователей с помощью SSH-ключей.
1. Создайте текстовый файл (например, `sshkeys.txt`) и укажите следующие данные:

   ```txt
   <имя_пользователя>:<открытый_SSH-ключ_пользователя>
   ```

   Пример текстового файла для пользователя `yc-user`:

   ```txt
   yc-user:ssh-ed25519 AAAAB3Nza......OjbSMRX yc-user@example.com
   ```

   По умолчанию пользовательские SSH-ключи хранятся в каталоге `~/.ssh` этого пользователя. Получить открытый ключ можно с помощью команды `cat ~/.ssh/<имя_открытого_ключа>.pub`.

## Включение консоли при создании ВМ из публичного образа {#turn-on-for-new-instance}

Чтобы включить доступ к серийной консоли при создании ВМ, установите в [метаданных](../../concepts/vm-metadata.md) параметр `serial-port-enable` в значение `1`.

Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

{% list tabs group=operating_system %}

- Linux {#linux}

  1. Посмотрите описание команды CLI для создания ВМ:

     ```bash
     yc compute instance create --help
     ```

  1. Выберите один из публичных [образов](../../concepts/image.md) на базе ОС Linux (например, Ubuntu).

     Чтобы получить список доступных образов с помощью CLI, выполните команду:
     
     ```bash
     yc compute image list --folder-id standard-images
     ```
     
     Результат:
     
     ```text
     +----------------------+-------------------------------------+--------------------------+----------------------+--------+
     |          ID          |                NAME                 |          FAMILY          |     PRODUCT IDS      | STATUS |
     +----------------------+-------------------------------------+--------------------------+----------------------+--------+
     ...
     | fdvk34al8k5n******** | centos-7-1549279494                 | centos-7                 | dqni65lfhvv2******** | READY  |
     | fdv7ooobjfl3******** | windows-2016-gvlk-1548913814        | windows-2016-gvlk        | dqnnc72gj2is******** | READY  |
     | fdv4f5kv5cvf******** | ubuntu-1604-lts-1549457823          | ubuntu-1604-lts          | dqnnb6dc7640******** | READY  |
     ...
     +----------------------+-------------------------------------+--------------------------+----------------------+--------+
     ```
     
     Где:
     
     * `ID` — идентификатор образа.
     * `NAME` — имя образа.
     * `FAMILY` — идентификатор [семейства образов](../../concepts/image.md#family), к которому относится образ.
     * `PRODUCT IDS` — идентификаторы [продуктов](../../../marketplace/concepts/product.md) Yandex Cloud Marketplace, связанных с образом.
     * `STATUS` — текущий статус образа. Может принимать одно из значений:
     
         * `STATUS_UNSPECIFIED` — статус образа не определен.
         * `CREATING` — образ в процессе создания.
         * `READY` — образ готов к использованию.
         * `ERROR` — образ нельзя использовать из-за возникшей с ним проблемы.
         * `DELETING` — образ в процессе удаления.

  1. Создайте ВМ в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

     ```bash
     yc compute instance create \
       --name first-instance \
       --zone ru-central1-a \
       --network-interface subnet-name=default-a,nat-ip-version=ipv4 \
       --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts \
       --metadata-from-file ssh-keys=sshkeys.txt \
       --metadata serial-port-enable=1
     ```

     Команда создаст ВМ:
     * С OC [Ubuntu](https://yandex.cloud/ru/marketplace?tab=software&search=Ubuntu&categories=os).
     * С именем `first-instance`.
     * В [зоне доступности](../../../overview/concepts/geo-scope.md) `ru-central1-a`.
     * С активной серийной консолью.

     В ОС ВМ будет автоматически создан пользователь `yc-user` с указанным открытым ключом.

{% endlist %}

## Включение консоли при изменении ВМ {#turn-on-for-current-instance}

Чтобы включить доступ к серийной консоли при изменении ВМ, установите в метаданных параметр `serial-port-enable` в значение `1`.
1. Получите список ВМ в каталоге по умолчанию:

   ```bash
   yc compute instance list
   ```
   
   Результат:
   ```text
   +----------------------+-----------------+---------------+---------+----------------------+
   |          ID          |       NAME      |    ZONE ID    | STATUS  |     DESCRIPTION      |
   +----------------------+-----------------+---------------+---------+----------------------+
   | fhm0b28lgfp4******** | first-instance  | ru-central1-a | RUNNING | my first vm via CLI  |
   | fhm9gk85nj7g******** | second-instance | ru-central1-a | RUNNING | my second vm via CLI |
   +----------------------+-----------------+---------------+---------+----------------------+
   ```

1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной ВМ, например `first-instance`.

1. Установите в метаданных ВМ параметр `serial-port-enable=1`:

   ```bash
   yc compute instance add-metadata \
     --name first-instance \
     --metadata-from-file ssh-keys=sshkeys.txt \
     --metadata serial-port-enable=1
   ```

   Команда запустит операцию активации серийной консоли на ВМ с именем `first-instance`.

## Настройка ВМ для доступа через серийный порт {#configuration}

Для настройки доступа через серийную консоль у ВМ должен быть [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses). Вы можете посмотреть адрес в [консоли управления](https://console.yandex.cloud) в разделе **Compute Cloud** на странице **Виртуальные машины**. Если вы создали ВМ без публичного IP-адреса, вы можете [привязать его](../vm-control/vm-attach-public-ip.md). После настройки адрес можно отвязать, для подключения через серийную консоль он не нужен.

Чтобы серийная консоль была доступна со стороны ОС, ОС должна быть настроена соответствующим образом.

### Linux {#linux-configuration}

Чтобы подключаться к серийной консоли Linux, убедитесь, что [отключена парольная аутентификация для SSH](#ssh-pass-off), и при необходимости [задайте пароль](#create-pass) для нужного пользователя ОС.

#### Отключите SSH-аутентификацию по паролю {#ssh-pass-off}

{% note info %}

В публичных образах Linux, предоставляемых Yandex Cloud, возможность подключения по протоколу SSH с использованием логина и пароля по умолчанию отключена.

{% endnote %}

Если вы используете собственный образ, убедитесь, что доступ по SSH с использованием логина и пароля отключен.

Чтобы отключить парольную аутентификацию по SSH:
1. Откройте файл конфигурации SSH-сервера, по умолчанию `/etc/ssh/sshd_config`. Файл доступен для чтения и редактирования только суперпользователю.
1. Задайте для опции `PasswordAuthentication` значение `no`.
1. Перезапустите SSH-сервер:

   ```bash
   sudo systemctl restart ssh*
   ```

#### Создайте пароль для пользователя Linux {#create-pass}

Некоторые ОС могут запрашивать данные пользователя для доступа на ВМ. Поэтому перед подключением к таким ВМ необходимо создать локальный пароль для пользователя по умолчанию.

Чтобы создать локальный пароль, используйте CLI.
1. Получите список ВМ в каталоге по умолчанию:

   ```bash
   yc compute instance list
   ```
   
   Результат:
   ```text
   +----------------------+-----------------+---------------+---------+----------------------+
   |          ID          |       NAME      |    ZONE ID    | STATUS  |     DESCRIPTION      |
   +----------------------+-----------------+---------------+---------+----------------------+
   | fhm0b28lgfp4******** | first-instance  | ru-central1-a | RUNNING | my first vm via CLI  |
   | fhm9gk85nj7g******** | second-instance | ru-central1-a | RUNNING | my second vm via CLI |
   +----------------------+-----------------+---------------+---------+----------------------+
   ```

1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной ВМ, например `first-instance`.
1. Получите публичный IP-адрес ВМ.

   ```bash
   yc compute instance get first-instance
   ```

   В выводе команды найдите адрес ВМ в блоке `one_to_one_nat`:

   ```bash
   ...
   one_to_one_nat:
     address: <публичный_IP-адрес>
     ip_version: IPV4
   ...
   ```

1. Подключитесь к ВМ. Подробнее читайте в разделе [Подключение к ВМ](../vm-connect/ssh.md#vm-connect).
1. Создайте локальный пароль. В OC Linux задать пароль можно с помощью команды `passwd`:

   ```bash
   sudo passwd <имя_пользователя>
   ```

   Пример для пользователя `yc-user`:

   ```bash
   sudo passwd yc-user
   ```

1. Завершите SSH-сессию с помощью команды `exit`.

#### Включите нужный способ авторизации {#ssh-authorization}

{% list tabs %}

- SSH-ключ

  Укажите имя ВМ и включите авторизацию по метаданным при подключении к серийной консоли:
  
  ```bash
  yc compute instance update \
    --name <имя_ВМ> \
    --serial-port-settings ssh-authorization=INSTANCE_METADATA
  ```
  
  Результат:
  
  ```yaml
  done (6s)
  id: fhm0b28lgfp4********
  folder_id: b1g9d2k0itu4********
  created_at: "2024-03-28T19:53:23Z"
  name: first-instance
  zone_id: ru-central1-a
  platform_id: standard-v3
  resources:
    memory: "1073741824"
    cores: "2"
    core_fraction: "20"
  status: RUNNING
  metadata_options:
    gce_http_endpoint: ENABLED
    aws_v1_http_endpoint: ENABLED
    gce_http_token: ENABLED
    aws_v1_http_token: DISABLED
  boot_disk:
    mode: READ_WRITE
    device_name: epdu3ce920e7********
    auto_delete: true
    disk_id: epdu3ce920e7********
  network_interfaces:
    - index: "0"
      mac_address: d0:0d:5c:**:**:**
      subnet_id: e2luhnr3rhf8********
      primary_v4_address:
        address: 192.168.1.21
        one_to_one_nat:
          address: 51.250.***.***
          ip_version: IPV4
      security_group_ids:
        - enpjauvetqfb********
  serial_port_settings:
    ssh_authorization: INSTANCE_METADATA
  gpu_settings: {}
  fqdn: sample-vm.ru-central1.internal
  scheduling_policy:
    preemptible: true
  network_settings:
    type: STANDARD
  placement_policy: {}
  hardware_generation:
    legacy_features:
      pci_topology: PCI_TOPOLOGY_V1
  ```
  
  Если на уровне организации [включен](../../../organization/operations/os-login-access.md) доступ по OS Login, то для новых ВМ, создаваемых в этой организации, полю `serial_port_settings.ssh_authorization` по умолчанию будет присваиваться значение `OS_LOGIN`. Если доступ по OS Login выключен, этому полю по умолчанию будет присваиваться значение `INSTANCE_METADATA`.

- OS Login

  Включите для ВМ авторизацию по OS Login при подключении к серийной консоли, указав имя ВМ:
  
  ```bash
  yc compute instance update \
    --name <имя_ВМ> \
    --serial-port-settings ssh-authorization=OS_LOGIN
  ```
  
  Результат:
  
  ```yaml
  done (6s)
  id: fhm0b28lgfp4********
  folder_id: b1g9d2k0itu4********
  created_at: "2024-03-28T19:53:23Z"
  name: first-instance
  zone_id: ru-central1-a
  platform_id: standard-v3
  resources:
    memory: "1073741824"
    cores: "2"
    core_fraction: "20"
  status: RUNNING
  metadata_options:
    gce_http_endpoint: ENABLED
    aws_v1_http_endpoint: ENABLED
    gce_http_token: ENABLED
    aws_v1_http_token: DISABLED
  boot_disk:
    mode: READ_WRITE
    device_name: epdu3ce920e7********
    auto_delete: true
    disk_id: epdu3ce920e7********
  network_interfaces:
    - index: "0"
      mac_address: d0:0d:5c:**:**:**
      subnet_id: e2luhnr3rhf8********
      primary_v4_address:
        address: 192.168.1.21
        one_to_one_nat:
          address: 51.250.***.***
          ip_version: IPV4
      security_group_ids:
        - enpjauvetqfb********
  serial_port_settings:
    ssh_authorization: OS_LOGIN
  gpu_settings: {}
  fqdn: sample-vm.ru-central1.internal
  scheduling_policy:
    preemptible: true
  network_settings:
    type: STANDARD
  placement_policy: {}
  hardware_generation:
    legacy_features:
      pci_topology: PCI_TOPOLOGY_V1
  ```
  
  {% note info %}
  
  Если на уровне организации [включен](../../../organization/operations/os-login-access.md) доступ по OS Login, то для новых ВМ, создаваемых в этой организации, полю `serial_port_settings.ssh_authorization` по умолчанию будет присваиваться значение `OS_LOGIN`. Если доступ по OS Login выключен, этому полю по умолчанию будет присваиваться значение `INSTANCE_METADATA`.
  
  {% endnote %}

{% endlist %}