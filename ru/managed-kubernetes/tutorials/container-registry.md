# Интеграция с {{ container-registry-name }}


[{{ container-registry-full-name }}](../../container-registry/) — сервис для хранения и распространения [Docker-образов](../../container-registry/concepts/docker-image.md). Интеграция с ним позволяет {{ managed-k8s-name }} запускать [поды](../concepts/index.md#pod) с приложениями из Docker-образов, которые хранятся в [реестре](../../container-registry/concepts/registry.md) {{ container-registry-name }}. Для взаимодействия с {{ container-registry-name }} [настраивается](#config-ch) Docker Credential helper. Он позволяет работать с приватными реестрами с помощью [сервисного аккаунта](../../iam/concepts/users/service-accounts.md).

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

{% include [requirements](kubernetes-backup.md#requirements) %}

{% include [before-you-begin](../../_includes/before-begin.md) %}

## Создайте сервисные аккаунты {#create-sa}

Создайте [сервисные аккаунты](../../iam/operations/sa/create.md):
* Сервисный аккаунт для ресурсов с [ролями](../security/index.md#yc-api) `k8s.clusters.agent` и `vpc.publicAdmin` на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создается кластер {{ managed-k8s-name }}. От его имени будут создаваться ресурсы, необходимые кластеру {{ managed-k8s-name }}.
* Сервисный аккаунт для [узлов {{ managed-k8s-name }}](../concepts/index.md#node-group) с ролью [{{ roles-cr-puller }}](../../container-registry/security/index.md#choosing-roles) на каталог с реестром Docker-образов. От его имени узлы {{ managed-k8s-name }} будут скачивать из реестра необходимые Docker-образы.

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

1. Назначьте сервисному аккаунту роль [k8s.clusters.agent](../security/index.md#k8s-clusters-agent) на каталог:

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

{% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

{% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

## Подготовьте ресурсы {{ k8s }} {#create-k8s-res}

{% include notitle [create-k8s-res](../../_includes/managed-kubernetes/create-k8s-res.md) %}

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

{% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

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
