

В этом руководстве вы научитесь отправлять электронные письма через {{ postbox-full-name }} с использованием [AWS SDK для Python (Boto3)](https://boto3.amazonaws.com/v1/documentation/api/latest/index.html).

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
      1. Перейдите в папку в склонированном репозитории `/`.
      1. {% include [edit-main-python](../../_includes/postbox/send-emails-aws-sdk/edit-main-python.md) %}

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
          SUBJECT = "{{ postbox-full-name }} Raw Email Test via AWS SDK for Python"

          # Путь к файлу, который нужно вложить в письмо.
          ATTACHMENT = "attachment.txt"

          # HTML-текст письма.
          HTML_BODY = """<h1>Amazon SES Raw Email Test (AWS SDK for Python)</h1>
          <p>This email was sent with <a href='{{ link-docs }}/postbox/quickstart'>{{ postbox-full-name }}</a> using the 
          <a href='https://aws.amazon.com/sdk-for-python/'>AWS SDK for Python</a> with raw email format.</p>
          <p>Please see the attached file.</p>"""

          # Текст письма для почтовых клиентов без поддержки HTML.
          TEXT_BODY = "This email was sent with {{ postbox-full-name }} using the AWS SDK for Python with raw email format. Please see the attached file."

          # Кодировка символов в письме.
          CHARSET = "UTF-8"

          def main():
              # Создание пользовательского резолвера эндпоинта для {{ postbox-full-name }}
              endpoint_url = "{{ postbox-endpoint }}"

              # Настройка клиента SES с пользовательским эндпоинтом
              config = Config(
                  region_name="{{ region-id }}",
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

      1. {% include [edit-main-python](../../_includes/postbox/send-emails-aws-sdk/edit-main-python.md) %}
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

{% include [clear-out](../../_includes/postbox/send-emails-aws-sdk/clear-out.md) %}