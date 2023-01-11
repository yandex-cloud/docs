# Установка HashiCorp Vault с поддержкой {{ kms-name }}

[HashiCorp Vault](https://www.vaultproject.io/) — инструмент с открытым исходным кодом, который обеспечивает безопасное хранение и доступ к различным секретам (паролям, сертификатам, токенам).

Образ приложения содержит предустановленную сборку HashiCorp Vault, которая при помощи [{{ kms-full-name }}](../../../kms/) дополнительно поддерживает [Auto Unseal](https://developer.hashicorp.com/vault/docs/concepts/seal#auto-unseal). Сборка подготовлена на основе [HashiCorp Vault](https://github.com/hashicorp/vault/tags) соответствующей версии.

Чтобы установить HashiCorp Vault:
1. [Создайте сервисный аккаунт и ключи](#sa-keys-create).
1. [Установите HashiCorp Vault](#install).
1. [Выполните инициализацию хранилища](#vault-init).

## Создание сервисного аккаунта и ключей {#sa-keys-create}

Для работы HashiCorp Vault требуется:
* [Сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) с [ролью](../../../iam/concepts/access-control/roles.md) `kms.keys.encrypterDecrypter`.
* [Авторизованный ключ](../../../iam/concepts/authorization/key.md).
* [Симметричный ключ шифрования](../../../kms/concepts/key.md).
1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md):

   ```bash
   yc iam service-account create --name vault-kms
   ```

1. [Создайте авторизованный ключ](../../../iam/operations/authorized-key/create.md) для сервисного аккаунта и сохраните его в файл `authorized-key.json`:

   ```bash
   yc iam key create \
     --service-account-name vault-kms \
     --output authorized-key.json
   ```

1. [Создайте симметричный ключ {{ kms-name }}](../../../kms/operations/key.md#create):

   ```bash
   yc kms symmetric-key create \
     --name example-key \
     --default-algorithm aes-256 \
     --rotation-period 24h
   ```

   Сохраните идентификатор ключа (`id`) — он понадобится при установке приложения.
1. [Назначьте роль](../../../iam/operations/roles/grant.md) `kms.keys.encrypterDecrypter` ключу {{ kms-name }}:

   ```bash
   yc resource-manager folder add-access-binding \
     --id <идентификатор каталога> \
     --service-account-name vault-kms \
     --role kms.keys.encrypterDecrypter
   ```

   Идентификатор каталога можно получить [со списком каталогов](../../../resource-manager/operations/folder/get-id.md).

## Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

1. Перейдите на страницу каталога и выберите сервис **{{ managed-k8s-name }}**.
1. Нажмите на имя нужного кластера и выберите вкладку **{{ marketplace-short-name }}**.
1. В разделе **Доступные для установки приложения** выберите [HashiCorp Vault с поддержкой {{ kms-name }}](/marketplace/products/yc/vault-yckms-k8s) и нажмите кнопку **Использовать**.
1. Задайте настройки приложения:
   * **Пространство имен** — выберите [пространство имен](../../concepts/index.md#namespace) или создайте новое.
   * **Название приложения** — укажите название приложения.
   * **Ключ сервисной учетной записи для Vault** — скопируйте в это поле содержимое файла `authorized-key.json`.
   * **ID ключа {{ kms-short-name }} для Vault** — укажите [полученный ранее](#sa-keys-create) идентификатор ключа {{ kms-name }}.
1. Нажмите кнопку **Установить**.

## Установка с помощью Helm-чарта {#helm-install}

1. {% include [Установка Helm](../../../_includes/managed-kubernetes/helm-install.md) %}

1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с HashiCorp Vault выполните команду:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   cat authorized-key.json | helm registry login {{ registry }} --username 'json_key' --password-stdin && \
   helm pull oci://{{ registry }}/yc-marketplace/yandex-cloud/vault/chart/vault \
     --version <версия Helm-чарта> \
     --untar && \
   helm install \
     --namespace <пространство имен> \
     --create-namespace \
     --set-file yandexKmsAuthJson=authorized-key.json \
     hashicorp ./vault/
   ```

   Актуальную версию Helm-чарта можно посмотреть на [странице приложения](/marketplace/products/yc/vault-yckms-k8s).

   Эта команда также создаст новое пространство имен, необходимое для работы HashiCorp Vault.

## Инициализация хранилища {#vault-init}

После установки HashiCorp Vault необходимо инициализировать один из его серверов. Процесс инициализации генерирует учетные данные, необходимые для [распечатывания (unseal)](https://www.vaultproject.io/docs/concepts/seal#why) всех серверов хранилища.

{% note info %}

При инициализации выполнять операцию `unseal` не нужно — образ приложения интегрирован с {{ kms-name }}.

Подробнее см. на странице [Auto Unseal](../../../kms/tutorials/vault-secret.md) и в документации [HashiCorp Vault](https://learn.hashicorp.com/tutorials/vault/kubernetes-raft-deployment-guide?in=vault/kubernetes#initialize-and-unseal-vault).

{% endnote %}

Чтобы инициализировать хранилище:
1. Убедитесь, что приложение перешло в состояние `Running` и имеет `0/1` готовых [подов](../../concepts/index.md#pod):

   ```bash
   kubectl get pods --selector='app.kubernetes.io/name=vault'
   ```

   Результат:

   ```text
   NAME              READY  STATUS   RESTARTS  AGE
   <имя пода vault>  0/1    Running  0         58s
   ```

1. Выполните инициализацию хранилища:

   ```bash
   kubectl exec \
     --stdin=true \
     --tty=true <имя пода vault> \
     -- vault operator init
   ```

   Результат:

   ```text
   Recovery Key 1: ulbugw4IKttmCCPprF6JwmUCyx1YfieCQPQiI2S0VV9o
   Recovery Key 2: S0kcValC6qSfEI4WJBovSbJWZntBUwtTrtisSIcS3n0e
   Recovery Key 3: t44ZRqbzLZNzfChinZNzLCNnwvFN/R52vbDq/UueHPPg
   ...

   Recovery key initialized with 5 key shares and a key threshold of 3. Please
   securely distribute the key shares printed above.
   ```

1. Повторно запросите список подов приложения и убедитесь, что готов один под:

   ```bash
   kubectl get pods --selector='app.kubernetes.io/name=vault'
   ```

   Результат:

   ```text
   NAME               READY  STATUS   RESTARTS  AGE
   vault-yckms-k8s-0  1/1    Running  0         5m
   ```