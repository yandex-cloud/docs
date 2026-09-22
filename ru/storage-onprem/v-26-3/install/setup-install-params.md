---
title: Настройка параметров установки {{ objstorage-onprem-name }}
description: Настройка inventory и конфигурации стенда {{ objstorage-onprem-name }} для установки через Ansible.
---

# Настройка параметров инсталляции

Параметры установки задаются в каталоге `ansible` на [установочном хосте](environment-preparation.md#installation-host):

* `inventory.ini` — список хостов и их распределение по группам.
* `group_vars/<имя_стенда>/main.yaml` — конфигурация стенда.
* `group_vars/<имя_стенда>/vault.yaml` — секреты, которые будут созданы при установке.

В примере используется стенд `my-onprem` из четырех хостов: три мастер-хоста {{ k8s }} и один worker-хост.

## Список хостов {#inventory}

В файле `ansible/inventory.ini` опишите группы `my-onprem`, `my-onprem-masters` и `my-onprem-workers`:

```ini
[my-onprem:children]
my-onprem-masters
my-onprem-workers

[my-onprem-masters]
onprem01.local ansible_host=10.0.0.11
onprem02.local ansible_host=10.0.0.12
onprem03.local ansible_host=10.0.0.13

[my-onprem-workers]
onprem04.local ansible_host=10.0.0.14
```

В `ansible_host` укажите IP-адреса для SSH-подключения с установочного хоста. Для своего стенда замените `my-onprem` во всех именах групп. Это же имя указывается в параметре `cluster` при запуске установки и в имени подкаталога `group_vars`.

Порядок мастер-хостов имеет значение: с первого хоста плейбук инициализирует кластер {{ k8s }} и запускает установку компонентов {{ objstorage-name }}.

## Конфигурация хостов, {{ k8s }} и OCI Registry {#host-config}

Создайте конфигурацию стенда из шаблона:

```bash
cd ansible
mkdir -p group_vars/my-onprem
cp group_vars/example/main.yaml group_vars/my-onprem/main.yaml
```

Заполните `group_vars/my-onprem/main.yaml`. Ниже показаны основные параметры: остальные настройки сохраните из шаблона `group_vars/example/main.yaml`. Общие настройки из `group_vars/all.yaml` оставьте без изменений.

Пример `main.yaml` с комментариями:

```yaml
# Пользователь для подключения по SSH
ansible_user: root

# Установка из архива с локальным OCI Registry
stand_type: external

# Всегда onprem, не следует менять
stand: onprem

release:
  # Имя архива с {{ objstorage-onprem-name }}
  version: yc-storage-26.3.0.tar.zst
  # Архив находится на установочном хосте в каталоге ansible/release
  file_location: local

# Режим подготовки HDD
mds_mode: mds2

# Точки монтирования:
# false — /srv/angel/disks/<номер_диска>
# true — /srv/angel/<номер_слота>/disks/<номер_диска>
angelSlotTopology: false

# Тип IP-адресации: IPv4 или IPv6
ip_type: IPv4

# При включенном VXLAN — IP-адреса виртуальных интерфейсов dummy-kube0
internal_ips:
  onprem01.local: 100.112.12.1
  onprem02.local: 100.112.12.2
  onprem03.local: 100.112.12.3
  onprem04.local: 100.112.12.4

# Настройки VXLAN
vxlan:
  enabled: true
  net_prefix: "100.112"
  # Адреса физических internal-интерфейсов
  vxlan0_peers:
    - 10.0.0.11
    - 10.0.0.12
    - 10.0.0.13
    - 10.0.0.14

# Конфигурация {{ k8s }}
k8s:
  # Подсеть для подов
  pod_subnet: 10.11.0.0/16
  # Подсеть для сервисов
  service_subnet: 10.12.0.0/16
  # Размер блока Calico: 26 для IPv4, 122 для IPv6
  block_size: 26
  # Имена должны совпадать с группой my-onprem-masters в inventory.ini
  master_hostnames:
    - onprem01.local
    - onprem02.local
    - onprem03.local
  calico:
    node_address_autodetection:
      # IP-адрес шлюза internal-подсети
      canReach: 10.0.0.1

# Конфигурация локального OCI Registry
zot:
  master_hostname: onprem01.local
  mirror_hostnames:
    - onprem02.local
    - onprem03.local

# Конфигурация yc-storage-operator
yc_storage_operator:
  helm_oci:
    repoURL: zot-proxy.zot-proxy.svc.cluster.local
    chart: onprem/mds-charts/yc-storage-operator
    # Версия yc-storage-operator в архиве
    targetRevision: 26.3.0

# Конфигурация {{ objstorage-onprem-name }}
bootstrap:
  # Версия {{ objstorage-onprem-name }} в архиве
  version: 26.3.0
  # Вставьте сюда YAML-конфигурацию из следующего раздела
  values_object: |
    <конфигурация>
```

При заполнении конфигурации учитывайте следующие требования:

* Укажите имя архива в `release.version` и версии компонентов из архива в `yc_storage_operator.helm_oci.targetRevision` и `bootstrap.version`.
* При включенном VXLAN используйте для `internal_ips` адреса виртуальных интерфейсов из подсети `<net_prefix>.12.0/24`, например `100.112.12.0/24`. В `vxlan.vxlan0_peers` укажите адреса физических internal-интерфейсов. При выключенном VXLAN в `internal_ips` указываются адреса физических internal-интерфейсов.
* Подсети `k8s.pod_subnet` и `k8s.service_subnet` используются внутри кластера {{ k8s }} и не должны пересекаться между собой и с другими подсетями, включая data, internal и management.
* Параметр `k8s.calico.node_address_autodetection` должен обеспечивать выбор IP-адресов internal-интерфейсов.
* Количество мастер-хостов {{ k8s }} зависит от требований надежности: три — для поддержки отказа одного хоста, пять — для поддержки отказа двух хостов.

Для [подготовки HDD](installation-steps.md#step-6) используйте `mds_mode: mds2` — значение по умолчанию. Точки монтирования зависят от параметра `angelSlotTopology`, заданного на верхнем уровне `main.yaml`:

#|
|| **Значение `angelSlotTopology`** | **Точки монтирования HDD** ||
|| `false` (по умолчанию) | `/srv/angel/disks/<номер_диска>`. ||
|| `true` | `/srv/angel/<номер_слота>/disks/<номер_диска>`. ||
|#

Здесь `<номер_диска>` — порядковый номер диска, который плейбук назначает автоматически, начиная с единицы. При `angelSlotTopology: true` `<номер_слота>` обозначает номер слота Angel от одного до трех, а диски нумеруются отдельно в каждом слоте. Например, `/srv/angel/2/disks/1` — точка монтирования первого диска во втором слоте.

## Конфигурация {{ objstorage-onprem-name }} {#objstorage-config}

В `bootstrap.values_object` заполните YAML-описание инсталляции из шаблона `group_vars/example/main.yaml`. Ниже приведены основные параметры для замены `<конфигурация>` в примере `main.yaml`. Сохраните отступы: весь блок должен быть вложен в `values_object`.

Пример конфигурации для четырех хостов:

```yaml
# Уникальное имя инсталляции (буквы, цифры, _)
name: my_onprem

# "ipv4" или "ipv6"; по умолчанию ipv4
ipType: ipv4

# Список хостов стенда
# Для каждого указывается:
# - name: FQDN хоста
# - intIP: IP-адрес из internal_ips
# - dc: имя дата-центра (зоны доступности).
hosts:
  - name: onprem01.local
    intIP: "100.112.12.1"
    dc: dc1
  - name: onprem02.local
    intIP: "100.112.12.2"
    dc: dc2
  - name: onprem03.local
    intIP: "100.112.12.3"
    dc: dc3
  - name: onprem04.local
    intIP: "100.112.12.4"
    dc: dc4

ipPools:
  # Пул адресов для management-сервисов: консоли, API для CLI и метрик
  # Исключите адреса, занятые хостами и другим оборудованием
  # Рекомендуется выделить не менее 16 адресов
  management:
    - "10.0.2.224-10.0.2.254"

# Настройки dataplane
dataplane:
  # Класс избыточности: R3 или EC4+2
  redundancy: R3

# Конфигурация S3-совместимого API {{ objstorage-onprem-name }}
s3:
  # Квота, согласно лицензии, в ГиБ
  quotaGB: "123456"
  # Размер in-memory кеша S3 API, на каждом хосте, в МиБ.
  # Рекомендуется использовать до четверти доступной RAM для in-memory кеширования.
  # По умолчанию 4096.
  cacheMB: "10240"
  # Список доменов, по которым будут обращения к S3 API.
  # Важно указать все домены, т.к. API не будет принимать обращения по другим адресам.
  domains:
    - "s3.onprem.local"
    - "s3-0.onprem.local"
    - "s3-1.onprem.local"
    - "s3-2.onprem.local"
    - "s3-3.onprem.local"
  # Список IP-адресов, выделенных для S3 API.
  # Количество адресов должно соответствовать количеству хостов.
  # Адреса должны быть из data-подсети.
  ips:
    - "10.0.1.11"
    - "10.0.1.12"
    - "10.0.1.13"
    - "10.0.1.14"

# Конфигурация консоли
console:
  # Веб-консоль
  ui:
    # Домен вида "console.xxx.net"
    # Консоль будет доступна только по этому домену
    domain: "console.onprem.local"
    # IP-адрес для веб-консоли, из management-подсети
    ip: "10.0.2.254"
    # Конфигурация для метрик, отображаемых непосредственно в веб-интерфейсе
    metrics:
      # Маска для имени сетевых интерфейсов, по которым следует отображать нагрузку
      externalNetworkInterfacesMask: "eth.*"
  # gRPC API для CLI
  grpc:
    # IP-адрес для gRPC API, из management-подсети
    ip: "10.0.2.253"

# Конфигурация ip-адресов эндпоинтов для метрик
# Адреса также должны быть из management-подсети
metrics:
  grafana:
    # IP-адрес для внутренней Grafana
    ip: "10.0.2.252"
  prometheusFederation:
    # IP-адрес для федеративного эндпоинта Prometheus, с которого можно выполнять скрапинг метрик
    ip: "10.0.2.251"
```

Учитывайте особенности конфигурации:

* Параметр `dc`, указанный для хостов в `hosts`, не обязательно должен соответствовать физическому расположению хостов. На практике он необходим для построения каплов дисков для репликации или EC.
    * При `dataplane.redundancy: R3` каждый из трех дисков капла должен относиться к разным `dc`.
    * При `dataplane.redundancy: EC4+2` берется по два диска из каждого `dc`, чтобы сформировать капл из шести.

* В management-подсети (указанной в `ipPools.management`) будет использовано несколько дополнительных адресов, явно не задаваемых в конфигурации. Такие адреса будут выбираться из начала пула. Поэтому рекомендуется указывать явные адреса из конца пула (`console.ui.ip`, `console.grpc.ip` и другие).


#### Что дальше? {#whats-next}

* [{#T}](installation-steps.md)
* [{#T}](../troubleshooting/installation-errors.md)
