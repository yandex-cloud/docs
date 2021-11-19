# Удаление API-шлюза

{% list tabs %}

- Консоль управления
    
    Чтобы удалить API-шлюз:
    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором необходимо удалить API-шлюз.
    1. В списке сервисов выберите **{{ api-gw-name }}**.
    1. В открывшемся окне выберите API-шлюз и нажмите кнопку ![image](../../_assets/options.svg).
    1. В открывшемся меню нажмите кнопку **Удалить**.
    1. В открывшемся окне нажмите кнопку **Удалить**.

- CLI

    Чтобы удалить API-шлюз, выполните команду со следующими параметрами: 
    
    - `id` — идентификатор API-шлюза.
    
    ```
    yc serverless api-gateway delete --id d5dug9gkmu187iojcpvp
    done (18s)
    ```
- API

  Удалить API-шлюз можно с помощью метода API [delete](../apigateway/api-ref/ApiGateway/delete.md).

- Yandex.Cloud Toolkit

  Удалить API-шлюз можно с помощью [плагина Yandex.Cloud Toolkit](https://github.com/yandex-cloud/ide-plugin-jetbrains) для семейства IDE на [платформе Intellij](https://www.jetbrains.com/ru-ru/opensource/idea/) от [JetBrains](https://www.jetbrains.com/).
       
{% endlist %}
