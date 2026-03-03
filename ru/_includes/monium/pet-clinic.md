В этом примере вы установите приложение [Spring PetClinic](https://github.com/spring-projects/spring-petclinic) и настроите отправку телеметрии в {{ monium-name }}.

{% list tabs group=instructions %}

- Ваша инфраструктура {#user-infrastructure}

  1. Установите [Git](https://git-scm.com/install/) и [Java](https://jdk.java.net/), подходящие для вашей ОС. Например:

     ```bash
     sudo apt update
     sudo apt install -y git openjdk-17-jdk
     ```

  1. Скачайте и установите [OTel Collector](https://github.com/open-telemetry/opentelemetry-collector-releases/releases), подходящий для вашей ОС. Например:

     ```bash
     wget https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/v144.0/otelcol-linux_amd64.tar.gz
     tar xvf otelcol-linux_amd64.tar.gz
     ```

  1. Установите переменные окружения:

     ```bash
     export MONIUM_PROJECT=folder__<идентификатор_каталога>
     export MONIUM_API_KEY=<api_ключ>
     ```

  1. Создайте файл `otel-collector.yaml` и скопируйте в него содержимое:

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
  
  1. Запустите OTel Collector:

     ```bash
     ./otelcol-linux_amd64 --config otel-collector.yaml
     ```
     
     Collector начнет слушать порты `4317` (gRPC) и `4318` (HTTP).

  1. Скачайте и соберите Spring PetClinic:

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
  
  1. Запустите приложение с Java-агентом, который будет передавать телеметрию в OTel Collector:

     ```bash
     OTEL_SERVICE_NAME=spring-petclinic \
     OTEL_EXPORTER_OTLP_METRICS_TEMPORALITY_PREFERENCE="delta" \
     java -javaagent:./opentelemetry-javaagent.jar -jar target/*.jar
     ```

  1. Откройте сайт Spring PetClinic `http://localhost:8080` и выполняйте в нем действия пользователей.

{% endlist %}