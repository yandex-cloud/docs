# Example of using {{ message-queue-full-name }} with Celery

[Celery](https://docs.celeryproject.org/en/stable/) is a task queue for Python that you can use to work with {{ message-queue-name }}.

## Installation {#install}

Install Celery and the necessary dependencies:

```
pip install celery
pip install celery[sqs]
pip install boto3
pip install pycurl
```

Set the environment variables:

```
export AWS_ACCESS_KEY_ID="<access key ID>"
export AWS_SECRET_ACCESS_KEY="<secret key>"
export AWS_DEFAULT_REGION="{{ region-id }}"
```

## Before you start {#prepare}

{% include [mq-http-api-preps](../_includes_service/mq-http-api-preps.md)%}

## Example {#sample}

In this example:

1. A task is enqueued.
1. The enqueued tasks are executed.

To run the example:

1. Copy the example to a file named `mq_example.py`:

   ```python
   from celery import Celery
   import logging
   import boto3

   ENDPOINT = 'message-queue.{{ api-host }}:443'

   broker='sqs://{}'.format(ENDPOINT)
   broker_transport_options = {
       'is_secure': True,
   }

   app = Celery('mq_example', broker=broker)
   app.conf.broker_transport_options = broker_transport_options

   @app.task
   def add(a, b):
       res = a + b
       app.log.get_default_logger().info('{} + {} = {}'.format(a, b, res))
       return res

   if __name__ == '__main__':
       add.delay(2, 3)
       print("Task scheduled, now run 'celery worker -A mq_example' to execute it")
   ```

1. Run the task handler with the command:

   ```
   celery worker -A mq_example
   ```

1. Enqueue a task with the command:

   ```
   python mq_example.py
   ```

By default, Celery creates a {{ message-queue-name }} queue named `celery` in the folder that the service account belongs to.