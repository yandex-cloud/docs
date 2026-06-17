# Установка Falco


[The Falco Project](https://falco.org/) предназначен для обеспечения безопасности работы операционных систем на базе Linux.

Приложение Falco:
* Парсит системные вызовы ядра Linux во время выполнения.
* Анализирует сигналы с помощью настраиваемого набора правил.
* Выдает предупреждение при нарушении заданных правил.

{% note warning %}

Чтобы использовать Falco, установите [Kyverno](https://yandex.cloud/ru/marketplace/products/yc/kyverno) или другой продукт, который поддерживает запись результатов в [wg-policy-prototypes](https://github.com/kubernetes-sigs/wg-policy-prototypes/blob/master/policy-report/README.md).

{% endnote %}

## Перед началом работы {#before-you-begin}

[Убедитесь](../connect/security-groups.md), что группы безопасности для кластера Managed Service for Kubernetes и его групп узлов настроены корректно. Если отсутствует какое-либо из правил — [добавьте](../../../vpc/operations/security-group-add-rule.md) его.

{% note warning %}

От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.

{% endnote %}

## Установка с помощью Yandex Cloud Marketplace {#marketplace-install}

1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
1. Перейдите в сервис **Managed Service for&nbsp;Kubernetes**.
1. Нажмите на имя нужного [кластера Managed Service for Kubernetes](../../concepts/index.md#kubernetes-cluster) и выберите вкладку ![image](../../../_assets/console-icons/shopping-cart.svg) **Marketplace**.
1. В разделе **Доступные для установки приложения** выберите [Falco](https://yandex.cloud/ru/marketplace/products/yc/falco) и нажмите кнопку **Перейти к установке**.
1. Задайте настройки приложения:
   * **Пространство имен** — создайте новое [пространство имен](../../concepts/index.md#namespace) (например, `falco-space`). Если вы оставите пространство имен по умолчанию, Falco может работать некорректно.
   * **Название приложения** — укажите название приложения.
1. Нажмите кнопку **Установить**.
1. Дождитесь перехода приложения в статус `Deployed`.

## Установка с помощью Helm-чарта {#helm-install}

1. [Установите менеджер пакетов Helm](https://helm.sh/ru/docs/intro/install/) версии не ниже 3.8.0.

1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../connect/index.md#kubectl-connect).

1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с Falco выполните команду:

   ```bash
   helm pull oci://cr.yandex/yc-marketplace/falco \
     --version 2.2.5 \
     --untar && \
   helm install \
     --namespace <пространство_имен> \
     --create-namespace \
     falco ./falco
   ```

   Если вы укажете в параметре `namespace` пространство имен по умолчанию, Falco может работать некорректно. Рекомендуем указывать значение, отличное от всех существующих пространств имен (например, `falco-space`).

   {% note info %}
   
   Если вы используете версию Helm ниже 3.8.0, добавьте в начало команды строку `export HELM_EXPERIMENTAL_OCI=1 && \`, чтобы включить поддержку [Open Container Initiative](https://opencontainers.org/) (OCI) в клиенте Helm.
   
   {% endnote %}

## Полезные ссылки {#see-also}

* [Документация Falco](https://falco.org/docs/).