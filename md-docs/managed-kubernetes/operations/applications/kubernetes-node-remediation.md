# Установка Kubernetes Node Remediation

[Kubernetes Node Remediation](https://www.medik8s.io/) — это набор операторов {{ k8s }}, которые обеспечивают автоматическое восстановление неисправных узлов кластера {{ managed-k8s-name }} и высокую доступность для stateful-нагрузок.

Решение состоит из двух контроллеров:

* Node Healthcheck Controller — отслеживает сбои.
* Self Node Remediation Controller — переносит нагрузку с неисправных узлов и восстанавливает их.

## Перед началом работы {#before-you-begin}

1. Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

   По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

1. [Убедитесь](../connect/security-groups.md), что группы безопасности для кластера {{ managed-k8s-name }} и его групп узлов настроены корректно. Если отсутствует какое-либо из правил — [добавьте](../../../vpc/operations/security-group-add-rule.md) его.

    {% note warning %}
    
    От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
    
    {% endnote %}

1. [Установите kubectl]({{ k8s-docs }}/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../connect/index.md#kubectl-connect).

## Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

1. В [консоли управления]({{ link-console-main }}) выберите каталог.
1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
1. В разделе **{{ ui-key.yacloud.marketplace-v2.label_available-products }}** выберите [Kubernetes Node Remediation](https://yandex.cloud/ru/marketplace/products/yc/kubernetes-node-remediation) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Задайте настройки приложения:
   * **Пространство имен** — создайте новое [пространство имен](../../concepts/index.md#namespace) (например, `remediation-space`). Если вы оставите пространство имен по умолчанию, Kubernetes Node Remediation может работать некорректно.
   * **Название приложения** — укажите название приложения.
1. Нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Дождитесь перехода приложения в статус `Deployed`.
1. [Создайте ресурс `NodeHealthCheck`](#create-resource).

## Установка с помощью Helm-чарта {#helm-install}

1. [Установите менеджер пакетов Helm](https://helm.sh/ru/docs/intro/install/) версии не ниже 3.8.0.
1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с Kubernetes Node Remediation выполните команду:

   ```bash
   helm pull oci://{{ mkt-k8s-key.yc_kubernetes-node-remediation.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_kubernetes-node-remediation.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace <пространство_имен> \
     --create-namespace \
   kubernetes-node-remediation ./kubernetes-node-remediation/
   ```

   Если вы укажете в параметре `namespace` пространство имен по умолчанию, Kubernetes Node Remediation может работать некорректно. Рекомендуем указывать значение, отличное от всех существующих пространств имен (например, `remediation-space`).

   {% note info %}
   
   Если вы используете версию Helm ниже 3.8.0, добавьте в начало команды строку `export HELM_EXPERIMENTAL_OCI=1 && \`, чтобы включить поддержку [Open Container Initiative](https://opencontainers.org/) (OCI) в клиенте Helm.
   
   {% endnote %}

1. [Создайте ресурс `NodeHealthCheck`](#create-resource).

## Создание ресурса NodeHealthCheck {#create-resource}

1. Создайте файл с описанием ресурса `NodeHealthCheck`:

    ```yml
    apiVersion: remediation.medik8s.io/v1alpha1
    kind: NodeHealthCheck
    metadata:
      name: nodehc-sample
    spec:
      minHealthy: 51%
      remediationTemplate:
        apiVersion: self-node-remediation.medik8s.io/v1alpha1
        kind: SelfNodeRemediationTemplate
        name: self-node-remediation-automatic-strategy-template
        namespace: <пространство_имен_приложения>
      selector:
        matchLabels:
          beta.kubernetes.io/os: linux
      unhealthyConditions:
      - duration: 60s
        status: "False"
        type: Ready
      - duration: 60s
        status: Unknown
        type: Ready
    ```

    Где:

    * `spec.minHealthy` — минимальный процент здоровых узлов, при котором разрешено начинать восстановление.
    * `spec.unhealthyConditions` — список [условий для статуса узла](https://kubernetes.io/docs/reference/node/node-status/), по которым контроллер определяет, что узел неисправен.

        * `duration` — время, в течение которого условие должно сохраняться, прежде чем начнется процесс восстановления узла.
        * `type` — тип условия.
        * `status` — ожидаемый статус для признания узла неисправным.

        В приведенном примере контроллер NodeHealthCheck начнет восстановление, если тип условия `Ready` для узла в течение 60 секунд указывает на его недоступность или нерабочее состояние.

    [Подробнее о полях ресурса](https://github.com/medik8s/node-healthcheck-operator/blob/main/docs/configuration.md).

1. Перейдите в директорию с файлом и выполните команду:

    ```bash
    kubectl apply -f <имя_файла>
    ```