# Удаление API-шлюза

{% list tabs %}

- Консоль управления
    
    Чтобы удалить API-шлюз:
    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором необходимо удалить API-шлюз.
    1. В списке сервисов выберите **{{ api-gw-name }}**.
    1. В строке с API-шлюзом нажмите кнопку ![image](../../_assets/options.svg) и выберите **Удалить**.
    1. В открывшемся окне нажмите кнопку **Удалить**.

- CLI

    Чтобы удалить API-шлюз, выполните команду: 

    ```
    yc serverless api-gateway delete --id <идентификатор_API-шлюза>
    ```

    Где:
    
    * `id` — идентификатор API-шлюза.

    Результат:

    ```
    done (18s)
    ```
    
- API

  Удалить API-шлюз можно с помощью метода API [delete](../apigateway/api-ref/ApiGateway/delete.md).

- Yandex.Cloud Toolkit

  Удалить API-шлюз можно с помощью [плагина Yandex.Cloud Toolkit](https://github.com/yandex-cloud/ide-plugin-jetbrains) для семейства IDE на [платформе IntelliJ](https://www.jetbrains.com/ru-ru/opensource/idea/) от [JetBrains](https://www.jetbrains.com/).
       
{% endlist %}
