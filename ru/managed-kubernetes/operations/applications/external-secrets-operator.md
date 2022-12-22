# Установка External Secrets Operator с поддержкой {{ lockbox-name }}

[External Secrets Operator](/marketplace/products/yc/external-secrets) — оператор {{ k8s }}, который интегрирует внешние системы управления секретами, такие как [{{ lockbox-name }}](../../../lockbox/), AWS Secrets Manager, Azure Key Vault, HashiCorp Vault, Google Secrets Manager и другие. Оператор считывает информацию из внешних API и автоматически вводит значения в {{ k8s }} Secret.

External Secrets Operator с поддержкой {{ lockbox-name }} позволяет настроить синхронизацию секретов {{ lockbox-name }} с секретами [кластера {{ k8s }}](../../concepts/index.md#kubernetes-cluster).

## Создание сервисного аккаунта {#create-sa-key}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md), необходимый для работы External Secrets Operator.
1. Создайте для него [авторизованный ключ](../../../iam/concepts/authorization/key.md) и сохраните его в файл `sa-key.json`:

   ```bash
   yc iam key create \
     --service-account-name <имя сервисного аккаунта> \
     --output sa-key.json
   ```

## Установка External Secrets Operator с помощью {{ marketplace-full-name }} {#install-eso-marketplace}

1. Перейдите на страницу каталога и выберите сервис **{{ managed-k8s-name }}**.
1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../../_assets/marketplace.svg) **{{ marketplace-short-name }}**.
1. В разделе **Доступные для установки приложения** выберите [External Secrets Operator с поддержкой {{ lockbox-name }}](/marketplace/products/yc/external-secrets) и нажмите кнопку **Использовать**.
1. Задайте настройки приложения:
   * **Пространство имен** — выберите [пространство имен](../../concepts/index.md#namespace) или создайте новое.
   * **Название приложения** — укажите название приложения.
   * **Идентификатор каталога** — укажите [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md).
   * **Идентификатор кластера** — укажите [идентификатор кластера](../kubernetes-cluster/kubernetes-cluster-list.md).
   * **Ключ сервисной учетной записи** — вставьте содержимое файла `sa-key.json`.
1. Нажмите кнопку **Установить**.

## Установка с помощью Helm-чарта {#install-eso-helm}

1. {% include [Установка Helm](../../../_includes/managed-kubernetes/helm-install.md) %}

1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с приложением External Secrets Operator выполните команду:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   helm pull oci://{{ registry }}/yc-marketplace/yandex-cloud/external-secrets/chart/external-secrets \
     --version 0.3.8-2 \
     --untar && \
   helm install \
     --namespace <пространство имен> \
     --create-namespace \
     --set-file auth.json=sa-key.json \
     external-secrets ./external-secrets
   ```

   Эта команда создаст новое пространство имен, необходимое для работы External Secrets Operator.

#### См. также {#see-also}

* [Описание External Secrets Operator](https://external-secrets.io/provider-yandex-lockbox/).
* [Документация {{ lockbox-name }}](../../../lockbox/).