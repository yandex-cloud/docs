# Установка Ingress-контроллера {{ alb-name }}

Для балансировки нагрузки и распределения трафика между приложениями {{ k8s }} используйте [Ingress-контроллер {{ alb-full-name }}](../../../application-load-balancer/tools/k8s-ingress-controller/index.md). Он запускает балансировщик и необходимые вспомогательные ресурсы, когда пользователь создает ресурс `Ingress` в кластере {{ managed-k8s-name }}.

## Перед началом работы {#before-you-begin}

1. {% include [k8s-ingress-controller-create-cluster](../../../_includes/application-load-balancer/k8s-ingress-controller-create-cluster.md) %}

1. {% include [k8s-ingress-controller-create-node-group](../../../_includes/application-load-balancer/k8s-ingress-controller-create-node-group.md) %}

## Создание сервисного аккаунта {#create-sa-key}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md), необходимый для работы Ingress-контроллера.
1. [Назначьте ему роли](../../../iam/operations/sa/assign-role-for-sa.md):
   * `alb.editor` — для создания необходимых ресурсов.
   * `vpc.publicAdmin` — для управления [внешней связностью](../../../vpc/security/index.md#roles-list).
   * `certificate-manager.certificates.downloader` — для работы с сертификатами, зарегистрированными в сервисе [{{ certificate-manager-full-name }}](../../../certificate-manager/).
   * `compute.viewer` — для использования узлов кластера {{ managed-k8s-name }} в [целевых группах](../../../application-load-balancer/concepts/target-group.md) балансировщика.
1. Создайте для него [авторизованный ключ](../../../iam/operations/sa/create-access-key.md) и сохраните в файл `sa-key.json`:

   ```bash
   yc iam key create \
     --service-account-name <имя сервисного аккаунта для Ingress-контроллера> \
     --output sa-key.json
   ```

## Установка с помощью {{ marketplace-full-name }} {#install-alb-marketplace}

1. Перейдите на страницу каталога и выберите сервис **{{ managed-k8s-name }}**.
1. Нажмите на имя нужного кластера и выберите вкладку ![Marketplace](../../../_assets/marketplace.svg) **{{ marketplace-short-name }}**.
1. В разделе **Доступные для установки приложения** выберите [ALB Ingress Controller](/marketplace/products/yc/alb-ingress-controller) и нажмите кнопку **Использовать**.
1. Задайте настройки приложения:
   * **Пространство имен** — выберите [пространство имен](../../concepts/index.md#namespace) или создайте новое.
   * **Название приложения** — укажите название приложения.
   * **Идентификатор каталога** — укажите [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md).
   * **Идентификатор кластера** — укажите [идентификатор кластера](../kubernetes-cluster/kubernetes-cluster-list.md).
   * **Ключ сервисного аккаунта** — вставьте содержимое файла `sa-key.json`.
1. Нажмите кнопку **Установить**.

## Установка с помощью Helm-чарта {#install-alb-helm}

1. {% include [Установка Helm](../../../_includes/managed-kubernetes/helm-install.md) %}

1. {% include [Настройка kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. Для потоковой обработки JSON-файлов установите [утилиту](https://stedolan.github.io/jq/) `jq`:

   ```bash
   sudo apt update && sudo apt install jq
   ```

1. Создайте [пространство имен](../../concepts/index.md#namespace):

   ```bash
   kubectl create namespace yc-alb-ingress
   ```

1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с Ingress-контроллером выполните команды:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   cat sa-key.json | helm registry login cr.yandex --username 'json_key' --password-stdin && \
   helm pull oci://cr.yandex/yc/yc-alb-ingress-controller-chart \
     --version=v{{ alb-ingress-version }} \
     --untar && \
   helm install \
     --namespace <пространство имен> \
     --set folderId=<идентификатор каталога> \
     --set clusterId=<идентификатор кластера> \
     --set-file saKeySecretKey=sa-key.json \
     yc-alb-ingress-controller ./yc-alb-ingress-controller-chart/
   ```

## См. также {#see-also}

* [Описание Ingress-контроллеров](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/) в документации {{ k8s }}.
* [Практическое руководство по настройке Ingress-контроллера {{ alb-name }}](../../tutorials/alb-ingress-controller.md).
* [Справочник Ingress-контроллера {{ alb-name }}](../../../application-load-balancer/k8s-ref/index.md).