[Документация Yandex Cloud](../../index.md) > [Monium](../index.md) > [Поставка данных](index.md) > Otel Collector > Пример для демо-приложения Java с использованием агента

# Настройка демо-приложения Java и сбор телеметрии

## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


## Настройка демо-приложения и передачи телеметрии {#example-app}

В этом примере вы установите демонстрационное приложение [Spring PetClinic](https://github.com/spring-projects/spring-petclinic) и настроите отправку телеметрии в Monium. 

Для установки демонстрационного приложения вы можете временно создать [виртуальную машину](../../compute/concepts/vm.md) Yandex Compute Cloud. Подробнее о создании подходящей виртуальной машины читайте в разделе [Создать виртуальную машину из публичного образа Linux](../../compute/operations/vm-create/create-linux-vm.md).

Ниже приведены примеры команд для установки демонстрационного приложения в ОС Linux Ubuntu.

{% note warning %}

Для корректной работы агента `OTel Collector` на ВМ или сервере должен быть разрешен _исходящий трафик_ на TCP-порте `443`.

Для корректной работы демонстрационного приложения на ВМ или сервере должен быть разрешен _входящий трафик_ на TCP-портах `4317`, `4318` и `8080`.

При использовании виртуальной машины Compute Cloud [создайте](../../vpc/operations/security-group-create.md) и [привяжите](../../compute/operations/vm-control/vm-change-security-groups-set.md) к ней [группу безопасности](../../vpc/concepts/security-groups.md), разрешающую указанные типы трафика.

{% endnote %}

{% list tabs group=instructions %}

- Ваша инфраструктура {#user-infrastructure}

  1. Установите [Git](https://git-scm.com/install/) и [Java](https://jdk.java.net/), подходящие для вашей ОС. Например:
  
      ```bash
      sudo apt update
      sudo apt install -y git openjdk-17-jdk
      ```
  1. Скачайте и установите агент [OTel Collector](https://github.com/open-telemetry/opentelemetry-collector-releases/releases), подходящий для вашей ОС. Например:
  
      ```bash
      wget https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/v0.144.0/otelcol_0.144.0_linux_amd64.tar.gz
      tar xvf otelcol_0.144.0_linux_amd64.tar.gz
      ```
  1. Задайте переменные окружения, содержащие данные для аутентификации агента в Monium:
  
      ```bash
      export MONIUM_PROJECT=folder__<идентификатор_каталога>
      export MONIUM_API_KEY=<api_ключ>
      ```
  
      Где:
  
      * `<идентификатор_каталога>` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором будет расположен [проект](../concepts/glossary.md#project) Monium.
      * `<api_ключ>` — [API-ключ](../../iam/concepts/authorization/api-key.md) сервисного аккаунта.
  
          [Сервисному аккаунту](../../iam/concepts/users/service-accounts.md) должна быть назначена [роль](../security/index.md#monium-telemetry-writer) `monium.telemetry.writer` или более гранулярные роли для записи метрик, логов или трейсов. Для API-ключа должна быть выбрана [область действия](../../iam/concepts/authorization/api-key.md#scoped-api-keys) `yc.monium.telemetry.write` или более узкие области действия для записи метрик, логов или трейсов.
  1. Создайте файл `otel-collector.yaml` и скопируйте в него следующее содержимое:
  
      ```yaml
      receivers:
        otlp:
          protocols:
            grpc:
            http:
  
      exporters:
        otlp_grpc/monium:
          compression: zstd
          endpoint: ingest.monium.yandex.cloud:443
          headers:
            Authorization: "Api-Key ${env:MONIUM_API_KEY}"
            x-monium-project: "${env:MONIUM_PROJECT}"
          sending_queue:
            batch:
  
      service:
        pipelines:
          metrics:
            receivers: [ otlp ]
            exporters: [ otlp_grpc/monium ]
          traces:
            receivers: [ otlp ]
            exporters: [ otlp_grpc/monium ]
          logs:
            receivers: [ otlp ]
            exporters: [ otlp_grpc/monium ]
        telemetry:
          metrics:
            level: normal
            readers:
              - periodic:
                  exporter:
                    otlp:
                      protocol: http/protobuf
                      endpoint: http://localhost:4318
                  interval: 30000
                  timeout: 5000
      ```
  1. Запустите агент [OTel Collector](opentelemetry.md):
  
      ```bash
      ./otelcol --config otel-collector.yaml
      ```
  
      После запуска агент начнет слушать порты `4317` (gRPC) и `4318` (HTTP).
  1. Откройте новое окно терминала. В нем скачайте и соберите приложение `Spring PetClinic`:
  
      ```bash
      git clone https://github.com/spring-projects/spring-petclinic
      cd spring-petclinic
      ./mvnw -DskipTests package
      ```
  
      Результат:
  
      ```text
      ...
      [INFO] ------------------------------------------------------------------------
      [INFO] BUILD SUCCESS
      [INFO] ------------------------------------------------------------------------
      [INFO] Total time:  53.308 s
      [INFO] Finished at: 2026-05-05T18:56:22Z
      [INFO] ------------------------------------------------------------------------
      ```
  1. Скачайте Java-агент OpenTelemetry:
  
      ```bash
      curl -L -o opentelemetry-javaagent.jar \
      https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/latest/download/opentelemetry-javaagent.jar
      ```
  1. Запустите демонстрационное приложение с помощью Java-агента, который будет передавать телеметрию в OTel Collector:
  
      ```bash
      cd ~/spring-petclinic
      OTEL_SERVICE_NAME=spring-petclinic \
      OTEL_EXPORTER_OTLP_METRICS_TEMPORALITY_PREFERENCE="delta" \
      java -javaagent:./opentelemetry-javaagent.jar -jar target/*.jar
      ```
  
      Результат:
  
      ```text
      ...
      2026-05-05T19:00:31.981Z  INFO 3657 --- [           main] 
      o.s.s.petclinic.PetClinicApplication     : Started PetClinicApplication in 9.287 seconds (process running for 12.883)
      ```
  1. В окне браузера откройте запущенное демонстрационное приложение `Spring PetClinic`:
  
      * Если приложение установлено на локальном компьютере, адрес приложения — `http://localhost:8080`.
      * Если для установки приложения вы использовали виртуальную машину, адрес приложения — `http://<публичный_IP-адрес_ВМ>:8080`.
  
  1. В интерфейсе демонстрационного приложения выполните несколько действий от лица пользователя: откройте меню, нажмите кнопку, введите данные о новом владельце, запишитесь на прием и т.п.

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
            
              Если нужных меток нет в подсказках, их можно ввести вручную. Но, скорее всего, в систему не поступали данные с такими метками. Решение возможных проблем описано в разделе [Устранение неполадок при поставке данных](troubleshooting.md).
        
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
            
              Если нужных меток нет в подсказках, их можно ввести вручную. Но, скорее всего, в систему не поступали данные с такими метками. Решение возможных проблем описано в разделе [Устранение неполадок при поставке данных](troubleshooting.md).
        
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
            
              Если нужных меток нет в подсказках, их можно ввести вручную. Но, скорее всего, в систему не поступали данные с такими метками. Решение возможных проблем описано в разделе [Устранение неполадок при поставке данных](troubleshooting.md).
        
        1. Нажмите **Выполнить запрос** или **Выполнить**.
        
            На странице будут отображены данные, соответствующие запросу.

        ![image](../../_assets/monium/petclinic-traces.png)

        Подробнее о [работе с трейсами](../traces/operations/traces-explorer.md).

      {% endlist %}

  1. Чтобы посмотреть информацию о шарде с данными, слева выберите **Шарды** и затем шард с названием вашего сервиса.

{% endlist %}