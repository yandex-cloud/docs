

В этом руководстве вы научитесь отправлять электронные письма через {{ postbox-full-name }} с использованием [AWS SDK для JavaScript](https://docs.aws.amazon.com/sdk-for-javascript/v3/developer-guide/welcome.html).

Чтобы начать отправлять электронные письма:

1. [Подготовьте облако к работе](#before-begin).
1. [Настройте директорию для аутентификационных данных](#auth).
1. [Создайте и запустите приложение](#app).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

{% include [paid-resources](../../_includes/postbox/send-emails-aws-sdk/paid-resources.md) %}


### Подготовьте ресурсы {#infrastructure}

{% include [infrastructure](../../_includes/postbox/send-emails-aws-sdk/infrastructure.md) %}


## Настройте директорию для аутентификационных данных {#auth}

{% include [sdk-auth](../../_includes/postbox/send-emails-aws-sdk/auth.md) %}


### Использование переменных окружения {#variables}

{% include [sdk-env-variables](../../_includes/postbox/send-emails-aws-sdk/env-variables.md) %}


## Создайте и запустите приложение {#app}

1. Получите код приложения:

    {% list tabs %}

    - Репозиторий

      1. {% include [clone-yc-postbox-examples](../../_includes/postbox/send-emails-aws-sdk/clone-yc-postbox-examples.md) %}
      1. Перейдите в папку в склонированном репозитории `javascript/`.
      1. {% include [edit-main-js](../../_includes/postbox/send-emails-aws-sdk/edit-main-js.md) %}

    - Вручную

      1. Создайте папку `postbox-javascript` и перейдите в нее.
      1. Создайте файл `main.js` и вставьте в него код:

          ```javascript
          // AWS SDK for JavaScript v3 (ESM)
          import { SESv2Client, SendEmailCommand } from '@aws-sdk/client-sesv2';

          // Адрес отправителя должен быть подтвержден с помощью Amazon SES.
          const SENDER = "<адрес_отправителя>";

          // Адрес получателя.
          const RECIPIENT = "<адрес_получателя>";

          // Тема письма.
          const SUBJECT = "{{ postbox-full-name }} Test via AWS SDK for JavaScript v3";

          // HTML-текст письма.
          const HTML_BODY = `<h1>Amazon SES Test Email (AWS SDK for JavaScript v3)</h1>
          <p>This email was sent with <a href='{{ link-docs }}/postbox/quickstart'>{{ postbox-full-name }}</a> using the 
          <a href='https://aws.amazon.com/sdk-for-javascript/'>AWS SDK for JavaScript v3</a>.</p>`;

          // Текст письма для почтовых клиентов без поддержки HTML.
          const TEXT_BODY = "This email was sent with {{ postbox-full-name }} using the AWS SDK for JavaScript v3.";

          // Кодировка символов в письме.
          const CHARSET = "UTF-8";

          // Основная функция
          async function main() {
              // Создайте клиент SES с эндпоинтом для {{ postbox-full-name }}
              const client = new SESv2Client({
                  region: '{{ region-id }}',
                  endpoint: '{{ postbox-endpoint }}',
                  // По умолчанию SDK использует цепочку поставщиков учетных данных по умолчанию.
                  // Вы можете использовать статические учетные данные, раскомментировав и изменив следующие строки:
                  // credentials: {
                  //     accessKeyId: 'accessKeyID',
                  //     secretAccessKey: 'secretAccessKey',
                  // },
              });

              // Сборка письма.
              const params = {
                  Destination: {
                      ToAddresses: [RECIPIENT],
                  },
                  Content: {
                      Simple: {
                          Subject: {
                              Charset: CHARSET,
                              Data: SUBJECT,
                          },
                          Body: {
                              Html: {
                                  Charset: CHARSET,
                                  Data: HTML_BODY,
                              },
                              Text: {
                                  Charset: CHARSET,
                                  Data: TEXT_BODY,
                              },
                          },
                      },
                  },
                  FromEmailAddress: SENDER,
              };

              try {
                  // Создание команды.
                  const command = new SendEmailCommand(params);

                  // Отправка письма.
                  const data = await client.send(command);
                  console.log(data.MessageId);
              } catch (err) {
                  console.error("Error sending email:", err);
                  throw err;
              }
          }

          // Запуск основной функции.
          main().catch(err => {
              console.error("Unhandled error:", err);
              process.exit(1);
          });
          ```

      1. {% include [edit-main-js](../../_includes/postbox/send-emails-aws-sdk/edit-main-js.md) %}
      1. Создайте файл `package.json` и вставьте в него код:

          ```json
          {
            "name": "yc-postbox-example",
            "version": "1.0.0",
            "description": "Example of sending emails through {{ postbox-full-name }} using AWS SDK for JavaScript",
            "main": "main.js",
            "type": "module",
            "scripts": {
              "start": "node main.js"
            },
            "dependencies": {
              "@aws-sdk/client-sesv2": "^3.821.0"
            },
            "license": "MIT"
          }
          ```

    {% endlist %}

1. Установите зависимости:

    ```bash
    npm install
    ```

    Результат:

    ```text
    added 79 packages, and audited 80 packages in 3s
    
    3 packages are looking for funding
      run `npm fund` for details
    
    found 0 vulnerabilities
    ```

  1. Запустите приложение:

      ```bash
      npm start
      ```

      Результат:

      ```text
      > yc-postbox-example@1.0.0 start
      > node main.js

      DB6TZYXAOBH1.2E2Q5********@ingress2-klg
      ```


## Проверьте результат {#check-result}

Убедитесь, что на адрес получателя, заданный в файле `main.js` в поле `RECIPIENT`, пришло письмо с указанными параметрами.


## Как удалить созданные ресурсы {#clear-out}

{% include [clear-out](../../_includes/postbox/send-emails-aws-sdk/clear-out.md) %}