# Установка Stackland на виртуальные машины в Yandex Cloud

В этом руководстве описана установка Yandex Cloud Stackland на виртуальные машины в Yandex Cloud из пользовательского загрузочного образа.

{% note info "Note" %}

Основные сценарии развертывания Stackland поверх виртуальных машин в Yandex Cloud — демонстрация, прототипирование и тестовые стенды.

Для production-нагрузок в зонах, где доступны управляемые сервисы Yandex Cloud, рекомендуем использовать эти сервисы.

{% endnote %}

## Введение {#introduction}

Для развертывания минимального кластера потребуется:

* Один бастионный хост на Ubuntu 22.04 или выше. На нем запускается `sladm`, выполняется доступ к кластеру и обеспечивается выход узлов в интернет.
* Не менее трех виртуальных машин для будущего кластера Stackland. Все машины должны находиться в одной облачной сети и одной подсети.
* Пользовательский образ диска, созданный из raw-образа Stackland.
* На каждой виртуальной машине: один загрузочный диск из пользовательского образа и один отдельный диск для данных.
* Сервисный аккаунт с правами на управление Network Load Balancer и использование облачной сети.

Рекомендуемые ресурсы для узлов кластера см. в разделе [Инфраструктура](../quickstart.md#infrastructure).

{% note info "Note" %}

В ссылках на релизные артефакты используется переменная `$VERSION`. Замените ее на актуальную версию Stackland.

{% endnote %}

В примерах CLI ниже используются переменные. Перед выполнением команд задайте их значения:

```bash
export VERSION=26.1.5
export ZONE=ru-central1-d
export NETWORK_NAME=stackland-network
export SUBNET_NAME=stackland-subnet
export SUBNET_CIDR=10.130.0.0/24
export SECURITY_GROUP_NAME=stackland-sg
export DNS_ZONE_NAME=stackland-internal
export BASE_DOMAIN=stackland.internal
export CLUSTER_NAME=main
```

## Подготовьте облачную сеть {#prepare-network}

Создайте облачную сеть и подсеть, в которой будут размещены бастионный хост и виртуальные машины кластера.

При подготовке сети учитывайте следующие требования:

* Все виртуальные машины кластера должны находиться в одной подсети. Это упрощает работу Network Load Balancer и целевой группы.
* Виртуальные машины кластера должны иметь стабильные внутренние IP-адреса.
* Бастионный хост должен иметь доступ в интернет и сетевой доступ к виртуальным машинам кластера.
* Узлы кластера должны иметь доступ в интернет через бастионный хост, NAT или другой сетевой механизм вашей инфраструктуры.

Создайте DNS-зону для будущего кластера. В примерах ниже используется домен `stackland.internal`.

Если вы используете CLI, выполните команды:

```bash
yc vpc network create --name $NETWORK_NAME

yc vpc subnet create \
  --name $SUBNET_NAME \
  --zone $ZONE \
  --range $SUBNET_CIDR \
  --network-name $NETWORK_NAME

NETWORK_ID=$(yc vpc network get $NETWORK_NAME --format json | jq -r '.id')

yc dns zone create \
  --name $DNS_ZONE_NAME \
  --zone $BASE_DOMAIN. \
  --private-visibility \
  --network-ids $NETWORK_ID
```

Если для виртуальных машин используются группы безопасности, создайте группу и разрешите трафик, необходимый для установки и работы кластера:

```bash
yc vpc security-group create \
  --name $SECURITY_GROUP_NAME \
  --network-name $NETWORK_NAME

SECURITY_GROUP_ID=$(yc vpc security-group get $SECURITY_GROUP_NAME --format json | jq -r '.id')

yc vpc security-group update-rules $SECURITY_GROUP_ID \
  --add-rule "direction=ingress,protocol=any,predefined=self_security_group" \
  --add-rule "direction=ingress,protocol=tcp,port=22,v4-cidrs=<ip_адрес_администратора>/32" \
  --add-rule "direction=ingress,protocol=tcp,from-port=30000,to-port=32767,v4-cidrs=0.0.0.0/0" \
  --add-rule "direction=egress,protocol=any,v4-cidrs=0.0.0.0/0"
```

Правило для диапазона `30000-32767` нужно для доступа Network Load Balancer к NodePort-портам системного ingress. В примере указан стандартный диапазон NodePort в Kubernetes. Если в вашей конфигурации задан другой диапазон, укажите его в правиле группы безопасности. Для production-стендов ограничьте источник трафика в этом правиле согласно сетевой политике вашей организации.

## Подготовьте сервисный аккаунт {#service-account}

Создайте сервисный аккаунт, который будет привязан к виртуальным машинам кластера. Назначьте ему роли:

* `load-balancer.admin` — для создания и удаления сетевых балансировщиков и целевых групп.
* `vpc.user` — для работы с ресурсами облачной сети.

Выполните команды:

```bash
yc iam service-account create --name stackland-yc-lb

SA_ID=$(yc iam service-account get stackland-yc-lb --format json | jq -r '.id')
FOLDER_ID=$(yc config get folder-id)

yc resource-manager folder add-access-binding "$FOLDER_ID" \
  --role load-balancer.admin \
  --subject serviceAccount:"$SA_ID"

yc resource-manager folder add-access-binding "$FOLDER_ID" \
  --role vpc.user \
  --subject serviceAccount:"$SA_ID"
```

## Создайте образ диска {#create-image}

Создайте пользовательский образ диска из raw-образа Stackland. Raw-образ доступен по адресу:

```text
https://storage.yandexcloud.net/stackland-public/stackland/$VERSION/images/stackland-amd64-$VERSION.raw
```

Создать образ можно по инструкции [Загрузить свой образ](../../compute/operations/image-create/upload.md).

Если вы используете CLI, выполните команду:

```bash
yc compute image create \
  --name stackland-$VERSION \
  --source-uri https://storage.yandexcloud.net/stackland-public/stackland/$VERSION/images/stackland-amd64-$VERSION.raw \
  --os-type linux \
  --min-disk-size 150GB
```

Дождитесь, пока образ перейдет в состояние `READY`.

## Создайте бастионный хост {#create-bastion}

Создайте виртуальную машину с Ubuntu 22.04 или выше в той же подсети, где будут размещены узлы кластера.

На бастионном хосте установите необходимые утилиты:

```bash
sudo apt update
sudo apt install unzip jq curl wget -y
```

Установите `kubectl`: он понадобится для проверки состояния кластера после установки. Например:

```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
```

Установите и настройте [CLI для Yandex Cloud](../../cli/quickstart.md).

Если узлы кластера выходят в интернет через бастионный хост, включите IPv4-маршрутизацию и NAT. Пример настройки NAT приведен в руководстве [Установка Stackland на Yandex BareMetal](install-on-yc-bms.md#net-settings).

## Создайте виртуальные машины кластера {#create-vms}

Создайте не менее трех виртуальных машин для кластера Stackland.

Для каждой виртуальной машины задайте следующие параметры:

* Загрузочный диск — из пользовательского образа `stackland-$VERSION`.
* Дополнительный диск для данных — не менее требуемого объема по [минимальным требованиям](../quickstart.md#infrastructure).
* Сервисный аккаунт — созданный ранее сервисный аккаунт.
* Подсеть — та же подсеть, где находится бастионный хост.
* Внутренний IP-адрес — статический.
* Публичный IP-адрес — не назначайте, если доступ к узлам выполняется через бастионный хост.
* Метка `cluster-name` — значение должно совпадать с `metadata.name` в ресурсе `StacklandClusterConfig`. В примере ниже это `main`.

Если вы используете CLI, добавьте параметр `--labels cluster-name=$CLUSTER_NAME` при создании виртуальных машин.

Если виртуальные машины уже созданы, добавьте метку отдельно:

```bash
yc compute instance add-labels node1 --labels cluster-name=$CLUSTER_NAME
yc compute instance add-labels node2 --labels cluster-name=$CLUSTER_NAME
yc compute instance add-labels node3 --labels cluster-name=$CLUSTER_NAME
```

{% note warning "Warning" %}

Метка `cluster-name` обязательна для компонента `yandexcloud-lb`. Без нее оператор балансировщика не сможет получить имя кластера из metadata-сервиса Yandex Cloud и будет перезапускаться с ошибкой `failed to get cluster name from metadata: metadata service returned status 404`.

{% endnote %}

Пример создания первого узла с помощью CLI:

```bash
yc compute instance create \
  --name node1 \
  --zone $ZONE \
  --hostname node1.$BASE_DOMAIN \
  --platform standard-v3 \
  --cores 32 \
  --memory 64GB \
  --core-fraction 100 \
  --labels cluster-name=$CLUSTER_NAME \
  --create-boot-disk name=node1-boot,image-name=stackland-$VERSION,type=network-ssd,size=150,auto-delete=true \
  --create-disk name=node1-data,type=network-ssd,size=400,device-name=data,auto-delete=true \
  --network-interface subnet-name=$SUBNET_NAME,ipv4-address=10.130.0.11,security-group-ids=$SECURITY_GROUP_ID \
  --service-account-name stackland-yc-lb
```

Создайте остальные узлы по этому примеру, изменив имена, FQDN, IP-адреса и имена дисков.

После создания виртуальных машин запишите для каждого узла:

* FQDN или имя, которое будет использоваться в конфигурации Stackland.
* Внутренний IP-адрес.
* MAC-адрес сетевого интерфейса.
* Имя загрузочного диска внутри гостевой ОС. Обычно это `/dev/vda`, но проверьте значение для вашей конфигурации.
* Имя диска для данных внутри гостевой ОС. Обычно это `/dev/vdb`, если к виртуальной машине подключен один дополнительный диск.

## Настройте DNS {#dns}

Настройте DNS-записи для домена кластера.

Для узлов кластера создайте A-записи, которые указывают на внутренние IP-адреса виртуальных машин:

```text
node1.stackland.internal.  A  10.130.0.11
node2.stackland.internal.  A  10.130.0.12
node3.stackland.internal.  A  10.130.0.13
```

Если вы используете CLI, выполните команду:

```bash
yc dns zone add-records $DNS_ZONE_NAME \
  --record "node1 300 A 10.130.0.11" \
  --record "node2 300 A 10.130.0.12" \
  --record "node3 300 A 10.130.0.13"
```

Также подготовьте записи для системных эндпоинтов:

* `api.sys.$baseDomain` — на адрес сетевого балансировщика, который вы используете для доступа к API Kubernetes, либо на внутренние IP-адреса узлов `combined` или `control-plane`.
* `*.sys.$baseDomain` — на адрес, который будет назначен сетевому балансировщику после установки.

Если адрес сетевого балансировщика неизвестен заранее, создайте или обновите wildcard-запись после завершения установки и создания Network Load Balancer.

До установки создайте запись для API Kubernetes:

```bash
yc dns zone add-records $DNS_ZONE_NAME \
  --record "api.sys 300 A 10.130.0.11" \
  --record "api.sys 300 A 10.130.0.12" \
  --record "api.sys 300 A 10.130.0.13"
```

После установки получите внешний IP-адрес Network Load Balancer и добавьте wildcard-запись:

```bash
INGRESS_IP=$(kubectl get svc -n stackland-ingress ingress-controller -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

yc dns zone add-records $DNS_ZONE_NAME \
  --record "*.sys 300 A $INGRESS_IP"
```

## Подготовьте конфигурацию Stackland {#prepare-config}

Создайте на бастионном хосте папку `config/` и сохраните в ней конфигурационные файлы кластера.

{% note info "Note" %}

Для балансировщика `yandex-nlb` не указывайте `ipPools`. Этот параметр не поддерживается Network Load Balancer.

{% endnote %}

Пример конфигурации кластера:

```yaml
apiVersion: v1alpha1
kind: StacklandClusterConfig
metadata:
  name: main
spec:
  platform:
    type: yandexcloud
    loadBalancer:
      type: yandex-nlb

  cluster:
    baseDomain: stackland.internal

    networking:
      hostsNetwork:
        - cidr: 10.130.0.0/24
      clusterNetwork:
        - cidr: 172.16.0.0/16
      servicesNetwork:
        - cidr: 10.96.0.0/12

    storage:
      defaultStorageClass: stackland-other

  genericHostConfig:
    disksConfig:
      - installDisk:
          name: /dev/vda
      - dataDisk:
          name: /dev/vdb
    networkConfig:
      routes:
        - to: 0.0.0.0/0
          via: 10.130.0.1
          iface: eth0
      resolvers:
        - 10.130.0.2
      timeservers:
        - 10.130.0.2
```

В Compute Cloud сетевые диски виртуальных машин отображаются как VirtIO-устройства. Stackland относит такие диски к Storage Class `stackland-other`, поэтому для этого сценария укажите `defaultStorageClass: stackland-other`.

Если указать `stackland-ssd`, постоянные тома для системных компонентов могут остаться в состоянии `Pending`, а в событиях подов будет сообщение `did not have enough free storage`.

Пример конфигурации хостов:

```yaml
apiVersion: v1alpha1
kind: StacklandHostsList
metadata:
  name: main
spec:
  hosts:
    - hostname: node1.stackland.internal
      role: combined
      networkConfig:
        interfaces:
          - macaddress: d0:0d:20:97:18:17
            name: eth0
        addresses:
          - interface: eth0
            ip: 10.130.0.11/24

    - hostname: node2.stackland.internal
      role: combined
      networkConfig:
        interfaces:
          - macaddress: d0:0d:1f:a3:b5:05
            name: eth0
        addresses:
          - interface: eth0
            ip: 10.130.0.12/24

    - hostname: node3.stackland.internal
      role: combined
      networkConfig:
        interfaces:
          - macaddress: d0:0d:1a:c5:b7:a5
            name: eth0
        addresses:
          - interface: eth0
            ip: 10.130.0.13/24
```

Замените IP-адреса, MAC-адреса, DNS-серверы, NTP-серверы и имена хостов на значения вашей инфраструктуры.

## Скачайте `sladm` {#download-sladm}

На бастионном хосте скачайте и распакуйте `sladm`:

```bash
wget https://storage.yandexcloud.net/stackland-public/stackland/$VERSION/sladm-$VERSION-linux-amd64.zip
unzip sladm-$VERSION-linux-amd64.zip
chmod +x sladm
```

## Подготовьте секреты {#prepare-secrets}

Сгенерируйте ресурс `StacklandSecretsConfig`:

```bash
./sladm secrets add --out config/secrets.yaml --license-key key.json
```

Где `key.json` — файл с лицензионным ключом Stackland.

## Установите кластер {#install}

Проверьте конфигурацию перед установкой:

```bash
./sladm validate --config config/
```

Запустите установку:

```bash
./sladm install --config config/ --installation-timeout 2h 2>&1 | tee install-$(date +%y%m%d-%H%M).log
```

Процесс установки занимает примерно час. Лог установки сохраните до окончания проверки: в нем есть сообщения о переходах узлов и компонентов между состояниями, а после успешной установки — адрес консоли управления, логин и пароль администратора.

{% note warning "Warning" %}

Лог установки содержит пароль администратора. Не публикуйте его и не передавайте третьим лицам.

{% endnote %}

Если установка не завершилась за отведенное время или остановилась с ошибкой, см. раздел [Устранение неполадок](#troubleshooting).

## Проверьте установку {#check-installation}

После завершения установки в логе `sladm` должно появиться сообщение:

```text
✓ Your Stackland cluster is ready
```

Также `sladm` выведет адрес консоли управления, логин и пароль по умолчанию.

На бастионном хосте проверьте состояние установки вручную.

Если `sladm` еще не скопировал kubeconfig в домашнюю директорию пользователя, укажите файл kubeconfig явно:

```bash
export KUBECONFIG=./_out/kubeconfig
```

1. Проверьте, что Kubernetes API доступен и все узлы находятся в состоянии `Ready`:

   ```bash
   kubectl get nodes -o wide
   ```

2. Проверьте, что начальная установка платформы завершена:

   ```bash
   kubectl get platformconfig main -o jsonpath='{.status.initialInstall.state}{"\n"}'
   ```

   Ожидаемое значение:

   ```text
   Installed
   ```

3. Проверьте состояния компонентов:

   ```bash
   kubectl get componentinstallations -o wide
   ```

   Все компоненты должны быть в состоянии `Ready`.

4. Проверьте, что нет зависших PVC и PVC с неверным Storage Class:

   ```bash
   kubectl get pvc -A
   kubectl get pvc -A | grep -E 'Pending|Lost|stackland-ssd' || true
   ```

   Для этого сценария PVC системных компонентов должны использовать `stackland-other`.

5. Проверьте, что нет подов c ошибками:

   ```bash
   kubectl get pod -A --field-selector=status.phase!=Succeeded | grep -E 'Pending|Error|CrashLoop|Init|0/|ContainerCreating' || true
   ```

   Если команда выводит поды, проверьте их события и логи:

   ```bash
   kubectl describe pod <имя_пода> -n <пространство_имен>
   kubectl logs <имя_пода> -n <пространство_имен> --previous --tail=100
   ```

6. Проверьте системные ingress-ресурсы:

   ```bash
   kubectl get ingress -A
   kubectl get svc -n stackland-ingress ingress-controller -o wide
   ```

   В поле `ADDRESS` у ingress-ресурсов должен быть внешний IP-адрес Network Load Balancer.

Проверьте, что доступны системные эндпоинты:

* `https://console.sys.$baseDomain` — консоль управления кластером.
* `https://dashboard.sys.$baseDomain` — дашборд кластера.
* `https://grafana.sys.$baseDomain` — графики кластера в Grafana.
* `https://prometheus.sys.$baseDomain` — метрики кластера в Prometheus.
* `https://alertmanager.sys.$baseDomain` — алерты кластера в Alertmanager.

Если wildcard-запись `*.sys.$baseDomain` еще не указывает на адрес Network Load Balancer, получите адрес созданного балансировщика и обновите DNS-запись.

Например:

```bash
INGRESS_IP=$(kubectl get svc -n stackland-ingress ingress-controller -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

yc dns zone add-records $DNS_ZONE_NAME \
  --record "*.sys 300 A $INGRESS_IP"
```

Если вы проверяете доступ с рабочей станции и не используете публичную DNS-зону, добавьте записи в файл `hosts` на вашем компьютере:

```text
<ip_балансировщика> console.sys.stackland.internal auth.sys.stackland.internal kubeconfig.sys.stackland.internal grafana.sys.stackland.internal docs.sys.stackland.internal
```

{% note info "Note" %}

Если открыть IP-адрес Network Load Balancer напрямую в браузере, ingress вернет ответ `default backend - 404`. Это ожидаемое поведение: маршрутизация выполняется по имени хоста. Открывайте консоль по адресу `https://console.sys.$baseDomain`.

{% endnote %}

Проверьте доступ к консоли управления:

```bash
curl -I --max-time 10 -H "Host: console.sys.$BASE_DOMAIN" http://$INGRESS_IP
curl -kI --max-time 10 \
  --resolve console.sys.$BASE_DOMAIN:443:$INGRESS_IP \
  https://console.sys.$BASE_DOMAIN
```

Ожидаемый результат:

* HTTP-запрос возвращает редирект на HTTPS.
* HTTPS-запрос возвращает редирект на страницу входа или саму страницу входа с кодом `200`.

Проверьте состояние целевой группы балансировщика:

```bash
yc load-balancer network-load-balancer list
yc load-balancer target-group list
yc load-balancer network-load-balancer target-states <имя_или_id_балансировщика> \
  --target-group-id <id_целевой_группы>
```

Все узлы должны перейти в состояние `HEALTHY`.

Если узлы остаются в состоянии `UNHEALTHY`, проверьте доступность NodePort-порта ingress с бастионного хоста:

```bash
INGRESS_HTTP_NODEPORT=$(kubectl get svc -n stackland-ingress ingress-controller -o jsonpath='{.spec.ports[?(@.port==80)].nodePort}')

for ip in <ip_узла_1> <ip_узла_2> <ip_узла_3>; do
  timeout 3 bash -c "</dev/tcp/$ip/$INGRESS_HTTP_NODEPORT" && \
    echo "$ip:$INGRESS_HTTP_NODEPORT open" || \
    echo "$ip:$INGRESS_HTTP_NODEPORT closed"
done
```

Если NodePort доступен из подсети, но целевая группа остается в состоянии `UNHEALTHY`, проверьте:

* правила групп безопасности для входящего трафика от Network Load Balancer к NodePort-портам узлов;
* сетевые ACL, маршруты и NAT-правила, которые могут влиять на обратный трафик от узлов к проверкам состояния Network Load Balancer;
* что в целевой группе указаны внутренние IP-адреса всех узлов;
* что сервис `stackland-ingress/ingress-controller` использует те же NodePort-порты, что и Network Load Balancer.

Для дополнительной проверки ingress из подсети выполните с бастионного хоста:

```bash
curl -I --max-time 10 -H "Host: console.sys.$BASE_DOMAIN" \
  http://<ip_любого_узла>:$INGRESS_HTTP_NODEPORT
```

Ожидаемый ответ — HTTP-редирект на HTTPS или страницу входа.

## Устранение неполадок {#troubleshooting}

В этом разделе приведены проблемы, характерные для установки Stackland на виртуальные машины в Yandex Cloud. Общие проблемы установки см. в разделе [Диагностика и устранение неполадок](../operations/troubleshooting.md).

### `yandexcloud-lb` перезапускается с ошибкой metadata-сервиса {#yandexcloud-lb-metadata}

Если установка останавливается на компонентах `load-balancer` или `ingress`, проверьте поды компонента балансировщика:

```bash
kubectl get pod -n stackland-load-balancer
kubectl logs -n stackland-load-balancer deploy/yandexcloud-lb --tail=100
```

Если в логах есть ошибка `failed to get cluster name from metadata: metadata service returned status 404`, проверьте, что у всех виртуальных машин кластера есть метка `cluster-name`, совпадающая с `metadata.name` в ресурсе `StacklandClusterConfig`:

```bash
yc compute instance add-labels node1 --labels cluster-name=$CLUSTER_NAME
yc compute instance add-labels node2 --labels cluster-name=$CLUSTER_NAME
yc compute instance add-labels node3 --labels cluster-name=$CLUSTER_NAME
```

После добавления метки перезапустите под `yandexcloud-lb`:

```bash
kubectl delete pod -n stackland-load-balancer -l app.kubernetes.io/name=yandexcloud-lb
```

### PVC остаются в состоянии `Pending` {#pending-pvc}

Если установка останавливается на компонентах `iam`, `logging` или `storage`, а в событиях подов есть сообщение `did not have enough free storage`, проверьте Storage Class и емкость TopoLVM:

```bash
kubectl get nodes -o custom-columns=NAME:.metadata.name,OTHER:.status.capacity.capacity\.topolvm\.io/stackland-other,SSD:.status.capacity.capacity\.topolvm\.io/stackland-ssd
kubectl get pvc -A
```

Для виртуальных машин в Compute Cloud емкость должна быть доступна в `capacity.topolvm.io/stackland-other`. В конфигурации установки должен быть указан параметр:

```yaml
storage:
  defaultStorageClass: stackland-other
```

Если PVC уже созданы с `stackland-ssd`, измените конфигурацию и перезапустите установку. На тестовом стенде без пользовательских данных можно удалить только те PVC, которые находятся в состоянии `Pending`, чтобы операторы пересоздали их с правильным Storage Class.

## См. также {#see-also}

* [Руководство по установке](../quickstart.md)
* [Установка Stackland на Yandex BareMetal](install-on-yc-bms.md)
* [Диагностика и устранение неполадок](../operations/troubleshooting.md)