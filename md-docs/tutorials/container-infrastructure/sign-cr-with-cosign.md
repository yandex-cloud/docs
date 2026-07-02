[Документация Yandex Cloud](../../index.md) > [Практические руководства](../index.md) > [Контейнерная инфраструктура](index.md) > Managed Service for Kubernetes > Использование Container Registry > Подпись и проверка Docker-образов Container Registry

# Подпись и проверка Docker-образов Yandex Container Registry в Yandex Managed Service for Kubernetes


В этом сценарии описано, как подписать [Docker-образы](../../container-registry/concepts/docker-image.md) с помощью [Cosign](https://docs.sigstore.dev/cosign/overview/) в [Yandex Container Registry](../../container-registry/index.md), а затем настроить проверку подписей в [Yandex Managed Service for Kubernetes](../../managed-kubernetes/index.md) с помощью ключей Yandex Key Management Service.

Чтобы подписать и настроить проверку Docker-образов:
1. [Подпишите Docker-образ с помощью Cosign](#cosign).
1. [Создайте политику для проверки подписей](#kyverno).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер Managed Service for Kubernetes: использование мастера и исходящий трафик ([тарифы Managed Service for Kubernetes](../../managed-kubernetes/pricing.md)).
* Плата за узлы кластера (ВМ): использование вычислительных ресурсов, операционной системы и хранилища ([тарифы Compute Cloud](../../compute/pricing.md)).
* Плата за публичные IP-адреса, если они назначены узлам кластера ([тарифы Virtual Private Cloud](../../vpc/pricing.md#prices-public-ip)).
* Плата за [использование хранилища](../../container-registry/pricing.md) Container Registry.


## Перед началом работы {#before-begin}

### Подготовьте инфраструктуру {#deploy-infrastructure}

{% list tabs group=instructions %}

- Вручную {#manual}

  1. [Создайте сервисные аккаунты](../../iam/operations/sa/create.md):
     * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) для ресурсов с [ролями](../../iam/concepts/access-control/roles.md) `k8s.clusters.agent` и `vpc.publicAdmin` на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создается [кластер Managed Service for Kubernetes](../../managed-kubernetes/concepts/index.md#kubernetes-cluster). От его имени будут создаваться ресурсы, необходимые кластеру Managed Service for Kubernetes.
     * Сервисный аккаунт для узлов с ролью [container-registry.images.puller](../../container-registry/security/index.md#required-roles) на каталог с [реестром](../../container-registry/concepts/registry.md) Docker-образов. От его имени узлы будут скачивать из реестра необходимые Docker-образы.

     Вы можете использовать один и тот же сервисный аккаунт для обеих операций.

  1. [Создайте группы безопасности](../../managed-kubernetes/operations/connect/security-groups.md) для кластера Managed Service for Kubernetes и входящих в него групп узлов.

        {% note warning %}
        
        От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
        
        {% endnote %}

  1. [Создайте кластер Managed Service for Kubernetes](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create) и [группу узлов](../../managed-kubernetes/operations/node-group/node-group-create.md). При создании кластера укажите ранее созданные сервисные аккаунты для ресурсов и узлов и группы безопасности.
  1. [Создайте реестр Container Registry](../../container-registry/operations/registry/registry-create.md).

- Terraform {#tf}

  1. Если у вас еще нет Terraform, [установите его](../infrastructure-management/terraform-quickstart.md#install-terraform).
  1. [Получите данные для аутентификации](../infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
  1. [Настройте и инициализируйте провайдер](../infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
  1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.
  1. Скачайте в ту же рабочую директорию файл конфигурации [k8s-validate-cr-image.tf](https://github.com/yandex-cloud-examples/yc-mk8s-cr-images-verification/blob/main/k8s-validate-cr-image.tf).

     В этом файле описаны:
     * [Сеть](../../vpc/concepts/network.md#network).
     * [Подсеть](../../vpc/concepts/network.md#subnet).
     * Реестр Container Registry.
     * Кластер Managed Service for Kubernetes.
     * Сервисный аккаунт, необходимый для работы кластера и группы узлов Managed Service for Kubernetes.
     * [Группы безопасности](../../vpc/concepts/security-groups.md), которые содержат [необходимые правила](../../managed-kubernetes/operations/connect/security-groups.md) для кластера Managed Service for Kubernetes и входящих в него групп узлов.

        {% note warning %}
        
        От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
        
        {% endnote %}

  1. Укажите в файле `k8s-validate-cr-image.tf`:
     * [Идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
     * [Версию Kubernetes](../../managed-kubernetes/concepts/release-channels-and-updates.md) для кластера и групп узлов Managed Service for Kubernetes.
     * CIDR кластера Managed Service for Kubernetes.
     * Имя сервисного аккаунта кластера.
     * Имя реестра Container Registry.
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

### Подготовьтесь к работе с кластером Managed Service for Kubernetes

1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../../managed-kubernetes/operations/connect/index.md#kubectl-connect).
1. [Установите менеджер пакетов Kubernetes Helm](https://helm.sh/ru/docs/intro/install).

### Добавьте несколько Docker-образов в реестр Container Registry {#add-docker-images}

1. [Настройте](../../container-registry/operations/configure-docker.md) Docker и [аутентифицируйтесь в Container Registry](../../container-registry/operations/authentication.md).
1. [Создайте несколько Docker-образов](../../container-registry/operations/docker-image/docker-image-create.md). Один из образов в дальнейшем будет подписан с помощью Cosign, остальные образы будут неподписанными.
1. [Загрузите Docker-образы](../../container-registry/operations/docker-image/docker-image-push.md) в реестр Container Registry.

## Подпишите Docker-образ с помощью утилиты Cosign {#cosign}

{% list tabs %}

- Подпись образа на асимметричных ключах Key Management Service

  1. Установите специальную сборку Cosign для вашей операционной системы:

     * [Linux amd64](https://storage.yandexcloud.net/cosign/linux-amd64/cosign)
     * [MacOS Darwin amd64](https://storage.yandexcloud.net/cosign/macOS-amd64/cosign)
     * [MacOS Darwin arm64](https://storage.yandexcloud.net/cosign/macOS-arm64/cosign)
     * [Windows](https://storage.yandexcloud.net/cosign/windows/cosign.exe)

  1. Получите [IAM-токен](../../iam/concepts/authorization/iam-token.md) и сохраните его в переменную среды `$YC_IAM_TOKEN`:
     * **Bash:**

       ```bash
       export YC_IAM_TOKEN=$(yc iam create-token)
       ```

     * **PowerShell:**

       ```powershell
       $env:YC_IAM_TOKEN = $(yc iam create-token)
       ```

  1. Авторизуйтесь в Container Registry:
     * **Bash:**

       ```bash
       docker login \
         --username iam \
         --password $YC_IAM_TOKEN \
         cr.yandex
       ```

     * **PowerShell:**

       ```powershell
       docker login `
         --username iam `
         --password $Env:YC_IAM_TOKEN `
         cr.yandex
       ```

     Результат:

     ```text
     WARNING! Using --password via the CLI is insecure. Use --password-stdin.
     Login Succeeded
     ```

     {% note info %}

     Чтобы не использовать credential helper при аутентификации, удалите в конфигурационном файле `${HOME}/.docker/config.json` из блока `credHelpers` строку домена `cr.yandex`.

     {% endnote %}

  1. Создайте и сохраните в Key Management Service ключевую пару электронной подписи:

     ```bash
     cosign generate-key-pair \
       --kms yckms:///folder/<идентификатор_каталога>/keyname/<имя_ключевой_пары>
     ```

     Где:
     * `<идентификатор_каталога>` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором будет сохранена создаваемая ключевая пара.
     * `<имя_ключевой_пары>` — имя создаваемой ключевой пары подписи.

     Результат:

     ```bash
     client.go:183: Using IAM Token from 'YC_IAM_TOKEN' environment variable as credentials
     client.go:310: generated yckms KEY_ID: '<идентификатор_ключевой_пары>'
     Public key written to cosign.pub
     ```

     Утилита вернет идентификатор созданной ключевой пары подписи и сохранит открытый ключ подписи в локальный файл. Сохраните идентификатор ключевой пары, он понадобится вам на следующих шагах.
      
     Идентификатор ключевой пары подписи всегда можно получить в [консоли управления](https://console.yandex.cloud) или с помощью [команды CLI](../../cli/cli-ref/kms/cli-ref/asymmetric-signature-key/list.md).
  1. Подпишите образ в Container Registry:

     ```bash
     cosign sign \
       --key yckms:///<идентификатор_ключевой_пары> \
       cr.yandex/<идентификатор_реестра>/<имя_Docker-образа>:<тег> \
       --tlog-upload=false
     ```

     Где:
     * `<идентификатор_ключевой_пары>` — идентификатор ключевой пары подписи, полученный на предыдущем шаге.
     * `<идентификатор_реестра>` — [идентификатор реестра](../../container-registry/operations/registry/registry-list.md#registry-list) Container Registry, в котором находится подписываемый образ.
     * `<имя_Docker-образа>` — имя подписываемого [Docker-образа](../../container-registry/operations/docker-image/docker-image-list.md#docker-image-list) в реестре Container Registry.
     * `<тег>` — тег версии образа, которую требуется подписать.

     Результат:

     ```bash
     Pushing signature to: cr.yandex/<идентификатор_реестра>/<имя_Docker-образа>
     ```

     В реестре Container Registry должен появиться второй объект с тегом `sha256-....sig` и хэшем `cr.yandex/<идентификатор_реестра>/<имя_Docker-образа>@sha256:...`.
  1. Вручную проверьте, что подпись Docker-образа корректна:

     ```bash
     cosign verify \
       --key yckms:///<идентификатор_ключевой_пары> \
       cr.yandex/<идентификатор_реестра>/<имя_Docker-образа>:<тег> \
       --insecure-ignore-tlog
     ```

     Где:
     * `<идентификатор_ключевой_пары>` — полученный ранее идентификатор ключевой пары подписи.
     * `<идентификатор_реестра>` — [идентификатор реестра](../../container-registry/operations/registry/registry-list.md#registry-list) Container Registry, в котором находится образ.
     * `<имя_Docker-образа>` — [имя Docker-образа](../../container-registry/operations/docker-image/docker-image-list.md#docker-image-list) в реестре Container Registry.
     * `<тег>` — тег версии образа, для которой требуется проверить подпись.

     Результат:

     ```bash
     Verification for cr.yandex/<идентификатор_реестра>/<имя_Docker-образа>:<тег> --
     The following checks were performed on each of these signatures:
     - The cosign claims were validated
     - The signatures were verified against the specified public key

     [{"critical":{"identity":{"docker-reference":"cr.yandex/<идентификатор_реестра>/<имя_Docker-образа>"},"image":{"docker-manifest-digest":"sha256:..."},"type":"cosign container image signature"},"optional":null}]
     ```

- Подпись образа на локальных ключах

  1. [Установите Cosign](https://docs.sigstore.dev/cosign/installation).
  1. Создайте пару ключей с помощью Cosign:

     ```bash
     cosign generate-key-pair
     ```

     Задайте и дважды введите пароль для закрытого ключа.

     Результат:

     ```bash
     Enter password for private key:
     Enter password for private key again:
     Private key written to cosign.key
     Public key written to cosign.pub
     ```

  1. Подпишите Docker-образ в реестре Container Registry:

     ```bash
     cosign sign \
         --key cosign.key \
         cr.yandex/<идентификатор_реестра>/<имя_Docker-образа>:<тег>
     ```

     Подписанный образ будет использоваться при [проверке результата](#check-result).

     Укажите пароль закрытого ключа. Результат:

     ```text
     Enter password for private key:
     Pushing signature to: cr.yandex/<идентификатор_реестра>/<имя_Docker-образа>
     ```

     В реестре Container Registry должен появиться второй объект с тегом `sha256-....sig` и хэшем `cr.yandex/<идентификатор_реестра>/<имя_Docker-образа>@sha256:...`.
  1. Вручную проверьте, что подпись Docker-образа корректна:

     ```bash
     cosign verify \
       --key cosign.pub \
       cr.yandex/<идентификатор_реестра>/<имя_Docker-образа>:<тег>
     ```

     Результат:

     ```text
     Verification for cr.yandex/<идентификатор_реестра>/<имя_Docker-образа>:<тег> --
     The following checks were performed on each of these signatures:
     - The cosign claims were validated
     - The signatures were verified against the specified public key

     [{"critical":{"identity":{"docker-reference":"cr.yandex/<идентификатор_реестра>/<имя_Docker-образа>"},"image":{"docker-manifest-digest":"sha256:..."},"type":"cosign container image signature"},"optional":null}]
     ```

{% endlist %}

## Создайте политику для проверки подписей {#kyverno}

1. Создайте [авторизованный ключ](../../iam/concepts/authorization/key.md) для сервисного аккаунта с ролью [container-registry.images.puller](../../container-registry/security/index.md#required-roles) и запишите его в файл:

   ```bash
   yc iam key create \
     --service-account-name=<имя_сервисного_аккаунта> \
     --output authorized-key.json
   ```

   Где `--service-account-name` — имя сервисного аккаунта с ролью container-registry.images.puller.
1. Установите приложение [Kyverno](https://kyverno.io/docs/) в кластер Managed Service for Kubernetes. Оно необходимо для создания политики, которой проверяются подписи Docker-образов.
   1. Добавьте репозиторий `kyverno`:

      ```bash
      helm repo add kyverno https://kyverno.github.io/kyverno/
      ```

      Результат:

      ```text
      "kyverno" has been added to your repositories
      ```

   1. Установите приложение Kyverno в пространство имен `kyverno`:

      ```bash
      helm install kyverno kyverno/kyverno \
        --namespace kyverno \
        --create-namespace \
        --set replicaCount=1 \
        --set imagePullSecrets.regcred.registry=cr.yandex \
        --set imagePullSecrets.regcred.username=json_key \
        --set-file imagePullSecrets.regcred.password=./authorized-key.json
      ```

      Результат:

      ```text
      NAME: kyverno
      LAST DEPLOYED: Thu Sep 8 10:43:00 2022
      NAMESPACE: kyverno
      STATUS: deployed
      ...
      ```

1. Создайте политику:
   1. Сохраните спецификацию для создания объекта `ClusterPolicy` в YAML-файл с названием `policy.yaml`:

      ```yaml
      apiVersion: kyverno.io/v1
      kind: ClusterPolicy
      metadata:
        name: check-image
      spec:
        validationFailureAction: enforce
        background: false
        webhookTimeoutSeconds: 30
        failurePolicy: Fail
        rules:
          - name: check-image
            match:
              any:
              - resources:
                  kinds:
                    - Pod
            verifyImages:
            - imageReferences:
              - "cr.yandex/<идентификатор_реестра>/*"
              attestors:
              - count: 1
                entries:
                - keys:
                    publicKeys: |-
                      <содержимое_cosign.pub>
      ```

      {% cut "Пример заполненного файла policy.yaml." %}

      ```yaml
      apiVersion: kyverno.io/v1
      kind: ClusterPolicy
      metadata:
        name: check-image
      spec:
        validationFailureAction: enforce
        background: false
        webhookTimeoutSeconds: 30
        failurePolicy: Fail
        rules:
          - name: check-image
            match:
              any:
              - resources:
                  kinds:
                    - Pod
            verifyImages:
            - imageReferences:
              - "cr.yandex/crpd2f2bnrlb********/*"
              attestors:
              - count: 1
                entries:
                - keys:
                    publicKeys: |-
                      -----BEGIN PUBLIC KEY-----
                      MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAE1jTu/9rJZZvUFi4bGhlvgMQdIY97
                      7NuGl2zzpV7olAyIu/WiywxI7Fny5tk6JmNPIFvSAtys3c08gfEc********
                      -----END PUBLIC KEY-----
      ```

      {% endcut %}

      {% note info %}

      По умолчанию при создании политики выполняется запрос проверки подписи в хранилище неизменяемых записей Transparency Log. Вы можете отключить его — для этого добавьте в элемент `keys` спецификации политики параметр `rekor: ignoreTlog: true`. Подробнее в [документации Kyverno](https://kyverno.io/docs/writing-policies/verify-images/sigstore/#ignoring-tlogs-and-sct-verification).

      {% endnote %}

   1. Выполните команду:

      ```bash
      kubectl apply -f ./policy.yaml
      ```

      Результат:

      ```text
      clusterpolicy.kyverno.io/check-image configured
      ```

## Проверьте результат {#check-result}

* Создайте [под](../../managed-kubernetes/concepts/index.md#pod) из подписанного Docker-образа:

  ```bash
  kubectl run pod --image=cr.yandex/<идентификатор_реестра>/<имя_Docker-образа>:<тег>
  ```

  Результат:

  ```text
  pod/pod created
  ```

* Создайте под из неподписанного Docker-образа:

  ```bash
  kubectl run pod2 --image=cr.yandex/<идентификатор_реестра>/<имя_неподписанного_Docker-образа>:<тег>
  ```

  Результат:

  ```text
  Error from server: admission webhook "mutate.kyverno.svc-fail" denied the request:

  resource Pod/default/pod2 was blocked due to the following policies

  check-image:
    check-image: 
      failed to verify signature for cr.yandex/crpsere9njsa********/alpine:2.0: .attestors[0].entries[0].keys: no matching signatures:
  ```

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs group=instructions %}

- Вручную {#manual}

  1. [Удалите кластер Managed Service for Kubernetes](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
  1. Если вы зарезервировали для кластера публичный статический IP-адрес, [удалите его](../../vpc/operations/address-delete.md).
  1. [Удалите сервисные аккаунты](../../iam/operations/sa/delete.md).
  1. [Удалите все Docker-образы](../../container-registry/operations/docker-image/docker-image-delete.md) из реестра Container Registry.
  1. [Удалите реестр Container Registry](../../container-registry/operations/registry/registry-delete.md).

- Terraform {#tf}

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