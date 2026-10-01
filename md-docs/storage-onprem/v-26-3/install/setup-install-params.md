[Документация Yandex Cloud](../../../index.md) > [On-premises Yandex Object Storage](../../index.md) > Версия 26.3 > [Установка и настройка](index.md) > Настройка параметров инсталляции

# Настройка параметров инсталляции

Параметры установки задаются в каталоге `ansible` на [установочном хосте](environment-preparation.md#installation-host):

* `inventory.ini` — список хостов и их распределение по группам.
* `group_vars/<имя_стенда>/main.yaml` — конфигурация стенда.
* `group_vars/<имя_стенда>/vault.yaml` — секреты, которые будут созданы при установке.

В примере используется стенд `my-onprem` из четырех хостов: три мастер-хоста Kubernetes и один worker-хост.

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

Порядок мастер-хостов имеет значение: с первого хоста плейбук инициализирует кластер Kubernetes и запускает установку компонентов Object Storage.

## Конфигурация хостов, Kubernetes и OCI Registry {#host-config}

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

# Всегда onprem
# Не меняйте это значение
stand: onprem

release:
  # Имя архива с On-premises Yandex Object Storage
  version: yc-storage-26.3.3.tar.zst
  # Архив находится на установочном хосте в каталоге ansible/release
  file_location: local

# Режим подготовки HDD
# По умолчанию — mds2
mds_mode: mds2

# Точки монтирования HDD:
# false (по умолчанию) — /srv/angel/disks/<номер_диска>
# true — /srv/angel/<номер_слота>/disks/<номер_диска>
angelSlotTopology: false

# Тип IP-адресации: IPv4 или IPv6
ip_type: IPv4

# IP-адреса internal-интерфейсов
# При включенном VXLAN — адреса виртуальных интерфейсов dummy-kube0
# из подсети <net_prefix>.12.0/24
# При выключенном VXLAN — адреса физических internal-интерфейсов
internal_ips:
  onprem01.local: 100.112.12.1
  onprem02.local: 100.112.12.2
  onprem03.local: 100.112.12.3
  onprem04.local: 100.112.12.4

# Конфигурация VXLAN
vxlan:
  enabled: true
  net_prefix: "100.112"
  # IP-адреса физических internal-интерфейсов
  vxlan0_peers:
    - 10.0.0.11
    - 10.0.0.12
    - 10.0.0.13
    - 10.0.0.14

# Конфигурация Kubernetes
k8s:
  # Подсеть для подов
  pod_subnet: 10.11.0.0/16
  # Подсеть для сервисов
  service_subnet: 10.12.0.0/16
  # Размер блока Calico
  # Рекомендуется 26 для IPv4, 122 для IPv6
  block_size: 26
  # Имена должны совпадать с группой my-onprem-masters в inventory.ini
  master_hostnames:
    - onprem01.local
    - onprem02.local
    - onprem03.local
  # Зоны хостов Kubernetes
  # Значения должны совпадать с dc соответствующих хостов
  # в конфигурации bootstrap.values_object
  zones:
    onprem01.local: dc1
    onprem02.local: dc2
    onprem03.local: dc3
    onprem04.local: dc4
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
    targetRevision: 26.3.3

# Конфигурация On-premises Yandex Object Storage
bootstrap:
  # Версия On-premises Yandex Object Storage в архиве
  version: 26.3.3
  # YAML-описание инсталляции из следующего раздела
  # Сохраните отступы: весь блок должен быть вложен в values_object
  values_object: |
    <конфигурация>
```

При заполнении конфигурации учитывайте следующие требования:

* Укажите имя архива в `release.version` и версии компонентов из архива в `yc_storage_operator.helm_oci.targetRevision` и `bootstrap.version`.
* При включенном VXLAN используйте для `internal_ips` адреса виртуальных интерфейсов из подсети `<net_prefix>.12.0/24`, например `100.112.12.0/24`. В `vxlan.vxlan0_peers` укажите адреса физических internal-интерфейсов. При выключенном VXLAN в `internal_ips` указываются адреса физических internal-интерфейсов.
* Подсети `k8s.pod_subnet` и `k8s.service_subnet` используются внутри кластера Kubernetes и не должны пересекаться между собой и с другими подсетями, включая data, internal и management.
* Параметр `k8s.calico.node_address_autodetection` должен обеспечивать выбор IP-адресов internal-интерфейсов.
* Количество мастер-хостов Kubernetes зависит от требований надежности: три — для поддержки отказа одного хоста, пять — для поддержки отказа двух хостов.

Для [подготовки HDD](installation-steps.md#step-6) используйте `mds_mode: mds2` — значение по умолчанию. Точки монтирования зависят от параметра `angelSlotTopology`, заданного на верхнем уровне `main.yaml`:

#|
|| **Значение `angelSlotTopology`** | **Точки монтирования HDD** ||
|| `false` (по умолчанию) | `/srv/angel/disks/<номер_диска>`. ||
|| `true` | `/srv/angel/<номер_слота>/disks/<номер_диска>`. ||
|#

Здесь `<номер_диска>` — порядковый номер диска, который плейбук назначает автоматически, начиная с единицы. При `angelSlotTopology: true` `<номер_слота>` обозначает номер слота Angel от одного до трех, а диски нумеруются отдельно в каждом слоте. Например, `/srv/angel/2/disks/1` — точка монтирования первого диска во втором слоте.

## Конфигурация On-premises Yandex Object Storage {#objstorage-config}

В `bootstrap.values_object` заполните YAML-описание инсталляции из шаблона `group_vars/example/main.yaml`. Ниже приведены основные параметры для замены `<конфигурация>` в примере `main.yaml`. Сохраните отступы: весь блок должен быть вложен в `values_object`.

Пример конфигурации для четырех хостов:

```yaml
# Уникальное имя инсталляции
# Допустимы строчные латинские буквы, цифры, дефис и подчеркивание
# После установки имя менять нельзя
name: my_onprem

featureFlags:
  # Значение должно совпадать с angelSlotTopology в main.yaml
  angelSlotTopology: false
  # Включение ограничителя частоты запросов YARL
  enableRatelimiter: false

# Тип IP-адресации: IPv4 или IPv6
# Тип IP-адресации должен соответствовать ip_type в main.yaml и IP-адресам
# в intIP, для S3 API и эндпоинтов в management-подсети
ipType: ipv4

# Список всех хостов стенда
# Для каждого хоста обязательны name, intIP и dc
hosts:
  - name: onprem01.local
    # IP-адрес хоста из internal-подсети
    # При включенном VXLAN — адрес виртуального интерфейса из internal_ips в main.yaml
    intIP: "100.112.12.1"
    dc: dc1
    # Количество слотов Angel для чарта: от одного до трех
    # При angelSlotTopology: true укажите количество HDD, выделенных под данные, но не более трех
    # По умолчанию — три
    # angelSlots: 3
  - name: onprem02.local
    intIP: "100.112.12.2"
    dc: dc2
  - name: onprem03.local
    intIP: "100.112.12.3"
    dc: dc3
  - name: onprem04.local
    intIP: "100.112.12.4"
    dc: dc4

dataplane:
  # Разметка пространств имен с избыточностью R3 или EC
  # Размер бэкенда — 916 GiB
  # Размер пространства имен задается в контейнерах или GiB
  # Размер в GiB должен быть кратен физическому размеру контейнера
  # Суммарный размер пространств имен не должен превышать емкость HDD, выделенных под данные
  namespaces:
    - name: angel-x3
      redundancy: R3
      size:
        containers: 100

    # Пример EC 4+2
    # Параметр groupsPerDC задает количество дисков из каждого dc для формирования капла
    # По умолчанию — один
    # Если для EC D+P количество хостов меньше D+P, включите angelSlotTopology
    # - name: angel-ec
    #   redundancy: EC
    #   ec:
    #     data: 4
    #     parity: 2
    #   groupsPerDC: 2
    #   size:
    #     containers: 20

  # Необязательные параметры durabilityWatchdog в Angel
  # Принудительный fsync выполняется каждые (interval - jitter) / 2 секунд
  # angel:
  #   durabilityWatchdogInterval: 3m
  #   durabilityWatchdogJitter: 30s

postgres:
  # Размещение реплик каждого кластера PostgreSQL:
  # none (по умолчанию) — CNPG предпочитает разные узлы, но не требует этого
  # host — реплики обязательно размещаются на разных узлах
  # dc — реплики обязательно размещаются в разных зонах
  # Для dc обязательно задайте k8s.zones в main.yaml
  placementMode: dc

s3:
  # Если в dataplane.namespaces больше одной записи, явно укажите,
  # какие пространства имен используются для классов хранилища STANDARD, COLD и ICE
  # storageClasses:
  #   - name: STANDARD
  #     namespace: angel-x3
  #   - name: COLD
  #     namespace: angel-ec
  #   - name: ICE
  #     namespace: angel-ec

  # Отдельные настройки s3db:
  # shards — количество шардов, по умолчанию равно количеству хостов
  # placementMode — размещение реплик
  # Если placementMode не указан или равен inherit, используется postgres.placementMode
  # postgres:
  #   s3db:
  #     shards: 3
  #     placementMode: inherit

  # Размер кеша Goose в оперативной памяти, в МиБ
  # По умолчанию — 4 096
  # Рекомендуется использовать до четверти оперативной памяти соответствующего узла
  cacheMB: "10240"

  # Все допустимые домены S3 API
  domains:
    - "s3.onprem.local"
    - "s3-0.onprem.local"
    - "s3-1.onprem.local"
    - "s3-2.onprem.local"
    - "s3-3.onprem.local"

  # IP-адреса для S3 API из data-подсети
  # Количество адресов должно совпадать с количеством хостов
  ips:
    - "10.0.1.11"
    - "10.0.1.12"
    - "10.0.1.13"
    - "10.0.1.14"

  # Домены для CORS на бакетах по умолчанию
  # Настройка распространяется на POST, PUT и DELETE, но не на GET
  cors:
    - "*.onprem.local"

# Конфигурация консоли
console:
  ui:
    metrics:
      # Фильтр сетевых интерфейсов для отображения метрик в консоли
      externalNetworkInterfacesMask: "eth.*"

# Конфигурация эндпоинтов в management-подсети
ingress:
  console:
    ip: "10.0.2.239"
    domain: "console.onprem.local"
  monitoring:
    ip: "10.0.2.238"
    domain: "monitoring.onprem.local"

# Размеры PVC для метаданных
# Выбирайте с учетом емкости NVMe-накопителей, выделенных под метаданные
resources:
  storage:
    # PVC для Raft в Angel
    # Минимум 10Gi, рекомендуется 20Gi и больше
    angelRaft: 20Gi
    # Кластеры MongoDB: по три PVC на кластер
    psmdb:
      gosper: 5Gi
      nscfg: 1Gi
      grestin: 5Gi
    # Кластеры PostgreSQL: по три PVC на кластер
    # Количество шардов s3db задается в s3.postgres.s3db.shards
    pg:
      gosper: 10Gi
      s3db: 30Gi
      s3meta: 10Gi
      s3bg: 10Gi
      zitadel: 10Gi
      yarl: 10Gi
    # Временное хранение отладочного архива: один PVC
    inspector: 30Gi
    # Локальные TSDB/WAL Mimir: три PVC
    mimir: 30Gi
    # Локальные хранилища Loki: по три PVC на каждое
    loki:
      internal: 50Gi
      access: 25Gi
```

Учитывайте особенности конфигурации:

* Значения зон в `k8s.zones` из `main.yaml` должны совпадать со значениями `dc` соответствующих хостов в `hosts`.
* Параметр `dc`, указанный для хостов в `hosts`, не обязательно должен соответствовать физическому расположению хостов. На практике он необходим для построения каплов дисков для репликации или EC.
    * При `redundancy: R3` каждый из трех дисков капла должен относиться к разным `dc`.
    * При `redundancy: EC` из каждого `dc` берется количество дисков, заданное в `groupsPerDC`.
* Значение `angelSlotTopology` в `main.yaml` должно совпадать со значением `featureFlags.angelSlotTopology`.
* Суммарный размер неймспейсов в `dataplane.namespaces` не должен превышать физическую емкость HDD, выделенных под данные.
* Размеры PVC в `resources.storage` выбирайте с учетом емкости NVMe-накопителей, выделенных под метаданные.


#### Что дальше? {#whats-next}

* [Шаги установки](installation-steps.md)
* [Устранение неисправностей при установке](../troubleshooting/installation-errors.md)