# Интеграция {{ managed-k8s-name }} с {{ container-registry-name }}

# Интеграция с {{ container-registry-name }}


[{{ container-registry-full-name }}](../../container-registry/index.md) — сервис для хранения и распространения [Docker-образов](../../container-registry/concepts/docker-image.md). Интеграция с ним позволяет {{ managed-k8s-name }} запускать [поды](../../managed-kubernetes/concepts/index.md#pod) с приложениями из Docker-образов, которые хранятся в [реестре](../../container-registry/concepts/registry.md) {{ container-registry-name }}. Для взаимодействия с {{ container-registry-name }} [настраивается](#config-ch) Docker Credential helper. Он позволяет работать с приватными реестрами с помощью [сервисного аккаунта](../../iam/concepts/users/service-accounts.md).

Чтобы интегрировать {{ managed-k8s-name }} с {{ container-registry-name }}:
1. [Создайте сервисные аккаунты](#create-sa).
   1. [Создайте сервисный аккаунт для ресурсов](#res-sa).
   1. [Создайте сервисный аккаунт для узлов {{ managed-k8s-name }}](#node-sa).
1. [Создайте группы безопасности](#create-sg).
1. [Подготовьте необходимые ресурсы {{ k8s }}](#create-k8s-res).
   1. [Создайте кластер {{ managed-k8s-name }}](#create-cluster).
   1. [Создайте группу узлов {{ managed-k8s-name }}](#create-node-groups).
1. [Подготовьте необходимые ресурсы {{ container-registry-name }}](#create-cr-res).
   1. [Создайте реестр](#registry-create).
   1. [Сконфигурируйте Credential helper](#config-ch).
   1. [Подготовьте Docker-образ](#docker-image).
1. [Подключитесь к кластеру {{ managed-k8s-name }}](#cluster-connect).
1. [Запустите тестовое приложение](#test-app).
1. [Удалите созданные ресурсы](#delete-resources).

## Перед началом работы {#before-you-begin}

Перейдите в [консоль]({{ link-console-main }}) {{ yandex-cloud }} и выберите каталог, в котором будете выполнять операции. Если такого каталога нет, создайте его:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) на панели сверху нажмите ![image](../../_assets/console-icons/layout-side-content-left.svg) или ![image](../../_assets/console-icons/chevron-down.svg) и выберите нужное [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud).
  1. Справа от названия облака нажмите ![image](../../_assets/console-icons/ellipsis.svg).
  1. Выберите ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
  
     ![create-folder1](../../_assets/resource-manager/create-folder-1.png)
  
  1. Введите имя [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder). Требования к имени:
  
      * длина — от 3 до 63 символов;
      * может содержать строчные буквы латинского алфавита, цифры и дефисы;
      * первый символ — буква, последний — не дефис.
  
  1. (Опционально) Введите описание каталога.
  1. Выберите опцию **{{ ui-key.yacloud.iam.cloud.folders-create.field_default-net }}**. Будет создана [сеть](../../vpc/concepts/network.md#network) с подсетями в каждой зоне доступности. Также в этой сети будет создана [группа безопасности по умолчанию](../../vpc/concepts/security-groups.md#default-security-group), внутри которой весь сетевой трафик разрешен.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.
  
     ![create-folder2](../../_assets/resource-manager/create-folder-2.png)

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  1. Посмотрите описание команды создания каталога:

      ```bash
      yc resource-manager folder create --help
      ```

  1. Создайте новый каталог:

      * с именем и без описания:

          ```bash
          yc resource-manager folder create \
             --name new-folder
          ```

          * длина — от 3 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.

      * с именем и описанием:

          ```bash
          yc resource-manager folder create \
             --name new-folder \
             --description "my first folder with description"
          ```

- API {#api}

  Воспользуйтесь методом [create](../../resource-manager/api-ref/Folder/create.md) для ресурса [Folder](../../resource-manager/api-ref/Folder/index.md) сервиса {{ resmgr-full-name }}.

{% endlist %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер {{ managed-k8s-name }}: использование мастера и исходящий трафик (см. [тарифы {{ managed-k8s-name }}](../../managed-kubernetes/pricing.md)).
* Плата за узлы кластера (ВМ): использование вычислительных ресурсов, операционной системы и хранилища (см. [тарифы {{ compute-name }}](../../compute/pricing.md)).
* Плата за публичные IP-адреса, если они назначены узлам кластера (см. [тарифы {{ vpc-name }}](../../vpc/pricing.md#prices-public-ip)).
* Плата за [использование хранилища](../../container-registry/pricing.md) {{ container-registry-name }}.


## Создайте сервисные аккаунты {#create-sa}

Создайте [сервисные аккаунты](../../iam/operations/sa/create.md):
* Сервисный аккаунт для ресурсов с [ролями](../../managed-kubernetes/security/index.md#yc-api) `k8s.clusters.agent` и `vpc.publicAdmin` на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создается кластер {{ managed-k8s-name }}. От его имени будут создаваться ресурсы, необходимые кластеру {{ managed-k8s-name }}.
* Сервисный аккаунт для [узлов {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#node-group) с ролью [{{ roles-cr-puller }}](../../container-registry/security/index.md#choosing-roles) на каталог с реестром Docker-образов. От его имени узлы {{ managed-k8s-name }} будут скачивать из реестра необходимые Docker-образы.

### Создайте сервисный аккаунт для ресурсов {#res-sa}

Чтобы создать сервисный аккаунт, от имени которого будут создаваться ресурсы, необходимые кластеру {{ managed-k8s-name }}.
1. Запишите в переменную идентификатор каталога из конфигурации вашего профиля CLI:

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
     RES_SA_ID=$(yc iam service-account get --name k8s-res-sa-${FOLDER_ID} --format json | jq .id -r)
     ```

   - PowerShell {#powershell}

     ```shell script
     $RES_SA_ID = (yc iam service-account get --name k8s-res-sa-$FOLDER_ID --format json | ConvertFrom-Json).id
     ```

   {% endlist %}

1. Назначьте сервисному аккаунту роль [k8s.clusters.agent](../../managed-kubernetes/security/index.md#k8s-clusters-agent) на каталог:

   ```bash
   yc resource-manager folder add-access-binding \
     --id $FOLDER_ID \
     --role k8s.clusters.agent \
     --subject serviceAccount:$RES_SA_ID
   ```

1. Назначьте сервисному аккаунту роль [vpc.publicAdmin](../../vpc/security/index.md#vpc-public-admin) на каталог:

   ```bash
   yc resource-manager folder add-access-binding \
     --id $FOLDER_ID \
     --role vpc.publicAdmin \
     --subject serviceAccount:$RES_SA_ID
   ```

### Создайте сервисный аккаунт для узлов кластера {#node-sa}

Чтобы создать сервисный аккаунт, от имени которого узлы {{ managed-k8s-name }} будут скачивать из реестра необходимые Docker-образы.
1. Запишите в переменную идентификатор каталога из конфигурации вашего профиля CLI:

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
     NODE_SA_ID=$(yc iam service-account get --name k8s-node-sa-${FOLDER_ID} --format json | jq .id -r)
     ```

   - PowerShell {#powershell}

     ```shell script
     $NODE_SA_ID = (yc iam service-account get --name k8s-node-sa-$FOLDER_ID --format json | ConvertFrom-Json).id
     ```

   {% endlist %}

1. Назначьте сервисному аккаунту роль [{{ roles-cr-puller }}](../../container-registry/security/index.md#choosing-roles) на каталог:

   ```bash
   yc resource-manager folder add-access-binding \
     --id $FOLDER_ID \
     --role container-registry.images.puller \
     --subject serviceAccount:$NODE_SA_ID
   ```

## Создайте группы безопасности {#create-sg}

[Создайте группы безопасности](../../managed-kubernetes/operations/connect/security-groups.md) для кластера {{ managed-k8s-name }} и входящих в него групп узлов.

{% note warning %}

От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.

{% endnote %}

## Подготовьте ресурсы {{ k8s }} {#create-k8s-res}

## Подготовьте ресурсы {{ k8s }} {#create-k8s-res}

### Создайте кластер {{ managed-k8s-name }} {#create-cluster}

{% note tip %}

В данном примере используются базовые параметры кластера. Часть настроек, например выбор [Container Network Interface](https://kubernetes.io/docs/concepts/extend-kubernetes/compute-storage-net/network-plugins/), [шифрование секретов](../../managed-kubernetes/concepts/encryption.md#k8s-secrets-encryption) с помощью {{ kms-full-name }} и ряд других, нельзя изменить после создания кластера. Рекомендуем ознакомиться с подробной [инструкцией по созданию кластера {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create).

{% endnote %}

Создайте [кластер {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) и укажите ранее созданные [сервисные аккаунты](../../iam/concepts/users/service-accounts.md) в параметрах `--service-account-id` и `--node-service-account-id`, и группы безопасности в параметре `--security-group-ids`.

{% list tabs group=programming_language %}

- Bash {#bash}

  Выполните команду:

  ```bash
  yc managed-kubernetes cluster create \
    --name k8s-demo \
    --network-name yc-auto-network \
    --zone {{ region-id }}-a \
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
    --zone {{ region-id }}-a `
    --subnet-name yc-auto-subnet-0 `
    --public-ip `
    --service-account-id $RES_SA_ID `
    --node-service-account-id $NODE_SA_ID `
    --security-group-ids <идентификаторы_групп_безопасности>
  ```

{% endlist %}

### Создайте группу узлов {{ managed-k8s-name }} {#create-node-groups}

{% note warning %}

Для доступа к {{ container-registry-name }} узлам кластера должен быть назначен публичный IP-адрес. Либо в подсети узлов должен быть настроен [NAT-шлюз](../../vpc/operations/create-nat-gateway.md) или [NAT-инстанс](../../vpc/tutorials/nat-instance/index.md).

Подробнее см. в разделе [{#T}](../../managed-kubernetes/concepts/network.md#nodes-internet).

{% endnote %}

1. Проверьте, что создание кластера {{ managed-k8s-name }} успешно завершено.
   1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором был создан кластер {{ managed-k8s-name }}.
   1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
   1. Проверьте, что кластер {{ managed-k8s-name }} успешно создан:
      * В столбце **{{ ui-key.yacloud.k8s.cluster.overview.label_status }}** должно быть указано `Running`.
      * В столбце **{{ ui-key.yacloud.k8s.cluster.overview.label_health }}** должно быть указано `Healthy`.
1. Создайте [группу узлов {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#node-group) и укажите ранее созданные группы безопасности в параметре `--network-interface security-group-ids`:

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

   ```bash
   FROM ubuntu:latest
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

      ```
      docker build . -f hello.dockerfile -t {{ registry }}/$REGISTRY_ID/ubuntu:hello
      ```

   1. Загрузите Docker-образ в реестр:

      ```
      docker push {{ registry }}/${REGISTRY_ID}/ubuntu:hello
      ```

1. Проверьте, что Docker-образ загрузился в реестр:

   ```bash
   yc container image list
   ```

   Результат:

   ```text
   +----------------------+---------------------+-----------------------------+-------+-----------------+
   |          ID          |       CREATED       |            NAME             | TAGS  | COMPRESSED SIZE |
   +----------------------+---------------------+-----------------------------+-------+-----------------+
   | crpa2mf008mp******** | 2019-11-20 11:52:17 | crp71hkgiolp********/ubuntu | hello | 27.5 MB         |
   +----------------------+---------------------+-----------------------------+-------+-----------------+
   ```

## Подключитесь к кластеру {{ managed-k8s-name }} {#cluster-connect}

[Установите kubectl]({{ k8s-docs }}/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../../managed-kubernetes/operations/connect/index.md#kubectl-connect).

## Запустите тестовое приложение {#test-app}

Запустите под с приложением из Docker-образа и убедитесь, что для загрузки Docker-образа не потребовалась дополнительная аутентификация в {{ container-registry-name }}.
1. Запустите под с приложением из Docker-образа:

   ```
   kubectl run --attach hello-ubuntu --image {{ registry }}/${REGISTRY_ID}/ubuntu:hello
   ```

1. Найдите запущенный под и посмотрите его полное имя:

   ```
   kubectl get po
   ```

   Результат:

   ```
   NAME                           READY  STATUS     RESTARTS  AGE
   hello-ubuntu-5847fb9***-*****  0/1    Completed  3         61s
   ```

1. Посмотрите логи контейнера, запущенного на этом поде:

   ```
   kubectl logs hello-ubuntu-5847fb9***-*****
   ```

   Результат:

   ```
   Hi, I'm inside
   ```

   Под загрузил Docker-образ без дополнительной аутентификации на стороне {{ container-registry-name }}.

## Удалите созданные ресурсы {#delete-resources}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:
1. Удалите кластер {{ managed-k8s-name }}:

   ```bash
   yc managed-kubernetes cluster delete --name k8s-demo
   ```

1. Удалите сервисные аккаунты:

   {% note warning %}

   Не удаляйте сервисный аккаунт до удаления кластера {{ managed-k8s-name }}.

   {% endnote %}

   - Удалите сервисный аккаунт для ресурсов:

     ```bash
     yc iam service-account delete --id $RES_SA_ID
     ```

   - Удалите сервисный аккаунт для узлов {{ managed-k8s-name }}:

     ```bash
     yc iam service-account delete --id $NODE_SA_ID
     ```

1. Удалите ресурсы {{ container-registry-name }}.
   1. Узнайте имя Docker-образа, загруженного в реестр:

      {% list tabs group=programming_language %}

      - Bash {#bash}

        ```bash
        IMAGE_ID=$(yc container image list --format json | jq .[0].id -r)
        ```

      - PowerShell {#powershell}

        ```shell script
        $IMAGE_ID = (yc container image list --format json | ConvertFrom-Json).id
        ```

      {% endlist %}

   1. Удалите Docker-образ:

      ```bash
      yc container image delete --id $IMAGE_ID
      ```

   1. Удалите реестр:

      ```bash
      yc container registry delete --name yc-auto-cr
      ```

#### См. также {#see-also}

* [{#T}](../../container-registry/concepts/docker-image.md).
* [{#T}](../../container-registry/operations/authentication.md).
* [{#T}](../../container-registry/operations/index.md).