# Интеграция с {{ container-registry-name }}

Для интеграции {{ k8s }} и {{ container-registry-name }} создайте следующие ресурсы: сервисные аккаунты для управления ресурсами и доступами к ним, кластер {{ k8s }}, группу узлов, а также реестр и Docker-образ. Для упрощения аутентификации настройте Docker Credential helper и убедитесь, что под с приложением из {{ container-registry-name }} запускается без дополнительной аутентификации, используя сервисный аккаунт.

1. [Создайте сервисные аккаунты](#create-sa)
    1. [Создайте сервисный аккаунт для ресурсов](#res-sa)
    1. [Создайте сервисный аккаунт для узлов](#node-sa) 
1. [Подготовьте необходимые ресурсы {{ k8s }}](#create-k8s-res)
    1. [Создайте кластер {{ k8s }}](#create-cluster)
    1. [Создайте группу узлов](#create-node-groups)
1. [Подготовьте необходимые ресурсы {{ container-registry-name }}](#create-cr-res)    
    1. [Создайте реестр](#registry-create) 
    1. [Сконфигурируйте Credential helper](#config-ch)
    1. [Подготовьте Docker-образ](#docker-image)
1. [Подключитесь к кластеру {{ k8s }}](#cluster-connect)
1. [Запустите тестовое приложение](#test-app)
1. [Удалите созданные ресурсы](#delete-resources)

{% include [before-you-begin](../../_includes/before-begin.md) %}

## Создайте сервисные аккаунты {#create-sa}

Создайте [сервисные аккаунты](../../iam/operations/sa/create.md):
- Сервисный аккаунт для ресурсов с ролью [{{ roles-editor }}](../../resource-manager/security/#roles-list) на каталог, в котором создается кластер {{ k8s }}. От его имени будут создаваться ресурсы, необходимые кластеру {{ k8s }}.
- Сервисный аккаунт для узлов с ролью [{{ roles-cr-puller }}](../../container-registry/security/index.md#required-roles) на каталог с реестром Docker-образов. От его имени узлы будут скачивать из реестра необходимые Docker-образы.

### Создайте сервисный аккаунт для ресурсов {#res-sa} 

Чтобы создать сервисный аккаунт, от имени которого будут создаваться ресурсы, необходимые кластеру {{ k8s }}:
1. Запишите в переменную идентификатор каталога из конфигурации вашего профиля CLI:

    {% list tabs %}
    
    - Bash
    
        ```
        $ FOLDER_ID=$(yc config get folder-id)
        ```
    
    - PowerShell
    
        ```
        > $FOLDER_ID = yc config get folder-id
        ```
        
    {% endlist %}    

1. Создайте сервисный аккаунт:

    {% list tabs %}
    
    - Bash
    
        ```
        $ yc iam service-account create --name k8s-res-sa-$FOLDER_ID
        ```
    
    - PowerShell
    
        ```
        > yc iam service-account create --name k8s-res-sa-$FOLDER_ID
        ```
    
    {% endlist %} 

1. Запишите в переменную идентификатор сервисного аккаунта: 

    {% list tabs %}
    
    - Bash
        
        ```
        $ RES_SA_ID=$(yc iam service-account get --name k8s-res-sa-${FOLDER_ID} --format json | jq .id -r)
        ```
    
    - PowerShell
    
        ```
        > $RES_SA_ID = (yc iam service-account get --name k8s-res-sa-$FOLDER_ID --format json | ConvertFrom-Json).id
        ```
    
    {% endlist %}

1. Назначьте сервисному аккаунту роль [{{ roles-editor }}](../../resource-manager/security/#roles-list) на каталог:
    
    ```
    yc resource-manager folder add-access-binding --id $FOLDER_ID --role editor --subject serviceAccount:$RES_SA_ID
    ```

### Создайте сервисный аккаунт для узлов {#node-sa} 

Чтобы создать сервисный аккаунт, от имени которого узлы будут скачивать из реестра необходимые Docker-образы:
1. Запишите в переменную идентификатор каталога из конфигурации вашего профиля CLI:

    {% list tabs %}
    
    - Bash
    
        ```
        $ FOLDER_ID=$(yc config get folder-id)
        ```
    
    - PowerShell
    
        ```
        > $FOLDER_ID = yc config get folder-id
        ```
        
    {% endlist %}    

1. Создайте сервисный аккаунт:

    {% list tabs %}
    
    - Bash
    
        ```
        $ yc iam service-account create --name k8s-node-sa-$FOLDER_ID
        ```
    
    - PowerShell
    
        ```
        > yc iam service-account create --name k8s-node-sa-$FOLDER_ID
        ```
    
    {% endlist %} 

1. Запишите в переменную идентификатор сервисного аккаунта: 

    {% list tabs %}
    
    - Bash
        
        ```
        $ NODE_SA_ID=$(yc iam service-account get --name k8s-node-sa-${FOLDER_ID} --format json | jq .id -r)
        ```
    
    - PowerShell
    
        ```
        > $NODE_SA_ID = (yc iam service-account get --name k8s-node-sa-$FOLDER_ID --format json | ConvertFrom-Json).id
        ```
    
    {% endlist %}

1. Назначьте сервисному аккаунту роль [{{ roles-cr-puller }}](../../container-registry/security/index.md#required-roles) на каталог:
    
    ```
    yc resource-manager folder add-access-binding --id $FOLDER_ID --role container-registry.images.puller --subject serviceAccount:$NODE_SA_ID
    ```   

{% include [create-k8s-res](../../_includes/managed-kubernetes/create-k8s-res.md) %}

## Подготовьте ресурсы {{ container-registry-name }} {#create-cr-res}

### Создайте реестр {#registry-create}

Создайте реестр контейнеров: 

```
yc container registry create --name yc-auto-cr
```

### Сконфигурируйте Docker Credential helper {#config-ch}

Для упрощения аутентификации в {{ container-registry-name }} сконфигурируйте [Docker Credential helper](../../container-registry/operations/authentication.md#cred-helper). Он позволяет работать с приватными реестрами Яндекс.Облака, не выполняя команду `docker login`.

Для настройки Credential helper выполните команду: 

```
yc container registry configure-docker
```

### Подготовьте Docker-образ {#docker-image}

Соберите Docker-образ и загрузите его в реестр:
1. Создайте Dockerfile `hello.dockerfile` и сохраните в него следующие строки:

    ```
    FROM ubuntu:latest
    CMD echo "Hi, I'm inside"
    ```
1. Соберите Docker-образ:

    1. Получите идентификатор реестра, [созданного ранее](#registry-create), и запишите его в переменную:
    
        {% list tabs %}
        
        - Bash
            
            ```
            $ REGISTRY_ID=$(yc container registry get --name yc-auto-cr  --format json | jq .id -r)
            ```
            
        - PowerShell
            
            ```
            > $REGISTRY_ID = (yc container registry get --name yc-auto-cr  --format json | ConvertFrom-Json).id
            ```
        
        {% endlist %}
    
    1. Соберите Docker-образ:
    
        ```
        docker build . -f hello.dockerfile -t cr.yandex/$REGISTRY_ID/ubuntu:hello
        ```
    1. Загрузите Docker-образ в реестр:
        
        ```
        docker push cr.yandex/${REGISTRY_ID}/ubuntu:hello
        ```
1. Проверьте, что Docker-образ загрузился в реестр: 

    ```
    yc container image list
    
    +----------------------+---------------------+-----------------------------+-------+-----------------+
    |          ID          |       CREATED       |            NAME             | TAGS  | COMPRESSED SIZE |
    +----------------------+---------------------+-----------------------------+-------+-----------------+
    | crpa2mf008mpjig73rp6 | 2019-11-20 11:52:17 | crp71hkgiolp6677hg9i/ubuntu | hello | 27.5 MB         |
    +----------------------+---------------------+-----------------------------+-------+-----------------+
    ```

{% include [kubectl-connect](../../_includes/managed-kubernetes/kubectl-connect.md) %}

## Запустите тестовое приложение {#test-app}

Запустите под с приложением из Docker-образа и убедитесь, что для загрузки Docker-образа не потребовалась дополнительная аутентификация в {{ container-registry-short-name }}. 

1. Запустите под с приложением из Docker-образа:
    
    ```
    kubectl run --attach hello-ubuntu --image cr.yandex/${REGISTRY_ID}/ubuntu:hello
    ```
1. Найдите запущенный под и посмотрите его полное имя:
    
    ```
    kubectl get po
   
    NAME                            READY   STATUS      RESTARTS   AGE
    hello-ubuntu-5847fb96b4-54g48   0/1     Completed   3          61s
    ```

1. Посмотрите логи контейнера, запущенного на этом поде:
    
    ```  
    kubectl logs hello-ubuntu-5847fb96b4-54g48
    
    Hi, I'm inside
    ```

    Под загрузил Docker-образ без дополнительной аутентификации на стороне {{ container-registry-short-name }}.
    
## Удалите созданные ресурсы {#delete-resources}

1. Удалите кластер {{ k8s }}:

    ```
    yc managed-kubernetes cluster delete --name k8s-demo
    ```
1. Удалите сервисные аккаунты:

    {% note important %}
    
    Не удаляйте сервисный аккаунт до удаления кластера {{ k8s }}.
    
    {% endnote %}
    
    - Удалите сервисный аккаунт для ресурсов:
    
        ```
        yc iam service-account delete --id $RES_SA_ID
        ```
    - Удалите сервисный аккаунт для узлов:
    
        ```
        yc iam service-account delete --id $NODE_SA_ID
        ```      
1. Удалите ресурсы {{ container-registry-short-name }}:
    1. Узнайте имя Docker-образа, загруженного в реестр:
    
        {% list tabs %}
        
        - Bash
        
            ```
            $ IMAGE_ID=$(yc container image list --format json | jq .[0].id -r)
            ```
        - PowerShell
        
            ```
            > $IMAGE_ID = (yc container image list --format json | ConvertFrom-Json).id
            ```
        
        {% endlist %}
        
    1. Удалите Docker-образ:
    
        ```
        yc container image delete --id $IMAGE_ID
        ```
    1. Удалите реестр: 
    
        ```
        yc container registry delete --name yc-auto-cr
        ```

#### См. также {#see-also}

* [{#T}](../../container-registry/concepts/docker-image.md)
* [{#T}](../../container-registry/operations/authentication.md)
* [{#T}](../../container-registry/operations/index.md)

