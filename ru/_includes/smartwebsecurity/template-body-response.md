Содержимое ответа должно соответствовать выбранному формату ответа, например:

* **HTML**

    ```html
    <!doctype html>
    <html lang="ru">
    <head><meta charset="utf-8"><title>403 Forbidden</title></head>
    <body><h1>403 Forbidden</h1><p>Доступ ограничен.</p></body>
    </html>
    ```

* **JSON**

    ```json
    {
    "error": {
        "code": 403,
        "message": "Доступ ограничен.",
        "details": "Недостаточно прав для выполнения операции."
    }
    }
    ```
     
* **XML**
    
    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <error>
    <code>403</code>
    <message>Доступ ограничен.</message>
    <details>Недостаточно прав для выполнения операции.</details>
    </error>
    ```