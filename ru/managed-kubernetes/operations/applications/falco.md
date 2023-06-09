# Установка Falco

[The Falco Project](https://falco.org/) предназначен для обеспечения безопасности работы операционных систем на базе Linux.

Приложение Falco:
* Парсит системные вызовы ядра Linux во время выполнения.
* Анализирует сигналы с помощью настраиваемого набора правил.
* Выдает предупреждение при нарушении заданных правил.

{% note warning %}

Чтобы использовать Falco, установите [Kyverno](/marketplace/products/yc/kyverno) или другой продукт, который поддерживает запись результатов в [wg-policy-prototypes](https://github.com/kubernetes-sigs/wg-policy-prototypes/blob/master/policy-report/README.md).

{% endnote %}

## Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ managed-k8s-name }}**.
1. Нажмите на имя нужного [кластера {{ k8s }}](../../concepts/index.md#kubernetes-cluster) и выберите вкладку ![image](../../../_assets/marketplace.svg) **{{ marketplace-short-name }}**.
1. В разделе **Доступные для установки приложения** выберите [Falco](/marketplace/products/yc/falco) и нажмите кнопку **Использовать**.
1. Задайте настройки приложения:
   * **Пространство имен** — выберите [пространство имен](../../concepts/index.md#namespace) для Falco или создайте новое.
   * **Название приложения** — укажите название приложения.
1. Нажмите кнопку **Установить**.
1. Дождитесь перехода приложения в статус `Deployed`.

## Установка с помощью Helm-чарта {#helm-install}

1. {% include [Установка Helm](../../../_includes/managed-kubernetes/helm-install.md) %}

1. {% include [Настройка kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с Falco выполните команду:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   helm pull oci://{{ mkt-k8s-key.yc_falco.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_falco.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace <пространство_имен> \
     --create-namespace \
     falco ./falco
   ```

## См. также {#see-also}

* [Документация Falco](https://falco.org/docs/).