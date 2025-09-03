---
title: Установка VictoriaLogs
description: Следуя данной инструкции, вы сможете установить VictoriaLogs.
---

# Установка VictoriaLogs


[VictoriaLogs](https://docs.victoriametrics.com/victorialogs/) — решение для сбора, хранения и анализа логов. VictoriaLogs устанавливается в [кластере {{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster). VictoriaLogs позволяет:

* Собирать логи приложений с помощью различных коллекторов логов.
* Анализировать логи с помощью языка запросов LogsQL.

## Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Нажмите на имя нужного кластера {{ managed-k8s-name }} и выберите вкладку ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
1. В разделе **{{ ui-key.yacloud.marketplace-v2.label_available-products }}** выберите [VictoriaLogs](/marketplace/products/yc/victoria-logs) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Задайте настройки приложения:
   * **Пространство имен** — создайте новое пространство имен (например `victoria-logs`). Если вы оставите пространство имен по умолчанию, VictoriaLogs может работать некорректно.
   * **Название приложения** — укажите название приложения.
1. Нажмите кнопку **Установить**.
1. Дождитесь перехода приложения в статус `Deployed`.
1. Настройте переадресацию порта сервиса `victoria-logs-single-server` на локальный компьютер:

   ```bash
   kubectl port-forward service/victoria-logs-single-server 30000:9428 \
      --namespace <пространство_имен_приложения>
   ```

1. Убедитесь, что веб-интерфейс VictoriaLogs доступен, открыв ссылку `http://localhost:30000`.

## Установка с помощью Helm-чарта {#helm-install}

1. {% include [Установка Helm](../../../_includes/managed-kubernetes/helm-install.md) %}
1. {% include [Настройка kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}
1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с VictoriaLogs выполните команду, указав в ней параметры ресурсов, созданных [ранее](#before-you-begin):

   ```bash
   helm pull oci://{{ mkt-k8s-key.yc_victoria-logs.helmChart.name }} \
        --version {{ mkt-k8s-key.yc_victoria-logs.helmChart.tag }} \
        --untar && \
   helm install \
        --namespace victoria-logs \
        --create-namespace \
        victoria-logs-single ./victoria-logs-single/
   ```

   {% include [Support OCI](../../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}

## См. также {#see-also}

* [Документация VictoriaLogs](https://docs.victoriametrics.com/victorialogs/)
* [Примеры использования](https://docs.victoriametrics.com/victorialogs/logsql-examples/)
