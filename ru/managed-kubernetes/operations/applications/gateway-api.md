# Установка Gateway API

[Gateway API](https://github.com/kubernetes-sigs/gateway-api) — набор ресурсов API, моделирующих сетевое взаимодействие в [кластере {{ k8s }}](../../concepts/index.md#kubernetes-cluster). Среди них `GatewayClass,` `Gateway`, `HTTPRoute` и другие.

В сервисе {{ managed-k8s-name }} Gateway API запускает [{{ alb-full-name }}](../../../application-load-balancer/) и необходимые вспомогательные ресурсы, когда пользователь {{ k8s }} объявляет ресурс `Gateway` в кластере.

## Перед началом работы {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. {% include [Настройка kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. Для потоковой обработки JSON-файлов установите [утилиту `jq`](https://stedolan.github.io/jq/):

   ```bash
   sudo apt update && sudo apt install jq
   ```

1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md), необходимый для работы Gateway API.
1. [Назначьте ему роли](../../../iam/operations/sa/assign-role-for-sa.md):
   * `alb.editor` — для создания необходимых ресурсов.
   * `vpc.publicAdmin` — для управления [внешней связностью](../../../vpc/security/index.md#roles-list).
   * `certificate-manager.admin` — для работы с сертификатами, зарегистрированными в сервисе [{{ certificate-manager-full-name }}](../../../certificate-manager/).
   * `compute.viewer` — для использования узлов кластера {{ managed-k8s-name }} в [целевых группах](../../../application-load-balancer/concepts/target-group.md) балансировщика.
1. Создайте для него [статический ключ](../../../iam/operations/sa/create-access-key.md) и сохраните в файл `sa-key.json`:

   ```bash
   yc iam key create \
     --service-account-name <имя сервисного аккаунта для Gateway API> \
     --output sa-key.json
   ```

## Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

1. Перейдите на страницу каталога и выберите сервис **{{ managed-k8s-name }}**.
1. Нажмите на имя нужного кластера и выберите вкладку **{{ marketplace-short-name }}**.
1. В разделе **Доступные для установки приложения** выберите [Gateway API](/marketplace/products/yc/gateway-api) и нажмите кнопку **Использовать**.
1. Задайте настройки приложения:
   * **Пространство имен** — выберите [пространство имен](../../concepts/index.md#namespace) или создайте новое.
   * **Название приложения** — укажите название приложения.
   * **Идентификатор каталога** — укажите [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md).
   * **Идентификатор сети** — укажите идентификатор [облачной сети](../../../vpc/concepts/network.md#network).
   * **Идентификатор подсети** — укажите идентификатор [подсети](../../../vpc/concepts/network.md#subnet).
   * **Ключ сервисного аккаунта** — вставьте содержимое файла `sa-key.json`.
1. Нажмите кнопку **Установить**.

## Установка с помощью Helm-чарта {#helm-install}

1. {% include [Установка Helm](../../../_includes/managed-kubernetes/helm-install.md) %}

1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с Gateway API выполните команду:

   ```bash
    export HELM_EXPERIMENTAL_OCI=1 && \
    helm pull oci://{{ registry }}/yc-marketplace/yandex-cloud/gateway-api/gateway-api-helm/gateway-api \
      --version <версия Helm-чарта> \
      --untar && \
    helm install \
      --namespace <пространство имен> \
      --create-namespace \
      --set folderId='<идентификатор каталога>' \
      --set networkId='<идентификатор облачной сети>' \
      --set subnetId='<идентификатор подсети>' \
      --set-file saKeySecretKey='<путь к ранее сгенерированному sa-key.json>' \
      gateway-api ./gateway-api/
   ```

   Актуальную версию Helm-чарта можно посмотреть на [странице приложения](/marketplace/products/yc/gateway-api#docker-images).

## См. также {#see-also}

* [Документация {{ k8s }} Gateway API](https://gateway-api.sigs.k8s.io/).
* [Документация {{ alb-name }}](../../../application-load-balancer/).