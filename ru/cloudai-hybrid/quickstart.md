# Как развернуть демонстрационный стенд {{ cloudml-full-name }}

## Компоненты {#components}

{{ cloudml-name }} разворачивается на виртуальной машине, внутри которой запущены три Docker-контейнера:
1. API-proxy — проксирующий балансировщик, принимающий REST-запросы пользователя, конвертирующий их в gRPC и направляющий в микросервис gRPC-backend.
1. gRPC-backend — нормализатор, принимающий gRPC-запросы от API-proxy и направляющий в микросервис Triton-backend.
1. Triton-backend — микросервис, обслуживающий запросы непосредственно к модели.

По умолчанию микросервисы работают на следующих сетевых TCP-портах:
* API-proxy: 8080 — REST-запросы
* GRPC-backend: 17004 — gRPC-запросы
* Triton-backend:
  * 8001 — gRPC-запросы
  * 8082 — метрики мониторинга в формате Prometheus

Номер любого из вышеперечисленных портов может быть переопределен.

## Модели {#models}

Помимо Docker-контейнеров компонентов в составе {{ cloudml-name }} поставляются конфигурационные файлы моделей в формате TRT. В данном примере файлы модели {{ gpt-pro }} размещены в директории ``./models/yagpt-pro`. В ходе развертывания она должна быть смонтирована внутрь микросервиса Triton-backend.

## Управление {#management}

Все параметры конфигурации рассматриваемой инсталляции {{ cloudml-name }} сосредоточены в двух файлах: `.env` и `docker-compose.yaml`.

Содержимое файла, описывающего схему запуска {{ cloudml-name }} посредством утилиты `docker-compose`:

```yaml
services:
  api-proxy:
    depends_on:
      - grpc-backend
    container_name: api-proxy
    network_mode: host
    image: cr.yandex/.../services-proxy-foundation-models:0.240
    command:
      - "/bin/bash"
      - "-c"
      - "/root/server -config /etc/yandex/services_proxy/config.yaml -gateway-port 8080"
    environment:
      - TZ=UTC
      - CLOUD_INSTALLATION=0
    cap_add:
      - NET_BIND_SERVICE
    restart: always

  grpc-backend:
    depends_on:
      - triton-backend
    container_name: grpc-backend
    network_mode: host
    image: cr.yandex/.../grpc-backend:yagpt
    environment:
      - TZ=UTC
      - GRPC_NUM_CQS=64
      - GRPC_MIN_POLLERS=64
    restart: always

  triton-backend:
    container_name: triton-backend
    image: cr.yandex/.../triton-backend:yagpt-pro
    network_mode: host
    privileged: true
    environment:
      - TZ=UTC
      - MODEL_NAME=yagpt-pro
      - WORLD_SIZE=1
      - TRTLLM_NGRAM_PENALTY=true
      - CUDA_VISIBLE_DEVICES=0
      - NVIDIA_VISIBLE_DEVICES=0
      - NVIDIA_DRIVER_CAPABILITIES=compute,utility
    volumes:
      - ./models/yagpt-pro:/opt/yagpt-pro:ro
    shm_size: 2gb
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              device_ids: ["0"]
              capabilities: [gpu]
    restart: always
```

Схема запускается и останавливается командами `docker-compose up -d` и `docker-compose down`.

## Функциональное тестирование {#test}

### Отправка произвольного REST-запроса {#rest-request}


```bash
time curl \
  --http1.0 \
  --request POST \
  "http://<server>:8080/foundationModels/v1/completion" \
  --header "Content-Type: application/json; charset=utf-8" \
  --header "Authorization: Bearer 0" \
  --data @- <<'EOF'
{
  "modelUri": "gpt://0/general",
  "completionOptions": {
    "stream": false,
    "temperature": 0.1,
    "maxTokens": "1000"
  },
  "messages": [
    {
      "role": "system",
      "text": "Translate text"
    },
    {
      "role": "user",
      "text": "To be, or not to be: that is the question."
    }
  ]
}
EOF
```

Результат: 

```text
{"result":{"alternatives":[{"message":{"role":"assistant","text":"Быть или не быть — вот в чём вопрос."},"status":"ALTERNATIVE_STATUS_FINAL"}],"usage":{"inputTextTokens":"26","completionTokens":"11","totalTokens":"37"},"modelVersion":"07.03.2024"}}
```
