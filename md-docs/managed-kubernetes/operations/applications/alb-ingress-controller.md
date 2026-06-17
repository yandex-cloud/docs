# Установка Ingress-контроллера Application Load Balancer

# Установка Ingress-контроллера Application Load Balancer

{% note tip %}

Вместо ALB Ingress-контроллера и Gateway API рекомендуется использовать новый контроллер [Yandex Cloud Gwin](../../alb-ref/gwin-index.md).

{% endnote %}

Для балансировки нагрузки и распределения трафика между приложениями Kubernetes используйте [Ingress-контроллер Yandex Application Load Balancer](../../alb-ref/ingress-controller/index.md). Он запускает L7-балансировщик и необходимые вспомогательные ресурсы, когда пользователь создает ресурс `Ingress` в кластере Managed Service for Kubernetes.

{% note warning %}

Не изменяйте и не удаляйте балансировщик нагрузки и его дочерние ресурсы, созданные с помощью Managed Service for Kubernetes, через интерфейсы Yandex Cloud (консоль управления, Terraform, CLI и API). Это может привести к некорректной работе кластера.

{% endnote %}

## Перед началом работы {#before-you-begin}

1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

   По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

1. [Убедитесь](../connect/security-groups.md), что группы безопасности для кластера Managed Service for Kubernetes и его групп узлов настроены корректно. Если отсутствует какое-либо из правил — [добавьте](../../../vpc/operations/security-group-add-rule.md) его.

    Также [убедитесь](../../alb-ref/security-groups.md), что настроены группы безопасности, необходимые для работы Application Load Balancer.

    {% note warning %}
    
    От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
    
    {% endnote %}

1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md), необходимый для работы Ingress-контроллера, и [назначьте ему роли](../../../iam/operations/sa/assign-role-for-sa.md) на каталог:
   * [alb.editor](../../../application-load-balancer/security/index.md#alb-editor) — для создания необходимых ресурсов Application Load Balancer.
   * [vpc.publicAdmin](../../../vpc/security/index.md#vpc-public-admin) — для управления внешней сетевой связностью.
   * [certificate-manager.certificates.downloader](../../../certificate-manager/security/index.md#certificate-manager-certificates-downloader) — для работы с сертификатами, зарегистрированными в сервисе [Yandex Certificate Manager](../../../certificate-manager/index.md).
   * [compute.viewer](../../../compute/security/index.md#compute-viewer) — для использования узлов кластера Managed Service for Kubernetes в [целевых группах](../../../application-load-balancer/concepts/target-group.md) L7-балансировщика.
   * [smart-web-security.editor](../../../smartwebsecurity/security/index.md#smart-web-security-editor) — (опционально) для подключения к виртуальному хосту L7-балансировщика [профиля безопасности](../../../smartwebsecurity/concepts/profiles.md) Yandex Smart Web Security.
1. [Создайте авторизованный ключ доступа](../../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) для сервисного аккаунта в формате JSON и сохраните его в файл `sa-key.json`:

   ```bash
   yc iam key create \
     --service-account-name <имя_сервисного_аккаунта_для_Ingress-контроллера> \
     --output sa-key.json
   ```

## Установка с помощью Yandex Cloud Marketplace {#marketplace-install}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на страницу [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. Перейдите в сервис **Managed Service for&nbsp;Kubernetes**.
  1. Нажмите на имя нужного кластера и выберите вкладку ![Marketplace](../../../_assets/console-icons/shopping-cart.svg) **Marketplace**.
  1. В разделе **Доступные для установки приложения** выберите [ALB Ingress Controller](https://yandex.cloud/ru/marketplace/products/yc/alb-ingress-controller) и нажмите кнопку **Перейти к установке**.
  1. Задайте настройки приложения:

     * **Пространство имен** — создайте новое [пространство имен](../../concepts/index.md#namespace) (например, `alb-ingress-controller-space`). Если вы оставите пространство имен по умолчанию, ALB Ingress Controller может работать некорректно.
     * **Название приложения** — укажите название приложения.
     * **Идентификатор каталога** — укажите [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md).
     * **Идентификатор кластера** — укажите [идентификатор кластера](../kubernetes-cluster/kubernetes-cluster-list.md).
     * **Ключ сервисного аккаунта** — вставьте содержимое файла `sa-key.json`.
     * **Включить проверки работоспособности по умолчанию** — выберите опцию, чтобы в сети группы узлов установить ресурс [DaemonSet](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/) для проверок состояния приложений.

        Ресурс добавляет поды с агентами мониторинга трафика на каждый узел. В результате изоляция узлов и пространств имен не влияет на мониторинг, поэтому информация о мониторинге трафика точная. DaemonSet добавляет или убирает агенты мониторинга в зависимости от того, увеличивается или уменьшается число узлов в кластере.

        Если вам не нужны проверки работоспособности кластера или вы используете свои, опцию можно не включать. Подробнее о настройке проверок вручную смотрите в разделе [Проверка состояния приложений в кластере Yandex Managed Service for Kubernetes с помощью L7-балансировщика Yandex Application Load Balancer](../../tutorials/custom-health-checks.md).

  1. Нажмите кнопку **Установить**.
  1. Дождитесь перехода приложения в статус `Deployed`.

{% endlist %}

## Установка с помощью Helm-чарта {#install-alb-helm}

1. [Установите менеджер пакетов Helm](https://helm.sh/ru/docs/intro/install/) версии не ниже 3.8.0.

1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../connect/index.md#kubectl-connect).

1. Установите [утилиту `jq`](https://stedolan.github.io/jq/) для потоковой обработки JSON-файлов:

   ```bash
   sudo apt update && sudo apt install jq
   ```

1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с Ingress-контроллером выполните команду:

   ```bash
   cat sa-key.json | helm registry login cr.yandex --username 'json_key' --password-stdin && \
   helm pull oci://cr.yandex/yc-marketplace/yandex-cloud/yc-alb-ingress/yc-alb-ingress-controller-chart \
     --version v0.2.26 \
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

   Если вам не нужны проверки работоспособности кластера или вы используете свои, опцию можно не включать. Подробнее о настройке проверок вручную смотрите в разделе [Проверка состояния приложений в кластере Yandex Managed Service for Kubernetes с помощью L7-балансировщика Yandex Application Load Balancer](../../tutorials/custom-health-checks.md).

## Примеры использования {#examples}

* [Настройка Ingress-контроллера Application Load Balancer](../../tutorials/alb-ingress-controller.md).
* [Настройка логирования для Ingress-контроллеров Application Load Balancer](../../tutorials/alb-ingress-controller-log-options.md).

## Полезные ссылки {#see-also}

* [Описание Ingress-контроллеров в документации Kubernetes](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/).
* [Ограничения при обновлении ALB Ingress Controller](upgrade-alb-ingress-controller.md).