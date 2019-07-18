# Вызов функции

{% note info %}

Чтобы любой пользователь мог вызывать функцию, необходимо [сделать ее публичной](function-public.md). Подробнее о правах читайте в разделе [#T](../security/index.md).

{% endnote %}

{% include [yc-function-list](../../_includes/serverless-functions/function-list.md) %}

Для примера используется функция, описанная в разделе [#T](version-manage.md#func-version-create).

{% list tabs %}

- HTTP
  
    {% note info %}
    
    Для обеспечения безопасности вызов функции возможен только с использованием протокола TLS.
    
    {% endnote %}
    
    Вызовите функцию как обычный HTTP-запрос, например, введите в адресной строке вашего браузера ссылку для вызова функции. Формат ссылки вызова: 
     
    ```
    {{ sf-url }}/<ID функции>
    ```
    
    Также ссылка для вызова функции отображается в параметре `http_invoke_url` при [создании функции](function-create.md). 
  
    - Пример вызова функции без дополнительных параметров:
    
        ```
        {{ sf-url }}/b09bhaokchn9pnbrlseb
        ```
    
        Ответ зависит от вашей функции, в данном случае он будет таким:
        
        ```
        Hello, World!
        ```
    
    - Пример вызова функции с добавлением в URL параметра `name`: 
        
        ```
        {{ sf-url }}/b09bhaokchn9pnbrlseb?name=<имя пользователя>
        ```
      
        На странице появится следующий ответ:
        
        ```
        Hello, Username!
        ```

- CLI
    
    Вызовите функцию, указав в параметре имя для приветствия:

    ```
    $ yc serverless function invoke b09bhaokchn9pnbrlseb -d '{"queryStringParameters": {"name": "Username"}}'
    
    {"statusCode": 200, "headers": {"Content-Type": "text/plain"}, "isBase64Encoded": false, "body": "Hello, Username!"}
    ```
  
{% endlist %}

Подробнее о том, какая должна быть структура функции для вызова разными способами (HTTP, CLI), читайте в разделе [#T](../concepts/function-invoke.md).
