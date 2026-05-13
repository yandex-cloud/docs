# Создание нового Kubernetes-проекта в Yandex Cloud


В этой статье описан запуск нового Kubernetes-проекта в Yandex Cloud. Приложение из [Yandex Container Registry](../../container-registry/index.md) будет развернуто в [кластере Managed Service for Kubernetes](../concepts/index.md#kubernetes-cluster) и опубликовано в интернете через Ingress-контроллер [Yandex Application Load Balancer](../../application-load-balancer/index.md).

Если вам нужно создать кластер Managed Service for Kubernetes без доступа в интернет, обратитесь к разделу [Создание и настройка кластера Kubernetes без доступа в интернет](k8s-cluster-with-no-internet.md).

Чтобы запустить приложение:

1. [Создайте сервисные аккаунты](#create-sa).
1. [Создайте группы безопасности](#create-sg).
1. [Подготовьте ресурсы Kubernetes](#create-k8s-res).
1. [Подключитесь к кластеру Managed Service for Kubernetes](#cluster-connect).
1. [Подготовьте ресурсы Container Registry](#create-cr-res).
1. [Установите Application Load Balancer](#setup-alb).
1. [Создайте балансировщик нагрузки](#create-ingress).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за DNS-зону и DNS-запросы (см. [тарифы Cloud DNS](../../dns/pricing.md)).
* Плата за кластер Managed Service for Kubernetes: использование мастера и исходящий трафик (см. [тарифы Managed Service for Kubernetes](../pricing.md)).
* Плата за узлы кластера (ВМ): использование вычислительных ресурсов, операционной системы и хранилища (см. [тарифы Compute Cloud](../../compute/pricing.md)).
* Плата за сервис Container Registry: использование хранилища и исходящий трафик (см. [тарифы Container Registry](../../container-registry/pricing.md)).
* Плата за использование вычислительных ресурсов L7-балансировщика (см. [тарифы Application Load Balancer](../../application-load-balancer/pricing.md)).
* Плата за публичный IP-адрес для L7-балансировщика (см. [тарифы Virtual Private Cloud](../../vpc/pricing.md#prices-public-ip)).


## Перед началом работы {#before-you-begin}

1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

   По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

1. Установите [утилиту потоковой обработки JSON-файлов](https://stedolan.github.io/jq/) `jq`:

   ```bash
   sudo apt update && sudo apt install jq
   ```

### Создайте сеть и подсеть {#create-network}

1. [Создайте сеть](../../vpc/operations/network-create.md) с именем `yc-auto-network`:

   ```bash
   yc vpc network create --name yc-auto-network
   ```

1. [Создайте подсеть](../../vpc/operations/subnet-create.md) в [зоне доступности](../../overview/concepts/geo-scope.md) `ru-central1-a`:

   ```bash
   yc vpc subnet create \
     --name yc-auto-subnet-0 \
     --network-name yc-auto-network \
     --range 192.168.1.0/24 \
     --zone ru-central1-a
   ```

{% note warning %}

Не изменяйте и не удаляйте ресурсы Virtual Private Cloud, которые используются кластером Managed Service for Kubernetes. Это может привести к некорректной работе кластера и невозможности его последующего удаления.

{% endnote %}

### Зарегистрируйте доменную зону и добавьте сертификат {#register-domain}

1. [Зарегистрируйте публичную доменную зону и делегируйте домен](../../dns/operations/zone-create-public.md).

1. Если у вас уже есть [сертификат](../../certificate-manager/concepts/index.md#types) для [доменной зоны](../../dns/concepts/dns-zone.md), [добавьте сведения о нем](../../certificate-manager/operations/import/cert-create.md) в сервис [Yandex Certificate Manager](../../certificate-manager/index.md).

   Если у вас нет сертификата, выпустите новый сертификат от Let's Encrypt® и [добавьте](../../certificate-manager/operations/managed/cert-create.md) его в Certificate Manager.
1. Получите идентификатор сертификата:

   ```bash
   yc certificate-manager certificate list
   ```

   Результат:

   ```text
   +-----------------+-------+----------------+---------------------+----------+--------+
   |       ID        | NAME  |    DOMAINS     |      NOT AFTER      |   TYPE   | STATUS |
   +-----------------+-------+----------------+---------------------+----------+--------+
   | <идентификатор> | <имя> | <доменное_имя> | 2022-04-06 17:19:37 | IMPORTED | ISSUED |
   +-----------------+-------+----------------+---------------------+----------+--------+
   ```

## Создайте сервисные аккаунты {#create-sa}

Для работы кластера Managed Service for Kubernetes и [балансировщика нагрузки](../../application-load-balancer/concepts/application-load-balancer.md) нужны [сервисные аккаунты](../../iam/concepts/users/service-accounts.md):
* Сервисный аккаунт с [ролями](../security/index.md#yc-api) `k8s.clusters.agent` и `vpc.publicAdmin` на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создается кластер Managed Service for Kubernetes. От имени этого сервисного аккаунта будут создаваться ресурсы, необходимые кластеру Managed Service for Kubernetes.
* Сервисный аккаунт с ролью [container-registry.images.puller](../../container-registry/security/index.md#container-registry-images-puller) на каталог с [реестром](../../container-registry/concepts/registry.md) [Docker-образов](../../container-registry/concepts/docker-image.md). От имени этого сервисного аккаунта [узлы](../concepts/index.md#node-group) будут скачивать из реестра необходимые Docker-образы.
* Для работы Ingress-контроллера Application Load Balancer, с ролями:
  * [alb.editor](../../application-load-balancer/security/index.md#alb-editor) — для создания необходимых ресурсов.
  * [vpc.publicAdmin](../../vpc/security/index.md#vpc-public-admin) — для управления [внешней связностью](../../vpc/security/index.md#roles-list).
  * [certificate-manager.certificates.downloader](../../certificate-manager/security/index.md#certificate-manager-certificates-downloader) — для работы с сертификатами, зарегистрированными в сервисе [Certificate Manager](../../certificate-manager/index.md).
  * [compute.viewer](../../compute/security/index.md#compute-viewer) — для использования узлов кластера Managed Service for Kubernetes в [целевых группах](../../application-load-balancer/concepts/target-group.md) балансировщика нагрузки.

### Сервисный аккаунт для ресурсов {#res-sa}

Чтобы создать сервисный аккаунт, от имени которого будут создаваться ресурсы, необходимые кластеру Managed Service for Kubernetes:
1. Запишите в переменную идентификатор каталога из конфигурации вашего профиля Yandex Cloud CLI:

   {% list tabs group=programming_language %}

   - Bash {#bash}

     ```bash
     FOLDER_ID=$(yc config get folder-id)
     ```

   - PowerShell {#powershell}

     ```shell script
     $FOLDER_ID = yc config get folder-id
     ```

   {% endlist %}

1. Создайте сервисный аккаунт:

   {% list tabs group=programming_language %}

   - Bash {#bash}

     ```bash
     yc iam service-account create --name k8s-res-sa-$FOLDER_ID
     ```

   - PowerShell {#powershell}

     ```shell script
     yc iam service-account create --name k8s-res-sa-$FOLDER_ID
     ```

   {% endlist %}

1. Запишите в переменную идентификатор сервисного аккаунта:

   {% list tabs group=programming_language %}

   - Bash {#bash}

     ```bash
     RES_SA_ID=$(yc iam service-account get --name k8s-res-sa-$FOLDER_ID --format json | jq .id -r)
     ```

   - PowerShell {#powershell}

     ```shell script
     $RES_SA_ID = (yc iam service-account get --name k8s-res-sa-$FOLDER_ID --format json | ConvertFrom-Json).id
     ```

   {% endlist %}

1. Назначьте сервисному аккаунту роль [editor](../../iam/roles-reference.md#editor) на каталог:

   ```bash
   yc resource-manager folder add-access-binding \
     --id $FOLDER_ID \
     --role editor \
     --subject serviceAccount:$RES_SA_ID
   ```

### Сервисный аккаунт для узлов {#node-sa}

Чтобы создать сервисный аккаунт, от имени которого узлы будут скачивать из реестра необходимые Docker-образы.
1. Запишите в переменную идентификатор каталога из конфигурации вашего профиля Yandex Cloud CLI:

   {% list tabs group=programming_language %}

   - Bash {#bash}

     ```bash
     FOLDER_ID=$(yc config get folder-id)
     ```

   - PowerShell {#powershell}

     ```shell script
     $FOLDER_ID = yc config get folder-id
     ```

   {% endlist %}

1. Создайте сервисный аккаунт:

   {% list tabs group=programming_language %}

   - Bash {#bash}

     ```bash
     yc iam service-account create --name k8s-node-sa-$FOLDER_ID
     ```

   - PowerShell {#powershell}

     ```shell script
     yc iam service-account create --name k8s-node-sa-$FOLDER_ID
     ```

   {% endlist %}

1. Запишите в переменную идентификатор сервисного аккаунта:

   {% list tabs group=programming_language %}

   - Bash {#bash}

     ```bash
     NODE_SA_ID=$(yc iam service-account get --name k8s-node-sa-$FOLDER_ID --format json | jq .id -r)
     ```

   - PowerShell {#powershell}

     ```shell script
     $NODE_SA_ID = (yc iam service-account get --name k8s-node-sa-$FOLDER_ID --format json | ConvertFrom-Json).id
     ```

   {% endlist %}

1. Назначьте сервисному аккаунту роль [container-registry.images.puller](../../container-registry/security/index.md#container-registry-images-puller) на каталог:

   ```bash
   yc resource-manager folder add-access-binding \
     --id $FOLDER_ID \
     --role container-registry.images.puller \
     --subject serviceAccount:$NODE_SA_ID
   ```

### Сервисный аккаунт, необходимый для работы Application Load Balancer Ingress-контроллера {#ic-sa}

1. Запишите в переменную идентификатор каталога из конфигурации вашего профиля Yandex Cloud CLI:

   {% list tabs group=programming_language %}

   - Bash {#bash}

     ```bash
     FOLDER_ID=$(yc config get folder-id)
     ```

   - PowerShell {#powershell}

     ```shell script
     $FOLDER_ID = yc config get folder-id
     ```

   {% endlist %}

1. Создайте сервисный аккаунт:

   {% list tabs group=programming_language %}

   - Bash {#bash}

     ```bash
     yc iam service-account create --name k8s-ic-sa-$FOLDER_ID
     ```

   - PowerShell {#powershell}

     ```shell script
     yc iam service-account create --name k8s-ic-sa-$FOLDER_ID
     ```

   {% endlist %}

1. Запишите в переменную идентификатор сервисного аккаунта:

   {% list tabs group=programming_language %}

   - Bash {#bash}

     ```bash
     IC_SA_ID=$(yc iam service-account get --name k8s-ic-sa-$FOLDER_ID --format json | jq .id -r)
     ```

   - PowerShell {#powershell}

     ```shell script
     $RES_SA_ID = (yc iam service-account get --name k8s-ic-sa-$FOLDER_ID --format json | ConvertFrom-Json).id
     ```

   {% endlist %}

1. Назначьте сервисному аккаунту роли на каталог:
   * [alb.editor](../../application-load-balancer/security/index.md#alb-editor).
   * [vpc.publicAdmin](../../vpc/security/index.md#vpc-public-admin).
   * [certificate-manager.certificates.downloader](../../certificate-manager/security/index.md#certificate-manager-certificates-downloader).
   * [compute.viewer](../../compute/security/index.md#compute-viewer).

   ```bash
   yc resource-manager folder add-access-binding \
     --id $FOLDER_ID \
     --role alb.editor \
     --role vpc.publicAdmin \
     --role certificate-manager.certificates.downloader \
     --role compute.viewer \
     --subject serviceAccount:$IC_SA_ID
   ```

1. Создайте для сервисного аккаунта [авторизованный ключ](../../iam/concepts/authorization/access-key.md) и сохраните в файл `sa-key.json`:

   ```bash
   yc iam key create \
     --service-account-id $IC_SA_ID \
     --output sa-key.json
   ```

## Создайте группы безопасности {#create-sg}

[Создайте группы безопасности](../operations/connect/security-groups.md) для кластера Managed Service for Kubernetes и входящих в него групп узлов.

Для доступа к Container Registry в группе безопасности узлов [добавьте правило](../operations/connect/security-groups.md#rules-internal-nodegroup) для исходящего трафика, разрешающее узлам подключаться к внешним ресурсам.

Также [настройте](../../application-load-balancer/tools/k8s-ingress-controller/security-groups.md) группы безопасности, необходимые для работы Application Load Balancer.

{% note warning %}

От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.

{% endnote %}

## Подготовьте ресурсы Kubernetes {#create-k8s-res}

## Подготовьте ресурсы Kubernetes {#create-k8s-res}

### Создайте кластер Managed Service for Kubernetes {#create-cluster}

{% note tip %}

В данном примере используются базовые параметры кластера. Часть настроек, например выбор [Container Network Interface](https://kubernetes.io/docs/concepts/extend-kubernetes/compute-storage-net/network-plugins/), [шифрование секретов](../concepts/encryption.md#k8s-secrets-encryption) с помощью Yandex Key Management Service и ряд других, нельзя изменить после создания кластера. Рекомендуем ознакомиться с подробной [инструкцией по созданию кластера Managed Service for Kubernetes](../operations/kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create).

{% endnote %}

Создайте [кластер Managed Service for Kubernetes](../concepts/index.md#kubernetes-cluster) и укажите ранее созданные [сервисные аккаунты](../../iam/concepts/users/service-accounts.md) в параметрах `--service-account-id` и `--node-service-account-id`, и группы безопасности в параметре `--security-group-ids`.

{% list tabs group=programming_language %}

- Bash {#bash}

  Выполните команду:

  ```bash
  yc managed-kubernetes cluster create \
    --name k8s-demo \
    --network-name yc-auto-network \
    --zone ru-central1-a \
    --subnet-name yc-auto-subnet-0 \
    --public-ip \
    --service-account-id $RES_SA_ID \
    --node-service-account-id $NODE_SA_ID \
    --security-group-ids <идентификаторы_групп_безопасности>
  ```

- PowerShell {#powershell}

  Выполните команду:

  ```shell script
  yc managed-kubernetes cluster create `
    --name k8s-demo `
    --network-name yc-auto-network `
    --zone ru-central1-a `
    --subnet-name yc-auto-subnet-0 `
    --public-ip `
    --service-account-id $RES_SA_ID `
    --node-service-account-id $NODE_SA_ID `
    --security-group-ids <идентификаторы_групп_безопасности>
  ```

{% endlist %}

### Создайте группу узлов Managed Service for Kubernetes {#create-node-groups}

{% note warning %}

Для доступа к Container Registry узлам кластера должен быть назначен публичный IP-адрес. Либо в подсети узлов должен быть настроен [NAT-шлюз](../../vpc/operations/create-nat-gateway.md) или [NAT-инстанс](../../vpc/tutorials/nat-instance/index.md).

Подробнее см. в разделе [Доступ в интернет для рабочих узлов кластера](../concepts/network.md#nodes-internet).

{% endnote %}

1. Проверьте, что создание кластера Managed Service for Kubernetes успешно завершено.
   1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором был создан кластер Managed Service for Kubernetes.
   1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;Kubernetes**.
   1. Проверьте, что кластер Managed Service for Kubernetes успешно создан:
      * В столбце **Статус** должно быть указано `Running`.
      * В столбце **Состояние** должно быть указано `Healthy`.
1. Создайте [группу узлов Managed Service for Kubernetes](../concepts/index.md#node-group) и укажите ранее созданные группы безопасности в параметре `--network-interface security-group-ids`:

   {% list tabs group=programming_language %}

   - Bash {#bash}

     ```bash
     yc managed-kubernetes node-group create \
       --name k8s-demo-ng \
       --cluster-name k8s-demo \
       --platform standard-v3 \
       --cores 2 \
       --memory 4 \
       --core-fraction 50 \
       --disk-type network-ssd \
       --fixed-size 2 \
       --network-interface subnets=yc-auto-subnet-0,ipv4-address=nat,security-group-ids=[<идентификаторы_групп_безопасности>] \
       --async
     ```

   - PowerShell {#powershell}

     ```shell script
     yc managed-kubernetes node-group create `
       --name k8s-demo-ng `
       --cluster-name k8s-demo `
       --platform standard-v3 `
       --cores 2 `
       --memory 4 `
       --core-fraction 50 `
       --disk-type network-ssd `
       --fixed-size 2 `
       --network-interface subnets=yc-auto-subnet-0,ipv4-address=nat,security-group-ids=[<идентификаторы_групп_безопасности>] `
       --async
     ```

   {% endlist %}

## Подключитесь к кластеру Managed Service for Kubernetes {#cluster-connect}

[Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../operations/connect/index.md#kubectl-connect).

## Подготовьте ресурсы Container Registry {#create-cr-res}

### Создайте реестр {#registry-create}

Создайте реестр контейнеров:

```bash
yc container registry create --name yc-auto-cr
```

### Сконфигурируйте Docker Credential helper {#config-ch}

Для упрощения аутентификации в Container Registry сконфигурируйте [Docker Credential helper](../../container-registry/operations/authentication.md#cred-helper). Он позволяет работать с приватными реестрами Yandex Cloud, не выполняя команду `docker login`.

Для настройки Credential helper выполните команду:

```bash
yc container registry configure-docker
```

### Подготовьте Docker-образ {#docker-image}

Соберите Docker-образ и загрузите его в реестр.
1. Создайте Dockerfile `hello.dockerfile` и сохраните в него следующие строки:

   ```docker
   FROM nginx
   CMD echo "Hi, I'm inside"
   ```

1. Соберите Docker-образ.
   1. Получите идентификатор реестра, [созданного ранее](#registry-create), и запишите его в переменную:

      {% list tabs group=programming_language %}

      - Bash {#bash}

        ```bash
        REGISTRY_ID=$(yc container registry get --name yc-auto-cr --format json | jq .id -r)
        ```

      - PowerShell {#powershell}

        ```shell script
        $REGISTRY_ID = (yc container registry get --name yc-auto-cr --format json | ConvertFrom-Json).id
        ```

      {% endlist %}

   1. Соберите Docker-образ:

      ```bash
      docker build . -f hello.dockerfile -t cr.yandex/$REGISTRY_ID/nginx:hello
      ```

   1. Загрузите Docker-образ в реестр:

      ```bash
      docker push cr.yandex/$REGISTRY_ID/nginx:hello
      ```

1. Проверьте, что Docker-образ загрузился в реестр:

   ```bash
   yc container image list
   ```

   Результат:

   ```text
   +----------------------+---------------------+----------------------------+-------+-----------------+
   |          ID          |       CREATED       |            NAME            | TAGS  | COMPRESSED SIZE |
   +----------------------+---------------------+----------------------------+-------+-----------------+
   | crpa2mf008mp******** | 2019-11-20 11:52:17 | crp71hkgiolp********/nginx | hello | 27.5 MB         |
   +----------------------+---------------------+----------------------------+-------+-----------------+
   ```

### Запустите тестовое приложение {#test-app}

Создайте [под](../concepts/index.md#pod) с приложением из Docker-образа и убедитесь, что для загрузки Docker-образа не потребовалась дополнительная аутентификация в Container Registry.
1. Запустите под с приложением из Docker-образа:

   ```bash
   kubectl run --attach hello-nginx --image cr.yandex/$REGISTRY_ID/nginx:hello
   ```

1. Убедитесь, что под перешел в состояние `Running`, и узнайте его полное имя:

   ```bash
   kubectl get pods
   ```

   Результат:

   ```text
   NAME                          READY  STATUS   RESTARTS  AGE
   hello-nginx-5847fb96**-*****  1/1    Running  0         1h
   ```

1. Посмотрите логи контейнера, запущенного на этом поде:

   ```bash
   kubectl logs hello-nginx-5847fb96**-*****
   ```

   Результат:

   ```text
   Hi, I'm inside
   ```

   Под загрузил Docker-образ без дополнительной аутентификации на стороне Container Registry.

## Установите Application Load Balancer {#setup-alb}

Чтобы установить [Application Load Balancer](https://yandex.cloud/ru/marketplace/products/yc/alb-ingress-controller), [воспользуйтесь инструкцией](../operations/applications/alb-ingress-controller.md).

## Создайте балансировщик нагрузки {#create-ingress}

1. Создайте балансировщик нагрузки для [сервисов Kubernetes](../concepts/index.md#service).
   1. Создайте файл `ingress.yaml` с манифестом Ingress-контроллера:

      ```yaml
      ---
      apiVersion: networking.k8s.io/v1
      kind: Ingress
      metadata:
        name: alb-demo-tls
        annotations:
          ingress.alb.yc.io/subnets: <список_идентификаторов_подсетей>
          ingress.alb.yc.io/security-groups: <список_идентификаторов_групп_безопасности>
          ingress.alb.yc.io/external-ipv4-address: <способ_назначения_IP-адреса>
          ingress.alb.yc.io/group-name: <имя_группы_ресурсов_Ingress>
      spec:
        tls:
          - hosts:
              - <доменное_имя>
            secretName: yc-certmgr-cert-id-<идентификатор_TLS-сертификата>
        rules:
          - host: <доменное_имя>
            http:
              paths:
                - pathType: Prefix
                  path: "/"
                  backend:
                    service:
                      name: service-hello
                      port:
                        name: http
      ---
      apiVersion: v1
      kind: Service
      metadata:
        name: service-hello
      spec:
        selector:
          run: hello-nginx
        type: NodePort
        ports:
          - name: http
            port: 80
            targetPort: 80
            protocol: TCP
            nodePort: 30080
      ```

      Где:
      * `ingress.alb.yc.io/subnets` — укажите одну или несколько [подсетей](../../vpc/concepts/network.md#subnet), с которыми будет работать Application Load Balancer.
      * `ingress.alb.yc.io/security-groups` — укажите одну или несколько [групп безопасности](../../application-load-balancer/concepts/application-load-balancer.md#security-groups) для Application Load Balancer. Если параметр не задан, используется группа безопасности по умолчанию. Хотя бы одна из групп безопасности должна разрешать исходящее TCP-соединение к порту 10501 в подсети группы узлов или в ее группу безопасности.
      * `ingress.alb.yc.io/external-ipv4-address` — чтобы получить новый и предоставить публичный доступ к Application Load Balancer из интернета, укажите [заранее полученный IP-адрес](../../vpc/operations/get-static-ip.md), либо установите значение `auto`.

        Если вы указали значение `auto`, то при удалении Ingress-контроллера IP-адрес также будет удален из облака. Чтобы избежать этого, используйте имеющийся зарезервированный адрес.
      * `ingress.alb.yc.io/group-name` — укажите имя группы. Группа объединяет ресурсы Kubernetes Ingress, обслуживаемые отдельным экземпляром Application Load Balancer.
   1. Создайте балансировщик нагрузки:

      ```bash
      kubectl apply -f ingress.yaml
      ```

   1. Дождитесь создания балансировщика нагрузки и получения им публичного IP-адреса, это может занять несколько минут:

      ```bash
      kubectl get ingress alb-demo-tls
      ```

      Ожидаемый результат — непустое значение в поле `ADDRESS` для созданного балансировщика нагрузки:

      ```bash
      NAME          CLASS   HOSTS           ADDRESS     PORTS    AGE
      alb-demo-tls  <none>  <доменное_имя>  <IP-адрес>  80, 443  15h
      ```

      По конфигурации балансировщика нагрузки будет автоматически развернут [L7-балансировщик](../../application-load-balancer/concepts/application-load-balancer.md).
1. Перейдите по ссылке `https://<доменное_имя>` и убедитесь, что ваше приложение успешно опубликовано.

    {% note info %}
    
    Если ресурс недоступен по указанному URL, то [убедитесь](../operations/connect/security-groups.md), что группы безопасности для кластера Managed Service for Kubernetes и его групп узлов настроены корректно. Если отсутствует какое-либо из правил — [добавьте его](../../vpc/operations/security-group-add-rule.md).
    
    {% endnote %}

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. [Удалите кластер Managed Service for Kubernetes](../operations/kubernetes-cluster/kubernetes-cluster-delete.md):

   ```bash
   yc managed-kubernetes cluster delete --name k8s-demo
   ```

1. Удалите сервисные аккаунты.
   * Удалите сервисный аккаунт для ресурсов:

     ```bash
     yc iam service-account delete --id $RES_SA_ID
     ```

   * Удалите сервисный аккаунт для узлов:

     ```bash
     yc iam service-account delete --id $NODE_SA_ID
     ```

   * Удалите сервисный аккаунт для балансировщика нагрузки:

     ```bash
     yc iam service-account delete --id $IC_SA_ID
     ```

1. Удалите ресурсы Container Registry.
   1. Узнайте идентификатор Docker-образа, загруженного в реестр:

      {% list tabs group=programming_language %}

      - Bash {#bash}

        ```bash
        IMAGE_ID=$(yc container image list --format json | jq .[0].id -r)
        ```

      - PowerShell {#powershell}

        ```powershell
        $IMAGE_ID = (yc container image list --format json | ConvertFrom-Json).id
        ```

      {% endlist %}

   1. [Удалите Docker-образ](../../container-registry/operations/docker-image/docker-image-delete.md):

      ```bash
      yc container image delete --id $IMAGE_ID
      ```

   1. [Удалите реестр](../../container-registry/operations/registry/registry-delete.md):

      ```bash
      yc container registry delete --name yc-auto-cr
      ```

1. Удалите [L7-балансировщик нагрузки](../../application-load-balancer/operations/application-load-balancer-delete.md).