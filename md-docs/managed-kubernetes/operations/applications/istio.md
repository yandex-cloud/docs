# Установка Istio


[Istio](https://istio.io/latest/about/service-mesh/) предназначен для организации _service mesh_ — инфраструктурного уровня с низкой задержкой, который нужен для обработки большого объема сетевых коммуникаций между сервисами в кластере Managed Service for Kubernetes.

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

1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

   По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

1. [Убедитесь](../connect/security-groups.md), что группы безопасности для кластера Managed Service for Kubernetes и его групп узлов настроены корректно. Если отсутствует какое-либо из правил — [добавьте его](../../../vpc/operations/security-group-add-rule.md).

    {% note warning %}
    
    От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
    
    {% endnote %}

1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../connect/index.md#kubectl-connect).

## Установка с помощью Yandex Cloud Marketplace {#marketplace-install}

1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;Kubernetes**.
1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../../_assets/console-icons/shopping-cart.svg) **Marketplace**.
1. В разделе **Доступные для установки приложения** выберите [Istio](https://yandex.cloud/ru/marketplace/products/yc/istio) и нажмите кнопку **Перейти к установке**.
1. Задайте настройки приложения:
   * **Пространство имен** — создайте новое [пространство имен](../../concepts/index.md#namespace) (например, `istio-space`). Если вы оставите пространство имен по умолчанию, Istio может работать некорректно.
   * **Название приложения** — укажите название приложения.
   * **Установка дополнений** — выберите эту опцию, чтобы автоматически установить дополнения: консоль управления [Kiali](https://kiali.io/), компоненты Grafana, Prometheus и [Loki](https://yandex.cloud/ru/marketplace/products/yc/loki).
1. Нажмите кнопку **Установить**.
1. Дождитесь перехода приложения в статус `Deployed`.

## Установка с помощью Helm-чарта {#helm-install}

1. [Установите менеджер пакетов Helm](https://helm.sh/ru/docs/intro/install/) версии не ниже 3.8.0.
1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../connect/index.md#kubectl-connect).
1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с Istio выполните команду:

   ```bash
   helm pull oci://cr.yandex/yc-marketplace/yandex-cloud/istio/istio \
     --version 1.21.2-1 \
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