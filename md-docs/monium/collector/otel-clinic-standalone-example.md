# Настройка демо-приложения Java и сбор телеметрии

## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


## Настройка демо-приложения и передачи телеметрии {#example-app}

В этом примере вы запустите приложение [Spring PetClinic](https://github.com/spring-projects/spring-petclinic) и настроите отправку телеметрии в Monium.
Вы сможете собирать логи, трейсы и метрики о работе механизмов JVM (загрузка классов, потребление CPU, сборка мусора), пула соединений к базе данных и HTTP-эндпоинтов без изменения кода приложения.

{% list tabs group=instructions %}

- Ваша инфраструктура {#user-infrastructure}

  1. Установите [Git](https://git-scm.com/install/) и [Java](https://jdk.java.net/), подходящие для вашей ОС. Например:

     ```bash
     sudo apt update
     sudo apt install -y git openjdk-25-jdk
     ```

  1. Установите переменные окружения для подключения к Monium:

     ```bash
     export MONIUM_API_KEY=<api_ключ>
     export MONIUM_PROJECT=<идентификатор_проекта>
     export MONIUM_CLUSTER=<имя_кластера> # опционально
     ```

  1. Склонируйте и соберите Spring PetClinic:

     ```bash
     git clone https://github.com/spring-projects/spring-petclinic
     cd spring-petclinic
     ./mvnw -DskipTests package
     ```

  1. Скачайте OpenTelemetry Java-агент:

     ```bash
     curl -L -o opentelemetry-javaagent.jar \
     https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/latest/download/opentelemetry-javaagent.jar
     ```

  1. Настройте параметры экспорта телеметрии:

     ```bash
     export OTEL_EXPORTER_OTLP_PROTOCOL="grpc"
     export OTEL_EXPORTER_OTLP_ENDPOINT="https://ingest.monium.yandex.cloud:443"
     export OTEL_EXPORTER_OTLP_HEADERS="x-monium-project=${MONIUM_PROJECT},x-monium-cluster=${MONIUM_CLUSTER},authorization=Api-Key ${MONIUM_API_KEY}"
     export OTEL_SERVICE_NAME=spring-petclinic
     ```

  1. (Опционально) Включите дельта-темпоральность для метрик:

     ```bash
     export OTEL_EXPORTER_OTLP_METRICS_TEMPORALITY_PREFERENCE="delta"
     ```

  1. Запустите приложение с Java-агентом:

     ```bash
     java -javaagent:./opentelemetry-javaagent.jar -jar target/*.jar
     ```

  1. Откройте веб-приложение Spring PetClinic по адресу `http://localhost:8080` и выполняйте в нем действия пользователей. Метрики создаются при первом вызове соответствующих функций.

{% endlist %}
  
## Просмотр телеметрии в Monium {#view-telemetry}

{% list tabs group=instructions %}

- Интерфейс Monium {#console}

  1. На главной странице [Monium](https://monium.yandex.cloud) слева выберите раздел с нужным типом данных:

      {% list tabs group=monium_telemetry_type %}

      - Метрики {#metrics}

        1. Вверху на шкале времени задайте временной промежуток поиска данных.
        1. В строке поиска введите запрос для поиска данных телеметрии:
        
            * `project = <идентификатор_проекта>` — выберите проект, заданный в параметре `x-monium-project` в конфигурации передачи телеметрии приложения.
            
                Это может быть проект облака (`cloud__<идентификатор_облака>`), каталога (`folder__<идентификатор_каталога>`) или другой [проект](project.md#project-create).
            * `cluster = <имя_кластера>` — выберите имя инсталляции, в которой запущено ваше приложение. Если кластер не задан, то по умолчанию `cluster = default`.
            * `service = <имя_сервиса>` — имя вашего приложения или сервиса. Может передаваться в переменной окружения `OTEL_SERVICE_NAME`.
            
              Если нужных меток нет в подсказках, их можно ввести вручную. Но, скорее всего, в систему не поступали данные с такими метками. Решение возможных проблем смотрите в разделе [Устранение неполадок при поставке данных](troubleshooting.md).
        
        1. Нажмите **Выполнить запрос** или **Выполнить**.
        
            На странице будут отображены данные, соответствующие запросу.

        ![image](../../_assets/monium/petclinic-metrics.png)

        Подробнее о [работе с метриками](../metrics/metric-explorer.md).

      - Логи {#logs}

        1. Вверху на шкале времени задайте временной промежуток поиска данных.
        1. В строке поиска введите запрос для поиска данных телеметрии:
        
            * `project = <идентификатор_проекта>` — выберите проект, заданный в параметре `x-monium-project` в конфигурации передачи телеметрии приложения.
            
                Это может быть проект облака (`cloud__<идентификатор_облака>`), каталога (`folder__<идентификатор_каталога>`) или другой [проект](project.md#project-create).
            * `cluster = <имя_кластера>` — выберите имя инсталляции, в которой запущено ваше приложение. Если кластер не задан, то по умолчанию `cluster = default`.
            * `service = <имя_сервиса>` — имя вашего приложения или сервиса. Может передаваться в переменной окружения `OTEL_SERVICE_NAME`.
            
              Если нужных меток нет в подсказках, их можно ввести вручную. Но, скорее всего, в систему не поступали данные с такими метками. Решение возможных проблем смотрите в разделе [Устранение неполадок при поставке данных](troubleshooting.md).
        
        1. Нажмите **Выполнить запрос** или **Выполнить**.
        
            На странице будут отображены данные, соответствующие запросу.

        ![image](../../_assets/monium/petclinic-logs.png)

        Подробнее о [работе с логами](../logs/logs-explorer.md).

      - Трейсы {#traces}

        1. Вверху на шкале времени задайте временной промежуток поиска данных.
        1. В строке поиска введите запрос для поиска данных телеметрии:
        
            * `project = <идентификатор_проекта>` — выберите проект, заданный в параметре `x-monium-project` в конфигурации передачи телеметрии приложения.
            
                Это может быть проект облака (`cloud__<идентификатор_облака>`), каталога (`folder__<идентификатор_каталога>`) или другой [проект](project.md#project-create).
            * `cluster = <имя_кластера>` — выберите имя инсталляции, в которой запущено ваше приложение. Если кластер не задан, то по умолчанию `cluster = default`.
            * `service = <имя_сервиса>` — имя вашего приложения или сервиса. Может передаваться в переменной окружения `OTEL_SERVICE_NAME`.
            
              Если нужных меток нет в подсказках, их можно ввести вручную. Но, скорее всего, в систему не поступали данные с такими метками. Решение возможных проблем смотрите в разделе [Устранение неполадок при поставке данных](troubleshooting.md).
        
        1. Нажмите **Выполнить запрос** или **Выполнить**.
        
            На странице будут отображены данные, соответствующие запросу.

        ![image](../../_assets/monium/petclinic-traces.png)

        Подробнее о [работе с трейсами](../traces/operations/traces-explorer.md).

      {% endlist %}

  1. Чтобы посмотреть информацию о шарде с данными, слева выберите **Шарды** и затем шард с названием вашего сервиса.

{% endlist %}