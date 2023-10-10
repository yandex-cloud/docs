В этом сценарии описано, как подписать [Docker-образы](../container-registry/concepts/docker-image.md) с помощью [Cosign](https://docs.sigstore.dev/cosign/overview/) в {{ container-registry-full-name }}, а затем настроить проверку подписей в {{ managed-k8s-full-name }}.

Чтобы подписать и настроить проверку Docker-образов:
1. [Подпишите Docker-образ с помощью Cosign](#cosign).
1. [Создайте политику для проверки подписей](#kyverno).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-begin}

### Подготовьте инфраструктуру {#deploy-infrastructure}

{% list tabs %}

- Вручную

  1. [Создайте сервисные аккаунты](../iam/operations/sa/create.md):
     * [Сервисный аккаунт](../iam/concepts/users/service-accounts.md) для ресурсов с [ролью](../iam/concepts/access-control/roles.md) [{{ roles-editor }}](../resource-manager/security/index.md#roles-list) на [каталог](../resource-manager/concepts/resources-hierarchy.md#folder), в котором создается [кластер {{ managed-k8s-name }}](../managed-kubernetes/concepts/index.md#kubernetes-cluster). От его имени будут создаваться ресурсы, необходимые кластеру {{ managed-k8s-name }}.
     * Сервисный аккаунт для узлов с ролью [{{ roles-cr-puller }}](../container-registry/security/index.md#required-roles) на каталог с [реестром](../container-registry/concepts/registry.md) Docker-образов. От его имени узлы будут скачивать из реестра необходимые Docker-образы.

     Вы можете использовать один и тот же сервисный аккаунт для обеих операций.
  1. [Создайте кластер {{ managed-k8s-name }}](../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create) и [группу узлов](../managed-kubernetes/operations/node-group/node-group-create.md). При создании кластера укажите ранее созданные сервисные аккаунты для ресурсов и узлов.
  1. [Создайте реестр {{ container-registry-name }}](../container-registry/operations/registry/registry-create.md).

- С помощью {{ TF }}

  1. Если у вас еще нет {{ TF }}, [установите и настройте его](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  1. Скачайте [файл с настройками провайдера](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Поместите его в отдельную рабочую директорию и [укажите значения параметров](../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
  1. Скачайте в ту же рабочую директорию файл конфигурации [k8s-validate-cr-image.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/data-migration-mysql-mmy/k8s-validate-cr-image.tf).

     В этом файле описаны:
     * [Сеть](../vpc/concepts/network.md#network).
     * [Подсеть](../vpc/concepts/network.md#subnet).
     * [Группа безопасности и правила](../managed-kubernetes/operations/connect/security-groups.md), необходимые для работы кластера {{ managed-k8s-name }}:
       * Правила для служебного трафика.
       * Правила для доступа к API {{ k8s }} и управления кластером с помощью `kubectl` через порты 443 и 6443.
     * Кластер {{ managed-k8s-name }}.
     * Сервисный аккаунт, необходимый для работы кластера и группы узлов {{ managed-k8s-name }}.
     * Реестр {{ container-registry-name }}.
  1. Укажите в файле `k8s-validate-cr-image.tf`:
     * [Идентификатор каталога](../resource-manager/operations/folder/get-id.md).
     * [Версию {{ k8s }}](../managed-kubernetes/concepts/release-channels-and-updates.md) для кластера и групп узлов {{ managed-k8s-name }}.
     * CIDR кластера {{ managed-k8s-name }}.
     * Имя сервисного аккаунта кластера.
     * Имя реестра {{ container-registry-name }}.
  1. Выполните команду `terraform init` в директории с конфигурационным файлом. Эта команда инициализирует провайдер, указанный в конфигурационных файлах, и позволяет работать с ресурсами и источниками данных провайдера.
  1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

     ```bash
     terraform validate
     ```

     Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Создайте необходимую инфраструктуру:

     {% include [terraform-apply](../_includes/mdb/terraform/apply.md) %}

     {% include [explore-resources](../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Подготовьтесь к работе с кластером {{ managed-k8s-name }}

1. {% include [install-kubectl](../_includes/managed-kubernetes/kubectl-install.md) %}

1. [Установите менеджер пакетов {{ k8s }} Helm](https://helm.sh/ru/docs/intro/install).

### Добавьте несколько Docker-образов в реестр {{ container-registry-name }} {#add-docker-images}

1. [Аутентифицируйтесь в {{ container-registry-name }}](../container-registry/operations/authentication.md).
1. [Создайте несколько Docker-образов](../container-registry/operations/docker-image/docker-image-create.md). Один из образов в дальнейшем будет подписан с помощью Cosign, остальные образы будут неподписанными.
1. [Загрузите Docker-образы](../container-registry/operations/docker-image/docker-image-push.md) в реестр {{ container-registry-name }}.

## Подпишите Docker-образ с помощью Cosign {#cosign}

1. [Установите Cosign](https://docs.sigstore.dev/cosign/installation).
1. Создайте пару ключей с помощью Cosign:

   ```bash
   cosign generate-key-pair
   ```

   Задайте и дважды введите пароль для закрытого ключа.

   Результат:

   ```text
   Enter password for private key:
   Enter password for private key again:
   Private key written to cosign.key
   Public key written to cosign.pub
   ```

1. Подпишите Docker-образ в реестре {{ container-registry-name }}:

   ```bash
   cosign sign --key cosign.key {{ registry }}/<ID реестра>/<имя Docker-образа>:<тег>
   ```

   Подписанный образ будет использоваться при [проверке результата](#check-result).

   Укажите пароль закрытого ключа. Результат:

   ```text
   Enter password for private key:
   Pushing signature to: {{ registry }}/<ID реестра>/<имя Docker-образа>
   ```

   В реестре {{ container-registry-name }} должен появится второй объект с тегом `sha256-....sig` и хешем `{{ registry }}/<ID реестра>/<имя Docker-образа>@sha256:...`.
1. Вручную проверьте, что подпись валидна:

   ```bash
   cosign verify --key cosign.pub {{ registry }}/<ID реестра>/<имя Docker-образа>:<тег>
   ```

   Результат:

   ```text
   Verification for {{ registry }}/<ID реестра>/<имя Docker-образа>:<тег> --
   The following checks were performed on each of these signatures:
   - The cosign claims were validated
   - The signatures were verified against the specified public key

   [{"critical":{"identity":{"docker-reference":"{{ registry }}/<ID реестра>/<имя Docker-образа>"},"image":{"docker-manifest-digest":"sha256:..."},"type":"cosign container image signature"},"optional":null}]
   ```

## Создайте политику для проверки подписей {#kyverno}

1. Создайте [авторизованный ключ](../iam/concepts/authorization/key.md) для сервисного аккаунта с ролью [{{ roles-cr-puller }}](../container-registry/security/index.md#required-roles) и запишите его в файл:

   ```bash
   yc iam key create \
     --service-account-name=<имя сервисного аккаунта с ролью {{ roles-cr-puller }}> \
     --output=authorized-key.json
   ```

1. Установите приложение [Kyverno](https://kyverno.io/docs/) в кластер {{ managed-k8s-name }}. Оно необходимо для создания политики, которой проверяются подписи Docker-образов.
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
        --set imagePullSecrets.regcred.registry={{ registry }} \
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
              - "{{ registry }}/<ID реестра>/*"
              attestors:
              - count: 1
                entries:
                - keys:
                    publicKeys: |-
                      <содержимое cosign.pub>
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
              - "{{ registry }}/crpd2f2bnrlb2i7ltssl/*"
              attestors:
              - count: 1
                entries:
                - keys:
                    publicKeys: |-
                      -----BEGIN PUBLIC KEY-----
                      MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAE1jTu/9rJZZvUFi4bGhlvgMQdIY97
                      7NuGl2zzpV7olAyIu/WiywxI7Fny5tk6JmNPIFvSAtys3c08gfEcVV3D1Q==
                      -----END PUBLIC KEY-----
      ```

      {% endcut %}

   1. Выполните команду:

      ```bash
      kubectl apply -f ./policy.yaml
      ```

      Результат:

      ```text
      clusterpolicy.kyverno.io/check-image configured
      ```

1. {% include [install policy reporter](../_includes/managed-kubernetes/install-policy-reporter.md) %}

## Проверьте результат {#check-result}

* Создайте [под](../managed-kubernetes/concepts/index.md#pod) из подписанного Docker-образа:

  ```bash
  kubectl run pod --image={{ registry }}/<ID реестра>/<имя Docker-образа>:<тег>
  ```

  Результат:

  ```text
  pod/pod created
  ```

* Создайте под из неподписанного Docker-образа:

  ```bash
  kubectl run pod2 --image={{ registry }}/<ID реестра>/<имя неподписанного Docker-образа>:<тег>
  ```

  Результат:

  ```text
  Error from server: admission webhook "mutate.kyverno.svc-fail" denied the request:

  resource Pod/default/pod2 was blocked due to the following policies

  check-image:
    check-image: 
      failed to verify signature for {{ registry }}/crpsere9njsadcq6fgm2/alpine:2.0: .attestors[0].entries[0].keys: no matching signatures:
  ```

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs %}

- Вручную

  1. [Удалите кластер {{ managed-k8s-name }}](../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
  1. Если вы зарезервировали для кластера публичный статический IP-адрес, [удалите его](../vpc/operations/address-delete.md).
  1. [Удалите сервисные аккаунты](../iam/operations/sa/delete.md).
  1. [Удалите все Docker-образы](../container-registry/operations/docker-image/docker-image-delete.md) из реестра {{ container-registry-name }}.
  1. [Удалите реестр {{ container-registry-name }}](../container-registry/operations/registry/registry-delete.md).

- С помощью {{ TF }}

  Чтобы удалить инфраструктуру, [созданную с помощью {{ TF }}](#deploy-infrastructure):
  1. [Удалите все Docker-образы](../container-registry/operations/docker-image/docker-image-delete.md) из реестра {{ container-registry-name }}.
  1. В терминале перейдите в директорию с планом инфраструктуры.
  1. Удалите конфигурационный файл `k8s-validate-cr-image.tf`.
  1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

     ```bash
     terraform validate
     ```

     Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../_includes/mdb/terraform/apply.md) %}

     Все ресурсы, которые были описаны в конфигурационном файле `k8s-validate-cr-image.tf`, будут удалены.

{% endlist %}