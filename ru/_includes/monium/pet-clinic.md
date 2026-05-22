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
1. Задайте переменные окружения, содержащие данные для аутентификации агента в {{ monium-name }}:

    ```bash
    export MONIUM_PROJECT=folder__<идентификатор_каталога>
    export MONIUM_API_KEY=<api_ключ>
    ```

    Где:

    * `<идентификатор_каталога>` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором будет расположен [проект](../../monium/concepts/glossary.md#project) {{ monium-name }}.
    * `<api_ключ>` — [API-ключ](../../iam/concepts/authorization/api-key.md) сервисного аккаунта.

        [Сервисному аккаунту](../../iam/concepts/users/service-accounts.md) должна быть назначена [роль](../../monium/security/index.md#monium-telemetry-writer) `monium.telemetry.writer` или более гранулярные роли для записи метрик, логов или трейсов. Для API-ключа должна быть выбрана [область действия](../../iam/concepts/authorization/api-key.md#scoped-api-keys) `yc.monium.telemetry.write` или более узкие области действия для записи метрик, логов или трейсов.
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
        endpoint: {{ api-host-monium }}:443
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
1. Запустите агент [OTel Collector](../../monium/collector/opentelemetry.md):

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
