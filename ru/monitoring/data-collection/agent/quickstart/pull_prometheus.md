# Поставка метрик пользовательского приложения

Для поставки пользовательских метрик используется вход `http`, который периодически собирает метрики из приложения по протоколу HTTP в формате Prometheus или в формате Яндекс.Мониторинга. TODO: добавить ссылку на формат Яндекс.Мониторинга

В качесте приложения в данном примере используется приложение из https://github.com/prometheus/client_python):
```
$ pip install prometheus_client

$ cat example.py
from prometheus_client import start_http_server, Summary
import random
import time

# Create a metric to track time spent and requests made.
REQUEST_TIME = Summary('request_processing_seconds', 'Time spent processing request')

# Decorate function with metric.
@REQUEST_TIME.time()
def process_request(t):
    """A dummy function that takes some time."""
    time.sleep(t)

if __name__ == '__main__':
    # Start up the server to expose the metrics.
    start_http_server(8000)
    # Generate some requests.
    while True:
        process_request(random.random())
```

Пример конфигурационного файла, собирающего метрики из приложения-примера:
```
$ cat /etc/yandex/unified-agent/conf.d/pull.yml


```

Команда для запуска Unified Agent:

 TODO: Написать про push?

## Что дальше

Изучите концепции Unified Agent
Узнайте подробнее о конфигурировании Unified Agent
Ознакомьтесь с рекомендациями по эксплуатации Unified Agent