# Установка HashiCorp Vault с поддержкой Key Management Service


[HashiCorp Vault](https://www.vaultproject.io/) — инструмент с открытым исходным кодом, который обеспечивает безопасное хранение и доступ к различным секретам (паролям, сертификатам, токенам).

Образ приложения содержит предустановленную сборку HashiCorp Vault, которая при помощи [Yandex Key Management Service](../../../kms/index.md) дополнительно поддерживает [Auto Unseal](https://developer.hashicorp.com/vault/docs/concepts/seal#auto-unseal). Сборка подготовлена на основе [HashiCorp Vault](https://github.com/hashicorp/vault/tags) соответствующей версии.

Чтобы установить HashiCorp Vault:
1. [Подготовьте все необходимое для начала работы](#before-you-begin).
1. Установите HashiCorp Vault с помощью [Yandex Cloud Marketplace](#marketplace-install) или [Helm](#helm-install).
1. [Выполните инициализацию хранилища](#vault-init).

## Перед началом работы {#before-you-begin}

Для работы HashiCorp Vault требуется:
* [Сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) с [ролью](../../../iam/concepts/access-control/roles.md) `kms.keys.encrypterDecrypter`.
* [Авторизованный ключ](../../../iam/concepts/authorization/key.md).
* [Симметричный ключ шифрования](../../../kms/concepts/key.md).

1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md):

   ```bash
   yc iam service-account create --name vault-kms
   ```

1. [Создайте авторизованный ключ](../../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) для сервисного аккаунта и сохраните его в файл `authorized-key.json`:

   ```bash
   yc iam key create \
     --service-account-name vault-kms \
     --output authorized-key.json
   ```

1. [Создайте симметричный ключ Key Management Service](../../../kms/operations/key.md#create):

   ```bash
   yc kms symmetric-key create \
     --name example-key \
     --default-algorithm aes-256 \
     --rotation-period 24h
   ```

   Сохраните идентификатор ключа (`id`) — он понадобится при установке приложения.
1. [Назначьте роль](../../../iam/operations/roles/grant.md) `kms.keys.encrypterDecrypter` сервисному аккаунту, созданному ранее:

   ```bash
   yc resource-manager folder add-access-binding \
     --id <идентификатор_каталога> \
     --service-account-name vault-kms \
     --role kms.keys.encrypterDecrypter
   ```

   Идентификатор каталога можно получить [со списком каталогов](../../../resource-manager/operations/folder/get-id.md).

1. [Убедитесь](../connect/security-groups.md), что группы безопасности для кластера Managed Service for Kubernetes и его групп узлов настроены корректно. Если отсутствует какое-либо из правил — [добавьте](../../../vpc/operations/security-group-add-rule.md) его.

    {% note warning %}
    
    От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
    
    {% endnote %}

1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../connect/index.md#kubectl-connect).

## Установка с помощью Yandex Cloud Marketplace {#marketplace-install}

{% note warning %}

При установке продукта HashiCorp Vault с поддержкой Key Management Service с помощью Cloud Marketplace будет задействован механизм доставки секретов [Agent injector](https://developer.hashicorp.com/vault/docs/platform/k8s/injector). Чтобы задействовать альтернативный механизм [Vault CSI provider](https://developer.hashicorp.com/vault/docs/platform/k8s/csi), установите продукт [с помощью Helm-чарта](#helm-install). Подробнее об отличиях этих механизмов см. [в документации Hashicorp](https://developer.hashicorp.com/vault/docs/platform/k8s/injector-csi).

{% endnote %}

1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
1. Перейдите в сервис **Managed Service for&nbsp;Kubernetes**.
1. Нажмите на имя нужного [кластера Managed Service for Kubernetes](../../concepts/index.md#kubernetes-cluster) и выберите вкладку ![Marketplace](../../../_assets/console-icons/shopping-cart.svg) **Marketplace**.
1. В разделе **Доступные для установки приложения** выберите [HashiCorp Vault с поддержкой Key Management Service](https://yandex.cloud/ru/marketplace/products/yc/vault-yckms-k8s) и нажмите кнопку **Перейти к установке**.
1. Задайте настройки приложения:
   * **Пространство имен** — создайте новое [пространство имен](../../concepts/index.md#namespace) (например, `hashicorp-vault-space`). Если вы оставите пространство имен по умолчанию, HashiCorp Vault может работать некорректно.
   * **Название приложения** — укажите название приложения.
   * **Ключ сервисной учетной записи для Vault** — скопируйте в это поле содержимое файла `authorized-key.json`.
   * **ID ключа KMS для Vault** — укажите [полученный ранее](#before-you-begin) идентификатор ключа Key Management Service.
1. Нажмите кнопку **Установить**.
1. Дождитесь перехода приложения в статус `Deployed`.

## Установка с помощью Helm-чарта {#helm-install}

1. [Установите менеджер пакетов Helm](https://helm.sh/ru/docs/intro/install/) версии не ниже 3.8.0.
1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../connect/index.md#kubectl-connect).
1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с HashiCorp Vault выполните команду, указав в ней параметры ресурсов, созданных [ранее](#before-you-begin):

   ```bash
   cat <путь_к_файлу_с_авторизованным_ключом> | helm registry login cr.yandex \
     --username 'json_key' \
     --password-stdin && \
   helm pull oci://cr.yandex/yc-marketplace/yandex-cloud/vault/chart/vault \
     --version 0.28.1+yckms \
     --untar && \
   helm install \
     --namespace <пространство_имен> \
     --create-namespace \
     --set-file yandexKmsAuthJson=<путь_к_файлу_с_авторизованным_ключом> \
     --set yandexKmsKeyId=<идентификатор_ключа_KMS> \
     hashicorp ./vault/
   ```

   {% note info %}
   
   Если вы используете версию Helm ниже 3.8.0, добавьте в начало команды строку `export HELM_EXPERIMENTAL_OCI=1 && \`, чтобы включить поддержку [Open Container Initiative](https://opencontainers.org/) (OCI) в клиенте Helm.
   
   {% endnote %}

   Параметры команды:
   * `<путь_к_файлу_с_авторизованным_ключом>` — путь к файлу `authorized-key.json`, [сохраненному ранее](#before-you-begin).
   * `<пространство_имен>` — новое пространство имен, которое будет создано для работы HashiCorp Vault. Если вы укажете пространство имен по умолчанию, HashiCorp Vault может работать некорректно. Рекомендуем указывать значение, отличное от всех существующих пространств имен (например, `hashicorp-vault-space`).
   * `<идентификатор_ключа_KMS>` — [полученный ранее](#before-you-begin) идентификатор ключа Key Management Service.

   В результате выполнения команды в кластер будет установлен продукт HashiCorp Vault с поддержкой KMS с механизмом доставки секретов [Agent injector](https://developer.hashicorp.com/vault/docs/platform/k8s/injector). Чтобы задействовать альтернативный механизм [Vault CSI provider](https://developer.hashicorp.com/vault/docs/platform/k8s/csi), дополните команду следующими параметрами:

   ```bash
   --set "injector.enabled=false" \
   --set "csi.enabled=true"
   ```

   Подробнее об отличиях этих механизмов см. [в документации Hashicorp](https://developer.hashicorp.com/vault/docs/platform/k8s/injector-csi).

## Инициализация хранилища {#vault-init}

После установки HashiCorp Vault необходимо инициализировать один из его серверов. Процесс инициализации генерирует учетные данные, необходимые для [распечатывания (unseal)](https://www.vaultproject.io/docs/concepts/seal#why) всех серверов хранилища.

{% note info %}

При инициализации выполнять операцию `unseal` не нужно — образ приложения интегрирован с Key Management Service.

Подробнее см. на странице [Auto Unseal](../../../kms/tutorials/vault-secret.md) и в документации [HashiCorp Vault](https://learn.hashicorp.com/tutorials/vault/kubernetes-raft-deployment-guide?in=vault/kubernetes#initialize-and-unseal-vault).

{% endnote %}

Чтобы инициализировать хранилище:
1. Убедитесь, что приложение перешло в состояние `Running` и имеет `0/1` готовых [подов](../../concepts/index.md#pod):

   ```bash
   kubectl get pods \
     --namespace=<пространство_имен> \
     --selector='app.kubernetes.io/name=vault'
   ```

   Результат:

   ```text
   NAME              READY  STATUS   RESTARTS  AGE
   <имя_пода_vault>  0/1    Running  0         58s
   ```

1. Выполните инициализацию хранилища:

   ```bash
   kubectl exec \
     --namespace=<пространство_имен> \
     --stdin=true \
     --tty=true <имя_пода_vault> \
     -- vault operator init
   ```

   Результат:

   ```text
   Recovery Key 1: ulbugw4IKttmCCPprF6JwmUCyx1YfieCQPQi********
   Recovery Key 2: S0kcValC6qSfEI4WJBovSbJWZntBUwtTrtis********
   Recovery Key 3: t44ZRqbzLZNzfChinZNzLCNnwvFN/R52vbD*/*******
   ...

   Recovery key initialized with 5 key shares and a key threshold of 3. Please
   securely distribute the key shares printed above.
   ```

   Сохраните полученные данные в надежном месте.

1. Повторно запросите список подов приложения и убедитесь, что готов один под:

   ```bash
   kubectl get pods \
     --namespace=<пространство_имен> \
     --selector='app.kubernetes.io/name=vault'
   ```

   Результат:

   ```text
   NAME               READY  STATUS   RESTARTS  AGE
   vault-yckms-k8s-0  1/1    Running  0         5m
   ```

## См. также {#see-also}

* [Документация HashiCorp Vault](https://developer.hashicorp.com/vault/docs?product_intent=vault)
* [Документация Key Management Service](../../../kms/index.md)
* [Использование HashiCorp Vault для хранения секретов](../../tutorials/marketplace/hashicorp-vault.md)
* [Установка External Secrets Operator с поддержкой Yandex Lockbox](external-secrets-operator.md)
* [Синхронизация с секретами Yandex Lockbox](../../tutorials/kubernetes-lockbox-secrets.md)