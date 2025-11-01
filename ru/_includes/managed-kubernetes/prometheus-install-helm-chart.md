1. {% include [Установка Helm](helm-install.md) %}

1. Получите идентификатор воркспейса {{ prometheus-name }}:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. Откройте [главную страницу сервиса]({{ link-monitoring }}) {{ monitoring-name }}.
      1. Слева выберите раздел **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.prometheus.title }}**.
      1. Выберите воркспейс {{ prometheus-name }}.
      1. Откроется вкладка **{{ ui-key.yacloud_monitoring.prometheus.approved.tab.info }}**, где отображается идентификатор воркспейса — сохраните его.

   {% endlist %}

1. Чтобы установить [Helm-чарт](https://helm.sh/docs/topics/charts/) с {{ prometheus-name }} Operator, выполните команду:

   ```bash
   helm pull oci://{{ mkt-k8s-key.yc_prometheus-operator.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_prometheus-operator.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace <пространство_имен_для_{{ prometheus-name }}_Operator> \
     --create-namespace \
     --set prometheusWorkspaceId=<идентификатор_воркспейса_{{ prometheus-name }}> \
     --set iam_api_key_value_generated.secretAccessKey=<секретная_часть_API-ключа> \
     prometheus ./kube-prometheus-stack/
   ```

   Эта команда также создаст новое пространство имен для работы {{ prometheus-name }} Operator.

   Если вы укажете в параметре `namespace` пространство имен по умолчанию, {{ prometheus-name }} Operator может работать некорректно. Используйте значение, отличное от всех существующих пространств имен, например `prometheus-operator-space`.

   {% include [Support OCI](note-helm-experimental-oci.md) %}

1. Убедитесь, что поды {{ prometheus-name }} Operator перешли в состояние `Running`:

   ```bash
   kubectl get pods --namespace=<пространство_имен_для_{{ prometheus-name }}_Operator> \
      -l "release=prometheus"
   ```