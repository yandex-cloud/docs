---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---
# Пример использования {{ message-queue-full-name }} с Celery

[Celery](http://www.celeryproject.org/) — это очередь задач для языка программирования Python, которую можно использовать в работе с {{ message-queue-name }}.

## Установка {#install}

Установите Celery и необходимые зависимости:

```
$ pip install celery
$ pip install celery[sqs]
$ pip install boto3
$ pip install pycurl
```

Задайте переменные окружения:

```
$ export AWS_ACCESS_KEY_ID="<идентификатор ключа доступа>"
$ export AWS_SECRET_ACCESS_KEY="<секретный ключ>"
$ export AWS_DEFAULT_REGION="ru-central1"
```

## Подготовка к работе {#prepare}

{% include [mq-http-api-preps](../_includes_service/mq-http-api-preps.md)%}

## Пример {#sample}

В этом примере:

1. Задача ставится в очередь.
1. Выполняются задачи, находящиеся в очереди.

Для запуска примера:

1. Скопируйте пример в файл с названием `ymq_example.py`:

   ```python
   from celery import Celery
   import logging
   import boto3

   ENDPOINT = 'message-queue.api.cloud.yandex.net:443'

   broker='sqs://{}'.format(ENDPOINT)
   broker_transport_options = {
       'is_secure': True,
   }

   app = Celery('ymq_example', broker=broker)
   app.conf.broker_transport_options = broker_transport_options

   @app.task
   def add(a, b):
       res = a + b
       app.log.get_default_logger().info('{} + {} = {}'.format(a, b, res))
       return res

   if __name__ == '__main__':
       add.delay(2, 3)
       print("Task scheduled, now run 'celery worker -A ymq_example' to execute it")
   ```

1. Запустите обработчик задач следующей командой: 
   
   ```
   $ celery worker -A ymq_example
   ```

1. Поставьте задачу в очередь задач следующей командой:
   
   ```
   $ python ymq_example.py
   ```

По умолчанию Celery создаёт очередь {{ message-queue-name }} с названием `celery` в каталоге, которому принадлежит сервисный аккаунт.