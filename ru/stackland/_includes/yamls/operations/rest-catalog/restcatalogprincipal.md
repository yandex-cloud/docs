{% list tabs %}

- Каталог

    ```yaml
    apiVersion: stacklandrestcatalog.stackland.yandex.cloud/v1alpha1
    kind: StacklandRestCatalogAccessBinding
    metadata:
      name: analytics-reader
    spec:
      catalogRef: analytics
      subject:
        kind: User
        name: analytics-user
      catalog:
        role: reader
    ```

- Пространство имен

    ```yaml
    apiVersion: stacklandrestcatalog.stackland.yandex.cloud/v1alpha1
    kind: StacklandRestCatalogAccessBinding
    metadata:
      name: analytics-reader
    spec:
      catalogRef: analytics
      subject:
        kind: User
        name: analytics-user
      namespace:
        namespacePath: [sales, reports]
        role: reader
    ```

- Таблица

    ```yaml
    apiVersion: stacklandrestcatalog.stackland.yandex.cloud/v1alpha1
    kind: StacklandRestCatalogAccessBinding
    metadata:
      name: analytics-reader
    spec:
      catalogRef: analytics
      subject:
        kind: User
        name: analytics-user
      table:
        namespacePath: [sales, reports]
        name: orders
        role: reader
    ```

- Представление

    ```yaml
    apiVersion: stacklandrestcatalog.stackland.yandex.cloud/v1alpha1
    kind: StacklandRestCatalogAccessBinding
    metadata:
      name: analytics-reader
    spec:
      catalogRef: analytics
      subject:
        kind: User
        name: analytics-user
      view:
        namespacePath: [sales, reports]
        name: recent_orders
        role: reader
    ```

{% endlist %}
