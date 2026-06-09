# Установить Ingress-контроллер {{ alb-name }} для {{ managed-k8s-name }}

# Установка Ingress-контроллера {{ alb-name }}

{% note tip %}

Вместо ALB Ingress-контроллера и Gateway API рекомендуется использовать новый контроллер [{{ yandex-cloud }} Gwin]({{ gwin-tip-local-link }}).

{% endnote %}

Для балансировки нагрузки и распределения трафика между приложениями {{ k8s }} используйте [Ingress-контроллер {{ alb-full-name }}]({{ ingress-local-link2 }}/index.md). Он запускает L7-балансировщик и необходимые вспомогательные ресурсы, когда пользователь создает ресурс `Ingress` в кластере {{ managed-k8s-name }}.

{% note warning %}

Не изменяйте и не удаляйте балансировщик нагрузки и его дочерние ресурсы, созданные с помощью {{ managed-k8s-name }}, через интерфейсы {{ yandex-cloud }} (консоль управления, {{ TF }}, CLI и API). Это может привести к некорректной работе кластера.

{% endnote %}

## Перед началом работы {#before-you-begin}

1. Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

   По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

1. [Убедитесь](../../managed-kubernetes/operations/connect/security-groups.md), что группы безопасности для кластера {{ managed-k8s-name }} и его групп узлов настроены корректно. Если отсутствует какое-либо из правил — [добавьте](../../vpc/operations/security-group-add-rule.md) его.

    Также [убедитесь]({{ alb-local-link2 }}/security-groups.md), что настроены группы безопасности, необходимые для работы {{ alb-name }}.

    {% note warning %}
    
    От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
    
    {% endnote %}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md), необходимый для работы Ingress-контроллера, и [назначьте ему роли](../../iam/operations/sa/assign-role-for-sa.md) на каталог:
   * [alb.editor](../security/index.md#alb-editor) — для создания необходимых ресурсов {{ alb-name }}.
   * [vpc.publicAdmin](../../vpc/security/index.md#vpc-public-admin) — для управления внешней сетевой связностью.
   * [certificate-manager.certificates.downloader](../../certificate-manager/security/index.md#certificate-manager-certificates-downloader) — для работы с сертификатами, зарегистрированными в сервисе [{{ certificate-manager-full-name }}](../../certificate-manager/index.md).
   * [compute.viewer](../../compute/security/index.md#compute-viewer) — для использования узлов кластера {{ managed-k8s-name }} в [целевых группах](../concepts/target-group.md) L7-балансировщика.
   * [smart-web-security.editor](../../smartwebsecurity/security/index.md#smart-web-security-editor) — (опционально) для подключения к виртуальному хосту L7-балансировщика [профиля безопасности](../../smartwebsecurity/concepts/profiles.md) {{ sws-full-name }}.
1. [Создайте авторизованный ключ доступа](../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) для сервисного аккаунта в формате JSON и сохраните его в файл `sa-key.json`:

   ```bash
   yc iam key create \
     --service-account-name <имя_сервисного_аккаунта_для_Ingress-контроллера> \
     --output sa-key.json
   ```

## Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на страницу [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку ![Marketplace](../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
  1. В разделе **{{ ui-key.yacloud.marketplace-v2.label_available-products }}** выберите [ALB Ingress Controller](https://yandex.cloud/ru/marketplace/products/yc/alb-ingress-controller) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
  1. Задайте настройки приложения:

     * **Пространство имен** — создайте новое [пространство имен](../../managed-kubernetes/concepts/index.md#namespace) (например, `alb-ingress-controller-space`). Если вы оставите пространство имен по умолчанию, ALB Ingress Controller может работать некорректно.
     * **Название приложения** — укажите название приложения.
     * **Идентификатор каталога** — укажите [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
     * **Идентификатор кластера** — укажите [идентификатор кластера](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-list.md).
     * **Ключ сервисного аккаунта** — вставьте содержимое файла `sa-key.json`.
     * **Включить проверки работоспособности по умолчанию** — выберите опцию, чтобы в сети группы узлов установить ресурс [DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) для проверок состояния приложений.

        Ресурс добавляет поды с агентами мониторинга трафика на каждый узел. В результате изоляция узлов и пространств имен не влияет на мониторинг, поэтому информация о мониторинге трафика точная. DaemonSet добавляет или убирает агенты мониторинга в зависимости от того, увеличивается или уменьшается число узлов в кластере.

        Если вам не нужны проверки работоспособности кластера или вы используете свои, опцию можно не включать. Подробнее о настройке проверок вручную см. в разделе [{#T}]({{ tutorial-local-link2 }}/custom-health-checks.md).

  1. Нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
  1. Дождитесь перехода приложения в статус `Deployed`.

{% endlist %}

## Установка с помощью Helm-чарта {#install-alb-helm}

1. [Установите менеджер пакетов Helm](https://helm.sh/ru/docs/intro/install/) версии не ниже 3.8.0.

1. [Установите kubectl]({{ k8s-docs }}/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../../managed-kubernetes/operations/connect/index.md#kubectl-connect).

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

   {% note info %}
   
   Если вы используете версию Helm ниже 3.8.0, добавьте в начало команды строку `export HELM_EXPERIMENTAL_OCI=1 && \`, чтобы включить поддержку [Open Container Initiative](https://opencontainers.org/) (OCI) в клиенте Helm.
   
   {% endnote %}

   Если вы укажете в параметре `namespace` пространство имен по умолчанию, ALB Ingress Controller может работать некорректно. Рекомендуем указывать значение, отличное от всех существующих пространств имен (например, `alb-ingress-controller-space`).

   Параметр `enableDefaultHealthChecks` включает проверки состояния приложений в кластере. Для этого Ingress-контроллер устанавливает ресурс [DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) в сети группы узлов.

   Ресурс добавляет поды с агентами мониторинга трафика на каждый узел. В результате изоляция узлов и пространств имен не влияет на мониторинг, поэтому информация о мониторинге трафика точная. DaemonSet добавляет или убирает агенты мониторинга в зависимости от того, увеличивается или уменьшается число узлов в кластере.

   Если вам не нужны проверки работоспособности кластера или вы используете свои, опцию можно не включать. Подробнее о настройке проверок вручную см. в разделе [{#T}](../../managed-kubernetes/tutorials/custom-health-checks.md).

## Примеры использования {#examples}

* [Настройка Ingress-контроллера {{ alb-name }}](../../managed-kubernetes/tutorials/alb-ingress-controller.md).
* [Настройка логирования для Ingress-контроллеров {{ alb-name }}](../../managed-kubernetes/tutorials/alb-ingress-controller-log-options.md).

## См. также {#see-also}

* [Описание Ingress-контроллеров в документации {{ k8s }}](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/).
* [Ограничения при обновлении ALB Ingress Controller]({{ ingress-upgrade-local-link2 }}).