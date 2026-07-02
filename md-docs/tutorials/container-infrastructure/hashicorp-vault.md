[Документация Yandex Cloud](../../index.md) > [Практические руководства](../index.md) > [Контейнерная инфраструктура](index.md) > Managed Service for Kubernetes > Использование продуктов Cloud Marketplace > Использование HashiCorp Vault для хранения секретов

# Использование HashiCorp Vault для хранения секретов в Yandex Managed Service for Kubernetes

# Использование HashiCorp Vault для хранения секретов


[HashiCorp Vault](https://www.vaultproject.io/) — инструмент с открытым исходным кодом, который обеспечивает безопасное хранение и доступ к различным секретам (паролям, сертификатам, токенам).

Настройте хранение и доступ к секретам внутри кластера Yandex Managed Service for Kubernetes с помощью продукта Yandex Cloud Marketplace [HashiCorp Vault с поддержкой Key Management Service](https://yandex.cloud/ru/marketplace/products/yc/vault-yckms-k8s).

В этом руководстве описан пример монтирования секрета из хранилища HashiCorp Vault через том [Container Storage Interface](https://kubernetes.io/docs/concepts/storage/volumes/#csi) (CSI).

Чтобы организовать доступ к секрету в кластере Managed Service for Kubernetes с помощью HashiCorp Vault:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Установите HashiCorp Vault](#install-vault).
1. [Войдите в HashiCorp Vault](#login-vault).
1. [Создайте секрет](#create-secret).
1. [Настройте метод аутентификации Kubernetes](#kubernetes-authentication).
1. [Установите драйвер SCI для хранилища секретов](#install-sci).
1. [Создайте ресурс SecretProviderClass](#create-resource).
1. [Создайте под со смонтированным секретом](#create-pod).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер Managed Service for Kubernetes: использование мастера и исходящий трафик ([тарифы Managed Service for Kubernetes](../../managed-kubernetes/pricing.md)).
* Плата за узлы кластера (ВМ): использование вычислительных ресурсов, операционной системы и хранилища ([тарифы Compute Cloud](../../compute/pricing.md)).
* Плата за публичный IP-адрес, если он назначен узлам кластера ([тарифы Virtual Private Cloud](../../vpc/pricing.md#prices-public-ip)).
* Плата за сервис Key Management Service: количество активных версий ключа (в статусах `Active` и `Scheduled For Destruction`) и выполненных криптографических операций ([тарифы Key Management Service](../../kms/pricing.md)).


## Подготовьте облако к работе {#before-you-begin}

1. Создайте [кластер](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) и [группу узлов](../../managed-kubernetes/concepts/index.md#node-group) Kubernetes.

    {% list tabs group=instructions %}

    * Вручную {#manual}

        1. Если у вас еще нет [сети](../../vpc/concepts/network.md#network), [создайте ее](../../vpc/operations/network-create.md).
        1. Если у вас еще нет [подсетей](../../vpc/concepts/network.md#subnet), [создайте их](../../vpc/operations/subnet-create.md) в [зонах доступности](../../overview/concepts/geo-scope.md), где будут созданы кластер Kubernetes и группа узлов.
        1. [Создайте сервисные аккаунты](../../iam/operations/sa/create.md):

            * Сервисный аккаунт с [ролями](../../managed-kubernetes/security/index.md#yc-api) `k8s.clusters.agent` и `vpc.publicAdmin` на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создается кластер Kubernetes. От его имени будут создаваться ресурсы, необходимые кластеру Kubernetes.
            * Сервисный аккаунт с [ролью](../../iam/concepts/access-control/roles.md) [container-registry.images.puller](../../container-registry/security/index.md#container-registry-images-puller). От его имени узлы будут скачивать из [реестра](../../container-registry/concepts/registry.md) необходимые [Docker-образы](../../container-registry/concepts/docker-image.md).

            {% note tip %}

            Вы можете использовать один и тот же [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) для управления кластером Kubernetes и его группами узлов.

            {% endnote %}

        1. [Создайте группы безопасности](../../managed-kubernetes/operations/connect/security-groups.md) для кластера Managed Service for Kubernetes и входящих в него групп узлов.

            {% note warning %}
            
            От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
            
            {% endnote %}

        1. [Создайте кластер Kubernetes](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) и [группу узлов](../../managed-kubernetes/operations/node-group/node-group-create.md) любой подходящей конфигурации. При создании укажите группы безопасности, подготовленные ранее.

    * С помощью Terraform {#tf}

        1. Если у вас еще нет Terraform, [установите его](../infrastructure-management/terraform-quickstart.md#install-terraform).
        1. [Получите данные для аутентификации](../infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
        1. [Настройте и инициализируйте провайдер](../infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
        1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

        1. Скачайте в ту же рабочую директорию файл конфигурации кластера [k8s-cluster.tf](https://github.com/yandex-cloud-examples/yc-mk8s-cluster-infrastructure/blob/main/k8s-cluster.tf). В файле описаны:

            * [Сеть](../../vpc/concepts/network.md#network).
            * [Подсеть](../../vpc/concepts/network.md#subnet).
            * Кластер Kubernetes.
            * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md), необходимый для работы кластера и группы узлов Managed Service for Kubernetes.
            * [Группы безопасности](../../vpc/concepts/security-groups.md), которые содержат [необходимые правила](../../managed-kubernetes/operations/connect/security-groups.md) для кластера Managed Service for Kubernetes и входящих в него групп узлов.

                {% note warning %}
                
                От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
                
                {% endnote %}

        1. Укажите в файле `k8s-cluster.tf`:

            * [Идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
            * Версию Kubernetes для кластера и групп узлов Kubernetes.
            * CIDR кластера Kubernetes.
            * Имя сервисного аккаунта кластера Managed Service for Kubernetes.

        1. Проверьте корректность файлов конфигурации Terraform с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, Terraform на них укажет.

        1. Создайте необходимую инфраструктуру:

            1. Выполните команду для просмотра планируемых изменений:
            
               ```bash
               terraform plan
               ```
            
               Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
            
            1. Если вас устраивают планируемые изменения, внесите их:
               1. Выполните команду:
            
                  ```bash
                  terraform apply
                  ```
            
               1. Подтвердите изменение ресурсов.
               1. Дождитесь завершения операции.

            В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).

    {% endlist %}

    {% note warning %}
    
    Не изменяйте и не удаляйте ресурсы Virtual Private Cloud, которые используются кластером Managed Service for Kubernetes. Это может привести к некорректной работе кластера и невозможности его последующего удаления.
    
    {% endnote %}

1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../../managed-kubernetes/operations/connect/index.md#kubectl-connect).

## Установите HashiCorp Vault {#install-vault}

Установите HashiCorp Vault с помощью Helm и инициализируйте хранилище [по инструкции](../../managed-kubernetes/operations/applications/hashicorp-vault.md). В команде установки укажите пространство имен `hcv` и добавьте дополнительные параметры, чтобы задействовать механизм [Vault CSI provider](https://developer.hashicorp.com/vault/docs/platform/k8s/csi):

```bash
--namespace hcv \
--set "injector.enabled=false" \
--set "csi.enabled=true"
```

## Войдите в HashiCorp Vault {#login-vault}

1. Запустите сеанс интерактивной оболочки HashiCorp Vault для пода `hashicorp-vault-0`.

    ```bash
    kubectl exec -it hashicorp-vault-0 \
       --namespace hcv \
       -- /bin/sh
    ```

1. [Распечатайте (unseal)](https://www.vaultproject.io/docs/concepts/seal#why) хранилище.

    ```bash
    vault operator unseal
    ```

    Введите один из ключей восстановления (`Recovery Key`), полученных при [инициализации хранилища](../../managed-kubernetes/operations/applications/hashicorp-vault.md#vault-init).

1. Аутентифицируйтесь в HashiCorp Vault с помощью корневого токена:

    ```bash
    vault login
    ```

    Введите корневой токен (`Initial Root Token`), полученный при инициализации хранилища.

## Создайте секрет {#create-secret}

1. Включите механизм секретов `kv` по пути `secret`:

    ```bash
    vault secrets enable -path=secret kv
    ```

1. Создайте секрет по пути `secret/db-pass`. В качестве секрета укажите пароль:

    ```bash
    vault kv put secret/db-pass password="12345678"
    ```

1. Убедитесь, что секрет доступен для чтения по пути `secret/db-pass`:

    ```bash
    vault kv get secret/db-pass
    ```

    Результат:

    ```text
    ====== Data ======
    Key         Value
    ---         -----
    password    12345678
    ```

## Настройте метод аутентификации Kubernetes {#kubernetes-authentication}

Этот метод позволяет аутентифицироваться с помощью токена сервисного аккаунта Kubernetes.

1. Включите метод аутентификации Kubernetes:

    ```bash
    vault auth enable kubernetes
    ```

1. Настройте аутентификацию через API-адрес Kubernetes:

    ```bash
    vault write auth/kubernetes/config \
       kubernetes_host="https://$KUBERNETES_PORT_443_TCP_ADDR:443"
    ```

    Переменная окружения `KUBERNETES_PORT_443_TCP_ADDR` ссылается на внутренний сетевой адрес узла Kubernetes.

1. Создайте политику `internal-app`, которая позволит сервисному аккаунту Kubernetes читать созданный ранее секрет:

    ```bash
    vault policy write internal-app - <<EOF
    path "secret/db-pass" {
      capabilities = ["read"]
    }
    EOF
    ```

1. Создайте роль `database`, которая свяжет политику `internal-app` с сервисным аккаунтом Kubernetes `webapp-sa` (будет создан позднее):

    ```bash
    vault write auth/kubernetes/role/database \
       bound_service_account_names=webapp-sa \
       bound_service_account_namespaces=hcv \
       policies=internal-app \
       ttl=20m
    ```

    Токены, возвращаемые после аутентификации, будут действительны в течение 20 минут.

1. Выйдите из HashiCorp Vault:

    ```bash
    exit
    ```

## Установите драйвер SCI для хранилища секретов {#install-sci}

1. Добавьте Helm-репозиторий `secrets-store-csi-driver`:

    ```bash
    helm repo add secrets-store-csi-driver https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts
    ```

1. Установите драйвер SCI:

    ```bash
    helm install csi secrets-store-csi-driver/secrets-store-csi-driver \
       --namespace=hcv \
       --set syncSecret.enabled=true
    ```

1. Убедитесь, что драйвер запущен и готов:

    ```bash
    kubectl get pods -n hcv -l "app=secrets-store-csi-driver"
    ```

    Результат:

    ```text
    NAME                                 READY   STATUS    RESTARTS   AGE
    csi-secrets-store-csi-driver-nbxcd   3/3     Running   0          4m28s
    ```

## Создайте ресурс SecretProviderClass {#create-resource}

1. Создайте файл `spc-vault-database.yaml` с настройками, которые предоставляются CSI-провайдеру:

    {% cut "spc-vault-database.yaml" %}

    ```yaml
    apiVersion: secrets-store.csi.x-k8s.io/v1
    kind: SecretProviderClass
    metadata:
      name: vault-database
    spec:
      provider: vault
      parameters:
        vaultAddress: "http://hashicorp-vault.hcv:8200"
        roleName: "database"
        objects: |
          - objectName: "db-password"
            secretPath: "secret/db-pass"
            secretKey: "password"
    ```

    {% endcut %}

1. Создайте ресурс `SecretProviderClass`:

    ```bash
    kubectl apply -f spc-vault-database.yaml -n hcv
    ```

## Создайте под со смонтированным секретом {#create-pod}

1. Создайте сервисный аккаунт `webapp-sa` в кластере Kubernetes:

    ```bash
    kubectl create serviceaccount webapp-sa \
       --namespace hcv
    ```

1. Создайте файл `webapp-pod.yaml`, который содержит конфигурацию пода `webapp`:

    {% cut "spc-vault-database.yaml" %}

    ```yaml
    kind: Pod
    apiVersion: v1
    metadata:
      name: webapp
    spec:
      serviceAccountName: webapp-sa
      containers:
      - image: jweissig/app:0.0.1
        name: webapp
        volumeMounts:
        - name: secrets-store-inline
          mountPath: "/mnt/secrets-store"
          readOnly: true
      volumes:
        - name: secrets-store-inline
          csi:
            driver: secrets-store.csi.k8s.io
            readOnly: true
            volumeAttributes:
              secretProviderClass: "vault-database"
    ```

    {% endcut %}

1. Создайте под `webapp`:

    ```bash
    kubectl apply -f webapp-pod.yaml -n hcv 
    ```

1. Убедитесь, что под `webapp` запущен и готов:

    ```bash
    kubectl get pod webapp -n hcv
    ```

    Результат:

    ```text
    NAME     READY   STATUS    RESTARTS   AGE
    webapp   1/1     Running   0          5m25s
    ```

1. Отобразите секретный пароль, записанный в файловую систему по пути `/mnt/secrets-store/db-password`:

    ```bash
    kubectl exec webapp -n hcv -- cat /mnt/secrets-store/db-password
    ```

    Результат:

    ```text
    12345678
    ```

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать.

{% list tabs group=instructions %}

* Вручную {#manual}

    1. [Удалите кластер Kubernetes](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
    1. [Удалите группы безопасности](../../vpc/operations/security-group-delete.md).
    1. [Удалите подсеть](../../vpc/operations/subnet-delete.md) и [сеть](../../vpc/operations/network-delete.md).
    1. [Удалите сервисные аккаунты](../../iam/operations/sa/delete.md).
    1. [Удалите симметричный ключ шифрования](../../kms/operations/key.md#delete).

* С помощью Terraform {#tf}

    1. В терминале перейдите в директорию с планом инфраструктуры.
    
        {% note warning %}
    
        Убедитесь, что в директории нет Terraform-манифестов с ресурсами, которые вы хотите сохранить. Terraform удаляет все ресурсы, которые были созданы с помощью манифестов в текущей директории.
    
        {% endnote %}
    
    1. Удалите ресурсы:
    
        1. Выполните команду:
    
            ```bash
            terraform destroy
            ```
    
        1. Подтвердите удаление ресурсов и дождитесь завершения операции.
    
        Все ресурсы, которые были описаны в Terraform-манифестах, будут удалены.

{% endlist %}

## Полезные ссылки {#see-also}

* [Документация HashiCorp Vault](https://developer.hashicorp.com/vault/docs?product_intent=vault)
* [Установка HashiCorp Vault с поддержкой Key Management Service](../../managed-kubernetes/operations/applications/hashicorp-vault.md)
* [Установка External Secrets Operator с поддержкой Yandex Lockbox](../../managed-kubernetes/operations/applications/external-secrets-operator.md)
* [Синхронизация с секретами Yandex Lockbox](../../managed-kubernetes/tutorials/kubernetes-lockbox-secrets.md)