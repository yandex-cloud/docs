# Как начать работать с {{ monium-name }}

{{ monium-name }} — платформа для сбора [метрик](./metrics/overview.md), [логов](./logs/quickstart.md) и [трейсов](./traces/index.md) из {{ yandex-cloud }}, других облаков или вашей инфраструктуры.

Эта инструкция поможет передать телеметрию из вашего или демонстрационного приложения через [OTel Collector](https://opentelemetry.io/docs/) и просмотреть ее в {{ monium-name }}. 

Чтобы начать работу с телеметрией приложения:

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте сервисный аккаунт и API-ключ](#create-ca-key).
1. [Настройте приложение](#setup-app).
1. [Просмотрите данные в {{ monium-name }}](#view-telemetry).

## Подготовьте облако к работе {#before-begin}

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include [before-you-begin](../_includes/monium/before-you-begin.md) %}

{% endlist %}

## Создайте сервисный аккаунт и API-ключ {#create-ca-key}

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include [create-ca-api-key](../_includes/monium/create-ca-api-key.md) %}

{% endlist %}


## Настройте приложение {#setup-app}

В {{ monium-name }} телеметрия организована в иерархии «проект → кластер → сервис». Данные для каждой пары «сервис-кластер» распределяются по отдельным шардам.

Способ настройки вашего приложения зависит от того, настроена в нем телеметрия или не настроена. Если телеметрия в приложении уже настроена, [задайте параметры подключения к {{ monium-name }}](#monium-connect). Если телеметрия еще не настроена или если у вас нет приложения, [выполните полную настройку](#otel-settings).

### Укажите параметры подключения к {{ monium-name }}, если телеметрия в вашем приложении уже настроена {#monium-connect}

Если у вас есть приложение и в нем ранее уже была настроена отправка телеметрии, укажите параметры, необходимые для подключения к {{ monium-name }}:

* Авторизация — [API-ключ](#create-ca-key).
* Эндпоинт — `{{ api-host-monium }}:443`.
* В заголовке: параметр `x-monium-project=folder__<идентификатор_каталога>`.
* В атрибутах ресурса `OTEL_RESOURCE_ATTRIBUTES`: `cluster` или `deployment.name` и `service` или `service.name`.

{% cut "Приоритет атрибутов при записи данных" %}

{% include [shard-distribution](../_includes/monium/shard-distribution.md) %}

{% endcut %}

### Настройте передачу телеметрии из приложения {#otel-settings}

Если у вас есть собственное приложение, но отправка телеметрии в нем еще не была настроена, выполните необходимые настройки. Если у вас нет готового приложения для тестирования, воспользуйтесь демонстрационным приложением.

{% list tabs group=instructions %}

- Собственное приложение {#own-app}

  1. Установите переменные окружения:
     
     * `MONIUM_PROJECT` — имя проекта {{ monium-name }}.

       По умолчанию при создании облака и каталога создаются два проекта: `cloud__<идентификатор_облака>` и `folder__<идентификатор_каталога>`. Также можно [создать другие проекты](collector/project.md#project-create).
     
       Для тестирования работы с {{ monium-name }} можно указать проект каталога, например, `folder__{{ folder-id-example }}`.
       
       При вводе вручную учитывайте, что после `folder` следуют два нижних подчеркивания.
     
     
     * `MONIUM_API_KEY` — API-ключ.
  
  1. Настройте отправку телеметрии из приложения в формате OTLP:
     
     * Установите агента для [автоинструментации](https://opentelemetry.io/docs/concepts/instrumentation/#automatic-instrumentation), который автоматически собирает часть телеметрии и передает в OTLP.
     * Добавьте [OpenTelemetry SDK](https://opentelemetry.io/docs/languages/) в ваше приложение.

  1. [Установите](https://opentelemetry.io/docs/collector/installation/) OTel Collector.

     Данные можно отправлять в {{ monium-name }} без агента, напрямую из OpenTelemetry SDK.

  1. В файле [конфигурации](https://opentelemetry.io/docs/collector/configuration/) `otel-collector.yaml` настройте передачу данных в {{ monium-name }}.
  
        Пример минимальной конфигурации `otel-collector.yaml`:

        ```yaml
        receivers:       
          otlp:          # Тип приемника — OTLP
            protocols:   # Протоколы, которые слушает Collector
              grpc:      # gRPC, порт 4317 по умолчанию
              http:      # HTTP, порт 4318 по умолчанию

        processors:
          cumulativetodelta:
          batch:

        exporters:       # Подключение к {{ monium-name }}
          otlp/monium:
            compression: zstd
            endpoint: {{ api-host-monium }}:443
            headers:
              Authorization: "Api-Key ${env:MONIUM_API_KEY}"
              x-monium-project: "${env:MONIUM_PROJECT}"

        service:         
          pipelines:
            metrics:                 # Передача метрик
              receivers: [ otlp ]
              processors: [ batch, cumulativetodelta ]
              exporters: [ otlp/monium ]
            traces:                  # Передача трейсов
              receivers: [ otlp ]
              processors: [ batch ]
              exporters: [ otlp/monium ]
            logs:                    # Передача логов
              receivers: [ otlp ]
              processors: [ batch ]
              exporters: [ otlp/monium ]
        ```

  1. Установите переменные окружения для распределения данных по шардам в {{ monium-name }}:
     * `OTEL_SERVICE_NAME` — имя вашего приложения или сервиса.
     * (Опционально) `OTEL_RESOURCE_ATTRIBUTES="cluster=my-cluster"` — имя инсталляции, в которой работает приложение (например, боевое и тестовое окружение). По умолчанию `cluster=default`.
  
  1. Запустите приложение и начните отправлять телеметрию.

- Демонстрационное приложение {#demo-app}

  {% include [pet-clinic-intro](../_includes/monium/pet-clinic-intro.md) %}

  {% include [pet-clinic](../_includes/monium/pet-clinic.md) %}

{% endlist %}

После завершения настройки приложения [просмотрите телеметрию в {{ monium-name }}](#view-telemetry).

## Просмотрите данные в {{ monium-name }} {#view-telemetry}

{% include [view-telemetry](../_includes/monium/view-telemetry.md) %}

{% include [data-lag](../_includes/monium/data-lag.md) %}

Чтобы использовать полученные данные, вы можете создавать [дашборды](operations/dashboard/create.md) и [алерты](operations/alert/create-alert.md).

#### См. также {#see-also}

* [Начало работы с метриками](metrics/quickstart.md)
* [Начало работы с логами](logs/quickstart.md)
* [Начало работы с трейсами](traces/index.md)
* [Создание дашборда](operations/dashboard/create.md)
* [Создание алерта](operations/alert/create-alert.md)
* [Способы поставки телеметрии](collector/index.md)
