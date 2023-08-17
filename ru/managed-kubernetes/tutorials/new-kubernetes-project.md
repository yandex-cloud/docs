# Создание нового {{ k8s }}-проекта в {{ yandex-cloud }}

В этой статье описан запуск нового {{ k8s }}-проекта в {{ yandex-cloud }}. Приложение из [{{ container-registry-full-name }}](../../container-registry/) будет развернуто в [кластере {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) и опубликовано в интернете через Ingress-контроллер [{{ alb-full-name }}](../../application-load-balancer/).

Чтобы запустить приложение:
1. [{#T}](#create-sa).
1. [{#T}](#create-k8s-res).
1. [{#T}](#create-cr-res).
1. [{#T}](#setup-alb).
1. [{#T}](#create-ingress).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

1. {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. Установите [утилиту потоковой обработки JSON-файлов](https://stedolan.github.io/jq/) `jq`:

   ```bash
   sudo apt update && sudo apt install jq
   ```

### Создайте сеть и подсеть {#create-network}

1. [Создайте сеть](../../vpc/operations/network-create.md) с именем `yc-auto-network`:

   ```bash
   yc vpc network create --name yc-auto-network
   ```

1. [Создайте подсеть](../../vpc/operations/subnet-create.md) в [зоне доступности](../../overview/concepts/geo-scope.md) `{{ region-id }}-a`:

   ```bash
   yc vpc subnet create \
     --name yc-auto-subnet-0 \
     --network-name yc-auto-network \
     --range 192.168.1.0/24 \
     --zone {{ region-id }}-a
   ```

### Зарегистрируйте доменную зону и добавьте сертификат {#register-domain}

1. [Зарегистрируйте публичную доменную зону и делегируйте домен](../../dns/operations/zone-create-public.md).
1. Если у вас уже есть [сертификат](../../certificate-manager/concepts/index.md#types) для [доменной зоны](../../dns/concepts/dns-zone.md), [добавьте сведения о нем](../../certificate-manager/operations/import/cert-create.md) в сервис {{ certificate-manager-full-name }}.

   Если у вас нет сертификата, выпустите новый сертификат от Let's Encrypt® и [добавьте](../../certificate-manager/operations/managed/cert-create.md) его в {{ certificate-manager-name }}.
1. Получите идентификатор сертификата:

   ```bash
   yc certificate-manager certificate list
   ```

   Результат:

   ```text
   +-----------------+-------+----------------+---------------------+----------+--------+
   |       ID        | NAME  |    DOMAINS     |      NOT AFTER      |   TYPE   | STATUS |
   +-----------------+-------+----------------+---------------------+----------+--------+
   | <идентификатор> | <имя> | <доменное имя> | 2022-04-06 17:19:37 | IMPORTED | ISSUED |
   +-----------------+-------+----------------+---------------------+----------+--------+
   ```

## Создайте сервисные аккаунты {#create-sa}

Для работы кластера {{ k8s }} и [балансировщика нагрузки](../../application-load-balancer/concepts/application-load-balancer.md) нужны [сервисные аккаунты](../../iam/concepts/users/service-accounts.md):
* С ролью [{{ roles-editor }}](../../iam/concepts/access-control/roles.md#editor) на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создается кластер {{ k8s }}. От имени этого сервисного аккаунта будут создаваться ресурсы, необходимые кластеру {{ k8s }}.
* С ролью [{{ roles-cr-puller }}](../../iam/concepts/access-control/roles.md#cr-images-puller) на каталог с [реестром](../../container-registry/concepts/registry.md) [Docker-образов](../../container-registry/concepts/docker-image.md). От имени этого сервисного аккаунта [узлы](../../managed-kubernetes/concepts/index.md#node-group) будут скачивать из реестра необходимые Docker-образы.
* Для работы Ingress-контроллера {{ alb-name }}, с ролями:
  * [alb.editor](../../iam/concepts/access-control/roles.md#alb-editor) — для создания необходимых ресурсов.
  * [vpc.publicAdmin](../../iam/concepts/access-control/roles.md#vpc-public-admin) — для управления [внешней связностью](../../vpc/security/index.md#roles-list).
  * [certificate-manager.certificates.downloader](../../iam/concepts/access-control/roles.md#certificate-manager-certificates-downloader) — для работы с сертификатами, зарегистрированными в сервисе [{{ certificate-manager-name }}](../../certificate-manager/).
  * [compute.viewer](../../iam/concepts/access-control/roles.md#compute-viewer) — для использования узлов кластера {{ k8s }} в [целевых группах](../../application-load-balancer/concepts/target-group.md) балансировщика нагрузки.

### Сервисный аккаунт для ресурсов {#res-sa}

Чтобы создать сервисный аккаунт, от имени которого будут создаваться ресурсы, необходимые кластеру {{ managed-k8s-name }}:
1. Запишите в переменную идентификатор каталога из конфигурации вашего профиля {{ yandex-cloud }} CLI:

   {% list tabs %}

   - Bash

     ```bash
     FOLDER_ID=$(yc config get folder-id)
     ```

   - PowerShell

     ```shell script
     $FOLDER_ID = yc config get folder-id
     ```

   {% endlist %}

1. Создайте сервисный аккаунт:

   {% list tabs %}

   - Bash

     ```bash
     yc iam service-account create --name k8s-res-sa-$FOLDER_ID
     ```

   - PowerShell

     ```shell script
     yc iam service-account create --name k8s-res-sa-$FOLDER_ID
     ```

   {% endlist %}

1. Запишите в переменную идентификатор сервисного аккаунта:

   {% list tabs %}

   - Bash

     ```bash
     RES_SA_ID=$(yc iam service-account get --name k8s-res-sa-$FOLDER_ID --format json | jq .id -r)
     ```

   - PowerShell

     ```shell script
     $RES_SA_ID = (yc iam service-account get --name k8s-res-sa-$FOLDER_ID --format json | ConvertFrom-Json).id
     ```

   {% endlist %}

1. Назначьте сервисному аккаунту роль [{{ roles-editor }}](../../iam/concepts/access-control/roles.md#editor) на каталог:

   ```bash
   yc resource-manager folder add-access-binding \
     --id $FOLDER_ID \
     --role editor \
     --subject serviceAccount:$RES_SA_ID
   ```

### Сервисный аккаунт для узлов {#node-sa}

Чтобы создать сервисный аккаунт, от имени которого узлы будут скачивать из реестра необходимые Docker-образы.
1. Запишите в переменную идентификатор каталога из конфигурации вашего профиля {{ yandex-cloud }} CLI:

   {% list tabs %}

   - Bash

     ```bash
     FOLDER_ID=$(yc config get folder-id)
     ```

   - PowerShell

     ```shell script
     $FOLDER_ID = yc config get folder-id
     ```

   {% endlist %}

1. Создайте сервисный аккаунт:

   {% list tabs %}

   - Bash

     ```bash
     yc iam service-account create --name k8s-node-sa-$FOLDER_ID
     ```

   - PowerShell

     ```shell script
     yc iam service-account create --name k8s-node-sa-$FOLDER_ID
     ```

   {% endlist %}

1. Запишите в переменную идентификатор сервисного аккаунта:

   {% list tabs %}

   - Bash

     ```bash
     NODE_SA_ID=$(yc iam service-account get --name k8s-node-sa-$FOLDER_ID --format json | jq .id -r)
     ```

   - PowerShell

     ```shell script
     $NODE_SA_ID = (yc iam service-account get --name k8s-node-sa-$FOLDER_ID --format json | ConvertFrom-Json).id
     ```

   {% endlist %}

1. Назначьте сервисному аккаунту роль [{{ roles-cr-puller }}](../../iam/concepts/access-control/roles.md#cr-images-puller) на каталог:

   ```bash
   yc resource-manager folder add-access-binding \
     --id $FOLDER_ID \
     --role container-registry.images.puller \
     --subject serviceAccount:$NODE_SA_ID
   ```

### Сервисный аккаунт, необходимый для работы {{ alb-name }} Ingress-контроллера {#ic-sa}

1. Запишите в переменную идентификатор каталога из конфигурации вашего профиля {{ yandex-cloud }} CLI:

   {% list tabs %}

   - Bash

     ```bash
     FOLDER_ID=$(yc config get folder-id)
     ```

   - PowerShell

     ```shell script
     $FOLDER_ID = yc config get folder-id
     ```

   {% endlist %}

1. Создайте сервисный аккаунт:

   {% list tabs %}

   - Bash

     ```bash
     yc iam service-account create --name k8s-ic-sa-$FOLDER_ID
     ```

   - PowerShell

     ```shell script
     yc iam service-account create --name k8s-ic-sa-$FOLDER_ID
     ```

   {% endlist %}

1. Запишите в переменную идентификатор сервисного аккаунта:

   {% list tabs %}

   - Bash

     ```bash
     IC_SA_ID=$(yc iam service-account get --name k8s-ic-sa-$FOLDER_ID --format json | jq .id -r)
     ```

   - PowerShell

     ```shell script
     $RES_SA_ID = (yc iam service-account get --name k8s-ic-sa-$FOLDER_ID --format json | ConvertFrom-Json).id
     ```

   {% endlist %}

1. Назначьте сервисному аккаунту роли на каталог:
   * [{{ roles-alb-editor }}](../../iam/concepts/access-control/roles.md#alb-editor).
   * [{{ roles-vpc-public-admin }}](../../iam/concepts/access-control/roles.md#vpc-public-admin).
   * [certificate-manager.certificates.downloader](../../iam/concepts/access-control/roles.md#certificate-manager-certificates-downloader).
   * [compute.viewer](../../iam/concepts/access-control/roles.md#compute-viewer).

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

{% include [create-k8s-res](../../_includes/managed-kubernetes/create-k8s-res.md) %}

1. [Настройте группы безопасности кластера {{ k8s }} и группы узлов](../operations/connect/security-groups.md). Группа безопасности группы узлов должна разрешать входящие TCP-соединения к портам 10501 и 10502 из подсетей балансировщика нагрузки или из его группы безопасности (позже подсети и группу нужно будет указать для [создания балансировщика](#create-ingress-and-apps)).
1. Убедитесь, что вы можете подключиться к кластеру с помощью `kubectl`:

   ```bash
   kubectl cluster-info
   ```

## Подготовьте ресурсы {{ container-registry-name }} {#create-cr-res}

### Создайте реестр {#registry-create}

Создайте реестр контейнеров:

```bash
yc container registry create --name yc-auto-cr
```

### Сконфигурируйте Docker Credential helper {#config-ch}

Для упрощения аутентификации в {{ container-registry-name }} сконфигурируйте [Docker Credential helper](../../container-registry/operations/authentication.md#cred-helper). Он позволяет работать с приватными реестрами {{ yandex-cloud }}, не выполняя команду `docker login`.

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

      {% list tabs %}

      - Bash

        ```bash
        REGISTRY_ID=$(yc container registry get --name yc-auto-cr --format json | jq .id -r)
        ```

      - PowerShell

        ```shell script
        $REGISTRY_ID = (yc container registry get --name yc-auto-cr --format json | ConvertFrom-Json).id
        ```

      {% endlist %}

   1. Соберите Docker-образ:

      ```bash
      docker build . -f hello.dockerfile -t {{ registry }}/$REGISTRY_ID/nginx:hello
      ```

   1. Загрузите Docker-образ в реестр:

      ```bash
      docker push {{ registry }}/$REGISTRY_ID/nginx:hello
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
   | crpa2mf008mpjig73rp6 | 2019-11-20 11:52:17 | crp71hkgiolp6677hg9i/nginx | hello | 27.5 MB         |
   +----------------------+---------------------+----------------------------+-------+-----------------+
   ```

### Запустите тестовое приложение {#test-app}

Создайте [под](../concepts/index.md#pod) с приложением из Docker-образа и убедитесь, что для загрузки Docker-образа не потребовалась дополнительная аутентификация в {{ container-registry-name }}.
1. Запустите под с приложением из Docker-образа:

   ```bash
   kubectl run --attach hello-nginx --image {{ registry }}/$REGISTRY_ID/nginx:hello
   ```

1. Убедитесь, что под перешел в состояние `Running`, и узнайте его полное имя:

   ```bash
   kubectl get pods
   ```

   Результат:

   ```text
   NAME                          READY  STATUS   RESTARTS  AGE
   hello-nginx-5847fb96b4-54g48  1/1    Running  0         1h
   ```

1. Посмотрите логи контейнера, запущенного на этом поде:

   ```bash
   kubectl logs hello-nginx-5847fb96b4-54g48
   ```

   Результат:

   ```text
   Hi, I'm inside
   ```

   Под загрузил Docker-образ без дополнительной аутентификации на стороне {{ container-registry-name }}.

## Установите {{ alb-name }} {#setup-alb}


Чтобы установить [{{ alb-name }}](/marketplace/products/yc/alb-ingress-controller), [воспользуйтесь инструкцией](../operations/applications/alb-ingress-controller.md).



## Создайте балансировщик нагрузки {#create-ingress}

1. Создайте балансировщик нагрузки для [сервисов {{ k8s }}](../concepts/index.md#service).
   1. Создайте файл `ingress.yaml` с манифестом Ingress-контроллера:

      ```yaml
      ---
      apiVersion: networking.k8s.io/v1
      kind: Ingress
      metadata:
        name: alb-demo-tls
        annotations:
          ingress.alb.yc.io/subnets: <список идентификаторов подсетей>
          ingress.alb.yc.io/security-groups: <список идентификаторов групп безопасности>
          ingress.alb.yc.io/external-ipv4-address: <auto или статический IP-адрес>
          ingress.alb.yc.io/group-name: <имя Ingress-группы>
      spec:
        tls:
          - hosts:
              - <доменное имя>
            secretName: yc-certmgr-cert-id-<идентификатор TLS-сертификата>
        rules:
          - host: <доменное имя>
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
      * `ingress.alb.yc.io/subnets` — укажите одну или несколько [подсетей](../../vpc/concepts/network.md#subnet), с которыми будет работать {{ alb-name }}.
      * `ingress.alb.yc.io/security-groups` — укажите одну или несколько [групп безопасности](../../application-load-balancer/concepts/application-load-balancer.md#security-groups) для {{ alb-name }}. Если параметр не задан, используется группа безопасности по умолчанию. Хотя бы одна из групп безопасности должна разрешать исходящие TCP-соединения к портам 10501 и 10502 в подсети группы узлов или в ее группу безопасности.
      * `ingress.alb.yc.io/external-ipv4-address` — чтобы получить новый и предоставить публичный доступ к {{ alb-name }} из интернета, укажите [заранее полученный IP-адрес](../../vpc/operations/get-static-ip.md), либо установите значение `auto`.

        Если вы указали значение `auto`, то при удалении Ingress-контроллера IP-адрес также будет удален из облака. Чтобы избежать этого, используйте имеющийся зарезервированный адрес.
      * `ingress.alb.yc.io/group-name` — укажите имя группы. Группа объединяет ресурсы {{ k8s }} Ingress, обслуживаемые отдельным экземпляром {{ alb-name }}.
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
      alb-demo-tls  <none>  <доменное имя>  <IP-адрес>  80, 443  15h
      ```

      По конфигурации балансировщика нагрузки будет автоматически развернут [L7-балансировщик](../../application-load-balancer/concepts/application-load-balancer.md).
1. Перейдите по ссылке `https://<доменное имя>` и убедитесь, что ваше приложение успешно опубликовано.

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. [Удалите кластер {{ k8s }}](../operations/kubernetes-cluster/kubernetes-cluster-delete.md):

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

1. Удалите ресурсы {{ container-registry-name }}.
   1. Узнайте идентификатор Docker-образа, загруженного в реестр:

      {% list tabs %}

      - Bash

        ```bash
        IMAGE_ID=$(yc container image list --format json | jq .[0].id -r)
        ```

      - PowerShell

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