# Разработка функций в Functions Framework и их развертывание в {{ serverless-containers-full-name }}

[Functions Framework](https://cloud.google.com/functions/docs/functions-framework) от Google Cloud — это открытый контракт и набор реализующих его библиотек с [открытым исходным кодом](https://ru.wikipedia.org/wiki/Открытое_программное_обеспечение) на различных языках программирования. Фреймворк позволяет разрабатывать [функции](../../functions/concepts/function.md) в стиле программирования [FaaS](https://ru.wikipedia.org/wiki/Функция_как_услуга) (Function as a service), которые могут обрабатывать HTTP-запросы или [CloudEvents](https://cloudevents.io/).

Фреймворк Functions Framework позволяет создавать функции и запускать их в [контейнерах](../../serverless-containers/concepts/container.md) {{ serverless-containers-full-name }} без использования сервиса [{{ sf-full-name }}](../../functions/index.yaml). Написанные этим способом функции можно переносить между различными платформами, такими как [Cloud Run](https://cloud.google.com/run), [Cloud Run functions](https://cloud.google.com/functions), [Knative](https://knative.dev/docs/) и [{{ serverless-containers-full-name }}](../../serverless-containers/index.yaml), а также между этими платформами и вашей локальной машиной разработки.

В данном руководстве рассматривается сценарий, при котором вы локально создадите функцию с помощью фреймворка Functions Framework. Затем из этой функции вы соберете [Docker-образ](../../container-registry/concepts/docker-image.md), который загрузите в [реестр](../../container-registry/concepts/registry.md) {{ container-registry-full-name }}. Из сохраненного в реестре Docker-образа вы создадите [контейнер](../../serverless-containers/concepts/container.md) {{ serverless-containers-name }}, при вызове которого будет выполняться код вашей функции.

Предлагаемое решение позволяет:
* собирать и распространять функции как [OCI-совместимые](https://opencontainers.org/) Docker-образы, а также развертывать их на различных облачных и [on-prem-платформах](https://en.wikipedia.org/wiki/On-premises_software): [Kubernetes](https://kubernetes.io/), Cloud Run, Knative и др.
* разрабатывать, локально запускать, отлаживать и тестировать функции как обычные веб-приложения с использованием современных [IDE](https://ru.wikipedia.org/wiki/Интегрированная_среда_разработки);
* переносить ваши функции из Cloud Run functions или Knative, сохранив совместимость с этими платформами;
* создавать функции на языках [Dart](https://dart.dev/), [C++](https://ru.wikipedia.org/wiki/C%2B%2B) или [Ruby](https://www.ruby-lang.org/ru/), которые в настоящий момент не поддержаны в {{ sf-name }}.

В данном руководстве вы создадите тестовую функцию. Полный перечень поддерживаемых языков программирования см. в [репозитории](https://github.com/GoogleCloudPlatform/functions-framework?tab=readme-ov-file#languages--test-status) проекта Functions Framework на GitHub.

Чтобы развернуть функцию в {{ serverless-containers-name }}:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте сервисный аккаунт](#service-account).
1. [Создайте реестр {{ container-registry-name }}](#create-registry).
1. [Создайте функцию](#create-function).
1. [Создайте Docker-образ и загрузите его в реестр {{ container-registry-name }}](#push-docker-image).
1. [Создайте контейнер {{ serverless-containers-name }} из загруженного Docker-образа](#setup-container).
1. [Проверьте работу функции в контейнере](#run-test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки создаваемой инфраструктуры входят:

* плата за объем хранилища, объем исходящего трафика и использование сканера уязвимостей {{ container-registry-name }} (см. [тарифы {{ container-registry-full-name }}](../../container-registry/pricing.md));
* плата за использование сервиса {{ serverless-containers-name }} (см. [тарифы {{ serverless-containers-full-name }}](../../serverless-containers/pricing.md)).

### Настройте окружение {#setup-runtime}

1. Установите утилиту [cURL](https://curl.haxx.se).
1. [Установите и настройте](../../cli/quickstart.md) интерфейс {{ yandex-cloud }} CLI.
1. [Установите и настройте](../../container-registry/operations/configure-docker.md) Docker.
1. [Аутентифицируйтесь](../../container-registry/operations/authentication.md) в {{ container-registry-name }}.
1. Установите утилиту [Pack](https://buildpacks.io/docs/for-platform-operators/how-to/integrate-ci/pack/). Для этого в терминале выполните команды и дождитесь завершения процесса установки:

    ```bash
    sudo add-apt-repository ppa:cncf-buildpacks/pack-cli -y
    sudo apt install pack-cli -y
    ```

    Инструкция по установке утилиты [Pack](https://buildpacks.io/docs/for-platform-operators/how-to/integrate-ci/pack/) приведена для ОС Linux Ubuntu. Если вы используете другую операционную систему, для установки воспользуйтесь документацией к утилите Pack.

## Создайте сервисный аккаунт {#service-account}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы будете создавать инфраструктуру.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}** и в открывшемся окне:
      1. Введите имя [сервисного аккаунта](../../iam/concepts/users/service-accounts.md): `serverless-containers-sa`.
      1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и выберите [роль](../../container-registry/security/index.md#container-registry-images-puller) `container-registry.images.puller`.
      1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.


- CLI {#cli}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Создайте сервисный аккаунт `serverless-containers-sa`:

      ```bash
      yc iam service-account create \
        --name serverless-containers-sa
      ```

      Результат:

      ```text
      done (1s)
      id: aje7tnmd885t********
      folder_id: b1gt6g8ht345********
      created_at: "2025-02-14T11:09:54.376880905Z"
      name: serverless-containers-sa
      ```

      Сохраните идентификаторы сервисного аккаунта (значение поля `id`) и каталога (значение поля `folder_id`) — они понадобятся на следующем шаге.

      Подробнее о команде `yc iam service-account create` читайте в [справочнике CLI](../../cli/cli-ref/iam/cli-ref/service-account/create.md).

  1. Назначьте созданному сервисному аккаунту [роль](../../container-registry/security/index.md#container-registry-images-puller) `container-registry.images.puller` на каталог, указав сохраненные на предыдущем шаге идентификаторы каталога и сервисного аккаунта:

      ```bash
      yc resource-manager folder add-access-binding <идентификатор_каталога> \
        --role container-registry.images.puller \
        --subject serviceAccount:<идентификатор_сервисного_аккаунта>
      ```

      Результат:

      ```text
      done (2s)
      effective_deltas:
        - action: ADD
          access_binding:
           role_id: container-registry.images.puller
            subject:
              id: aje7tnmd885t********
              type: serviceAccount
      ```

      Подробнее о команде `yc resource-manager folder add-access-binding` читайте в [справочнике CLI](../../cli/cli-ref/resource-manager/cli-ref/folder/add-access-binding.md).

- API {#api}

  Чтобы создать сервисный аккаунт, воспользуйтесь методом REST API [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md).

  Чтобы назначить сервисному аккаунту роль на каталог, воспользуйтесь методом REST API [updateAccessBindings](../../resource-manager/api-ref/Folder/updateAccessBindings.md) для ресурса [Folder](../../resource-manager/api-ref/Folder/index.md) или вызовом gRPC API [FolderService/UpdateAccessBindings](../../resource-manager/api-ref/grpc/Folder/updateAccessBindings.md).

{% endlist %}

## Создайте реестр {{ container-registry-name }} {#create-registry}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы ранее создали сервисный аккаунт.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.cr.overview.button_create }}**.
  1. В поле **{{ ui-key.yacloud.cr.overview.popup-create_field_name }}** задайте имя реестра: `functions-framework-registry`.
  1. Нажмите кнопку **{{ ui-key.yacloud.cr.overview.popup-create_button_create }}**.
  1. На открывшейся странице скопируйте идентификатор созданного реестра, он понадобится в дальнейшем.

- CLI {#cli}

  Создайте реестр `functions-framework-registry`:

  ```bash
  yc container registry create \
    --name functions-framework-registry
  ```

  Результат:

  ```text
  done (1s)
  id: crpfn9p374a3********
  folder_id: b1gt6g8ht345********
  name: functions-framework-registry
  status: ACTIVE
  created_at: "2025-02-14T11:44:23.698Z"
  ```

  Сохраните идентификатор (значение поля `id`) созданного реестра, он понадобится позднее.

  Подробнее о команде `yc container registry create` читайте в [справочнике CLI](../../cli/cli-ref/container/cli-ref/registry/create.md).

- API {#api}

  Чтобы создать реестр, воспользуйтесь методом [create](../../container-registry/api-ref/Registry/create.md) для ресурса [Registry](../../container-registry/api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/Create](../../container-registry/api-ref/grpc/Registry/create.md).

{% endlist %}

## Создайте функцию {#create-function}

На этом этапе вы локально создадите функцию с помощью фреймворка Functions Framework. Команды для установки пакетов приведены для ОС Linux Ubuntu. Если вы используете другую ОС, для установки воспользуйтесь документацией к вашей операционной системе.

{% list tabs group=programming_language %}

- Node.js {#node}

  Чтобы создать функцию на [Node.js](https://nodejs.org/en):

  1. Установите менеджер пакетов [npm](https://nodejs.org/en/learn/getting-started/an-introduction-to-the-npm-package-manager):

      ```bash
      sudo apt update && \
      sudo apt install npm -y
      ```
  1. {% include [create-function-make-dir](../_tutorials_includes/functions-framework-to-container/create-function-make-dir.md) %}
  1. Пройдите процедуру инициализации проекта:

      ```bash
      npm init
      ```

      В процессе инициализации оставьте все запрашиваемые значения по умолчанию, нажимая клавишу **ENTER**. В конце процесса в ответ на запрос `Is this OK?` введите `yes` и нажмите **ENTER**. В результате в директории с вашим проектом будет создан файл проекта `package.json`:

      ```json
      {
        "name": "my-first-function",
        "version": "1.0.0",
        "description": "",
        "main": "index.js",
        "scripts": {
          "test": "echo \"Error: no test specified\" && exit 1"
        },
        "author": "",
        "license": "ISC"
      }
      ```
  1. Создайте новый файл `index.js`, открыв его в текстовом редакторе:

      ```bash
      nano index.js
      ```
  1. Добавьте в файл `index.js` следующий код:

      ```js
      const functions = require('@google-cloud/functions-framework');

      functions.http('helloWorld', (req, res) => {
        res.send('Hello, World!');
      });
      ```
  1. Установите фреймворк Functions Framework в ваш проект:

      ```bash
      npm install @google-cloud/functions-framework
      ```
  1. Добавьте в файл `package.json` следующий код:

      ```bash
      "scripts": {
        "start": "functions-framework --target=helloWorld"
      }
      ```

      Пример итогового содержимого файла `package.json`:

      ```json
      {
        "name": "my-first-function",
        "version": "1.0.0",
        "description": "",
        "main": "index.js",
        "scripts": {
          "test": "echo \"Error: no test specified\" && exit 1"
        },
        "author": "",
        "license": "ISC",
        "dependencies": {
          "@google-cloud/functions-framework": "^3.4.5"
        },
        "scripts": {
          "start": "functions-framework --target=helloWorld"
        }
      }
      ```
  1. Локально запустите вашу функцию, чтобы убедиться, что все работает:

      1. Запустите функцию:

          ```bash
          npm start
          ```

          Результат:

          ```text
          > my-first-function@1.0.0 start
          > functions-framework --target=helloWorld

          Serving function...
          Function: helloWorld
          Signature type: http
          URL: http://localhost:8080/
          ```
      1. {% include [local-curl-test](../_tutorials_includes/functions-framework-to-container/local-curl-test.md) %}

      {% include [ide-notice](../_tutorials_includes/functions-framework-to-container/ide-notice.md) %}

- Python {#python}

  Чтобы создать функцию на [Python](https://www.python.org):

  1. Установите Python и менеджер пакетов [pip](https://pip.pypa.io/en/stable/):

      ```bash
      sudo apt update && \
      sudo apt install python3 python3-pip -y
      ```
  1. {% include [create-function-make-dir](../_tutorials_includes/functions-framework-to-container/create-function-make-dir.md) %}
  1. Установите фреймворк Functions Framework:

      ```bash
      sudo pip install functions-framework
      ```
  1. Создайте файл `main.py` с кодом функции, открыв его в текстовом редакторе:

      ```bash
      nano main.py
      ```
  1. Добавьте в файл `main.py` следующий код:

      ```python
      import flask
      import functions_framework

      @functions_framework.http
      def helloWorld(request: flask.Request) -> flask.typing.ResponseReturnValue:
          return "Hello, World!"
      ```
  1. Локально запустите вашу функцию, чтобы убедиться, что все работает:

      1. Запустите функцию:

          ```bash
          functions-framework --target helloWorld --debug
          ```

          Результат:

          ```text
          * Serving Flask app 'hello'
          * Debug mode: on
          WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
          * Running on all addresses (0.0.0.0)
          * Running on http://127.0.0.1:8080
          * Running on http://192.168.1.15:8080
          Press CTRL+C to quit
          * Restarting with watchdog (inotify)
          * Debugger is active!
          * Debugger PIN: 817-187-***
          ```
      1. {% include [local-curl-test](../_tutorials_includes/functions-framework-to-container/local-curl-test.md) %}

      {% include [ide-notice](../_tutorials_includes/functions-framework-to-container/ide-notice.md) %}

- Go {#go}

  Чтобы создать функцию на [Go](https://go.dev/):

  1. [Установите](https://go.dev/doc/install) Go версии `1.18` или выше.
  1. {% include [create-function-make-dir](../_tutorials_includes/functions-framework-to-container/create-function-make-dir.md) %}
  1. Создайте новый модуль:

      ```bash
      go mod init example.com/helloWorld
      ```
  1. Создайте файл `function.go` с кодом функции, открыв его в текстовом редакторе:

      ```go
      nano function.go
      ```
  1. Добавьте в файл `function.go` следующий код:

      ```go
      package function

      import (
        "fmt"
        "net/http"

        "github.com/GoogleCloudPlatform/functions-framework-go/functions"
      )

      func init() {
        functions.HTTP("helloWorld", helloWorld)
      }

      // helloWorld writes "Hello, World!" to the HTTP response.
      func helloWorld(w http.ResponseWriter, r *http.Request) {
        fmt.Fprintln(w, "Hello, World!")
      }
      ```
  1. Локально запустите вашу функцию, чтобы убедиться, что все работает:

      1. Создайте директорию `cmd`:

          ```bash
          mkdir cmd
          ```
      1. В директории `cmd` создайте файл `main.go`:

          ```bash
          nano cmd/main.go
          ```
      1. Добавьте в файл `main.go` следующий код:

          ```go
          package main

          import (
            "log"
            "os"

            // Blank-import the function package so the init() runs
            _ "example.com/helloWorld"
            "github.com/GoogleCloudPlatform/functions-framework-go/funcframework"
          )

          func main() {
            // Use PORT environment variable, or default to 8080.
            port := "8080"
            if envPort := os.Getenv("PORT"); envPort != "" {
              port = envPort
            }
            
            // By default, listen on all interfaces. If testing locally, run with 
            // LOCAL_ONLY=true to avoid triggering firewall warnings and 
            // exposing the server outside of your own machine.
            hostname := ""
            if localOnly := os.Getenv("LOCAL_ONLY"); localOnly == "true" {
              hostname = "127.0.0.1"
            } 
            if err := funcframework.StartHostPort(hostname, port); err != nil {
              log.Fatalf("funcframework.StartHostPort: %v\n", err)
            }
          }
          ```
      1. Обновите зависимости:

          ```bash
          go mod tidy
          ```
      1. Запустите локальный сервер:

          ```bash
          FUNCTION_TARGET=helloWorld \
          LOCAL_ONLY=true \
          go run cmd/main.go
          ```
      1. {% include [local-curl-test](../_tutorials_includes/functions-framework-to-container/local-curl-test.md) %}

      {% include [ide-notice](../_tutorials_includes/functions-framework-to-container/ide-notice.md) %}


{% endlist %}

## Создайте Docker-образ и загрузите его в реестр {{ container-registry-name }} {#push-docker-image}

Для сборки функции используется технология [Buildpacks](https://buildpacks.io) и набор [сборщиков](https://buildpacks.io/docs/for-app-developers/concepts/builder/) от [GCP](https://github.com/GoogleCloudPlatform/buildpacks). Вы также можете использовать сборщики от [Heroku](https://github.com/heroku/buildpacks).

1. Воспользуйтесь установленной ранее утилитой Pack, чтобы собрать Docker-образ с вашим приложением:

    ```bash
    sudo pack build \
     --builder gcr.io/buildpacks/builder:google-22 \
     --env GOOGLE\_FUNCTION\_SIGNATURE\_TYPE=http \
     --env GOOGLE\_FUNCTION\_TARGET=helloWorld \
     my-first-function
    ```

    Чтобы дополнительно настроить сборку контейнера, в т.ч. добавить в него дополнительные пакеты или зависимости, воспользуйтесь [инструкцией](https://cloud.google.com/docs/buildpacks/build-run-image).

    Результат:

    ```text
    ...
    Successfully built image my-first-function
    ```

    Приведенная выше команда сборки может использоваться для функций, написанных на разных языках программирования, поскольку сборщик автоматически определяет язык и среду выполнения проекта, после чего собирает приложение в OCI-совместимый Docker-образ. Это избавляет разработчика от необходимости вручную создавать Dockerfile. 

1. Локально запустите контейнер из собранного Docker-образа, чтобы убедиться, что все работает:

    1. Выполните команду:

        ```bash
        docker run --rm -p 8080:8080 my-first-function
        ```
    1. {% include [local-curl-test](../_tutorials_includes/functions-framework-to-container/local-curl-test.md) %}

        Код функции выполняется в запущенном локально Docker-контейнере.
    1. Закройте дополнительное окно терминала. В основном окне терминала остановите выполнение Docker-контейнера, нажав сочетание клавиш **Ctrl + C**.
1. Присвойте созданному Docker-образу URL вида `{{ registry }}/<идентификатор_реестра>/<имя_Docker-образа>:<тег>`, указав сохраненный ранее идентификатор реестра {{ container-registry-name }}:

     ```bash
     docker tag my-first-function \
       cr.yandex/<идентификатор_реестра>/my-first-function:some-tag
     ```

     {% note info %}

     Загрузить в {{ container-registry-name }} можно только Docker-образы с URL вида `{{ registry }}/<идентификатор_реестра>/<имя_Docker-образа>:<тег>`.

     {% endnote %}
1. Загрузите Docker-образ в реестр:

    ```bash
    docker push \
      cr.yandex/<идентификатор_реестра>/my-first-function:some-tag
    ```

    Результат:

    ```text
    The push refers to repository [cr.yandex/crpfn9p374a3********/my-first-function]
    ...
    14f9fd9947d2: Pushed
    2573e0d81582: Pushed
    some-tag: digest: sha256:1b8bac8da5e64dd4359f81d71a7803f212af385f9718a7a4f9a40bca******** size: 2830
    ```

## Создайте контейнер {{ serverless-containers-name }} из загруженного Docker-образа {#setup-container}

Используйте загруженный в {{ container-registry-name }} Docker-образ, чтобы создать [ревизию](../../serverless-containers/concepts/container.md#revision) контейнера {{ serverless-containers-name }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находятся созданные ранее ресурсы.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-containers.button_create-container }}**.
  1. В поле **{{ ui-key.yacloud.common.name }}** укажите имя контейнера: `my-first-function`.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  1. В блоке **{{ ui-key.yacloud.serverless-containers.section_image }}** в поле **{{ ui-key.yacloud.serverless-containers.label_image-url }}** выберите загруженный ранее Docker-образ `cr.yandex/<идентификатор_реестра>/my-first-function:some-tag`.
  1. В блоке **{{ ui-key.yacloud.serverless-containers.section_parameters }}** в поле **{{ ui-key.yacloud.forms.label_service-account-select }}** выберите созданный ранее сервисный аккаунт `serverless-containers-sa`.
  1. В блоке **{{ ui-key.yacloud.logging.label_title }}** отключите опцию **{{ ui-key.yacloud.logging.field_logging }}**, чтобы отключить запись логов в [лог-группу](../../logging/concepts/log-group.md).

      Вы можете оставить опцию включенной, чтобы [записывать](../../serverless-containers/operations/logs-write.md) логи в журнал выполнения контейнера. Запись и хранение логов [тарифицируются](../../logging/pricing.md).
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-containers.button_deploy-revision }}**.
  1. В открывшемся окне в блоке **{{ ui-key.yacloud_org.common.section-base }}** скопируйте значение поля **{{ ui-key.yacloud.serverless-containers.label_url }}** — этот URL понадобится при тестировании работы функции в контейнере.

- CLI {#cli}

  1. Создайте контейнер `my-first-function`:

      ```bash
      yc serverless container create \
        --name my-first-function
      ```

      Результат:

      ```text
      done (1s)
      id: bba0tc5nv6j0********
      folder_id: b1gt6g8ht345********
      created_at: "2025-02-14T15:26:04.744Z"
      name: my-first-function
      url: https://bba0tc5nv6j0********.containers.yandexcloud.net/
      status: ACTIVE
      ```

      Сохраните полученную ссылку для вызова контейнера (значение поля `url`) — она понадобится при тестировании работы функции в контейнере.

      Подробнее о команде `yc serverless container create` читайте в [справочнике CLI](../../cli/cli-ref/serverless/cli-ref/container/create.md).

  1. Создайте ревизию созданного ранее контейнера:

      ```bash
      yc serverless container revision deploy \
        --container-name my-first-function \
        --image "cr.yandex/<идентификатор_реестра>/my-first-function:some-tag" \
        --service-account-id <идентификатор_сервисного_аккаунта> \
        --no-logging
      ```

      Где:
      * `<идентификатор_реестра>` — сохраненный ранее идентификатор реестра {{ container-registry-name }}.
      * `<идентификатор_сервисного_аккаунта>` — сохраненный ранее идентификатор сервисного аккаунта `serverless-containers-sa`.
      * `--no-logging` — параметр отключает запись логов в [лог-группу](../../logging/concepts/log-group.md). Уберите этот параметр из команды, чтобы [записывать](../../serverless-containers/operations/logs-write.md) логи в журнал выполнения контейнера. Запись и хранение логов [тарифицируются](../../logging/pricing.md).

      Результат:

      ```text
      done (16s)
      id: bba6f1jllc3t********
      container_id: bbakbil5lg7j********
      created_at: "2025-02-14T20:48:06.424Z"
      image:
        image_url: cr.yandex/crpfn9p374a3********/my-first-function:some-tag
        image_digest: sha256:1b8bac8da5e64dd4359f81d71a7803f212af385f9718a7a4f9a40bca********
      resources:
        memory: "134217728"
        cores: "1"
        core_fraction: "100"
      execution_timeout: 3s
      concurrency: "1"
      service_account_id: aje7tnmd885t********
      status: ACTIVE
      log_options:
        disabled: true
        folder_id: b1gt6g8ht345********
      runtime:
        http: {}
      ```

      Подробнее о команде `yc serverless container revision deploy` читайте в [справочнике CLI](../../cli/cli-ref/serverless/cli-ref/container/revision/deploy.md).

- API {#api}

  Чтобы создать [контейнер](../../serverless-containers/concepts/container.md), воспользуйтесь методом REST API [create](../../serverless-containers/containers/api-ref/Container/create.md) для ресурса [Container](../../serverless-containers/containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/Create](../../serverless-containers/containers/api-ref/grpc/Container/create.md).

  Чтобы создать ревизию контейнера, воспользуйтесь методом REST API [deployRevision](../../serverless-containers/containers/api-ref/Container/deployRevision.md) для ресурса [Container](../../serverless-containers/containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/DeployRevision](../../serverless-containers/containers/api-ref/grpc/Container/deployRevision.md).

{% endlist %}

## Проверьте работу функции в контейнере {#run-test}

После создания контейнера вы получили ссылку для его вызова. Чтобы проверить работу функции в контейнере, выполните запрос, указав в нем полученную ссылку:

```bash
curl \
  --request GET \
  --header "Authorization: Bearer $(yc iam create-token)" \
  <ссылка_для_вызова_контейнера>
```

Результат:

```text
Hello, World%
```

При вызове контейнера был выполнен код функции `my-first-function`, созданной ранее с помощью фреймворка Functions Framework.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите](../../serverless-containers/operations/delete.md) контейнер {{ serverless-containers-name }}.
1. [Удалите](../../container-registry/operations/docker-image/docker-image-delete.md) Docker-образ из реестра {{ container-registry-name }}, затем [удалите](../../container-registry/operations/registry/registry-delete.md) реестр.
1. Если вы оставили включенной запись логов в журнал выполнения контейнера, [удалите](../../logging/operations/delete-group.md) лог-группу.