# Установка Ingress-контроллера {{ alb-name }}

Для балансировки нагрузки и распределения трафика между приложениями {{ k8s }} используйте [Ingress-контроллер {{ alb-full-name }}](../../application-load-balancer/tools/k8s-ingress-controller/index.md). Он запускает L7-балансировщик и необходимые вспомогательные ресурсы, когда пользователь создает ресурс `Ingress` в кластере {{ managed-k8s-name }}.

## Перед началом работы {#before-you-begin}

1. {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

1. {% include [check-sg-prerequsites](./security-groups/check-sg-prerequsites-lvl3.md) %}

    Также [убедитесь](../../application-load-balancer/tools/k8s-ingress-controller/security-groups.md), что настроены группы безопасности, необходимые для работы {{ alb-name }}.

    {% include [sg-common-warning](./security-groups/sg-common-warning.md) %}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md), необходимый для работы Ingress-контроллера, и [назначьте ему роли](../../iam/operations/sa/assign-role-for-sa.md) на каталог:
   * [alb.editor](../../application-load-balancer/security/index.md#alb-editor) — для создания необходимых ресурсов {{ alb-name }}.
   * [vpc.publicAdmin](../../vpc/security/index.md#vpc-public-admin) — для управления внешней сетевой связностью.
   * [certificate-manager.certificates.downloader](../../certificate-manager/security/index.md#certificate-manager-certificates-downloader) — для работы с сертификатами, зарегистрированными в сервисе [{{ certificate-manager-full-name }}](../../certificate-manager/).
   * [compute.viewer](../../compute/security/index.md#compute-viewer) — для использования узлов кластера {{ managed-k8s-name }} в [целевых группах](../../application-load-balancer/concepts/target-group.md) L7-балансировщика.
   * [smart-web-security.editor](../../smartwebsecurity/security/index.md#smart-web-security-editor) — (опционально) для подключения к виртуальному хосту L7-балансировщика [профиля безопасности](../../smartwebsecurity/concepts/profiles.md) {{ sws-full-name }}.
1. [Создайте авторизованный ключ доступа](../../iam/operations/authorized-key/create.md) для сервисного аккаунта в формате JSON и сохраните его в файл `sa-key.json`:

   ```bash
   yc iam key create \
     --service-account-name <имя_сервисного_аккаунта_для_Ingress-контроллера> \
     --output sa-key.json
   ```

## Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Нажмите на имя нужного кластера и выберите вкладку ![Marketplace](../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
1. В разделе **{{ ui-key.yacloud.marketplace-v2.label_available-products }}** выберите [ALB Ingress Controller](/marketplace/products/yc/alb-ingress-controller) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Задайте настройки приложения:

   * **Пространство имен** — выберите [пространство имен](../../managed-kubernetes/concepts/index.md#namespace), отличное от `default`, или создайте новое. Если вы выберете пространство имен по умолчанию, ALB Ingress Controller может работать некорректно.
   * **Название приложения** — укажите название приложения.
   * **Идентификатор каталога** — укажите [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
   * **Идентификатор кластера** — укажите [идентификатор кластера](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-list.md).
   * **Ключ сервисного аккаунта** — вставьте содержимое файла `sa-key.json`.
   * **Включить проверки работоспособности по умолчанию** — выберите опцию, чтобы в сети группы узлов установить ресурс [DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) для проверок состояния приложений.

      Ресурс добавляет поды с агентами мониторинга трафика на каждый узел. В результате изоляция узлов и пространств имен не влияет на мониторинг, поэтому информация о мониторинге трафика точная. DaemonSet добавляет или убирает агенты мониторинга в зависимости от того, увеличивается или уменьшается число узлов в кластере.

      Если вам не нужны проверки работоспособности кластера или вы используете свои, опцию можно не включать. Подробнее о настройке проверок вручную см. в разделе [{#T}](../../managed-kubernetes/tutorials/custom-health-checks.md).

1. Нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Дождитесь перехода приложения в статус `Deployed`.

## Установка с помощью Helm-чарта {#install-alb-helm}

1. {% include [helm-install](helm-install.md) %}

1. {% include [kubectl-install](kubectl-install.md) %}

1. Установите [утилиту `jq`](https://stedolan.github.io/jq/) для потоковой обработки JSON-файлов:

   ```bash
   sudo apt update && sudo apt install jq
   ```

1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с Ingress-контроллером выполните команду:

   ```bash
   cat sa-key.json | helm registry login {{ registry }} --username 'json_key' --password-stdin && \
   helm pull oci://{{ mkt-k8s-key.yc_alb-ingress-controller.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_alb-ingress-controller.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace <пространство_имен> \
     --create-namespace \
     --set folderId=<идентификатор_каталога> \
     --set clusterId=<идентификатор_кластера> \
     --set enableDefaultHealthChecks=<true_или_false> \
     --set-file saKeySecretKey=sa-key.json \
     yc-alb-ingress-controller ./yc-alb-ingress-controller-chart/
   ```

   {% include [Support OCI](../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}

   Если вы укажете в параметре `namespace` пространство имен по умолчанию, ALB Ingress Controller может работать некорректно. Рекомендуем указывать значение, отличное от `default`.

   Параметр `enableDefaultHealthChecks` включает проверки состояния приложений в кластере. Для этого Ingress-контроллер устанавливает ресурс [DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) в сети группы узлов.

   Ресурс добавляет поды с агентами мониторинга трафика на каждый узел. В результате изоляция узлов и пространств имен не влияет на мониторинг, поэтому информация о мониторинге трафика точная. DaemonSet добавляет или убирает агенты мониторинга в зависимости от того, увеличивается или уменьшается число узлов в кластере.

   Если вам не нужны проверки работоспособности кластера или вы используете свои, опцию можно не включать. Подробнее о настройке проверок вручную см. в разделе [{#T}](../../managed-kubernetes/tutorials/custom-health-checks.md).

## Примеры использования {#examples}

* [Практическое руководство по настройке Ingress-контроллера {{ alb-name }}](../../managed-kubernetes/tutorials/alb-ingress-controller.md).
* [Практическое руководство по настройке логирования для Ingress-контроллеров {{ alb-name }}](../../managed-kubernetes/tutorials/alb-ingress-controller-log-options.md).

## См. также {#see-also}

* Описание Ingress-контроллеров в документации:
   * [{{ k8s }}](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/).
   * [{{ alb-name }}](../../application-load-balancer/tools/k8s-ingress-controller/index.md).
* [Ограничения при обновлении ALB Ingress Controller](../../application-load-balancer/operations/k8s-ingress-controller-upgrade.md).
