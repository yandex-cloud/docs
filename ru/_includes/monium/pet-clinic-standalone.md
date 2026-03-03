В этом примере вы запустите приложение [Spring PetClinic](https://github.com/spring-projects/spring-petclinic) и настроите отправку телеметрии в {{ monium-name }}.
Вы сможете собирать логи, трейсы и метрики о работе механизмов JVM (загрузка классов, потребление CPU, сборка мусора), пула соединений к базе данных и HTTP-эндпоинтов без изменения кода приложения.

{% list tabs group=instructions %}

- Ваша инфраструктура {#user-infrastructure}

  1. Установите [Git](https://git-scm.com/install/) и [Java](https://jdk.java.net/), подходящие для вашей ОС. Например:

     ```bash
     sudo apt update
     sudo apt install -y git openjdk-25-jdk
     ```

  1. Установите переменные окружения для подключения к {{ monium-name }}:

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
     export OTEL_EXPORTER_OTLP_ENDPOINT="https://{{ api-host-monium }}:443"
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