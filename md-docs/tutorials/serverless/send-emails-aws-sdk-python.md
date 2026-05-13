# Отправка писем с помощью AWS SDK для Python

В этом руководстве вы научитесь отправлять электронные письма через Yandex Cloud Postbox с использованием [AWS SDK для Python (Boto3)](https://boto3.amazonaws.com/v1/documentation/api/latest/index.html).

Чтобы начать отправлять электронные письма:

1. [Подготовьте облако к работе](#before-begin).
1. [Настройте директорию для аутентификационных данных](#auth).
1. [Создайте и запустите приложение](#app).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:

* плата за использование Yandex Cloud Postbox (см. [тарифы Yandex Cloud Postbox](../../postbox/pricing.md));
* плата за публичные [DNS-запросы](../../glossary/dns.md) и [зоны DNS](../../dns/concepts/dns-zone.md), если вы создаете ресурсную запись в Cloud DNS (см. [тарифы Cloud DNS](../../dns/pricing.md)).


### Подготовьте ресурсы {#infrastructure}

1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт.
1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту [роль](../../postbox/security/index.md#postbox-sender) `postbox.sender`.
1. [Создайте](../../iam/operations/authentication/manage-access-keys.md) статический ключ доступа для сервисного аккаунта. Сохраните идентификатор и секретный ключ.
1. [Создайте](../../postbox/operations/create-address.md) адрес.
1. [Пройдите](../../postbox/operations/check-domain.md) проверку владения доменом.


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
    region = ru-central1
    endpoint_url = https://postbox.cloud.yandex.net
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
      1. Перейдите в папку в склонированном репозитории `/`.
      1. В файле `raw.py` укажите данные:
         
         * В поле `SENDER` — электронную почту отправителя.
         
             Домен электронной почты отправителя должен совпадать с указанным в адресе Yandex Cloud Postbox, созданном при [подготовке к работе](#infrastructure). Например, если домен, на который вы подтвердили владение, — `yourdomain.com`, можно указать электронную почту `noreply@yourdomain.com` или `admin@yourdomain.com`, а `user@mail.yourdomain.com` — нельзя.
         
         * В поле `RECIPIENT` — электронную почту получателя. Например: `receiver@yourdomain.com`. Далее для проверки вам потребуется доступ к этой электронной почте.

    - Вручную

      1. Создайте папку `postbox-python` и перейдите в нее.
      1. Создайте файл `raw.py` и вставьте в него код:

          ```python
          import boto3
          from botocore.config import Config
          from email.mime.multipart import MIMEMultipart
          from email.mime.text import MIMEText
          from email.mime.application import MIMEApplication
          import os

          # Адрес отправителя должен быть подтвержден с помощью Amazon SES.
          SENDER = "<адрес_отправителя>"

          # Адрес получателя.
          RECIPIENT = "<адрес_получателя>"

          # Тема письма.
          SUBJECT = "Yandex Cloud Postbox Raw Email Test via AWS SDK for Python"

          # Путь к файлу, который нужно вложить в письмо.
          ATTACHMENT = "attachment.txt"

          # HTML-текст письма.
          HTML_BODY = """<h1>Amazon SES Raw Email Test (AWS SDK for Python)</h1>
          <p>This email was sent with <a href='https://yandex.cloud/ru/docs/postbox/quickstart'>Yandex Cloud Postbox</a> using the 
          <a href='https://aws.amazon.com/sdk-for-python/'>AWS SDK for Python</a> with raw email format.</p>
          <p>Please see the attached file.</p>"""

          # Текст письма для почтовых клиентов без поддержки HTML.
          TEXT_BODY = "This email was sent with Yandex Cloud Postbox using the AWS SDK for Python with raw email format. Please see the attached file."

          # Кодировка символов в письме.
          CHARSET = "UTF-8"

          def main():
              # Создание пользовательского резолвера эндпоинта для Yandex Cloud Postbox
              endpoint_url = "https://postbox.cloud.yandex.net"

              # Настройка клиента SES с пользовательским эндпоинтом
              config = Config(
                  region_name="ru-central1",
                  # Раскомментируйте следующую строку для включения отладочного логирования
                  # parameter_validation=False,
              )

              # Создание клиента SES
              # По умолчанию SDK использует цепочку поставщиков учетных данных по умолчанию
              # Вы можете использовать статические учетные данные, раскомментировав и изменив следующие строки:
              # session = boto3.Session(
              #     aws_access_key_id='accessKeyID',
              #     aws_secret_access_key='secretAccessKey',
              # )
              # ses_client = session.client('sesv2', config=config, endpoint_url=endpoint_url)

              # Использование учетных данных по умолчанию
              ses_client = boto3.client('sesv2', config=config, endpoint_url=endpoint_url)

              # Создание родительского контейнера multipart/mixed
              msg = MIMEMultipart('mixed')
              # Добавление строк: тема, от кого, кому
              msg['Subject'] = SUBJECT
              msg['From'] = SENDER
              msg['To'] = RECIPIENT

              # Создание дочернего контейнера multipart/alternative
              msg_body = MIMEMultipart('alternative')

              # Кодирование содержимого в текстовом и HTML-формате и установка кодировки символов
              textpart = MIMEText(TEXT_BODY.encode(CHARSET), 'plain', CHARSET)
              htmlpart = MIMEText(HTML_BODY.encode(CHARSET), 'html', CHARSET)

              # Добавление частей с текстовым и HTML-содержимым в дочерний контейнер
              msg_body.attach(textpart)
              msg_body.attach(htmlpart)

              # Определение части с вложением и кодирование с помощью MIMEApplication
              try:
                  att = MIMEApplication(open(ATTACHMENT, 'rb').read())
                  # Добавление заголовка, чтобы указать почтовому клиенту, что эту часть нужно рассматривать как вложение
                  att.add_header('Content-Disposition', 'attachment', filename=os.path.basename(ATTACHMENT))
                  # Прикрепление вложения к родительскому контейнеру
                  msg.attach(att)
              except FileNotFoundError:
                  print(f"Warning: Attachment file {ATTACHMENT} not found. Sending email without attachment.")

              # Прикрепление дочернего контейнерf multipart/alternative к родительскому контейнеру multipart/mixed
              msg.attach(msg_body)

              # Преобразование MIME-сообщение в строку, а затем в байты
              raw_message = str(msg)
              raw_message_bytes = bytes(raw_message, CHARSET)

              try:
                  # Отправка письма
                  response = ses_client.send_email(
                      FromEmailAddress=SENDER,
                      Destination={
                          'ToAddresses': [RECIPIENT]
                      },
                      Content={
                          'Raw': {
                              'Data': raw_message_bytes
                          }
                      }
                  )
                  # Вывод идентификатора письма
                  print(f"Email sent! Message ID: {response['MessageId']}")
              except Exception as e:
                  print(f"Error sending email: {e}")
                  raise

          if __name__ == "__main__":
              main()
          ```

      1. В файле `raw.py` укажите данные:
         
         * В поле `SENDER` — электронную почту отправителя.
         
             Домен электронной почты отправителя должен совпадать с указанным в адресе Yandex Cloud Postbox, созданном при [подготовке к работе](#infrastructure). Например, если домен, на который вы подтвердили владение, — `yourdomain.com`, можно указать электронную почту `noreply@yourdomain.com` или `admin@yourdomain.com`, а `user@mail.yourdomain.com` — нельзя.
         
         * В поле `RECIPIENT` — электронную почту получателя. Например: `receiver@yourdomain.com`. Далее для проверки вам потребуется доступ к этой электронной почте.
      1. Создайте файл `requirements.txt` и вставьте в него строку: `boto3`.
      1. Создайте файл `attachment.txt` и вставьте в него любой текст.

    {% endlist %}

1. Создайте виртуальную среду и установите зависимости:

    {% list tabs group=operating_system %}

    - Linux/MacOS {#linux-macos}

      ```bash
      python -m venv venv
      source venv/bin/activate
      pip install -r requirements.txt
      ```

    - Windows {#windows}

      ```bash
      python -m venv venv
      source venv\Scripts\activate
      pip install -r requirements.txt
      ```

    {% endlist %}

    Результат:

    ```text
    ...
    Successfully installed boto3-1.39.4 botocore-1.39.4 jmespath-1.0.1 python-dateutil-2.9.0.post0 s3transfer-0.13.0 six-1.17.0 urllib3-2.5.0
    ```

1. Запустите приложение:

    ```bash
    python raw.py
    ```

    Результат:

    ```text
    Email sent! Message ID: DB9WSLG38TUS.11PW8********@ingress2-klg
    ```


## Проверьте результат {#check-result}

Убедитесь, что на адрес получателя, заданный в файле `raw.py` в поле `RECIPIENT`, пришло письмо с указанными параметрами. Письмо должно содержать вложение — файл `attachment.txt`.


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. Удалите [адрес](../../postbox/concepts/glossary.md#adress).
1. [Удалите](../../dns/operations/zone-delete.md) зону DNS, если создавали в ней ресурсную запись.