# AWS SDK для JavaScript

[AWS SDK для JavaScript](https://aws.amazon.com/ru/sdk-for-javascript) — это комплект средств разработки для взаимодействия с сервисами AWS, совместимый с {{ objstorage-full-name }}.

## Подготовка к работе {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

## Установка {#installation}

{% include [install-js-sdk](../../_includes/aws-tools/install-js-sdk.md) %}

## Настройка {#setup}

{% include [storage-sdk-setup](../_includes_service/storage-sdk-setup-storage-url.md) %}

## Примеры кода {#js-sdk-examples}

Пример кода для создания бакета находится в директории `javascriptv3/example_code/nodegetstarted/src` репозитория.

Чтобы подключиться к {{ objstorage-name }} и создать бакет:

1. Установите зависимости, описанные в файле `javascriptv3/example_code/nodegetstarted/package.json`:

    ```bash
    npm install node -g
    cd aws-doc-sdk-examples/javascriptv3/example_code/nodegetstarted
    npm install
    ```

1. В директории `javascriptv3/example_code/nodegetstarted/src/libs/` откройте файл `s3Client.js` с описанием клиента для {{ objstorage-name }}.
1. Замените содержимое файла на следующий код:

    ```js
    import { S3Client } from "@aws-sdk/client-s3";
    // Установка региона {{ objstorage-name }}
    const REGION = "{{ region-id }}";
    // Установка эндпоинта {{ objstorage-name }}
    const ENDPOINT = "https://{{ s3-storage-host }}";
    // Создание клиента для {{ objstorage-name }}
    const s3Client = new S3Client({ region: REGION, endpoint: ENDPOINT });
    export { s3Client };
    ```

1. В директории `javascriptv3/example_code/nodegetstarted/src/` откройте файл `sample.js` с кодом для создания бакета и объекта в нем.

    {% cut "Содержимое sample.js" %}

    ```js
    // Импорт клиентов и команд AWS SDK для работы с Node.js
    import { PutObjectCommand, CreateBucketCommand } from "@aws-sdk/client-s3";
    import { s3Client } from "./libs/s3Client.js";

    // Установка параметров
    const params = {
      Bucket: "<имя_бакета>", // Имя бакета, например 'sample-bucket-101'.
      Key: "<имя_объекта>", // Имя объекта, например 'sample_upload.txt'.
      Body: "<содержимое_объекта>", // Содержимое объекта, например 'Hello world!".
    };

    const run = async () => {
      // Создание бакета
      try {
        const data = await s3Client.send(
            new CreateBucketCommand({ Bucket: params.Bucket })
        );
        console.log(data);
        console.log("Successfully created a bucket called ", data.Location);
        return data; // Для модульного тестирования.
      } catch (err) {
        console.log("Error", err);
      }
      // Создание объекта и загрузка его в бакет
      try {
        const results = await s3Client.send(new PutObjectCommand(params));
        console.log(
            "Successfully created " +
            params.Key +
            " and uploaded it to " +
            params.Bucket +
            "/" +
            params.Key
        );
        return results; // Для модульного тестирования.
      } catch (err) {
        console.log("Error", err);
      }
    };
    run();
    ```

    {% endcut %}

1. В блоке `const params` задайте имя бакета, имя и содержимое объекта в бакете.
1. Запустите приложение:

    ```bash
    node sample.js
    ```

Подробности о работе с AWS SDK для JavaScript см. в [документации AWS](https://docs.aws.amazon.com/sdk-for-javascript/v3/developer-guide/getting-started-nodejs.html).