The content of the response must match the selected response format, for example:

* **HTML**

    ```html
    <!doctype html>
    <html lang="ru">
    <head><meta charset="utf-8"><title>403 Forbidden</title></head>
    <body><h1>403 Forbidden</h1><p>Access restricted.</p></body>
    </html>
    ```

* **JSON**

    ```json
    {
    "error": {
        "code": 403,
        "message": "Access restricted.",
        "details": "Not enough permissions to perform the operation."
    }
    }
    ```
     
* **XML**
    
    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <error>
    <code>403</code>
    <message>Access restricted.</message>
    <details>Not enough permissions to perform the operation.</details>
    </error>
    ```