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

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. {% include [check-sg-prerequsites](../../../_includes/managed-kubernetes/security-groups/check-sg-prerequsites-lvl3.md) %}

    {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

1. {% include [Настройка kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

## Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
1. В разделе **Доступные для установки приложения** выберите [Istio](/marketplace/products/yc/istio) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
1. Задайте настройки приложения:
   * **Пространство имен** — выберите [пространство имен](../../concepts/index.md#namespace) для Istio или создайте новое. Не рекомендуется устанавливать приложение в пространство имен `default`.
   * **Название приложения** — укажите название приложения.
   * **Установка дополнений** — выберите эту опцию, чтобы автоматически установить дополнения: консоль управления [Kiali](https://kiali.io/), компоненты Grafana, Prometheus, [Jaeger](/marketplace/products/yc/jaeger-ydb-store) и [Loki](/marketplace/products/yc/loki).
1. Нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Дождитесь перехода приложения в статус `Deployed`.

## Установка с помощью Helm-чарта {#helm-install}

1. {% include [Установка Helm](../../../_includes/managed-kubernetes/helm-install.md) %}

1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с Istio выполните команду:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   helm pull oci://{{ mkt-k8s-key.yc_istio.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_istio.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace <пространство_имен> \
     --create-namespace \
   istio ./istio/
   ```

## См. также {#see-also}

* [Документация Istio](https://istio.io/latest/docs/).
