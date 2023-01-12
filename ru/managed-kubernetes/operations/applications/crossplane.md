# Установка Crossplane с поддержкой {{ yandex-cloud }}

[Crossplane](https://crossplane.io/) — свободно распространяемое дополнение к {{ k8s }}, позволяющее командам разработки платформы собрать инфраструктуру для нескольких вендоров и производить более высокоуровневые API сервисов для потребления командами разработки приложений.

## Перед началом работы {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. {% include [Настройка kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) с ролью `admin`. Он необходим для работы Crossplane.
1. Создайте [ключ сервисного аккаунта](../../../iam/concepts/authorization/access-key.md) и сохраните его в файл:

   ```bash
   yc iam key create --service-account-name <имя сервисного аккаунта> --output key.json
   ```

## Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ managed-k8s-name }}**.
1. Нажмите на имя нужного [кластера {{ k8s }}](../../concepts/index.md#kubernetes-cluster) и выберите вкладку ![image](../../../_assets/marketplace.svg) **{{ marketplace-short-name }}**.
1. В разделе **Доступные для установки приложения** выберите [Crossplane с поддержкой {{ yandex-cloud }}](/marketplace/products/yc/crossplane) и нажмите кнопку **Использовать**.
1. Задайте настройки приложения:
   * **Пространство имен** — выберите [пространство имен](../../concepts/index.md#namespace) для Crossplane или создайте новое.
   * **Название приложения** — укажите название приложения.
   * **Ключ сервисной учетной записи** — вставьте содержимое файла [ключа сервисной учетной записи](../../../iam/concepts/authorization/access-key.md), [полученного ранее](#before-you-begin), или создайте новый.
1. Нажмите кнопку **Установить**.
1. Дождитесь перехода приложения в статус `Deployed`.

## Установка с помощью Helm-чарта {#helm-install}

1. {% include [Установка Helm](../../../_includes/managed-kubernetes/helm-install.md) %}

1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с Crossplane выполните команду:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   helm pull oci://{{ registry }}/yc-marketplace/crossplane/crossplane/crossplane \
     --version <версия Helm-чарта> \
     --untar && \
   helm install \
     --namespace <пространство имен> \
     --create-namespace \
     --set-file providerJetYC.creds=key.json \
     crossplane crossplane/.
   ```

   Актуальную версию Helm-чарта можно посмотреть на [странице приложения](/marketplace/products/yc/crossplane#docker-images).

## Установка с помощью GitHub-репозитория Helm {#helm-repo-install}

1. {% include [Установка Helm](../../../_includes/managed-kubernetes/helm-install.md) %}

1. Создайте пространство имен для Crossplane:

   ```bash
   kubectl create namespace <пространство имен>
   ```

1. Добавьте GitHub-репозиторий Helm:

   ```bash
   helm repo add crossplane-stable https://charts.crossplane.io/stable && \
   helm repo update
   ```

1. Установите Crossplane:

   ```bash
   helm install crossplane --namespace crossplane-system crossplane-stable/crossplane
   ```

1. Убедитесь, что Crossplane установлен и работает:

   ```bash
   helm list -n crossplane-system && \
   kubectl get all -n crossplane-system
   ```

1. Установите Crossplane CLI:

   ```bash
   curl -sL https://raw.githubusercontent.com/crossplane/crossplane/master/install.sh | sh && \
   sudo mv kubectl-crossplane $(dirname $(which kubectl))
   ```

1. Установите провайдер:

   ```bash
   kubectl crossplane install provider {{ registry }}/crp0kch415f0lke009ft/crossplane/provider-jet-yc:v0.1.33
   ```

   Актуальная версия провайдера доступна в [GitHub-репозитории](https://github.com/yandex-cloud/provider-jet-yc).