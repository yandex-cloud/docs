# Отправка писем с помощью AWS SDK для JavaScript

В этом руководстве вы научитесь отправлять электронные письма через {{ postbox-full-name }} с использованием [AWS SDK для JavaScript](https://docs.aws.amazon.com/sdk-for-javascript/v3/developer-guide/welcome.html).

Чтобы начать отправлять электронные письма:

1. [Подготовьте облако к работе](#before-begin).
1. [Настройте директорию для аутентификационных данных](#auth).
1. [Создайте и запустите приложение](#app).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-begin}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:

* плата за использование {{ postbox-full-name }} (см. [тарифы {{ postbox-name }}](../pricing.md));
* плата за публичные [DNS-запросы](../../glossary/dns.md) и [зоны DNS](../../dns/concepts/dns-zone.md), если вы создаете ресурсную запись в {{ dns-name }} (см. [тарифы {{ dns-name }}](../../dns/pricing.md)).


### Подготовьте ресурсы {#infrastructure}

1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт.
1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту [роль](../security/index.md#postbox-sender) `postbox.sender`.
1. [Создайте](../../iam/operations/authentication/manage-access-keys.md) статический ключ доступа для сервисного аккаунта. Сохраните идентификатор и секретный ключ.
1. [Создайте](../operations/create-address.md) адрес.
1. [Пройдите](../operations/check-domain.md) проверку владения доменом.


## Настройте директорию для аутентификационных данных {#auth}

1. Создайте директорию для хранения аутентификационных данных и перейдите в нее: 

    Для macOS и Linux:

    ```bash
    mkdir ~/.aws/
    ```

    Для Windows:

    ```bash
    mkdir C:\Users\<имя_пользователя>\.aws\
    ```

1. В директории `.aws` создайте файл `credentials` и скопируйте в него аутентификационные данные, полученные при [создании статического ключа доступа](#infrastructure):

    ```text
    [default]
    aws_access_key_id = <идентификатор_статического_ключа>
    aws_secret_access_key = <секретный_ключ>
    ```

1. Создайте файл `config` с параметрами региона по умолчанию и скопируйте в него следующую информацию:

    ```text
    [default]
    region = {{ region-id }}
    endpoint_url = https://{{ postbox-host }}
    ```


### Использование переменных окружения {#variables}

AWS SDK по умолчанию использует аутентификационные данные из переменных окружения, если они заданы. Эти переменные имеют приоритет над аутентификационными данными, которые указаны в файле `.aws/credentials`.

Поддерживаются следующие переменные окружения:

* `AWS_ACCESS_KEY_ID` — идентификатор статического ключа;
* `AWS_SECRET_ACCESS_KEY` — секретный ключ.

Чтобы задать переменные окружения, выполните следующие действия в зависимости от вашей операционной системы:

{% list tabs group=operating_system %}

- Linux/macOS

    В терминале выполните команду:

    ```bash
    export AWS_ACCESS_KEY_ID=<идентификатор_статического_ключа>
    export AWS_SECRET_ACCESS_KEY=<секретный_ключ>
    ```

- Windows

    В PowerShell выполните команду:

    ```powershell
    $Env:AWS_ACCESS_KEY_ID=<идентификатор_статического_ключа>
    $Env:AWS_SECRET_ACCESS_KEY=<секретный_ключ>
    ```

{% endlist %}


## Создайте и запустите приложение {#app}

1. Получите код приложения:

    {% list tabs %}

    - Репозиторий

      1. Склонируйте репозиторий:
         
         ```bash
         git clone https://github.com/yandex-cloud-examples/yc-postbox-examples
         ```
      1. Перейдите в папку в склонированном репозитории `javascript/`.
      1. В файле `main.js` укажите данные:
         
         * В поле `SENDER` — электронную почту отправителя.
         
             Домен электронной почты отправителя должен совпадать с указанным в адресе {{ postbox-short-name }}, созданном при [подготовке к работе](#infrastructure). Например, если домен, на который вы подтвердили владение, — `yourdomain.com`, можно указать электронную почту `noreply@yourdomain.com` или `admin@yourdomain.com`, а `user@mail.yourdomain.com` — нельзя.
         
         * В поле `RECIPIENT` — электронную почту получателя. Например: `receiver@yourdomain.com`. Далее для проверки вам потребуется доступ к этой электронной почте.

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

      1. В файле `main.js` укажите данные:
         
         * В поле `SENDER` — электронную почту отправителя.
         
             Домен электронной почты отправителя должен совпадать с указанным в адресе {{ postbox-short-name }}, созданном при [подготовке к работе](#infrastructure). Например, если домен, на который вы подтвердили владение, — `yourdomain.com`, можно указать электронную почту `noreply@yourdomain.com` или `admin@yourdomain.com`, а `user@mail.yourdomain.com` — нельзя.
         
         * В поле `RECIPIENT` — электронную почту получателя. Например: `receiver@yourdomain.com`. Далее для проверки вам потребуется доступ к этой электронной почте.
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

Чтобы перестать платить за созданные ресурсы:

1. Удалите [адрес](../concepts/glossary.md#adress).
1. [Удалите](../../dns/operations/zone-delete.md) зону DNS, если создавали в ней ресурсную запись.