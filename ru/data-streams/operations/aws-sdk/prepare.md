# Подготовка окружения в AWS SDK

Настройте окружение для вашего языка программирования:

{% list tabs %}

- Python

  1. Скачайте и установите [Python](https://www.python.org/downloads/) версии 3.6 или выше.
  1. Установите библиотеку Boto3:

     ```bash
     pip install boto3
     ```

     Подробнее об AWS SDK for Python (Boto) читайте в [документации AWS]{% if region == "int" %}(https://aws.amazon.com/sdk-for-python/){% else %}(https://aws.amazon.com/ru/sdk-for-python/){% endif %}.

{% endlist %}