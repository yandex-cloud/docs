---
title: AWS SDK для JavaScript
description: Из статьи вы узнаете, что такое AWS SDK для JavaScript, как его установить и настроить, а также ознакомитесь с примерами кода.
---

# AWS SDK для JavaScript


[AWS SDK для JavaScript](https://docs.aws.amazon.com/sdk-for-javascript/) — это комплект средств разработки для взаимодействия с сервисами AWS, совместимый с {{ objstorage-full-name }}.

С помощью AWS SDK для Node.js вы создадите бакет, загрузите в него объекты, получите список объектов, извлечете отдельный объект, очистите содержимое бакета и удалите  бакет.

## Подготовка к работе {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

{% include [access-bucket-sa](../../_includes/storage/access-bucket-sa.md) %}

## Подготовка проекта {#setup-project}

### Подготовка аутентификационных данных {#setup-project-aws-tools}

{% include [storage-sdk-setup](../_includes_service/storage-sdk-setup-storage-url.md) %}

### Подготовка директории проекта {#setup-project-folder}

{% include [nodejs-project-folder-setup](../_includes_service/storage-sdk-nodejs-project-setup.md) %}

## Примеры кода {#js-sdk-examples}

Ниже мы рассмотрим, как выполнять основные операции с бакетом в AWS SDK для Node.js.
1. В файл `index.js` вставьте следующий код:

    ```js
    import { readFileSync } from "node:fs"
    import
    {
        S3Client,
        PutObjectCommand,
        CreateBucketCommand,
        DeleteObjectCommand,
        DeleteBucketCommand,
        paginateListObjectsV2,
        GetObjectCommand,
        ListObjectsV2Command,
    } from "@aws-sdk/client-s3";

    (async function ()
    {
        // Создание s3 клиента для взаимодействия с aws.
        // Данные для авторизации берутся из вашего окружения, но вы можете указать их явно. Например:
        // `new S3Client({ region: 'ru-central1', credentials: {...} })`
        const s3Client = new S3Client({});

        const bucketName = `test-bucket-${Date.now()}`;
        // Создать новый бакет
        console.log(`Creating the bucket ${bucketName}.`);
        await s3Client.send(
            new CreateBucketCommand({
                Bucket: bucketName,
            }),
        );
        console.log(`The bucket ${bucketName} was created.\n\n`);

        // Загрузить объекты в бакет
        // Из строки
        console.log('Creating a object from string.');
        await s3Client.send(
            new PutObjectCommand({
                Bucket: bucketName,
                Key: "bucket-text",
                Body: 'Hello bucket!',
            }),
        );
        console.log('The object from string was created.\n');
        // Из файлов
        console.log('Creating the first object from local file.');
        await s3Client.send(
            new PutObjectCommand({
                Bucket: bucketName,
                Key: "my-package.json",
                Body: readFileSync('package.json'),
            }),
        );
        console.log('The first object was created.\nCreating the second object from local file.');
        await s3Client.send(
            new PutObjectCommand({
                Bucket: bucketName,
                Key: "my-package-lock.json",
                Body: readFileSync('package-lock.json'),
            }),
        );
        console.log('The second object was created.\n');

        // Получить список объектов
        console.log('Getting bucket objects list.');
        const command = new ListObjectsV2Command({ Bucket: bucketName });
        const { Contents } = await s3Client.send(command);
        const contentsList = Contents.map((c) => ` • ${c.Key}`).join("\n");
        console.log("Here's a list of files in the bucket:");
        console.log(`${contentsList}\n`);

        // Удалить несколько объектов
        console.log('Deleting objects.');
        await s3Client.send(
            new DeleteObjectCommand({ Bucket: bucketName, Key: "my-package.json" }),
        );
        await s3Client.send(
            new DeleteObjectCommand({ Bucket: bucketName, Key: "my-package-lock.json" }),
        );
        console.log('The objects were deleted.\n');

        // Получить объект
        console.log('Getting your "bucket-text" object')
        const { Body } = await s3Client.send(
            new GetObjectCommand({
                Bucket: bucketName,
                Key: "bucket-text",
            }),
        );
        console.log('Your "bucket-text" content:')
        console.log(await Body.transformToString(), '\n');

        // Удаление объектов в бакетах и затем самого бакета
        // Получаем список объектов постранично
        const paginator = paginateListObjectsV2(
            { client: s3Client },
            { Bucket: bucketName },
        );
        for await (const page of paginator)
        {
            const objects = page.Contents;
            if (objects)
            {
                // Выполняем команду удаления для каждого объекта через итерацию страниц с объектами
                for (const object of objects)
                {
                    // Отправляем команду на удаление
                    await s3Client.send(
                        new DeleteObjectCommand({ Bucket: bucketName, Key: object.Key }),
                    );
                }
            }
        }

        // Удаляем ранее созданный бакет
        await s3Client.send(new DeleteBucketCommand({ Bucket: bucketName }));
        console.log('Your bucket was emptied and deleted.');
    })()
    ```
  
    В этом фрагменте кода мы добавили [IIFE - Immediately Invoked Function Expression](https://developer.mozilla.org/en-US/docs/Glossary/IIFE). Это позволит вызвать скрипт при запуске файла.
1. Запустите приложение:

    ```bash
    node index.js
    ```

    В выводе консоли появится пошаговое описание результатов операции.

Подробности о работе с AWS SDK для JavaScript см. в [документации AWS](https://docs.aws.amazon.com/sdk-for-javascript/v3/developer-guide/getting-started-nodejs.html).
