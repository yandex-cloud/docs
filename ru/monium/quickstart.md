# Как начать работать с {{ monium-name }}

{{ monium-name }} — платформа для сбора метрик, логов и трейсов из {{ yandex-cloud }}, других облаков или вашей инфраструктуры.

Эта инструкция поможет передать телеметрию из вашего или демонстрационного приложения через [OTel Collector](https://opentelemetry.io/docs/) и просмотреть ее в {{ monium-name }}. 

Чтобы начать работу с телеметрией ресурсов {{ yandex-cloud }}, перейдите в разделы:
* [Метрики ресурсов {{ yandex-cloud }}](metrics/quickstart.md).
* [Логи ресурсов {{ yandex-cloud }}](logs/quickstart-resources.md).

Чтобы начать работу с телеметрией приложения:

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте сервисный аккаунт и API-ключ](#create-ca-key).
1. Настройте передачу телеметрии из [вашего приложения](#otel-settings) или [демо-приложения](#example-app).

    Если у вас уже настроена отправка телеметрии в формате OTLP, укажите [параметры подключения к {{ monium-name }}](#monium-connect).

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


## Настройте передачу телеметрии из вашего приложения {#otel-settings}

Если у вас нет готового приложения, воспользуйтесь [демонстрационным](#example-app).

В {{ monium-name }} телеметрия организована в иерархии «проект → кластер → сервис». Данные для каждой пары «сервис-кластер» распределяются по отдельным шардам.

{% list tabs group=instructions %}

- Ваша инфраструктура {#user-infrastructure}

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

{% endlist %}

## Укажите параметры подключения к {{ monium-name }}, если телеметрия уже настроена {#monium-connect}

Если в вашем приложении уже была настроена отправка телеметрии, укажите параметры:

* Авторизация — [API-ключ](#create-ca-key).
* Эндпоинт — `{{ api-host-monium }}:443`.
* В заголовке: параметр `x-monium-project=folder__<идентификатор_каталога>`.
* В атрибутах ресурса `OTEL_RESOURCE_ATTRIBUTES`: `cluster` или `deployment.name` и `service` или `service.name`.

{% cut "Приоритет атрибутов при записи данных" %}

{% include [shard-distribution](../_includes/monium/shard-distribution.md) %}

{% endcut %}

## Просмотрите данные в {{ monium-name }} {#view-telemetry}

{% include [view-telemetry](../_includes/monium/view-telemetry.md) %}

{% include [data-lag](../_includes/monium/data-lag.md) %}

Чтобы использовать полученные данные, вы можете создавать [дашборды](operations/dashboard/create.md) и [алерты](operations/alert/create-alert.md).

## Пример настройки демонстрационного приложения {#example-app}

{% include [pet-clinic](../_includes/monium/pet-clinic.md) %}

После настройки [просмотрите телеметрию в {{ monium-name }}](#view-telemetry).

#### См. также {#see-also}

* [Начало работы с метриками](metrics/quickstart.md)
* [Начало работы с логами](logs/quickstart.md)
* [Начало работы с трейсами](traces/index.md)
* [Создание дашборда](operations/dashboard/create.md)
* [Создание алерта](operations/alert/create-alert.md)
* [Способы поставки телеметрии](collector/index.md)