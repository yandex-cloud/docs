# Как начать работать с {{ monium-name }}

{{ monium-name }} — платформа для сбора [метрик](metrics/overview.md), [логов](logs/quickstart.md) и [трейсов](traces/index.md) из {{ yandex-cloud }}, других облаков или вашей инфраструктуры.

Эта инструкция поможет передать телеметрию из вашего или демонстрационного приложения через [OTel Collector](https://opentelemetry.io/docs/) и просмотреть ее в {{ monium-name }}. 

Чтобы начать работу с телеметрией приложения:

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте сервисный аккаунт и API-ключ](#create-ca-key).
1. [Настройте приложение](#setup-app).
1. [Просмотрите данные в {{ monium-name }}](#view-telemetry).

## Подготовьте облако к работе {#before-begin}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Войдите в [консоль управления]({{ link-console-main }}) или зарегистрируйтесь. Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
  1. На странице [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../billing/concepts/billing-account.md) и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md#create_billing_account).
  
      Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).
  
      [Подробнее об облаках и каталогах](../resource-manager/concepts/resources-hierarchy.md).

{% endlist %}

## Создайте сервисный аккаунт и API-ключ {#create-ca-key}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором будет храниться телеметрия.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Введите имя сервисного аккаунта, например `monium-sa`.
  1. Нажмите кнопку ![image](../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и добавьте [роль](security/index.md#monium-telemetry-writer) `monium.telemetry.writer`.
  
      Если вы планируете передавать только некоторые типы данных, вместо `monium.telemetry.writer` выберите одну или несколько ролей с более узкими наборами разрешений: `monium.metrics.writer`, `monium.logs.writer`, `monium.traces.writer`.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.
  1. В открывшемся списке выберите созданный сервисный аккаунт.
  1. На панели сверху нажмите кнопку ![image](../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** и выберите пункт **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_api_key }}**.
  1. Выберите **{{ ui-key.yacloud.iam.folder.service-account.overview.field_key-scope }}** — `yc.monium.telemetry.write`.
  
      Если вы планируете передавать только некоторые типы данных, вместо `yc.monium.telemetry.write` выберите одну или несколько более узких [областей действия](../iam/concepts/authorization/api-key.md#scoped-api-keys): `yc.monium.metrics.write`, `yc.monium.logs.write`, `yc.monium.traces.write`.
  1. (Опционально) Укажите **{{ ui-key.yacloud.iam.folder.service-account.overview.field_key-expires-at }}** создаваемого API-ключа.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
  1. Сохраните полученный секретный ключ — он понадобится на следующем шаге.
  
      После закрытия окна повторно посмотреть секретный ключ будет нельзя.

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

Все метрики, логи, трейсы в {{ monium-name }} имеют обязательные метки `project`, `cluster` и `service`. Эти метки формируют ключ шарда.

При поставке телеметрии в формате OpenTelemetry значения ключевых атрибутов назначаются по следующим приоритетам:

* Самый высокий приоритет у значений, заданных через HTTP- или gRPC-заголовки.
* Затем у значений, заданных в ресурсных атрибутах тела запроса с ключами `cluster`, `service`.
* Затем у значений, заданных в ресурсных атрибутах, рекомендуемых семантической конвенцией OpenTelemetry.
* Если перечисленных значений не задано, проставляется значение по умолчанию.

Имя проекта проставляется только из заголовка. Алгоритм определения ключа шарда представлен в таблице ниже.

#|
|| заголовок | собственный атрибут ресурса | стандартный атрибут ресурса | значение по умолчанию ||
|| `x-monium-project` | — | — | — ||
|| `x-monium-cluster` | `cluster` | `deployment.name` | `default` ||
|| `x-monium-service` | `service` | `service.name`, `k8s.deployment.name`, `k8s.namespace.name` | `default` ||
|#

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

  В этом примере вы установите демонстрационное приложение [Spring PetClinic](https://github.com/spring-projects/spring-petclinic) и настроите отправку телеметрии в {{ monium-name }}. 
  
  Для установки демонстрационного приложения вы можете временно создать [виртуальную машину](../compute/concepts/vm.md) {{ compute-full-name }}. Подробнее о создании подходящей виртуальной машины читайте в разделе [{#T}](../compute/operations/vm-create/create-linux-vm.md).
  
  Ниже приведены примеры команд для установки демонстрационного приложения в ОС Linux Ubuntu.
  
  {% note warning %}
  
  Для корректной работы агента `OTel Collector` на ВМ или сервере должен быть разрешен _исходящий трафик_ на TCP-порте `443`.
  
  Для корректной работы демонстрационного приложения на ВМ или сервере должен быть разрешен _входящий трафик_ на TCP-портах `4317`, `4318` и `8080`.
  
  При использовании виртуальной машины {{ compute-name }} [создайте](../vpc/operations/security-group-create.md) и [привяжите](../compute/operations/vm-control/vm-change-security-groups-set.md) к ней [группу безопасности](../vpc/concepts/security-groups.md), разрешающую указанные типы трафика.
  
  {% endnote %}

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
  
      * `<идентификатор_каталога>` — [идентификатор каталога](../resource-manager/operations/folder/get-id.md), в котором будет расположен [проект](concepts/glossary.md#project) {{ monium-name }}.
      * `<api_ключ>` — [API-ключ](../iam/concepts/authorization/api-key.md) сервисного аккаунта.
  
          [Сервисному аккаунту](../iam/concepts/users/service-accounts.md) должна быть назначена [роль](security/index.md#monium-telemetry-writer) `monium.telemetry.writer` или более гранулярные роли для записи метрик, логов или трейсов. Для API-ключа должна быть выбрана [область действия](../iam/concepts/authorization/api-key.md#scoped-api-keys) `yc.monium.telemetry.write` или более узкие области действия для записи метрик, логов или трейсов.
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
  1. Запустите агент [OTel Collector](collector/opentelemetry.md):
  
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

После завершения настройки приложения [просмотрите телеметрию в {{ monium-name }}](#view-telemetry).

## Просмотрите данные в {{ monium-name }} {#view-telemetry}

{% list tabs group=instructions %}

- Интерфейс {{ monium-name }} {#console}

  1. На главной странице [{{ monium-name }}]({{ link-monium }}) слева выберите раздел с нужным типом данных:

      {% list tabs group=monium_telemetry_type %}

      - {{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }} {#metrics}

        1. Вверху на шкале времени задайте временной промежуток поиска данных.
        1. В строке поиска введите запрос для поиска данных телеметрии:
        
            * `project = <идентификатор_проекта>` — выберите проект, заданный в параметре `x-monium-project` в конфигурации передачи телеметрии приложения.
            
                Это может быть проект облака (`cloud__<идентификатор_облака>`), каталога (`folder__<идентификатор_каталога>`) или другой [проект](collector/project.md#project-create).
            * `cluster = <имя_кластера>` — выберите имя инсталляции, в которой запущено ваше приложение. Если кластер не задан, то по умолчанию `cluster = default`.
            * `service = <имя_сервиса>` — имя вашего приложения или сервиса. Может передаваться в переменной окружения `OTEL_SERVICE_NAME`.
            
              Если нужных меток нет в подсказках, их можно ввести вручную. Но, скорее всего, в систему не поступали данные с такими метками. Решение возможных проблем см. в разделе [{#T}](collector/troubleshooting.md).
        
        1. Нажмите **{{ ui-key.yacloud_monitoring.querystring.action.execute-query }}** или **{{ ui-key.yacloud_monitoring.querystring.button.apply-and-parse }}**.
        
            На странице будут отображены данные, соответствующие запросу.

        ![image](../_assets/monium/petclinic-metrics.png)

        Подробнее о [работе с метриками](metrics/metric-explorer.md).

      - {{ ui-key.yacloud_monitoring.aside-navigation.menu-item.logs.title }} {#logs}

        1. Вверху на шкале времени задайте временной промежуток поиска данных.
        1. В строке поиска введите запрос для поиска данных телеметрии:
        
            * `project = <идентификатор_проекта>` — выберите проект, заданный в параметре `x-monium-project` в конфигурации передачи телеметрии приложения.
            
                Это может быть проект облака (`cloud__<идентификатор_облака>`), каталога (`folder__<идентификатор_каталога>`) или другой [проект](collector/project.md#project-create).
            * `cluster = <имя_кластера>` — выберите имя инсталляции, в которой запущено ваше приложение. Если кластер не задан, то по умолчанию `cluster = default`.
            * `service = <имя_сервиса>` — имя вашего приложения или сервиса. Может передаваться в переменной окружения `OTEL_SERVICE_NAME`.
            
              Если нужных меток нет в подсказках, их можно ввести вручную. Но, скорее всего, в систему не поступали данные с такими метками. Решение возможных проблем см. в разделе [{#T}](collector/troubleshooting.md).
        
        1. Нажмите **{{ ui-key.yacloud_monitoring.querystring.action.execute-query }}** или **{{ ui-key.yacloud_monitoring.querystring.button.apply-and-parse }}**.
        
            На странице будут отображены данные, соответствующие запросу.

        ![image](../_assets/monium/petclinic-logs.png)

        Подробнее о [работе с логами](logs/logs-explorer.md).

      - {{ ui-key.yacloud_monitoring.aside-navigation.menu-item.traces.title }} {#traces}

        1. Вверху на шкале времени задайте временной промежуток поиска данных.
        1. В строке поиска введите запрос для поиска данных телеметрии:
        
            * `project = <идентификатор_проекта>` — выберите проект, заданный в параметре `x-monium-project` в конфигурации передачи телеметрии приложения.
            
                Это может быть проект облака (`cloud__<идентификатор_облака>`), каталога (`folder__<идентификатор_каталога>`) или другой [проект](collector/project.md#project-create).
            * `cluster = <имя_кластера>` — выберите имя инсталляции, в которой запущено ваше приложение. Если кластер не задан, то по умолчанию `cluster = default`.
            * `service = <имя_сервиса>` — имя вашего приложения или сервиса. Может передаваться в переменной окружения `OTEL_SERVICE_NAME`.
            
              Если нужных меток нет в подсказках, их можно ввести вручную. Но, скорее всего, в систему не поступали данные с такими метками. Решение возможных проблем см. в разделе [{#T}](collector/troubleshooting.md).
        
        1. Нажмите **{{ ui-key.yacloud_monitoring.querystring.action.execute-query }}** или **{{ ui-key.yacloud_monitoring.querystring.button.apply-and-parse }}**.
        
            На странице будут отображены данные, соответствующие запросу.

        ![image](../_assets/monium/petclinic-traces.png)

        Подробнее о [работе с трейсами](traces/operations/traces-explorer.md).

      {% endlist %}

  1. Чтобы посмотреть информацию о шарде с данными, слева выберите **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.shards.title }}** и затем шард с названием вашего сервиса.

{% endlist %}

{% note info %}

Учитывайте, что данные в {{ monium-name }} появляются не сразу, а с задержкой, поскольку Otel Collector начинает отправку данных через 60 секунд.

{% endnote %}

Чтобы использовать полученные данные, вы можете создавать [дашборды](operations/dashboard/create.md) и [алерты](operations/alert/create-alert.md).

#### См. также {#see-also}

* [Начало работы с метриками](metrics/quickstart.md)
* [Начало работы с логами](logs/quickstart.md)
* [Начало работы с трейсами](traces/index.md)
* [Создание дашборда](operations/dashboard/create.md)
* [Создание алерта](operations/alert/create-alert.md)
* [Способы поставки телеметрии](collector/index.md)