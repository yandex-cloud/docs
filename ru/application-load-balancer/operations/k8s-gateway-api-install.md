# Установить Gateway API {{ alb-name }} для {{ managed-k8s-name }}

[Gateway API {{ alb-name }} для {{ managed-k8s-full-name }}](../tools/k8s-gateway-api/index.md) поставляется{% if product == "yandex-cloud" %} как продукт {{ marketplace-name }} или{% endif %} как чарт [Helm]{% if lang == "ru" %}(https://helm.sh/ru/){% else %}(https://helm.sh/){% endif %} — менеджера пакетов для {{ k8s }}.

## Перед началом работы {#before-you-begin}

1. {% include [k8s-ingress-controller-create-cluster](../../_includes/application-load-balancer/k8s-ingress-controller-create-cluster.md) %}

1. {% include [k8s-ingress-controller-create-node-group](../../_includes/application-load-balancer/k8s-ingress-controller-create-node-group.md) %}

1. Создайте и настройте сервисный аккаунт для работы Gateway API:

   1. {% include [cli-install](../../_includes/cli-install.md) %}
   
      {% include [default-catalogue](../../_includes/default-catalogue.md) %}
   
   1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md), необходимый для работы Gateway API.
   1. [Назначьте ему роли](../../iam/operations/sa/assign-role-for-sa.md):
      * `alb.editor` — для создания необходимых ресурсов.
      * `vpc.publicAdmin` — для управления [внешней связностью](../../vpc/security/index.md#roles-list).
      * `certificate-manager.certificates.admin` — для управления сертификатами, зарегистрированными в сервисе [{{ certificate-manager-full-name }}](../../certificate-manager/).
      * `compute.viewer` — для использования узлов кластера {{ managed-k8s-name }} в [целевых группах](../../application-load-balancer/concepts/target-group.md) балансировщика.
   1. Создайте для сервисного аккаунта [авторизованный ключ](../../iam/operations/sa/create-access-key.md) и сохраните в файле `sa-key.json`:
   
      ```bash
      yc iam key create \
        --service-account-name <имя_сервисного_аккаунта_для_Gateway_API> \
        --output sa-key.json
      ```

{% if product == "yandex-cloud" %}

## Установка с помощью {{ marketplace-full-name }} {#install-alb-marketplace}

1. Перейдите на страницу каталога и выберите сервис **{{ managed-k8s-name }}**.
1. Нажмите на имя нужного кластера и выберите вкладку ![Marketplace](../../_assets/marketplace.svg) **{{ marketplace-short-name }}**.
1. В разделе **Доступные для установки приложения** выберите [Gateway API](/marketplace/products/yc/gateway-api) и нажмите кнопку **Использовать**.
1. Задайте настройки приложения:
   * **Пространство имен** — выберите [пространство имен](../../managed-kubernetes/concepts/index.md#namespace) или создайте новое.
   * **Название приложения** — укажите название приложения.
   * **Идентификатор каталога** — выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создавать балансировщики.
   * **Идентификатор сети** — выберите [сеть](../../vpc/concepts/network.md), в которой нужно [располагать балансировщики](../concepts/application-load-balancer.md#lb-location).
   * **Идентификатор подсети** — выберите [подсеть](../../vpc/concepts/network.md#subnet), в которой нужно [располагать балансировщики](../concepts/application-load-balancer.md#lb-location). Сейчас балансировщики, создаваемые через Gateway API, могут располагаться только в одной подсети.
   * **Secret Key** — вставьте содержимое файла `sa-key.json`.
1. Нажмите кнопку **Установить**.

{% endif %}

## Установка с помощью Helm-чарта {#install-alb-helm}

1. {% include [Установка Helm](../../_includes/managed-kubernetes/helm-install.md) %}

1. {% include [Настройка kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

1. Для потоковой обработки JSON-файлов установите [утилиту](https://stedolan.github.io/jq/) `jq`:

   ```bash
   sudo apt update && sudo apt install jq
   ```

1. Создайте [пространство имен](../../managed-kubernetes/concepts/index.md#namespace):

   ```bash
   kubectl create namespace yc-alb-ingress
   ```

1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с Ingress-контроллером выполните команды:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   cat sa-key.json | helm registry login {{ registry }} --username 'json_key' --password-stdin && \
   helm pull oci://{{ registry }}/yc-marketplace/yandex-cloud/gateway-api/gateway-api-helm/gateway-api \
     --version {{ alb-gateway-api-version }} \
     --untar && \
   helm install \
     --namespace <пространство_имен> \
     --set folderId=<идентификатор_каталога> \
     --set networkId=<идентификатор_сети> \
     --set subnetId=<идентификатор_подсети> \
     --set-file saKeySecretKey=sa-key.json \
     yc-alb-gateway-api ./yc-alb-gateway-api-chart/
   ```

## См. также {#see-also}

* [Описание проекта Gateway API](https://gateway-api.sigs.k8s.io/).
* [Справочник инструментов {{ alb-name }} для {{ managed-k8s-name }}](../k8s-ref/index.md).