# Установка Gateway API

[Gateway API](https://github.com/kubernetes-sigs/gateway-api) — набор ресурсов API, моделирующих сетевое взаимодействие в [кластере {{ k8s }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster). Среди них `GatewayClass,` `Gateway`, `HTTPRoute` и другие.

В сервисе {{ managed-k8s-name }} Gateway API запускает [{{ alb-full-name }}](../../application-load-balancer/) и необходимые вспомогательные ресурсы, когда пользователь {{ k8s }} объявляет ресурс `Gateway` в кластере.

## Перед началом работы {#before-you-begin}

1. {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

1. {% include [Настройка kubectl](kubectl-install.md) %}
1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md), необходимый для работы Gateway API.
1. [Назначьте ему роли](../../iam/operations/sa/assign-role-for-sa.md):
   * `alb.editor` — для создания необходимых ресурсов.
   * `vpc.publicAdmin` — для управления [внешней связностью](../../vpc/security/index.md#roles-list).
   * `certificate-manager.admin` — для работы с сертификатами, зарегистрированными в сервисе [{{ certificate-manager-full-name }}](../../certificate-manager/).
   * `compute.viewer` — для использования узлов кластера {{ managed-k8s-name }} в [целевых группах](../../application-load-balancer/concepts/target-group.md) балансировщика.
1. Создайте для него [статический ключ](../../iam/operations/sa/create-access-key.md) и сохраните в файл `sa-key.json`:

   ```bash
   yc iam key create \
     --service-account-name <имя_сервисного_аккаунта_для_Gateway_API> \
     --output sa-key.json
   ```


## Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

1. Перейдите на страницу каталога и выберите сервис **{{ managed-k8s-name }}**.
1. Нажмите на имя нужного кластера и выберите вкладку ![Marketplace](../../_assets/marketplace.svg) **{{ marketplace-short-name }}**.
1. В разделе **Доступные для установки приложения** выберите [Gateway API](/marketplace/products/yc/gateway-api) и нажмите кнопку **Использовать**.
1. Задайте настройки приложения:
   * **Пространство имен** — выберите [пространство имен](../../managed-kubernetes/concepts/index.md#namespace) или создайте новое.
   * **Название приложения** — укажите название приложения.
   * **Идентификатор каталога** — выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создавать балансировщики.
   * **Идентификатор сети** — выберите [облачную сеть](../../vpc/concepts/network.md#network), в которой нужно [располагать балансировщики](../../application-load-balancer/concepts/application-load-balancer.md#lb-location).
   * **Идентификатор подсети 1**, **Идентификатор подсети 2**, **Идентификатор подсети 3**  — выберите [подсети](../../vpc/concepts/network.md#subnet), в которых нужно [располагать балансировщики](../../application-load-balancer/concepts/application-load-balancer.md#lb-location).
   * **Secret Key** — вставьте содержимое файла `sa-key.json` или создайте новый ключ сервисного аккаунта.
1. Нажмите кнопку **Установить**.


## Установка с помощью Helm-чарта {#helm-install}

1. {% include [Установка Helm](helm-install.md) %}

1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с Gateway API выполните команду:

   ```bash
    export HELM_EXPERIMENTAL_OCI=1 && \
    helm pull oci://{{ mkt-k8s-key.yc_gateway-api.helmChart.name }} \
      --version {{ mkt-k8s-key.yc_gateway-api.helmChart.tag }} \
      --untar && \
    helm install \
      --namespace <пространство_имен> \
      --create-namespace \
      --set folderId='<идентификатор_каталога>' \
      --set networkId='<идентификатор_облачной_сети>' \
      --set subnetId='<идентификатор_подсети>' \
      --set-file saKeySecretKey='<путь_к_ранее_сгенерированному_sa-key.json>' \
      gateway-api ./gateway-api/
   ```

## См. также {#see-also}

* [Описание проекта Gateway API](https://gateway-api.sigs.k8s.io/).
* [Документация {{ alb-name }}](../../application-load-balancer/).
* [Справочник инструментов {{ alb-name }} для {{ managed-k8s-name }}](../../application-load-balancer/k8s-ref/index.md).