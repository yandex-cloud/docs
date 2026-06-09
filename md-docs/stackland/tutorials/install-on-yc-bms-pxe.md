# Установка {{ stackland-name }} на {{ baremetal-full-name }} через PXE

В этом руководстве описана установка {{ stackland-full-name }} на серверы {{ baremetal-full-name }} с помощью сетевой загрузки PXE. При такой установке серверы загружают установочную среду по сети, поэтому не нужно вручную подключать ISO-образ к каждому серверу через KVM-консоль.

Общие требования к ресурсам кластера, DNS, дискам и сетевым диапазонам описаны в [Руководстве по установке](../quickstart.md). Базовый сценарий подготовки серверов {{ baremetal-name }} описан в руководстве [Установка {{ stackland-name }} на {{ baremetal-full-name }}](install-on-yc-bms.md). В этой инструкции приведены отличия для установки через PXE.

## Введение {#introduction}

Для установки через PXE потребуется:

* один бастионный сервер на Ubuntu 22.04 или выше. На нем запускается `sladm`, DHCP-сервер и TFTP-сервер для сетевой загрузки;
* не менее трех серверов для будущего кластера {{ stackland-name }}, подключенных к той же приватной сети, что и бастион;
* архив с PXE-файлами `stackland-pxe-amd64-<version>.zip`;
* утилита `sladm`, версия которой поддерживает параметры установки `--dhcp-interface` и `--pxe-folder`;
* файл `key.json`, предоставленный вместе с поставкой {{ stackland-name }} для доступа к необходимым компонентам и генерации секретов;
* конфигурация кластера со статическими IP-адресами и MAC-адресами сетевых интерфейсов всех узлов.

{% note warning %}

Не запускайте другие DHCP-серверы в приватной подсети для PXE-загрузки. Не включайте DHCP при создании приватной подсети {{ baremetal-name }}.

{% endnote %}

В примерах ниже используется подсеть `192.168.22.0/24`. Бастиону назначен адрес `192.168.22.1`, узлам кластера — адреса `192.168.22.2`, `192.168.22.3` и `192.168.22.4`. Замените эти значения на адреса из вашей инфраструктуры.

## Подготовьте приватную подсеть {#create-private-subnet}

Создайте приватную подсеть для бастиона и серверов кластера, как описано в [базовом руководстве](install-on-yc-bms.md#create-private-subnet), но не включайте автоматическое назначение адресов по DHCP.

При создании подсети укажите:

* CIDR приватной подсети, например `192.168.22.0/24`;
* отключенное назначение IP-адресов по DHCP.

Задайте статические адреса для узлов кластера в конфигурации {{ stackland-name }}. Во время установки `sladm` выдаст эти адреса узлам с помощью встроенного DHCP-сервера.

## Арендуйте серверы {#lease-servers}

Арендуйте серверы {{ baremetal-name }} так же, как в [базовом сценарии](install-on-yc-bms.md#lease-servers):

1. Арендуйте бастионный сервер.

   При создании сервера:

   * выберите Ubuntu 24.04;
   * подключите сервер к приватной подсети, созданной на предыдущем шаге;
   * выделите серверу публичный адрес для доступа по SSH;
   * задайте пароль пользователя `root` и добавьте SSH-ключ.

1. Арендуйте не менее трех серверов для будущего кластера {{ stackland-name }}.

   При создании каждого сервера:

   * выберите опцию **Без операционной системы**;
   * подключите сервер к той же приватной подсети;
   * выберите опцию **Без адреса** для публичного адреса.

После аренды серверов запишите MAC-адрес сетевого интерфейса каждого сервера кластера. Он указан на странице сервера в поле **Приватная сеть** → **MAC-адрес**. Эти значения потребуются в конфигурации `StacklandHostsList`.

## Настройте бастион {#configure-bastion}

Настройте на бастионе VPN, маршрутизацию, DNS и NTP, как описано в разделах [Настройка сетевых доступов](install-on-yc-bms.md#net-settings) и [Установка дополнительных сервисов](install-on-yc-bms.md#additional-services).

Если на приватном интерфейсе бастиона нет IP-адреса из подсети серверов кластера, настройте его вручную и сохраните настройку в конфигурации сети ОС.

Для Ubuntu с `netplan` добавьте приватный адрес в конфигурацию соответствующего интерфейса. В примере ниже приватный интерфейс называется `eth1`:

```yaml
network:
  version: 2
  ethernets:
    eth1:
      addresses:
        - 192.168.22.1/24
      dhcp4: false
```

Примените конфигурацию и проверьте адрес:

```bash
sudo netplan apply
ip -brief addr show eth1
```

Замените `eth1` и `192.168.22.1/24` на имя интерфейса и адрес из вашей инфраструктуры.

Для подготовки PXE-файлов и настройки прав для `sladm` установите на бастионе дополнительные утилиты:

```bash
sudo apt install wget unzip libcap2-bin -y
```

Разрешите на бастионе входящий трафик для DHCP и TFTP из приватной подсети. Если используется `ufw`, выполните:

```bash
sudo ufw allow from 192.168.22.0/24 to any port 67 proto udp
sudo ufw allow from 192.168.22.0/24 to any port 69 proto udp
sudo ufw allow from 192.168.22.0/24 to any port 53 proto udp
sudo ufw allow from 192.168.22.0/24 to any port 123 proto udp
```

Замените `192.168.22.0/24` на CIDR вашей приватной подсети. Порты 53 и 123 нужны, если DNS и NTP для узлов кластера также работают на бастионе.

Проверьте, что на бастионе включена IPv4-маршрутизация и настроен NAT для приватной подсети, как описано в [базовом руководстве](install-on-yc-bms.md#net-settings):

```bash
sysctl net.ipv4.ip_forward
sudo iptables -t nat -S POSTROUTING
```

## Скачайте и распакуйте PXE-файлы {#prepare-pxe-files}

Скачайте архив `stackland-pxe-amd64-<version>.zip` по ссылке, предоставленной вместе с поставкой {{ stackland-name }}, и распакуйте его на бастионе:

```bash
unzip stackland-pxe-amd64-<version>.zip
ls -lh pxe/
```

Если вместе с архивом предоставлена контрольная сумма, проверьте ее перед распаковкой:

```bash
sha256sum -c stackland-pxe-amd64-<version>.zip.sha256
```

В папке `pxe/` должны быть файлы:

* `ipxe.pxe` — загрузчик iPXE для BIOS;
* `ipxe.efi` — загрузчик iPXE для UEFI;
* `vmlinuz` — ядро Linux;
* `initramfs.xz` — initial ramdisk.

Скачайте и установите `sladm`, как описано в разделе [Скачивание необходимых файлов](../quickstart.md#download-files).

Проверьте, что установленная версия `sladm` поддерживает установку через PXE:

```bash
sladm install --help | grep -E 'dhcp-interface|pxe-folder'
```

После подготовки файлов на бастионе рекомендуется держать установочные артефакты в одной рабочей папке:

```text
yc-bms-pxe/
├── sladm
├── key.json
├── stackland-pxe-amd64-<version>.zip
├── pxe/
│   ├── initramfs.xz
│   ├── ipxe.efi
│   ├── ipxe.pxe
│   └── vmlinuz
└── config/
    ├── cluster.yaml
    ├── hosts.yaml
    └── secrets.yaml
```

Файл `secrets.yaml` появится после выполнения `sladm secrets add`, как описано ниже.

## Настройте DNS {#dns}

Настройте DNS-зону кластера и зону с именами узлов, как описано в разделе [Настройка DNS](install-on-yc-bms.md#dns).

В примере из этой инструкции именам узлов соответствуют следующие адреса:

* `node1.baremetal.internal` — `192.168.22.2`;
* `node2.baremetal.internal` — `192.168.22.3`;
* `node3.baremetal.internal` — `192.168.22.4`.

## Подготовьте конфигурацию кластера {#configuration}

Создайте папку `config/` и подготовьте конфигурационные файлы. Общий формат описан в разделе [Начальная конфигурация](../quickstart.md#configuration).

Для установки через PXE в конфигурации каждого узла должны быть указаны:

* MAC-адрес сетевого интерфейса, по которому узел загружается по PXE;
* статический IP-адрес этого интерфейса в формате CIDR.

Перед созданием `StacklandHostsList` подготовьте таблицу соответствия серверов, интерфейсов и адресов:

| Сервер | FQDN | MAC-адрес приватного PXE-интерфейса | Статический IP | Роль | Диск для установки |
| --- | --- | --- | --- | --- | --- |
| `node1` | `node1.baremetal.internal` | `06:2a:b7:15:de:f1` | `192.168.22.2/24` | `combined` | `/dev/sda` |
| `node2` | `node2.baremetal.internal` | `0e:9d:6b:fc:42:88` | `192.168.22.3/24` | `combined` | `/dev/sda` |
| `node3` | `node3.baremetal.internal` | `02:5e:c3:a8:07:d9` | `192.168.22.4/24` | `combined` | `/dev/sda` |

MAC-адрес должен принадлежать именно приватному интерфейсу, через который сервер загружается по PXE. Если в KVM-консоли доступно несколько вариантов сетевой загрузки, выбирайте интерфейс с этим MAC-адресом.

{% note warning %}

Не используйте `dhcp: true` для интерфейсов, по которым выполняется PXE-загрузка. Встроенный DHCP-сервер `sladm` выдает только статические адреса, указанные в конфигурации.

{% endnote %}

Пример конфигурации для кластера из трех узлов с ролью `combined`:

```yaml
apiVersion: v1alpha1
kind: StacklandClusterConfig
metadata:
  name: main
spec:
  platform:
    type: "baremetal"
    loadBalancer:
      type: "cilium-l2"
      ipPools:
        - cidrs:
          - 192.168.22.128/25

  cluster:
    baseDomain: "stackland.internal"

    networking:
      hostsNetwork:
        - cidr: 192.168.22.0/25
      clusterNetwork:
        - cidr: 172.16.0.0/16
      servicesNetwork:
        - cidr: 10.96.0.0/12
      virtualIPs:
        api: 192.168.22.127

    storage:
      defaultStorageClass: "stackland-ssd"

  genericHostConfig:
    disksConfig:
      - installDisk:
          name: "/dev/sda"
    networkConfig:
      routes:
        - to: "0.0.0.0/0"
          via: "192.168.22.1"
          iface: "eth0"
      resolvers:
        - "192.168.22.1"
      timeservers:
        - "192.168.22.1"

---
apiVersion: v1alpha1
kind: StacklandHostsList
metadata:
  name: main
spec:
  hosts:
    - hostname: "node1.baremetal.internal"
      role: "combined"
      networkConfig:
        interfaces:
          - macaddress: "06:2a:b7:15:de:f1"
            name: "eth0"
        addresses:
          - interface: "eth0"
            ip: "192.168.22.2/24"

    - hostname: "node2.baremetal.internal"
      role: "combined"
      networkConfig:
        interfaces:
          - macaddress: "0e:9d:6b:fc:42:88"
            name: "eth0"
        addresses:
          - interface: "eth0"
            ip: "192.168.22.3/24"

    - hostname: "node3.baremetal.internal"
      role: "combined"
      networkConfig:
        interfaces:
          - macaddress: "02:5e:c3:a8:07:d9"
            name: "eth0"
        addresses:
          - interface: "eth0"
            ip: "192.168.22.4/24"
```

Сохраните конфигурацию в папке `config/` и создайте файл секретов:

```bash
sladm secrets add --out config/secrets.yaml --license-key key.json
chmod 600 key.json config/secrets.yaml
```

Подробнее о подготовке секретов в разделе [Подготовка секретов](../quickstart.md#prepare-secrets).

## Запустите установку с PXE {#start-installation}

Запустите установку на бастионе:

```bash
sladm install \
  --config config/ \
  --dhcp-interface <interface_name> \
  --pxe-folder ./pxe \
  --installation-timeout 3h
```

Параметры команды:

* `--config` — путь к папке с конфигурационными файлами;
* `--dhcp-interface` — сетевой интерфейс бастиона, подключенный к приватной подсети серверов кластера;
* `--pxe-folder` — путь к папке с PXE-файлами;
* `--installation-timeout` — таймаут установки. Для PXE-установки на серверах {{ baremetal-name }} рекомендуется увеличить значение, так как выбор загрузочного устройства через KVM может занять дополнительное время.

Например, если приватный интерфейс бастиона называется `eth1`, команда будет такой:

```bash
sladm install \
  --config config/ \
  --dhcp-interface eth1 \
  --pxe-folder ./pxe \
  --installation-timeout 3h
```

После запуска `sladm` ожидает, пока узлы загрузятся по сети и подключатся к установочному процессу.

Если предварительные проверки завершаются ошибкой из-за того, что узлы еще не загрузились в установочную среду, устраните найденные проблемы или перезапустите установку с параметром `--ignore-checks`, как описано в разделе [Установка кластера](../quickstart.md#installation-online).

## Загрузите серверы по сети {#boot-servers}

Для каждого сервера кластера выполните действия:

1. Подключитесь к [KVM-консоли](../../baremetal/operations/servers/server-kvm.md).
1. Откройте меню выбора загрузочного устройства.
1. Выберите загрузку по сети: **Network Boot**, **PXE Boot** или **UEFI PXE IPv4** для приватного интерфейса, MAC-адрес которого указан в `StacklandHostsList`.
1. Дождитесь загрузки установочной среды {{ stackland-name }}.

Если сервер открывает UEFI Shell, выполните `exit`, вернитесь в меню загрузки и выберите сетевую загрузку. Не выбирайте пункт UEFI Shell в качестве первого загрузочного устройства. Если доступны варианты IPv4 и IPv6, выберите IPv4.

После сетевой загрузки сервер получит IP-адрес от встроенного DHCP-сервера `sladm` и загрузит установочную среду через TFTP. Дальнейший процесс установки выполняется автоматически.

В логах `sladm` можно увидеть получение DHCP-запросов и передачу файлов по TFTP. Например:

```text
INFO  DHCP: Received request  {"mac": "06:2a:b7:15:de:f1", "message_type": "DISCOVER"}
INFO  DHCP: Processing request from known MAC  {"mac": "06:2a:b7:15:de:f1", "hostname": "node1", "ip": "192.168.22.2"}
INFO  TFTP read request  {"client": "192.168.22.2:49152", "filename": "ipxe.efi"}
INFO  TFTP transfer completed  {"client": "192.168.22.2:49152", "filename": "ipxe.efi"}
```

После установки узел будет загружаться с локального диска.

Ожидаемые этапы в логах `sladm`:

1. DHCP-запрос от известного MAC-адреса.
1. Загрузка `boot.ipxe`, `vmlinuz` и `initramfs.xz` через TFTP.
1. Доступность Talos API на адресе узла и порту 50000.
1. Доступность Kubernetes API на виртуальном IP-адресе и порту 6443.
1. Готовность платформенных компонентов {{ stackland-name }}.

Установка считается завершенной, когда `sladm` вывел сообщение об успешном завершении reconcile-цикла и сохранил kubeconfig администратора. Если установка прервалась после загрузки узлов или во время настройки платформенных компонентов, запустите `sladm install` повторно с тем же файлом конфигурации. Инсталлятор продолжит процесс с уже выполненных этапов.

Если узлы уже установлены, загрузились с локальных дисков и доступны по Talos API, повторный запуск не требует PXE-загрузки. В этом случае можно не указывать `--pxe-folder`, а DHCP-сервер `sladm` отключить:

```bash
sladm install \
  --config config/ \
  --dhcp-interface none \
  --installation-timeout 3h
```

Если ваша версия `sladm` не поддерживает значение `none` для `--dhcp-interface`, повторите исходную команду с `--dhcp-interface` и `--pxe-folder`. Перед повторным запуском убедитесь, что UDP-порты 67 и 69 свободны или используются только текущим процессом `sladm`.

## Проверьте установку {#verification}

Проверка кластера не отличается от базового сценария. Выполните действия из разделов:

* [Проверка работы кластера](../quickstart.md#verification);
* [Проверка работы кластера и дальнейшие шаги](install-on-yc-bms.md#final-check).

Дополнительно проверьте, что все узлы и платформенные компоненты готовы:

```bash
kubectl get nodes
kubectl get componentinstallations.stackland.yandex.cloud
kubectl get pods -A --field-selector=status.phase!=Running,status.phase!=Succeeded
```

В успешной установке:

* все узлы находятся в состоянии `Ready`;
* все `ComponentInstallation` находятся в фазе `Ready`;
* команда поиска подов не возвращает ресурсы.

Проверьте предупреждения в событиях Kubernetes:

```bash
kubectl get events -A --field-selector type=Warning --sort-by=.lastTimestamp
```

Старые события Kubernetes могут оставаться после уже исправленной проблемы. Не удаляйте их до завершения диагностики. Если `sladm install` завершился успешно, все компоненты готовы и предупреждение больше не повторяется, устаревшее событие можно удалить:

```bash
kubectl delete event -n <namespace> <event_name>
```