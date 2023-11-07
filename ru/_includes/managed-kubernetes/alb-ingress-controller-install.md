# Установка Ingress-контроллера {{ alb-name }}

Для балансировки нагрузки и распределения трафика между приложениями {{ k8s }} используйте [Ingress-контроллер {{ alb-full-name }}](../../application-load-balancer/tools/k8s-ingress-controller/index.md). Он запускает балансировщик и необходимые вспомогательные ресурсы, когда пользователь создает ресурс `Ingress` в кластере {{ managed-k8s-name }}.

## Перед началом работы {#before-you-begin}

1. {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md), необходимый для работы Ingress-контроллера, и [назначьте ему роли](../../iam/operations/sa/assign-role-for-sa.md):
   * `alb.editor` — для создания необходимых ресурсов.
   * `vpc.publicAdmin` — для управления [внешней связностью](../../vpc/security/index.md#roles-list).
   * `certificate-manager.certificates.downloader` — для работы с сертификатами, зарегистрированными в сервисе [{{ certificate-manager-full-name }}](../../certificate-manager/).
   * `compute.viewer` — для использования узлов кластера {{ managed-k8s-name }} в [целевых группах](../../application-load-balancer/concepts/target-group.md) балансировщика.
1. Создайте [статический ключ доступа](../../iam/operations/sa/create-access-key.md) для сервисного аккаунта в формате JSON и сохраните его в файл `sa-key.json`:

   ```bash
  yc iam key create \
  --service-account-name <имя_сервисного_аккаунта> \
  --folder-id <id_каталога_с_сервисным_аккаунтом> \
  --output sa-key.json
   ```


## Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Нажмите на имя нужного кластера и выберите вкладку ![Marketplace](../../_assets/marketplace.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
1. В разделе **Доступные для установки приложения** выберите [ALB Ingress Controller](/marketplace/products/yc/alb-ingress-controller) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
1. Задайте настройки приложения:
   * **Пространство имен** — выберите [пространство имен](../../managed-kubernetes/concepts/index.md#namespace) или создайте новое.
   * **Название приложения** — укажите название приложения.
   * **Идентификатор каталога** — укажите [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
   * **Идентификатор кластера** — укажите [идентификатор кластера](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-list.md).
   * **Ключ сервисного аккаунта** — вставьте содержимое файла `sa-key.json`.
1. Нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Дождитесь перехода приложения в статус `{{ ui-key.yacloud.k8s.cluster.marketplace.label_release-status-DEPLOYED }}`.


## Установка с помощью Helm-чарта {#install-alb-helm}

1. {% include [helm-install](helm-install.md) %}

1. {% include [kubectl-install](kubectl-install.md) %}

1. Установите [утилиту `jq`](https://stedolan.github.io/jq/) для потоковой обработки JSON-файлов:

   ```bash
   sudo apt update && sudo apt install jq
   ```

1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с Ingress-контроллером выполните команды:

   
   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   cat sa-key.json | helm registry login {{ registry }} --username 'json_key' --password-stdin && \
   helm pull oci://{{ mkt-k8s-key.yc_alb-ingress-controller.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_alb-ingress-controller.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace <пространство_имен> \
     --create-namespace \
     --set folderId=<идентификатор_каталога> \
     --set clusterId=<идентификатор_кластера> \
     --set-file saKeySecretKey=sa-key.json \
     yc-alb-ingress-controller ./yc-alb-ingress-controller-chart/
   ```


## См. также {#see-also}

* [Описание Ingress-контроллеров](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/) в документации {{ k8s }}.


* [Практическое руководство по настройке Ingress-контроллера {{ alb-name }}](../../managed-kubernetes/tutorials/alb-ingress-controller.md).
* [Практическое руководство по настройке логирования для Ingress-контроллеров {{ alb-name }}](../../managed-kubernetes/tutorials/alb-ingress-controller-log-options.md).


* [Справочник Ingress-контроллера {{ alb-name }}](../../application-load-balancer/k8s-ref/index.md).
