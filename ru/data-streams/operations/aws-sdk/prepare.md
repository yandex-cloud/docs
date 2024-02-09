---
title: "Подготовка окружения в AWS SDK в {{ yds-full-name }}"
description: "Следуя данной инструкции, вы сможете настроить окружение для вашего языка программирования." 
---

# Подготовка окружения в AWS SDK

{% note warning %}

В данный момент отсутствует поддержка новых версий AWS SDK. Используйте версии [AWS SDK](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-json-faqs.html#json-protocol-getting-started) до введения поддержки протокола JSON.

{% endnote %}

Настройте окружение для вашего языка программирования:

{% list tabs group=programming_language %}

- Python {#python}

  1. Скачайте и установите [Python](https://www.python.org/downloads/) версии 3.6 или выше.
  1. Установите библиотеку Boto3:

     ```bash
     pip install boto3
     ```

     Подробнее об AWS SDK for Python (Boto) читайте в [документации AWS](https://aws.amazon.com/ru/sdk-for-python/).

{% endlist %}