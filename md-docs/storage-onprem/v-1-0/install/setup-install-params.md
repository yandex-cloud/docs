# Настройка параметров инсталляции

В распакованном архиве `install-kit.tar.gz` содержится каталог `stands/example`, в котором представлен пример параметров установки.

1. Создайте копию каталога `example`, например `my-onprem`:

    ```text
    stands/
    ├─ example/
    └─ my-onprem/
      ├─ env
      └─ pillar.sls
    ```

1. Заполните файл `env`, используя IP-адреса, по которым осуществляется SSH-подключение. Например:

    ```text
    MASTER_IP='10.0.0.11'
    MINION_IPS='10.0.0.12 10.0.0.13'
    MASTER_HOST='onprem01.local'

    DNS=$(cat <<EOF
    onprem01.local 10.0.0.11
    onprem02.local 10.0.0.12
    onprem03.local 10.0.0.13
    EOF
    )
    ```

    Где:

    * `MASTER_IP` и `MASTER_HOST` — для Salt-мастера.
    * `MINION_IPS` — для Salt-минионов.
    * `DNS` используется для установки хостнеймов.


## Конфигурация Salt: хосты, Kubernetes и OCI Registry

В файл `pillar.sls` записывается конфигурация для Salt, используемая для:

* разворачивания кластера Kubernetes;
* разворачивания локального OCI Registry.

Пример `pillar.sls` с комментариями:

```yaml
# Всегда onprem, не следует менять
stand: onprem

# Тип IP-адресации (IPv4 или IPv6)
ip_type: IPv4

# Конфигурация пакетов, не следует менять
install_packages:
  kernel: False

# В том случае, если хостеймы резолвятся на несколько IP-адресов,
# следует явно указать IP-адреса internal-подсети:
internal_ips:
  onprem01.local: 10.0.0.11
  onprem02.local: 10.0.0.12
  onprem03.local: 10.0.0.13

# Конфигурация Kubernetes
k8s:
  # Подсеть для подов
  pod_subnet: 10.11.0.0/16
  # Подсеть для сервисов
  service_subnet: 10.12.0.0/16
  # Параметр blockSize для calico; рекомендуется 26 для IPv4, 122 для IPv6
  block_size: 26
  # Хосты, которые будут выполнять роль мастеров Kubernetes
  master_hostnames:
    - onprem01.local
    - onprem02.local
    - onprem03.local
  calico:
    # Конфигурация nodeAddressAutodetection для Calico
    # Необходимо, чтобы адреса хостов устанавливались равными IP-адресам internal-интерфейсов
    node_address_autodetection:
      # Лучше всего, указать canReach: адрес gateway internal-подсети
      canReach: 10.0.0.1

# Конфигурация локального OCI Registry 
zot:
  # Хост, на котором будет установлен мастер OCI Registry
  master_hostname: onprem01.local
  # Хосты, выполняющие роль зеркал
  mirror_hostnames:
    - onprem02.local
    - onprem03.local

# Конфигурация для первоначальной установки yc-storage-operator
# Не следует менять, за исключением helm_oci.targetRevision
yc_storage_operator:
  helm_oci:
    repoURL: zot-proxy.zot-proxy.svc.cluster.local
    chart: onprem/mds-charts/yc-storage-operator
    # Версия yc-storage-operator, указана в поставке
    targetRevision: 1.0.0

# Конфигурация On-premises Yandex Object Storage
bootstrap:
  # Версия On-premises Yandex Object Storage, указана в поставке
  version: 1.0.0
  # Параметры инсталляции On-premises Yandex Object Storage
  values_object: |
    <конфигурация>
```

Где `values_object` — [конфигурация On-premises Yandex Object Storage](#objstorage-config) в формате YAML.

* Подсети `k8s.pod_subnet`, `k8s.service_subnet` используются исключительно внутри кластера Kubernetes и не должны пересекаться с другими подсетями, включая data, internal и management.
* `k8s.calico.node_address_autodetection` должен соответствовать internal-подсети.
* Количество мастеров Kubernetes зависит от требований надежности: три — для поддержки отказа одного хоста, пять — для поддержки отказа двух хостов.


## Конфигурация On-premises Yandex Object Storage {#objstorage-config}

Пример инсталляции Object Storage с комментариями:

```yaml
# Уникальное имя инсталляции (буквы, цифры, _)
name: my_onprem

# "ipv4" или "ipv6"; по умолчанию ipv4
ipType: ipv4

# Список хостов стенда
# Для каждого указывается:
# - name: FQDN хоста
# - intIP: IP-адрес internal-интерфейсов
# - dc: имя дата-центра (зоны доступности).
hosts:
  - name: onprem01.local
    intIP: "10.0.0.11"
    dc: dc1
  - name: onprem02.local
    intIP: "10.0.0.12"
    dc: dc2
  - name: onprem03.local
    intIP: "10.0.0.13"
    dc: dc3
    
ipPools:
  # Подсеть для management сервисов (консоль, API для CLI, метрики, и т.д.)
  # Рекомендуется выделить не менее 16 адресов
  management:
    - "10.0.2.0/24"
    
# Настройки dataplane
dataplane:
  # Класс избыточности: R3 или EC4+2
  redundancy: R3
      
# Конфигурация S3-совместимого API On-premises Yandex Object Storage
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
  # Список IP-адресов, выделенных для S3 API.
  # Количество адресов должно соответствовать количеству хостов.
  # Адреса должны быть из data-подсети.
  ips:
    - "10.0.1.11"
    - "10.0.1.12"
    - "10.0.1.13"

# Конфигурация консоли
console:
  # Веб-консоль
  ui:
    # Домен вида "console.xxx.net"
    # Консоль будет доступна только по этому домену
    domain: "console.onprem.local"
    # IP-адрес для веб-консоли, из management-подсети
    ip: "10.0.2.255"
    # Конфигурация для метрик, отображаемых непосредственно в веб-интерфейсе
    metrics:
      # Маска для имени сетевых интерфейсов, по которым следует отображать нагрузку
      externalNetworkInterfacesMask: "etx.*"
  # gRPC API для CLI
  grpc:
    # IP-адрес для gRPC API, из management-подсети
    ip: "10.0.2.254"
    
# Конфигурация ip-адресов эндпоинтов для метрик
# Адреса также должны быть из management-подсети
metrics:
  grafana:
    # IP-адрес для внутренней Grafana
    ip: "10.0.2.253"
  prometheusFederation:
    # IP-адрес для федеративного эндпоинта Prometheus, с которого можно выполнять скрапинг метрик
    ip: "10.0.2.252"
```

* Параметр `dc`, указанный для хостов в `hosts`, не обязательно должен соответствовать физическому расположению хостов. На практике он необходим для построения каплов дисков для репликации или EC.
    * При `dataplane.redundancy: R3` каждый из трех дисков капла должен относиться к разным `dc`.
    * При `dataplane.redundancy: EC4+2` берется по два диска из каждого `dc`, чтобы сформировать капл из шести.

* В management-подсети (указанной в `ipPools.management`) будет использовано несколько дополнительных адресов, явно не задаваемых в конфигурации. Такие адреса будут выбираться из начала пула. Поэтому рекомендуется указывать явные адреса из конца пула (см. `console.ui.ip`, `console.grpc.ip` и т.д.)


#### Что дальше? {#whats-next}

* [Шаги установки](installation-steps.md)
* [Устранение неисправностей при установке](../troubleshooting/installation-errors.md)