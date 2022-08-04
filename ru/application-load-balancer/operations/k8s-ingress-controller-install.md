# Установить Ingress-контроллер {{ alb-name }} для {{ managed-k8s-name }}

[Ingress-контроллер {{ alb-name }} для {{ managed-k8s-full-name }}](../tools/k8s-ingress-controller/index.md) поставляется через [Helm]{% if lang == "ru" %}(https://helm.sh/ru/){% else %}(https://helm.sh/){% endif %} — менеджер пакетов для {{ k8s }}.

## Перед началом работы {#prerequisites}

1. {% include [cli-install](../../_includes/cli-install.md) %}
1. {% include [k8s-ingress-controller-install-helm](../../_includes/application-load-balancer/k8s-ingress-controller-install-helm.md) %}
1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) для работы Ingress-контроллера.
1. С помощью CLI [создайте авторизованный ключ для сервисного аккаунта](../../iam/operations/sa/create-access-key.md), сохранив его в файл `sa-key.json`:

   ```bash
   yc iam key create \
     --service-account-name <имя сервисного аккаунта> \
     --output sa-key.json
   ```
   
1. {% include [k8s-ingress-controller-create-cluster](../../_includes/application-load-balancer/k8s-ingress-controller-create-cluster.md) %}
1. {% include [k8s-ingress-controller-create-node-group](../../_includes/application-load-balancer/k8s-ingress-controller-create-node-group.md) %}
1. [Создайте пространство имен](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-namespace-create.md) в кластере.

## Установка {#install}

1. Включите для Helm [экспериментальную поддержку OCI](https://helm.sh/docs/topics/registries/) (Open Container Initiative):

   ```bash
   export HELM_EXPERIMENTAL_OCI=1
   ```
   
1. Аутентифицируйте клиент Helm в реестре {{ container-registry-full-name }} с помощью авторизованного ключа сервисного аккаунта:

   ```bash
   cat sa-key.json | helm registry login {{ registry }} --username 'json_key' --password-stdin
   ```
   
1. Загрузите чарт Ingress-контроллера из реестра и разархивируйте его:

   ```bash
   helm pull \
     --version v{{ alb-ingress-version }} \
     oci://{{ registry }}/yc/yc-alb-ingress-controller-chart
   ```

   {% note info %}

    Если команда возвращает ошибку о медиатипе `manifest does not contain a layer with mediatype application/tar+gzip`, убедитесь, что [установили менеджер пакетов Helm](https://helm.sh/ru/docs/intro/install/) версии не ниже {{ alb-ingress-helm-version }}. Чтобы проверить установленную версию, [выполните команду](https://helm.sh/docs/helm/helm_version/) `helm version`.

    {% endnote %}
   
1. Установите чарт в кластер:

   ```bash
   helm install \
     --namespace <имя пространства имен> \
     --set folderId=<идентификатор каталога> \
     --set clusterId=<идентификатор кластера> \
     --set-file saKeySecretKey=sa-key.json \
     yc-alb-ingress-controller ./yc-alb-ingress-controller-chart-v{{ alb-ingress-version }}.tgz
   ```
   
   Где:

   * `--namespace` — имя пространства имен, созданного перед установкой.
   * `--set` и `--set-file` устанавливают [значения для чарта](https://helm.sh/docs/topics/charts/#templates-and-values) напрямую или из файла соответственно:
     * `folderId` — идентификатор каталога {{ yandex-cloud }}, в котором создан кластер {{ managed-k8s-name }}. Получить идентификатор можно по [инструкции](../../resource-manager/operations/folder/get-id.md) в документации {{ resmgr-full-name }}.
     * `clusterId` — идентификатор кластера. Получить идентификатор можно по [инструкции](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-list.md).
     * `saKeySecretKey` — авторизованный ключ сервисного аккаунта, созданный перед установкой.
   
   * Первый аргумент (`yc-alb-ingress-controller`) — имя чарта для установки.
   * Второй аргумент (`./yc-alb-ingress-controller-chart-v{{ alb-ingress-version }}.tgz`) — путь к скачанному чарту (`./` указывает на текущую папку).
