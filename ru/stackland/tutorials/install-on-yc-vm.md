# Установка {{ stackland-name }} на виртуальные машины в {{ yandex-cloud }}

В этом руководстве описана установка {{ stackland-full-name }} на виртуальные машины в {{ yandex-cloud }} из пользовательского загрузочного образа.

{% note info "Note" %}

Основные сценарии развертывания {{ stackland-name }} поверх виртуальных машин в {{ yandex-cloud }} — демонстрация, прототипирование и тестовые стенды.

Для production-нагрузок в зонах, где доступны управляемые сервисы {{ yandex-cloud }}, рекомендуем использовать эти сервисы.

{% endnote %}

## Введение {#introduction}

Для развертывания минимального кластера потребуется:

* Один бастионный хост на Ubuntu 22.04 или выше. На нем запускается `sladm` и выполняется доступ к кластеру. Для выхода узлов в интернет в примере ниже используется NAT-шлюз {{ yandex-cloud }}.
* Не менее трех виртуальных машин для будущего кластера {{ stackland-name }}. Все машины должны находиться в одной облачной сети и одной подсети.
* Пользовательский образ диска, созданный из raw-образа {{ stackland-name }}.
* На каждой виртуальной машине: один загрузочный диск из пользовательского образа и один отдельный диск для данных.
* Сервисный аккаунт с правами на управление {{ network-load-balancer-name }} и использование облачной сети.

Рекомендуемые ресурсы для узлов кластера см. в разделе [Инфраструктура](../quickstart.md#infrastructure).

В приведенном ниже CLI-примере три узла используют суммарно 96 vCPU, 192 ГБ памяти и 2850 ГБ дисков `network-ssd`. Бастионный хост требует еще 2 vCPU, 4 ГБ памяти и диск 20 ГБ. Перед созданием виртуальных машин проверьте квоты каталога, прежде всего квоту на диски `network-ssd`.

{% note info "Note" %}

В ссылках на релизные артефакты используется переменная `$VERSION`. Замените ее на актуальную версию {{ stackland-name }}.

{% endnote %}

Команды `yc` выполняйте на рабочей станции, а команды `sladm` и `kubectl` — на бастионном хосте. Для работы с бастионом используйте отдельный терминал с SSH-сессией.

На рабочей станции [установите и инициализируйте CLI для {{ yandex-cloud }}](https://yandex.cloud/ru/docs/cli/quickstart#install).

По умолчанию используется каталог, указанный в активном профиле CLI. Чтобы изменить каталог по умолчанию, выполните команду:

```bash
yc config set folder-id <идентификатор_каталога>
```

Также для любой команды можно указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.

Если вы обращаетесь к ресурсу по имени, поиск выполняется в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск выполняется во всех каталогах с учетом прав доступа.

Также установите на рабочей станции `jq`.

В примерах CLI ниже используются переменные. На рабочей станции задайте их значения:

```bash
export VERSION={{ version }}
export IMAGE_NAME="stackland-${VERSION//./-}"
export ZONE=ru-central1-d
export NETWORK_NAME=stackland-network
export SUBNET_NAME=stackland-subnet
export SUBNET_CIDR=10.130.0.0/24
export NAT_GATEWAY_NAME=stackland-nat
export ROUTE_TABLE_NAME=stackland-routes
export SECURITY_GROUP_NAME=stackland-sg
export DNS_ZONE_NAME=stackland-internal
export BASE_DOMAIN=stackland.internal
export CLUSTER_NAME=main
export BASTION_NAME=stackland-bastion
```

## Подготовьте облачную сеть {#prepare-network}

Создайте облачную сеть и подсеть, в которой будут размещены бастионный хост и виртуальные машины кластера.

При подготовке сети учитывайте следующие требования:

* Все виртуальные машины кластера должны находиться в одной подсети. Это упрощает работу {{ network-load-balancer-name }} и целевой группы.
* Виртуальные машины кластера должны иметь стабильные внутренние IP-адреса.
* Бастионный хост должен иметь доступ в интернет и сетевой доступ к виртуальным машинам кластера.
* Узлы кластера должны иметь доступ в интернет через NAT-шлюз или другой сетевой механизм вашей инфраструктуры.

Если вы используете CLI, выполните команды:

```bash
yc vpc network create --name $NETWORK_NAME

yc vpc subnet create \
  --name $SUBNET_NAME \
  --zone $ZONE \
  --range $SUBNET_CIDR \
  --network-name $NETWORK_NAME

NETWORK_ID=$(yc vpc network get $NETWORK_NAME --format json | jq -r '.id')
```

Для выхода узлов в интернет через NAT-шлюз создайте шлюз, таблицу маршрутов и привяжите ее к подсети:

```bash
yc vpc gateway create --name $NAT_GATEWAY_NAME

GATEWAY_ID=$(yc vpc gateway get $NAT_GATEWAY_NAME --format json | jq -r '.id')

yc vpc route-table create \
  --name $ROUTE_TABLE_NAME \
  --network-name $NETWORK_NAME \
  --route destination=0.0.0.0/0,gateway-id=$GATEWAY_ID

yc vpc subnet update $SUBNET_NAME --route-table-name $ROUTE_TABLE_NAME
```

Для адресации внутри кластера создайте приватную DNS-зону. В примерах ниже используется домен `stackland.internal`:

```bash
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
  --add-rule "direction=ingress,protocol=any,port=any,predefined=self_security_group" \
  --add-rule "direction=ingress,protocol=tcp,port=22,v4-cidrs=<ip_адрес_администратора>/32" \
  --add-rule "direction=ingress,protocol=tcp,from-port=30000,to-port=32767,v4-cidrs=0.0.0.0/0" \
  --add-rule "direction=egress,protocol=any,port=any,v4-cidrs=0.0.0.0/0"
```

Правило для диапазона `30000-32767` нужно для доступа {{ network-load-balancer-name }} к NodePort-портам системного ingress. В примере указан стандартный диапазон NodePort в Kubernetes. Если в вашей конфигурации задан другой диапазон, укажите его в правиле группы безопасности. Для production-стендов ограничьте источник трафика в этом правиле согласно сетевой политике вашей организации.

В правилах с `protocol=any` укажите `port=any`: без поля порта команда `yc vpc security-group update-rules` возвращает ошибку `for rule spec port or [from/to]-port fields is required`. Если внешний IP администратора изменится, обновите SSH-правило с его новым адресом `/32`.

## Подготовьте сервисный аккаунт {#service-account}

Создайте сервисный аккаунт, который будет привязан к виртуальным машинам кластера. Назначьте ему роли:

* `load-balancer.admin` — для создания и удаления сетевых балансировщиков и целевых групп.
* `vpc.user` — для работы с ресурсами облачной сети.

Выполните команды. Идентификатор каталога для назначения ролей получите из созданного сервисного аккаунта: так роли будут назначены в том же каталоге, даже если при создании вы указали `--folder-id` или `--folder-name`:

```bash
yc iam service-account create --name stackland-yc-lb

SA_ID=$(yc iam service-account get stackland-yc-lb --format json | jq -r '.id')
FOLDER_ID=$(yc iam service-account get "$SA_ID" --format json | jq -r '.folder_id')

yc resource-manager folder add-access-binding "$FOLDER_ID" \
  --role load-balancer.admin \
  --subject serviceAccount:"$SA_ID"

yc resource-manager folder add-access-binding "$FOLDER_ID" \
  --role vpc.user \
  --subject serviceAccount:"$SA_ID"
```

## Создайте образ диска {#create-image}

Создайте пользовательский образ диска из raw-образа {{ stackland-name }}. Raw-образ доступен по адресу:

```text
https://storage.yandexcloud.net/stackland-public/stackland/$VERSION/images/stackland-amd64-$VERSION.raw
```

Создать образ можно по инструкции [Загрузить свой образ](https://yandex.cloud/ru/docs/compute/operations/image-create/upload).

Если вы используете CLI, выполните команду:

```bash
yc compute image create \
  --name "$IMAGE_NAME" \
  --source-uri https://storage.yandexcloud.net/stackland-public/stackland/$VERSION/images/stackland-amd64-$VERSION.raw \
  --os-type linux \
  --min-disk-size 150GB
```

Дождитесь, пока образ перейдет в состояние `READY`.

## Создайте бастионный хост {#create-bastion}

Создайте виртуальную машину с Ubuntu 22.04 или выше в той же подсети, где будут размещены узлы кластера.

Пример для Ubuntu 24.04 с публичным IP-адресом и SSH-ключом администратора:

```bash
yc compute instance create \
  --name $BASTION_NAME \
  --zone $ZONE \
  --platform standard-v3 \
  --cores 2 \
  --memory 4GB \
  --create-boot-disk name=$BASTION_NAME-boot,image-folder-id=standard-images,image-family=ubuntu-2404-lts,type=network-ssd,size=20,auto-delete=true \
  --network-interface subnet-name=$SUBNET_NAME,ipv4-address=10.130.0.10,nat-ip-version=ipv4,security-group-ids=$SECURITY_GROUP_ID \
  --ssh-key "$HOME/.ssh/id_ed25519.pub"

BASTION_IP=$(yc compute instance get $BASTION_NAME --format json | jq -r '.network_interfaces[0].primary_v4_address.one_to_one_nat.address')
printf '%s\n' "$BASTION_IP"
```

Если ваш публичный SSH-ключ находится в другом файле, измените путь в параметре `--ssh-key`. Дождитесь завершения первоначальной настройки Ubuntu перед установкой утилит.

В отдельном терминале на рабочей станции подключитесь к бастионному хосту, подставив полученный адрес вместо `<ip_бастиона>`:

```bash
ssh "yc-user@<ip_бастиона>"
```

Переменные рабочей станции не передаются в SSH-сессию автоматически. На бастионном хосте задайте ту же версию {{ stackland-name }} и тот же домен кластера:

```bash
export VERSION={{ version }}
export BASE_DOMAIN=stackland.internal
```

На бастионном хосте установите необходимые утилиты:

```bash
sudo apt update
sudo apt install unzip jq curl wget -y
```

Установите `kubectl`: он понадобится для проверки состояния кластера после установки. Для релиза `{{ version }}` используйте `{{ kubernetes-version }}` — версию Kubernetes в этом релизе. Согласно [правилам совместимости Kubernetes](https://kubernetes.io/releases/version-skew-policy/), версия `kubectl` может отличаться от версии API-сервера не более чем на один минорный выпуск.

```bash
KUBECTL_VERSION="{{ kubernetes-version }}"
curl -fsSLO "https://dl.k8s.io/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl"
curl -fsSLO "https://dl.k8s.io/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
```

Только после успешной проверки контрольной суммы установите бинарный файл:

```bash
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
```

Если вместо NAT-шлюза узлы выходят в интернет через бастионный хост, включите на нем IPv4-маршрутизацию и NAT, а маршрут `0.0.0.0/0` направьте на его внутренний IP-адрес. Пример настройки NAT приведен в руководстве [Установка {{ stackland-name }} на {{ baremetal-full-name }}](install-on-yc-bms.md#net-settings).

## Создайте виртуальные машины кластера {#create-vms}

Вернитесь в терминал рабочей станции с настроенным CLI для {{ yandex-cloud }}. Создайте не менее трех виртуальных машин для кластера {{ stackland-name }}.

Для каждой виртуальной машины задайте следующие параметры:

* Загрузочный диск — из пользовательского образа `$IMAGE_NAME`.
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

Метка `cluster-name` обязательна для компонента `yandexcloud-lb`. Без нее оператор балансировщика не сможет получить имя кластера из metadata-сервиса {{ yandex-cloud }} и будет перезапускаться с ошибкой `failed to get cluster name from metadata: metadata service returned status 404`.

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
  --create-boot-disk name=node1-boot,image-name=$IMAGE_NAME,type=network-ssd,size=150,auto-delete=true \
  --create-disk name=node1-data,type=network-ssd,size=800,device-name=data,auto-delete=true \
  --network-interface subnet-name=$SUBNET_NAME,ipv4-address=10.130.0.11,security-group-ids=$SECURITY_GROUP_ID \
  --service-account-name stackland-yc-lb
```

Создайте остальные узлы по этому примеру, изменив имена, FQDN, IP-адреса и имена дисков.

После создания виртуальных машин запишите для каждого узла:

* FQDN или имя, которое будет использоваться в конфигурации {{ stackland-name }}.
* Внутренний IP-адрес.
* MAC-адрес сетевого интерфейса.
* Имя загрузочного диска внутри гостевой ОС. Обычно это `/dev/vda`, но проверьте значение для вашей конфигурации.
* Имя диска для данных внутри гостевой ОС. Обычно это `/dev/vdb`, если к виртуальной машине подключен один дополнительный диск.

IP- и MAC-адреса сетевых интерфейсов можно получить через CLI:

```bash
for node in node1 node2 node3; do
  yc compute instance get "$node" --format json |
    jq -r --arg node "$node" '.network_interfaces[] | [$node, .primary_v4_address.address, .mac_address] | @tsv'
done
```

Перенесите полученные MAC-адреса в `StacklandHostsList`: значения в примере конфигурации ниже предназначены только для иллюстрации.

## Настройте DNS {#dns}

На рабочей станции настройте DNS-записи для домена кластера.

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

Если адрес сетевого балансировщика неизвестен заранее, создайте или обновите wildcard-запись после завершения установки и создания {{ network-load-balancer-name }}.

До установки создайте запись для API Kubernetes:

```bash
yc dns zone add-records $DNS_ZONE_NAME \
  --record "api.sys 300 A 10.130.0.11" \
  --record "api.sys 300 A 10.130.0.12" \
  --record "api.sys 300 A 10.130.0.13"
```

После установки получите внешний IP-адрес {{ network-load-balancer-name }} на бастионном хосте и добавьте wildcard-запись с рабочей станции, как описано в разделе [Проверьте установку](#check-installation).

## Подготовьте конфигурацию {{ stackland-name }} {#prepare-config}

Создайте на бастионном хосте папку `config/` и сохраните в ней конфигурационные файлы кластера.

{% note info "Note" %}

Для балансировщика `yandex-nlb` не указывайте `ipPools`. Этот параметр не поддерживается {{ network-load-balancer-name }}.

{% endnote %}

Пример конфигурации кластера:

```yaml
apiVersion: stackland.yandex.cloud/v1alpha1
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
        - 0.ru.pool.ntp.org
        - ntp0.NL.net
```

В подсети `10.130.0.0/24` облачный [DNS-резолвер](https://yandex.cloud/ru/docs/dns/concepts/dns-resolver) доступен по адресу `10.130.0.2`. Если используете другую подсеть, укажите адрес ее DNS-резолвера в `resolvers`. Он должен разрешать имена в созданной приватной DNS-зоне.

Для синхронизации времени в примере используются публичные NTP-серверы из [рекомендованного списка {{ yandex-cloud }}](https://yandex.cloud/ru/docs/compute/tutorials/ntp). Обеспечьте узлам доступ к ним по UDP/123 через NAT-шлюз. Если используете собственные NTP-серверы, укажите их адреса в `timeservers`.

В {{ compute-name }} сетевые диски виртуальных машин отображаются как VirtIO-устройства. {{ stackland-name }} относит такие диски к Storage Class `stackland-other`, поэтому для этого сценария укажите `defaultStorageClass: stackland-other`.

Если указать `stackland-ssd`, постоянные тома для системных компонентов могут остаться в состоянии `Pending`, а в событиях подов будет сообщение `did not have enough free storage`.

Пример конфигурации хостов:

```yaml
apiVersion: stackland.yandex.cloud/v1alpha1
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

Поместите файл с лицензионным ключом на бастионный хост в рабочую директорию `sladm` под именем `key.json`. На бастионном хосте сгенерируйте ресурс `StacklandSecretsConfig`:

```bash
./sladm secrets add --out config/secrets.yaml --license-key key.json
```

Где `key.json` — файл с лицензионным ключом {{ stackland-name }}.

## Установите кластер {#install}

На бастионном хосте проверьте конфигурацию перед установкой:

```bash
./sladm validate --config config/
```

Запустите установку:

```bash
set -o pipefail
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
   kubectl get svc -n stackland-ingress envoy -o wide
   ```

   В поле `ADDRESS` у ingress-ресурсов должен быть внешний IP-адрес {{ network-load-balancer-name }}.

Если wildcard-запись `*.sys.$baseDomain` еще не указывает на адрес {{ network-load-balancer-name }}, получите адрес созданного балансировщика и обновите DNS-запись.

На бастионном хосте получите адрес балансировщика:

```bash
INGRESS_IP=$(kubectl get svc -n stackland-ingress envoy -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
printf '%s\n' "$INGRESS_IP"
```

На рабочей станции задайте `INGRESS_IP`, подставив выведенный адрес вместо `<ip_балансировщика>`, и создайте DNS-запись:

```bash
export INGRESS_IP="<ip_балансировщика>"
yc dns zone add-records $DNS_ZONE_NAME \
  --record "*.sys 300 A $INGRESS_IP"
```

Если вы проверяете доступ с рабочей станции и не используете публичную DNS-зону, добавьте записи в файл `hosts` на вашем компьютере:

```text
<ip_балансировщика> console.sys.stackland.internal auth.sys.stackland.internal kubeconfig.sys.stackland.internal grafana.sys.stackland.internal docs.sys.stackland.internal
```

Публичная DNS-зона для установки не требуется: приватная зона доступна внутри подключенной облачной сети. Если рабочая станция находится вне этой сети, используйте VPN с доступом к приватному DNS или записи `hosts` для нужных имен. Wildcard-запись через `hosts` задать нельзя, поэтому каждый проверяемый эндпоинт нужно перечислить отдельно.

Системные HTTPS-эндпоинты могут использовать сертификат внутреннего удостоверяющего центра {{ stackland-name }}. Если рабочая станция не доверяет этому центру, браузер покажет предупреждение, а `curl` вернет ошибку проверки сертификата. Для штатного доступа добавьте корневой сертификат центра в доверенные на рабочей станции или настройте домен с доверенным сертификатом. Флаг `-k` в команде ниже нужен только для проверки сетевой доступности.

{% note info "Note" %}

Если открыть IP-адрес {{ network-load-balancer-name }} напрямую в браузере, ingress вернет ответ `default backend - 404`. Это ожидаемое поведение: маршрутизация выполняется по имени хоста. Открывайте консоль по адресу `https://console.sys.$baseDomain`.

{% endnote %}

Проверьте, что доступны системные эндпоинты:

* `https://console.sys.$baseDomain` — консоль управления кластером.
* `https://grafana.sys.$baseDomain` — графики кластера в Grafana.

На рабочей станции проверьте доступ к консоли управления:

```bash
curl -I --max-time 10 -H "Host: console.sys.$BASE_DOMAIN" http://$INGRESS_IP
curl -kI --max-time 10 \
  --resolve console.sys.$BASE_DOMAIN:443:$INGRESS_IP \
  https://console.sys.$BASE_DOMAIN
```

Ожидаемый результат:

* HTTP-запрос возвращает редирект на HTTPS.
* HTTPS-запрос возвращает редирект на страницу входа или саму страницу входа с кодом `200`.

На рабочей станции проверьте состояние целевой группы балансировщика:

```bash
yc load-balancer network-load-balancer list
yc load-balancer target-group list
yc load-balancer network-load-balancer target-states <имя_или_id_балансировщика> \
  --target-group-id <id_целевой_группы>
```

Все узлы должны перейти в состояние `HEALTHY`.

Если узлы остаются в состоянии `UNHEALTHY`, проверьте доступность NodePort-порта ingress с бастионного хоста:

```bash
INGRESS_HTTP_NODEPORT=$(kubectl get svc -n stackland-ingress envoy -o jsonpath='{.spec.ports[?(@.port==80)].nodePort}')

for ip in <ip_узла_1> <ip_узла_2> <ip_узла_3>; do
  timeout 3 bash -c "</dev/tcp/$ip/$INGRESS_HTTP_NODEPORT" && \
    echo "$ip:$INGRESS_HTTP_NODEPORT open" || \
    echo "$ip:$INGRESS_HTTP_NODEPORT closed"
done
```

Если NodePort доступен из подсети, но целевая группа остается в состоянии `UNHEALTHY`, проверьте:

* правила групп безопасности для входящего трафика от {{ network-load-balancer-name }} к NodePort-портам узлов;
* сетевые ACL, маршруты и NAT-правила, которые могут влиять на обратный трафик от узлов к проверкам состояния {{ network-load-balancer-name }};
* что в целевой группе указаны внутренние IP-адреса всех узлов;
* что сервис `stackland-ingress/envoy` использует те же NodePort-порты, что и {{ network-load-balancer-name }}.

Для дополнительной проверки ingress из подсети выполните с бастионного хоста:

```bash
curl -I --max-time 10 -H "Host: console.sys.$BASE_DOMAIN" \
  http://<ip_любого_узла>:$INGRESS_HTTP_NODEPORT
```

Ожидаемый ответ — HTTP-редирект на HTTPS или страницу входа.

## Устранение неполадок {#troubleshooting}

В этом разделе приведены проблемы, характерные для установки {{ stackland-name }} на виртуальные машины в {{ yandex-cloud }}. Общие проблемы установки см. в разделе [Диагностика и устранение неполадок](../operations/troubleshooting.md).

### `yandexcloud-lb` перезапускается с ошибкой metadata-сервиса {#yandexcloud-lb-metadata}

Если установка останавливается на компонентах `load-balancer` или `ingress`, на бастионном хосте проверьте поды компонента балансировщика:

```bash
kubectl get pod -n stackland-load-balancer
kubectl logs -n stackland-load-balancer deploy/yandexcloud-lb --tail=100
```

Если в логах есть ошибка `failed to get cluster name from metadata: metadata service returned status 404`, на рабочей станции проверьте, что у всех виртуальных машин кластера есть метка `cluster-name`, совпадающая с `metadata.name` в ресурсе `StacklandClusterConfig`:

```bash
yc compute instance add-labels node1 --labels cluster-name=$CLUSTER_NAME
yc compute instance add-labels node2 --labels cluster-name=$CLUSTER_NAME
yc compute instance add-labels node3 --labels cluster-name=$CLUSTER_NAME
```

После добавления метки на бастионном хосте перезапустите под `yandexcloud-lb`:

```bash
kubectl delete pod -n stackland-load-balancer -l app.kubernetes.io/name=yandexcloud-lb
```

### PVC остаются в состоянии `Pending` {#pending-pvc}

Если установка останавливается на компонентах `iam`, `logging` или `storage`, а в событиях подов есть сообщение `did not have enough free storage`, на бастионном хосте проверьте Storage Class и емкость TopoLVM:

```bash
kubectl get nodes -o json | jq -r '.items[] | [
  .metadata.name,
  .metadata.annotations["capacity.topolvm.io/stackland-other"],
  .metadata.annotations["capacity.topolvm.io/stackland-ssd"]
] | @tsv'
kubectl get pvc -A
```

Команда выводит имя узла и свободную емкость для Storage Class `stackland-other` и `stackland-ssd`. TopoLVM хранит эти значения в аннотациях узлов. Для виртуальных машин в {{ compute-name }} емкость должна быть доступна в аннотации `capacity.topolvm.io/stackland-other`. В конфигурации установки должен быть указан параметр:

```yaml
storage:
  defaultStorageClass: stackland-other
```

Если PVC уже созданы с `stackland-ssd`, измените конфигурацию и перезапустите установку. На тестовом стенде без пользовательских данных можно удалить только те PVC, которые находятся в состоянии `Pending`, чтобы операторы пересоздали их с правильным Storage Class.

## См. также {#see-also}

* [Руководство по установке](../quickstart.md)
* [Установка {{ stackland-name }} на {{ baremetal-full-name }}](install-on-yc-bms.md)
* [Диагностика и устранение неполадок](../operations/troubleshooting.md)
