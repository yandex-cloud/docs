{% list tabs group=instructions %}

- Консоль управления {#console}

   1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
   1. Нажмите на имя нужного кластера {{ k8s }} и выберите вкладку ![image](../../_assets/marketplace.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
   1. В разделе **{{ ui-key.yacloud.marketplace-v2.label_available-products }}** выберите [{{ prometheus-name }} Operator с поддержкой {{ monitoring-name }}](/marketplace/products/yc/prometheus-operator) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
   1. Задайте настройки приложения:

      * **Пространство имен** — создайте новое [пространство имен](../../managed-kubernetes/concepts/index.md#namespace), например `prometheus-operator-space`. Если вы оставите пространство имен по умолчанию, {{ prometheus-name }} Operator может работать некорректно.
      * **Название приложения** — укажите название приложения.
      * **{{ prometheus-name }} Workspace** — выберите воркспейс {{ prometheus-name }}.
      * **API-ключ** — укажите содержимое файла `sa-key.json`.

   1. Нажмите кнопку **Установить**.
   1. Дождитесь перехода приложения в статус `Deployed`.  

{% endlist %}