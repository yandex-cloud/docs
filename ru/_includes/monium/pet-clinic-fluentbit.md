В этом примере вы установите приложение [Spring PetClinic](https://github.com/spring-projects/spring-petclinic) и настроите отправку телеметрии в {{ monium-name }} через Fluent Bit.

{% list tabs group=instructions %}

- Ваша инфраструктура {#user-infrastructure}

  1. Установите [Git](https://git-scm.com/install/) и [Java](https://jdk.java.net/), подходящие для вашей ОС. Например:

     ```bash
     sudo apt update
     sudo apt install -y git openjdk-17-jdk
     ```

  1. Установите [Fluent Bit](https://docs.fluentbit.io/fluent-bit/v/4.0/installation/getting-started-with-fluent-bit) версии 4.0 и выше.

  1. Установите переменные окружения:

     ```bash
     export MONIUM_PROJECT=<идентификатор_проекта>
     export MONIUM_API_KEY=<api_ключ>
     ```

  1. Создайте файл конфигурации (например, `fluent-bit.yaml`). Используйте конфигурацию раздела [Настройка Fluent Bit](../../monium/collector/fluentbit.md#configure). Пример для gRPC:

     ```yaml
     pipeline:
       inputs:
         - name: opentelemetry
           listen: 127.0.0.1
           port: 4318

       outputs:
         - name: opentelemetry
           match: "*"
           host: {{ api-host-monium }}
           port: 443
           tls: on
           compress: zstd
           grpc: on
           header:
             - Authorization Api-Key ${MONIUM_API_KEY}
             - x-monium-project ${MONIUM_PROJECT}
     ```

  1. Запустите Fluent Bit:

     ```bash
     fluent-bit -c fluent-bit.yaml
     ```

     Fluent Bit начнет принимать телеметрию по OTLP на `127.0.0.1:4318` (HTTP).

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

  1. Запустите приложение с Java-агентом. Телеметрия будет отправляться во Fluent Bit на порт 4318. Не задавайте `OTEL_EXPORTER_OTLP_METRICS_TEMPORALITY_PREFERENCE="delta"` — при передаче через Fluent Bit дельта-метрики обрабатываются некорректно.

     ```bash
     OTEL_SERVICE_NAME=spring-petclinic \
     OTEL_EXPORTER_OTLP_METRICS_TEMPORALITY_PREFERENCE="cumulative" \
     java -javaagent:./opentelemetry-javaagent.jar -jar target/*.jar
     ```

  1. Откройте приложение Spring PetClinic `http://localhost:8080` и выполняйте в нем действия пользователей.

{% endlist %}
