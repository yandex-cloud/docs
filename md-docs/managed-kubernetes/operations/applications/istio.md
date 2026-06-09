# Установка Istio


[Istio](https://istio.io/latest/about/service-mesh/) предназначен для организации _service mesh_ — инфраструктурного уровня с низкой задержкой, который нужен для обработки большого объема сетевых коммуникаций между сервисами в кластере {{ managed-k8s-name }}.

Istio обеспечивает:

* Зашифрованное взаимодействие между сервисами в кластере.
* Аутентификацию между сервисами.
* Балансировку нагрузки для трафика протоколов HTTP, TCP, RPC и WebSocket.
* Детальный контроль трафика с помощью расширенных правил маршрутизации.

В состав приложения входит компонент [Istio Ingress Gateway](https://istio.io/latest/docs/tasks/traffic-management/ingress/ingress-control/), который позволяет организовать точку входа для внешнего трафика.

{% note info %}

Для работы Istio требуется группа узлов с оперативной памятью не менее 6 ГБ.

{% endnote %}

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
1. В разделе **{{ ui-key.yacloud.marketplace-v2.label_available-products }}** выберите [Istio](https://yandex.cloud/ru/marketplace/products/yc/istio) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Задайте настройки приложения:
   * **Пространство имен** — создайте новое [пространство имен](../../concepts/index.md#namespace) (например, `istio-space`). Если вы оставите пространство имен по умолчанию, Istio может работать некорректно.
   * **Название приложения** — укажите название приложения.
   * **Установка дополнений** — выберите эту опцию, чтобы автоматически установить дополнения: консоль управления [Kiali](https://kiali.io/), компоненты Grafana, Prometheus и [Loki](https://yandex.cloud/ru/marketplace/products/yc/loki).
1. Нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Дождитесь перехода приложения в статус `Deployed`.

## Установка с помощью Helm-чарта {#helm-install}

1. [Установите менеджер пакетов Helm](https://helm.sh/ru/docs/intro/install/) версии не ниже 3.8.0.
1. [Установите kubectl]({{ k8s-docs }}/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../connect/index.md#kubectl-connect).
1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с Istio выполните команду:

   ```bash
   helm pull oci://{{ mkt-k8s-key.yc_istio.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_istio.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace <пространство_имен> \
     --create-namespace \
   istio ./istio/
   ```

   Если вы укажете в параметре `namespace` пространство имен по умолчанию, Istio может работать некорректно. Рекомендуем указывать значение, отличное от всех существующих пространств имен (например, `istio-space`).

   {% note info %}
   
   Если вы используете версию Helm ниже 3.8.0, добавьте в начало команды строку `export HELM_EXPERIMENTAL_OCI=1 && \`, чтобы включить поддержку [Open Container Initiative](https://opencontainers.org/) (OCI) в клиенте Helm.
   
   {% endnote %}

## См. также {#see-also}

* [Документация Istio](https://istio.io/latest/docs/).