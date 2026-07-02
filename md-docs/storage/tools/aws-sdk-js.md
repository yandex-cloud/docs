[Документация Yandex Cloud](../../index.md) > [Yandex Object Storage](../index.md) > [Инструменты](index.md) > SDK > AWS SDK для JavaScript

# AWS SDK для JavaScript


[AWS SDK для JavaScript](https://docs.aws.amazon.com/sdk-for-javascript/) — это комплект средств разработки для взаимодействия с сервисами AWS, совместимый с Yandex Object Storage.

С помощью AWS SDK для Node.js вы создадите бакет, загрузите в него объекты, получите список объектов, извлечете отдельный объект, очистите содержимое бакета и удалите  бакет.

## Подготовка к работе {#before-you-begin}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md).
1. [Назначьте сервисному аккаунту роли](../../iam/operations/sa/assign-role-for-sa.md), которые нужны для вашего проекта, например [storage.editor](../security/index.md#storage-editor) на бакет — для работы с конкретным бакетом, или на каталог — для работы со всеми бакетами в каталоге. Подробнее о ролях смотрите на странице [Управление доступом с помощью Yandex Identity and Access Management](../security/index.md).

          
    Чтобы работать с объектами в [зашифрованном](../concepts/encryption.md) бакете, у пользователя или [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) вместе с [ролью](../security/index.md#storage-configurer) `storage.configurer` должны быть следующие [роли на ключ шифрования](../../kms/operations/key-access.md):
    
    * `kms.keys.encrypter` — для чтения ключа, [шифрования](../../kms/security/index.md#kms-keys-encrypter) и загрузки объектов;
    * `kms.keys.decrypter` — для чтения ключа, [расшифровки](../../kms/security/index.md#kms-keys-decrypter) и скачивания объектов;
    * `kms.keys.encrypterDecrypter` — включает [разрешения](../../kms/security/index.md#kms-keys-encrypterDecrypter), предоставляемые ролями `kms.keys.encrypter` и `kms.keys.decrypter`.
    
    Подробнее смотрите [Сервисные роли Key Management Service](../../kms/security/index.md#service-roles).


1. [Создайте статический ключ доступа](../../iam/operations/authentication/manage-access-keys.md#create-access-key).

    
    В результате вы получите данные статического ключа доступа. Для аутентификации в Object Storage вам понадобятся:
    
    * `key_id` — идентификатор статического ключа доступа;
    * `secret` — секретный ключ.
    
    Сохраните `key_id` и `secret`, так как повторное получение значения ключа будет невозможно.



Авторизация статическими ключами необходима для обращения напрямую к HTTP API и поддерживается инструментами, перечисленными в разделе [Поддерживаемые инструменты](index.md).
  
{% note info %}

Вы можете [запретить доступ в бакет с помощью статических ключей](../operations/buckets/disable-statickey-auth.md). После запрета доступ будет прекращен для всех инструментов, которые их используют: AWS CLI, SDK и сторонние приложения. Это также отключит доступ с помощью [эфемерных ключей](../security/ephemeral-keys.md), [временных ключей доступа Security Token Service](../security/sts.md) и [подписанных (pre-signed) URL](../security/overview.md#pre-signed). Останется доступ только через [IAM-токен](../../iam/concepts/authorization/iam-token.md) или [анонимный доступ](../security/public-access.md) (если он включен).

{% endnote %}


Статический ключ для доступа к Object Storage можно безопасно хранить в сервисе Yandex Lockbox. Подробнее смотрите [Использование секрета Yandex Lockbox для хранения статического ключа доступа](../tutorials/static-key-in-lockbox/index.md).

{% note info %}

Сервисный аккаунт может просматривать список бакетов только в том каталоге, в котором он был создан.

Сервисный аккаунт может выполнять действия с объектами в бакетах, которые созданы в каталогах, отличных от каталога сервисного аккаунта. Для этого [назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту [роли](../security/index.md#service-roles) на нужный каталог или бакет в нем.

{% endnote %}

## Подготовка проекта {#setup-project}

### Подготовка аутентификационных данных {#setup-project-aws-tools}

1. Создайте директорию для хранения аутентификационных данных и перейдите в нее: 

    Для macOS и Linux:

    ```bash
    mkdir ~/.aws/
    ```

    Для Windows:

    ```bash
    mkdir C:\Users\<имя_пользователя>\.aws\
    ```

1.  В директории `.aws` создайте файл `credentials` и скопируйте в него аутентификационные данные, [полученные ранее](#before-you-begin):

    ```text
    [default]
    aws_access_key_id = <идентификатор_статического_ключа>
    aws_secret_access_key = <секретный_ключ>
    ```

1. Создайте файл `config` с параметрами региона по умолчанию и скопируйте в него следующую информацию:

    ```text
    [default]
    region = ru-central1
    endpoint_url = https://storage.yandexcloud.net
    ```

    {% note info %}

    Некоторые приложения, предназначенные для работы с Amazon S3, не позволяют указывать регион, поэтому Object Storage принимает также значение основного региона AWS — [первая строка в таблице регионов](https://docs.aws.amazon.com/global-infrastructure/latest/regions/aws-regions.html#available-regions).

    {% endnote %}

Для доступа к Object Storage используйте эндпоинт `https://storage.yandexcloud.net`.

### Подготовка директории проекта {#setup-project-folder}

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

## Примеры кода {#js-sdk-examples}

Далее будут описаны способы выполнения базовых операций с бакетом с помощью AWS SDK для Node.js.
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

Подробнее о работе с AWS SDK для JavaScript читайте в [документации AWS](https://docs.aws.amazon.com/sdk-for-javascript/v3/developer-guide/getting-started-nodejs.html).