1. [Установите](https://nodejs.org/en/download) Node.js.
1. Создайте директорию, в которой будет находиться пример кода и перейдите в нее:

    ```bash
    mkdir app
    cd app
    ```

1. Инициализируйте проект Node.js и установите библиотеку `aws-sdk/client-s3` командой:

    ```bash
    npm init -y && npm i @aws-sdk/client-s3
    ```

1. Чтобы указать, что в проекте будет использоваться синтаксис [ESM (ECMAScript Moudules)](https://nodejs.org/api/esm.html), добавьте в файл package.json строку `"type": "module"`. В директории будет создан файл `package.json` с базовыми настройками проекта на Node.js. 

    Итоговый файл `package.json` должен иметь следующий вид:

    ```json
    {
        "name": "check",
        "version": "1.0.0",
        "main": "index.js",
        "scripts": {
            "test": "echo \"Error: no test specified\" && exit 1"
        },
        "keywords": [],
        "author": "",
        "license": "ISC",
        "description": "",
        "dependencies": {
            "@aws-sdk/client-s3": "^3.726.1"
        },
        "type": "module"
    }
    ```

1. Создайте файл `index.js`, в котором будет размещаться код с использованием AWS SDK.