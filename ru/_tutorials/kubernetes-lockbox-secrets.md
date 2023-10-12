С помощью инструмента [External Secrets Operator](https://external-secrets.io/latest/provider/yandex-lockbox/) вы можете настроить синхронизацию [секретов](../lockbox/concepts/secret.md) {{ lockbox-name }} с [секретами кластера](../managed-kubernetes/concepts/encryption.md) {{ managed-k8s-name }}.

Существует [несколько схем интеграции](https://external-secrets.io/latest/guides/multi-tenancy/) {{ lockbox-name }} с сервисом {{ managed-k8s-name }}. Далее для примера рассматривается схема [ESO as a Service](https://external-secrets.io/latest/guides/multi-tenancy/#eso-as-a-service):

![image](../_assets/managed-kubernetes/mks-lockbox-eso.svg)

Чтобы настроить синхронизацию секретов:
1. [Перед началом работы](#before-you-begin).
1. [Установите External Secrets Operator](#install-eso).
1. [Настройте {{ lockbox-name }}](#configure-lockbox).
1. [Настройте кластер {{ k8s }}](#configure-k8s).
1. [Создайте External Secret](#create-es).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

Также инфраструктуру для синхронизации секретов {{ lockbox-short-name }} с секретами кластера {{ managed-k8s-name }} можно развернуть через {{ TF }} с помощью [готового файла конфигурации](#terraform).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость ресурсов для синхронизации секретов входит:
* Плата за использование мастера {{ managed-k8s-name }} (см. [тарифы {{ managed-k8s-full-name }}](../managed-kubernetes/pricing.md)).
* Плата за вычислительные ресурсы и диски группы узлов (см. [тарифы {{ compute-full-name }}](../compute/pricing.md)).
* Плата за хранение и операции с секретом (см. [тарифы {{ lockbox-full-name }}](../lockbox/pricing.md)).

### Создайте инфраструктуру {#create-infrastructure}


1. [Создайте облачную сеть](../vpc/operations/network-create.md) и [подсеть](../vpc/operations/subnet-create.md).

1. Создайте сервисный аккаунт:

    {% list tabs %}
    
    - Консоль управления

      1. В [консоли управления]({{link-console-main}}) выберите каталог, в котором вы хотите создать сервисный аккаунт.
      1. Перейдите на вкладку **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
      1. Введите имя сервисного аккаунта, например `eso-service-account`.

          Требования к формату имени:

          {% include [name-format](../_includes/name-format.md) %}

      1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

    - CLI

      Чтобы создать сервисный аккаунт, выполните команду:

      ```bash
      yc iam service-account create --name <имя_сервисного_аккаунта>
      ```

      Где `--name` — имя сервисного аккаунта, например `eso-service-account`. Требования к формату имени:

      {% include [name-format](../_includes/name-format.md) %}

    {% endlist %}

1. Создайте [авторизованный ключ](../iam/concepts/authorization/access-key.md) для сервисного аккаунта и сохраните его в файл `authorized-key.json`:

    {% list tabs %}
    
    - Консоль управления

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит сервисный аккаунт.
      1. Перейдите на вкладку **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}**.
      1. Выберите сервисный аккаунт, например `eso-service-account`, и нажмите на строку с его именем.
      1. На верхней панели нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** и выберите пункт **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_key }}**.
      1. Выберите алгоритм шифрования.
      1. Задайте описание ключа, чтобы потом было проще найти его в консоли управления.
      1. Сохраните открытый и закрытый ключи: закрытый ключ не сохраняется в {{ yandex-cloud }}, открытый ключ нельзя будет посмотреть в консоли управления.

    - CLI

      Чтобы создать авторизованный ключ, выполните команду:

      ```bash
      yc iam key create \
        --service-account-name <имя_сервисного_аккаунта> \
        --output authorized-key.json
      ```

      Где:
      * `--service-account-name` — имя сервисного аккаунта, например `eso-service-account`.
      * `--output` — имя файла, в который сохраняется содержимое авторизованного ключа.

    {% endlist %}

1. [Создайте](../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) кластер {{ managed-k8s-name }} любой подходящей конфигурации.

    {% note info %}

    Для работы External Secrets Operator требуется, чтобы в узле кластера было как минимум 10 подов.

    {% endnote %}

1. [Создайте](../managed-kubernetes/operations/node-group/node-group-create.md) группу узлов.

### Настройте окружение {#environment-set-up}

1. {% include [cli-install](../_includes/cli-install.md) %}

   {% include [default-catalogue](../_includes/default-catalogue.md) %}

1. Установите утилиту `jq`:

   ```bash
   sudo apt update && sudo apt install jq
   ```

1. {% include [Install and configure kubectl](../_includes/managed-kubernetes/kubectl-install.md) %}

## Установите External Secrets Operator {#install-eso}

{% list tabs %}

- С помощью {{ marketplace-full-name }}

  Чтобы установить [External Secrets Operator](/marketplace/products/yc/external-secrets) с помощью {{ marketplace-name }}, [воспользуйтесь инструкцией](../managed-kubernetes/operations/applications/external-secrets-operator.md#install-eso-marketplace).

- С помощью Helm

  1. [Установите менеджер пакетов Helm](https://helm.sh/ru/docs/intro/install/).

  1. Добавьте Helm-репозиторий `external-secrets`:

      ```bash
      helm repo add external-secrets https://charts.external-secrets.io
      ```

  1. Установите External Secrets Operator в кластер {{ k8s }}:

      ```bash
      helm install external-secrets \
        external-secrets/external-secrets \
        --namespace external-secrets \
        --create-namespace
      ```

      {% note info %}

      Эта команда создаст новое пространство имен `external-secrets`, необходимое для работы External Secrets Operator.

      {% endnote %}

      Результат:

      ```text
      NAME: external-secrets
      LAST DEPLOYED: Sun Sep 19 11:20:58 2021
      NAMESPACE: external-secrets
      STATUS: deployed
      REVISION: 1
      TEST SUITE: None
      NOTES:
      external-secrets has been deployed successfully!
      ...
      ```

{% endlist %}

## Настройте {{ lockbox-name }} {#configure-lockbox}

{% list tabs %}

- Консоль управления

  1. Создайте секрет:
      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создан секрет.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}** и нажмите кнопку **{{ ui-key.yacloud.lockbox.button_create-secret }}**.
      1. В поле **{{ ui-key.yacloud.common.name }}** введите имя секрета – `lockbox-secret`.
      1. В блоке **{{ ui-key.yacloud.lockbox.forms.section_version }}**:
          * В поле **{{ ui-key.yacloud.lockbox.forms.label_key }}** введите неконфиденциальный идентификатор – `password`.
          * В поле **{{ ui-key.yacloud.lockbox.forms.label_value }}** введите конфиденциальные данные для хранения – `p@$$w0rd`.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  1. Сохраните идентификатор созданного секрета, он понадобится в дальнейшем.
  1. Назначьте сервисному аккаунту `eso-service-account` роль `lockbox.payloadViewer` на созданный секрет:
      1. Нажмите на имя секрета `lockbox-secret`.
      1. На панели слева выберите раздел ![image](../_assets/organization/icon-groups.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** и нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
      1. В открывшемся окне нажмите кнопку ![image](../_assets/plus-sign.svg) **{{ ui-key.yacloud_components.acl.action.select-subject }}**.
      1. Выберите сервисный аккаунт `eso-service-account`.
      1. Нажмите кнопку ![image](../_assets/plus-sign.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите `lockbox.payloadViewer`.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI

  1. Создайте секрет с именем `lockbox-secret`:

      ```bash
      yc lockbox secret create \
        --name lockbox-secret \
        --payload '[{"key": "password","textValue": "p@$$w0rd"}]'
      ```

      Где:
      * `--name` — имя секрета.
      * `--payload` — содержимое секрета.

  1. Получите идентификатор секрета:

      ```bash
      yc lockbox secret list
      ```

      Результат:

      ```text
      +----------------------+----------------+------------+---------------------+----------------------+--------+
      |          ID          |      NAME      | KMS KEY ID |     CREATED AT      |  CURRENT VERSION ID  | STATUS |
      +----------------------+----------------+------------+---------------------+----------------------+--------+
      | e6qoffd33mf0osc2lpum | lockbox-secret |            | 2021-09-19 04:33:44 | e6qlkguf0hs4q3i6jpen | ACTIVE |
      +----------------------+----------------+------------+---------------------+----------------------+--------+
      ```

      Сохраните идентификатор секрета (столбец `ID`), он понадобится в дальнейшем. 

  1. Назначьте сервисному аккаунту `eso-service-account` роль `lockbox.payloadViewer` на созданный секрет:

      ```bash
      yc lockbox secret add-access-binding \
        --name lockbox-secret \
        --service-account-name eso-service-account \
        --role lockbox.payloadViewer
      ```

      Где:
      * `--name` — имя секрета.
      * `--service-account-name` — имя сервисного аккаунта.
      * `--role` — назначаемая роль.

{% endlist %}

## Настройте кластер {{ managed-k8s-name }} {#configure-k8s}

1. Создайте [пространство имен](../managed-kubernetes/concepts/index.md#namespace) `ns`, в котором будут размещены объекты External Secrets Operator:

    ```bash
    kubectl create namespace ns
    ```

1. Создайте секрет `yc-auth` с ключом сервисного аккаунта `eso-service-account`:

    ```bash
    kubectl --namespace ns create secret generic yc-auth \
      --from-file=authorized-key=authorized-key.json
    ```

1. Создайте хранилище секретов [SecretStore](https://external-secrets.io/latest/api/secretstore/), содержащее секрет `yc-auth`:

    ```bash
    kubectl --namespace ns apply -f - <<< '
    apiVersion: external-secrets.io/v1alpha1
    kind: SecretStore
    metadata:
      name: secret-store
    spec:
      provider:
        yandexlockbox:
          auth:
            authorizedKeySecretRef:
              name: yc-auth
              key: authorized-key'
    ```

## Создайте External Secret {#create-es}

1. Создайте объект [ExternalSecret](https://external-secrets.io/latest/api/externalsecret/), указывающий на секрет `lockbox-secret` в хранилище `secret-store`:

    ```bash
    kubectl --namespace ns apply -f - <<< '
    apiVersion: external-secrets.io/v1alpha1
    kind: ExternalSecret
    metadata:
      name: external-secret
    spec:
      refreshInterval: 1h
      secretStoreRef:
        name: secret-store
        kind: SecretStore
      target:
        name: k8s-secret
      data:
      - secretKey: password
        remoteRef:
          key: e6qoffd33mf0osc2lpum
          property: password'
    ```

    Где:
    * `key` — идентификатор секрета {{ lockbox-name }}.
    * `spec.target.name` — имя нового ключа: `k8s-secret`. External Secret Operator создаст этот ключ и поместит в него параметры секрета `lockbox-secret`.

1. Убедитесь, что новый ключ `k8s-secret` содержит значение секрета `lockbox-secret`:

    ```bash
    kubectl --namespace ns get secret k8s-secret \
      --output=json | \
      jq --raw-output ."data"."password" | \
      base64 --decode
    ```

    В выводе команды будет содержаться значение ключа `password` секрета `lockbox-secret`:

    ```text
    p@$$w0rd
    ```

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

{% list tabs %}

- Вручную

  1. [Удалите кластер {{ managed-k8s-name }}](../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
  1. Если вы зарезервировали для кластера публичный статический IP-адрес, [удалите его](../vpc/operations/address-delete.md).
  1. [Удалите секрет](../lockbox/operations/secret-delete.md) `lockbox-secret`.

- С помощью {{ TF }}

  1. В терминале перейдите в директорию, в которой расположен актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
  1. Удалите конфигурационный файл `k8s-cluster.tf`.
  1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

     ```bash
     terraform validate
     ```

     Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../_includes/mdb/terraform/apply.md) %}

     Все ресурсы, которые были описаны в конфигурационном файле `k8s-cluster.tf`, будут удалены.

{% endlist %}

## Как создать инфраструктуру с помощью {{ TF }} {#terraform}

1. Если у вас еще нет {{ TF }}, [установите его](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
1. Скачайте [файл с настройками провайдера](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Поместите его в отдельную рабочую директорию и укажите значения параметров.
1. Скачайте в ту же рабочую директорию файл конфигурации кластера [k8s-cluster.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/managed-kubernetes/k8s-cluster.tf). В файле описаны:
   * [Сеть](../vpc/concepts/network.md#network).
   * [Подсеть](../vpc/concepts/network.md#network).
   * [Группа безопасности](../vpc/concepts/security-groups.md) и [правила](../managed-kubernetes/operations/connect/security-groups.md), необходимые для работы кластера {{ managed-k8s-name }}:
     * Правила для служебного трафика.
     * Правила для доступа к API {{ k8s }} и управления кластером с помощью `kubectl` через порты 443 и 6443.
   * Кластер {{ managed-k8s-name }}.
   * [Сервисный аккаунт](../iam/concepts/users/service-accounts.md), необходимый для работы кластера и группы узлов {{ managed-k8s-name }}.
1. Укажите в файле конфигурации:
   * [Идентификатор каталога](../resource-manager/operations/folder/get-id.md).
   * Версии {{ k8s }} для кластера и групп узлов {{ managed-k8s-name }}.
   * CIDR кластера {{ managed-k8s-name }}.
   * Имя сервисного аккаунта кластера.
1. Выполните команду `terraform init` в директории с конфигурационными файлами. Эта команда инициализирует провайдер, указанный в конфигурационных файлах, и позволяет работать с ресурсами и источниками данных провайдера.
1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

   ```bash
   terraform validate
   ```

   Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.
1. Создайте необходимую инфраструктуру:

   {% include [terraform-apply](../_includes/mdb/terraform/apply.md) %}

   {% include [explore-resources](../_includes/mdb/terraform/explore-resources.md) %}
