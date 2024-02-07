В этом сценарии описано, как подписать [Docker-образы](../../container-registry/concepts/docker-image.md) с помощью [Cosign](https://docs.sigstore.dev/cosign/overview/) в [{{ container-registry-full-name }}](../../container-registry/), а затем настроить проверку подписей в [{{ managed-k8s-full-name }}](../../managed-kubernetes/).

Чтобы подписать и настроить проверку Docker-образов:
1. [Подпишите Docker-образ с помощью Cosign](#cosign).
1. [Создайте политику для проверки подписей](#kyverno).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-begin}

### Подготовьте инфраструктуру {#deploy-infrastructure}

{% list tabs group=instructions %}

- Вручную {#manual}

  1. [Создайте сервисные аккаунты](../../iam/operations/sa/create.md):
     * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) для ресурсов с [ролью](../../iam/concepts/access-control/roles.md) [{{ roles-editor }}](../../resource-manager/security/index.md#roles-list) на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создается [кластер {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster). От его имени будут создаваться ресурсы, необходимые кластеру {{ managed-k8s-name }}.
     * Сервисный аккаунт для узлов с ролью [{{ roles-cr-puller }}](../../container-registry/security/index.md#required-roles) на каталог с [реестром](../../container-registry/concepts/registry.md) Docker-образов. От его имени узлы будут скачивать из реестра необходимые Docker-образы.

     Вы можете использовать один и тот же сервисный аккаунт для обеих операций.
  1. [Создайте кластер {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create) и [группу узлов](../../managed-kubernetes/operations/node-group/node-group-create.md). При создании кластера укажите ранее созданные сервисные аккаунты для ресурсов и узлов.
  1. [Создайте реестр {{ container-registry-name }}](../../container-registry/operations/registry/registry-create.md).

- {{ TF }} {#tf}

  1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
  1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
  1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
  1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}
  1. Скачайте в ту же рабочую директорию файл конфигурации [k8s-validate-cr-image.tf](https://github.com/yandex-cloud/examples/blob/master/tutorials/terraform/managed-kubernetes/k8s-validate-cr-image.tf).

     В этом файле описаны:
     * [Сеть](../../vpc/concepts/network.md#network).
     * [Подсеть](../../vpc/concepts/network.md#subnet).
     * [Группа безопасности и правила](../../managed-kubernetes/operations/connect/security-groups.md), необходимые для работы кластера {{ managed-k8s-name }}:
       * Правила для служебного трафика.
       * Правила для доступа к API {{ k8s }} и управления кластером с помощью `kubectl` через порты 443 и 6443.
     * Кластер {{ managed-k8s-name }}.
     * Сервисный аккаунт, необходимый для работы кластера и группы узлов {{ managed-k8s-name }}.
     * Реестр {{ container-registry-name }}.
  1. Укажите в файле `k8s-validate-cr-image.tf`:
     * [Идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
     * [Версию {{ k8s }}](../../managed-kubernetes/concepts/release-channels-and-updates.md) для кластера и групп узлов {{ managed-k8s-name }}.
     * CIDR кластера {{ managed-k8s-name }}.
     * Имя сервисного аккаунта кластера.
     * Имя реестра {{ container-registry-name }}.
  1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

     ```bash
     terraform validate
     ```

     Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Создайте необходимую инфраструктуру:

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Подготовьтесь к работе с кластером {{ managed-k8s-name }}

1. {% include [install-kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}
1. [Установите менеджер пакетов {{ k8s }} Helm](https://helm.sh/ru/docs/intro/install).

### Добавьте несколько Docker-образов в реестр {{ container-registry-name }} {#add-docker-images}

1. [Аутентифицируйтесь в {{ container-registry-name }}](../../container-registry/operations/authentication.md).
1. [Создайте несколько Docker-образов](../../container-registry/operations/docker-image/docker-image-create.md). Один из образов в дальнейшем будет подписан с помощью Cosign, остальные образы будут неподписанными.
1. [Загрузите Docker-образы](../../container-registry/operations/docker-image/docker-image-push.md) в реестр {{ container-registry-name }}.

## Подпишите Docker-образ с помощью утилиты Cosign {#cosign}

{% list tabs %}

- Подпись образа на асимметричных ключах {{ kms-full-name }}

  1. Установите специальную сборку Cosign для вашей операционной системы:

     {% include [install-cosign](../../_includes/kms/install-cosign.md) %}

  1. Получите [{{ iam-full-name }}-токен](../../iam/concepts/authorization/iam-token.md) и сохраните его в переменную среды `$YC_IAM_TOKEN`:
     * **Bash:**

       ```bash
       export YC_IAM_TOKEN=$(yc iam create-token)
       ```

     * **PowerShell:**

       ```powershell
       $env:YC_IAM_TOKEN = $(yc iam create-token)
       ```

  1. Авторизуйтесь в {{ container-registry-name }}:
     * **Bash:**

       ```bash
       docker login \
         --username iam \
         --password $YC_IAM_TOKEN \
         {{ registry }}
       ```

     * **PowerShell:**

       ```powershell
       docker login `
         --username iam `
         --password $Env:YC_IAM_TOKEN `
         {{ registry }}
       ```

     Результат:

     ```text
     WARNING! Using --password via the CLI is insecure. Use --password-stdin.
     Login Succeeded
     ```

     {% note info %}

     Чтобы не использовать Credential helper при аутентификации, удалите в конфигурационном файле `${HOME}/.docker/config.json` из блока `credHelpers` строку домена `{{ registry }}`.

     {% endnote %}

  1. Создайте и сохраните в {{ kms-name }} ключевую пару электронной подписи:

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
      
     Идентификатор ключевой пары подписи всегда можно получить в [консоли управления]({{ link-console-main }}) или с помощью [команды CLI](../../cli/cli-ref/managed-services/kms/asymmetric-signature-key/list.md).
  1. Подпишите образ в {{ container-registry-name }}:

     ```bash
     cosign sign \
       --key yckms:///<идентификатор_ключевой_пары> \
       {{ registry }}/<идентификатор_реестра>/<имя_Docker-образа>:<тег> \
       --tlog-upload=false
     ```

     Где:
     * `<идентификатор_ключевой_пары>` — идентификатор ключевой пары подписи, полученный на предыдущем шаге.
     * `<идентификатор_реестра>` — [идентификатор реестра](../../container-registry/operations/registry/registry-list.md#registry-list) {{ container-registry-name }}, в котором находится подписываемый образ.
     * `<имя_Docker-образа>` — имя подписываемого [Docker-образа](../../container-registry/operations/docker-image/docker-image-list.md#docker-image-list) в реестре {{ container-registry-name }}.
     * `<тег>` — тег версии образа, которую требуется подписать.

     Результат:

     ```bash
     Pushing signature to: {{ registry }}/<идентификатор_реестра>/<имя_Docker-образа>
     ```

     В реестре {{ container-registry-name }} должен появиться второй объект с тегом `sha256-....sig` и хэшем `{{ registry }}/<идентификатор_реестра>/<имя_Docker-образа>@sha256:...`.
  1. Вручную проверьте, что подпись Docker-образа корректна:

     ```bash
     cosign verify \
       --key yckms:///<идентификатор_ключевой_пары> \
       {{ registry }}/<идентификатор_реестра>/<имя_Docker-образа>:<тег> \
       --insecure-ignore-tlog
     ```

     Где:
     * `<идентификатор_ключевой_пары>` — полученный ранее идентификатор ключевой пары подписи.
     * `<идентификатор_реестра>` — [идентификатор реестра](../../container-registry/operations/registry/registry-list.md#registry-list) {{ container-registry-name }}, в котором находится образ.
     * `<имя_Docker-образа>` — [имя Docker-образа](../../container-registry/operations/docker-image/docker-image-list.md#docker-image-list) в реестре {{ container-registry-name }}.
     * `<тег>` — тег версии образа, для которой требуется проверить подпись.

     Результат:

     ```bash
     Verification for {{ registry }}/<идентификатор_реестра>/<имя_Docker-образа>:<тег> --
     The following checks were performed on each of these signatures:
     - The cosign claims were validated
     - The signatures were verified against the specified public key

     [{"critical":{"identity":{"docker-reference":"{{ registry }}/<идентификатор_реестра>/<имя_Docker-образа>"},"image":{"docker-manifest-digest":"sha256:..."},"type":"cosign container image signature"},"optional":null}]
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

  1. Подпишите Docker-образ в реестре {{ container-registry-name }}:

     ```bash
     cosign sign \
         --key cosign.key \
         {{ registry }}/<идентификатор_реестра>/<имя_Docker-образа>:<тег>
     ```

     Подписанный образ будет использоваться при [проверке результата](#check-result).

     Укажите пароль закрытого ключа. Результат:

     ```text
     Enter password for private key:
     Pushing signature to: {{ registry }}/<идентификатор_реестра>/<имя_Docker-образа>
     ```

     В реестре {{ container-registry-name }} должен появиться второй объект с тегом `sha256-....sig` и хэшем `{{ registry }}/<идентификатор_реестра>/<имя_Docker-образа>@sha256:...`.
  1. Вручную проверьте, что подпись Docker-образа корректна:

     ```bash
     cosign verify \
       --key cosign.pub \
       {{ registry }}/<идентификатор_реестра>/<имя_Docker-образа>:<тег>
     ```

     Результат:

     ```text
     Verification for {{ registry }}/<идентификатор_реестра>/<имя_Docker-образа>:<тег> --
     The following checks were performed on each of these signatures:
     - The cosign claims were validated
     - The signatures were verified against the specified public key

     [{"critical":{"identity":{"docker-reference":"{{ registry }}/<идентификатор_реестра>/<имя_Docker-образа>"},"image":{"docker-manifest-digest":"sha256:..."},"type":"cosign container image signature"},"optional":null}]
     ```

{% endlist %}

## Создайте политику для проверки подписей {#kyverno}

1. Создайте [авторизованный ключ](../../iam/concepts/authorization/key.md) для сервисного аккаунта с ролью [{{ roles-cr-puller }}](../../container-registry/security/index.md#required-roles) и запишите его в файл:

   ```bash
   yc iam key create \
     --service-account-name=<имя_сервисного_аккаунта> \
     --output authorized-key.json
   ```

   Где `--service-account-name` — имя сервисного аккаунта с ролью {{ roles-cr-puller }}.
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
              - "{{ registry }}/<идентификатор_реестра>/*"
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
              - "{{ registry }}/crpd2f2bnrlb********/*"
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

   1. Выполните команду:

      ```bash
      kubectl apply -f ./policy.yaml
      ```

      Результат:

      ```text
      clusterpolicy.kyverno.io/check-image configured
      ```

1. {% include [install policy reporter](../../_includes/managed-kubernetes/install-policy-reporter.md) %}

## Проверьте результат {#check-result}

* Создайте [под](../../managed-kubernetes/concepts/index.md#pod) из подписанного Docker-образа:

  ```bash
  kubectl run pod --image={{ registry }}/<идентификатор_реестра>/<имя_Docker-образа>:<тег>
  ```

  Результат:

  ```text
  pod/pod created
  ```

* Создайте под из неподписанного Docker-образа:

  ```bash
  kubectl run pod2 --image={{ registry }}/<идентификатор_реестра>/<имя_неподписанного_Docker-образа>:<тег>
  ```

  Результат:

  ```text
  Error from server: admission webhook "mutate.kyverno.svc-fail" denied the request:

  resource Pod/default/pod2 was blocked due to the following policies

  check-image:
    check-image: 
      failed to verify signature for {{ registry }}/crpsere9njsa********/alpine:2.0: .attestors[0].entries[0].keys: no matching signatures:
  ```

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs group=instructions %}

- Вручную {#manual}

  1. [Удалите кластер {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
  1. Если вы зарезервировали для кластера публичный статический IP-адрес, [удалите его](../../vpc/operations/address-delete.md).
  1. [Удалите сервисные аккаунты](../../iam/operations/sa/delete.md).
  1. [Удалите все Docker-образы](../../container-registry/operations/docker-image/docker-image-delete.md) из реестра {{ container-registry-name }}.
  1. [Удалите реестр {{ container-registry-name }}](../../container-registry/operations/registry/registry-delete.md).

- {{ TF }} {#tf}

  Чтобы удалить инфраструктуру, [созданную с помощью {{ TF }}](#deploy-infrastructure):
  1. [Удалите все Docker-образы](../../container-registry/operations/docker-image/docker-image-delete.md) из реестра {{ container-registry-name }}.
  1. В терминале перейдите в директорию с планом инфраструктуры.
  1. Удалите конфигурационный файл `k8s-validate-cr-image.tf`.
  1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

     ```bash
     terraform validate
     ```

     Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     Все ресурсы, которые были описаны в конфигурационном файле `k8s-validate-cr-image.tf`, будут удалены.

{% endlist %}