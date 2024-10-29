# Вызов нагрузочного тестирования из {{ GL }} CI

[{{ GL }}](https://about.gitlab.com/) — это сайт и система управления репозиториями кода для Git. Также {{ GL }} позволяет разработчикам вести непрерывный процесс для создания, тестирования и развертывания кода.

В этом сценарии вы добавите в пайплайн [непрерывной интеграции и непрерывной поставки (CI/CD)](/blog/posts/2022/10/ci-cd) этап вызова нагрузочного тестирования развертываемого приложения с помощью сервиса {{ load-testing-name }}. На этом этапе скрипт создаст агент тестирования, запустит тест и проверит результат тестирования.

Чтобы добавить вызов нагрузочного тестирования из {{ GL }} CI:
1. [Подготовьте облако к работе](#before-begin).
1. [Подготовьте инфраструктуру](#infrastructure-prepare).
1. [Подготовьте файл с тестовыми данными](#test-file).
1. [Создайте переменные окружения {{ GL }}](#add-variables).
1. [Добавьте этап нагрузочного тестирования в файл конфигурации сценария CI](#add-loadtesting-ci)

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

1. Если [агент](../../load-testing/concepts/agent.md) размещается на платформе {{ yandex-cloud }}, взимается плата за вычислительные ресурсы (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).

1. Плата за хранение данных в бакете и операции с ними (см. [тарифы {{ objstorage-name }}](../../storage/pricing.md)).


## Подготовьте инфраструктуру {#infrastructure-prepare}

### Создайте сервисный аккаунт {#sa-create}

1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт `sa-loadtest` в каталоге, где будет размещаться агент, с которого будет подаваться нагрузка.
1. [Назначьте](../../iam/operations/roles/grant.md) сервисному аккаунту [роли](../../load-testing/security/#roles-list):
   * `loadtesting.generatorClient`;
   * `loadtesting.loadTester`;
   * `iam.serviceAccounts.user`;
   * `compute.editor`;
   * `vpc.user`;
   * `vpc.publicAdmin` (опционально, если агент будет разворачиваться в публичной сети).

1. [Создайте](../../iam/operations/authorized-key/create.md) авторизованный ключ для этого сервисного аккаунта и сохраните ключ в файл `key.json`.

### Настройте сеть {#network-setup}

[Создайте и настройте NAT-шлюз](../../vpc/operations/create-nat-gateway.md) в подсети, где размещается цель тестирования и будет размещен агент. Это обеспечит доступ агента к сервису {{ load-testing-name }}.

### Настройте группу безопасности {#security-group-setup}

Настройте группу безопасности агента тестирования:

{% include [security-groups-agent](../../_includes/load-testing/security-groups-agent.md) %}

### Подготовьте пайплайн CI/CD в {{ GL }} для развертывания цели тестирования {#prepare-gitlab-ci}

В данном сценарии, в качестве примера цели тестирования, будем использовать приложение с [публичным IP-адресом](../../vpc/concepts/address#public-addresses) `51.250.103.44`. С примером построения пайплайна CI/CD в {{ GL }} вы можете ознакомиться в [статье](../../tutorials/serverless/ci-cd-serverless).

## Подготовьте файл с тестовыми данными {#test-file}

1. Сформируйте тестовые данные в формате [HTTP_JSON](../../load-testing/concepts/payloads/http-json.md):

   ```JSON
   {"host": "51.250.103.44", "method": "GET", "uri": "/", "tag": "url1", "headers": {"User-agent": "Tank", "Connection": "Close"}}
   ```

   Где:
   * `host` — значение заголовка `Host`;
   * `method` — метод HTTP-запроса;
   * `uri` — URI запроса;
   * `tag` — тег запроса для отображения в отчетах;
   * `headers` — заголовки запроса.

Для подготовки тестовых данных вы также можете воспользоваться инструментом [Dispatcher](../../load-testing/operations/payload-dispatcher).

1. Сохраните тестовые данные в файл `httpjson.payload`.
1. [Создайте](../../storage/operations/buckets/create.md) бакет и [загрузите](../../storage/operations/objects/upload.md) в него файл с тестовыми данными.
1. Выдайте сервисному аккаунту права на чтение в бакете. Для этого отредактируйте [ACL](../../storage/concepts/acl.md) бакета:
   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится бакет.
   1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
   1. Напротив нужного бакета нажмите ![image](../../_assets/horizontal-ellipsis.svg) и выберите **{{ ui-key.yacloud.storage.buckets.button_permissions }}**.
   1. В открывшемся окне введите имя сервисного аккаунта, выберите права на чтение в бакете — `READ` и нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

   Сервисному аккаунту будут предоставлены права на чтение данных только из этого бакета.

## Создайте переменные окружения {{ GL }} {#add-variables}

1. На панели слева в {{ GL }} перейдите в раздел **Settings** и во всплывающем списке выберите пункт **CI/CD**.
1. Нажмите кнопку **Expand** напротив пункта **Variables**.
1. Добавьте переменные окружения с выключенной опцией защиты:
   * `SERVICE_ACCOUNT_ID` — идентификатор сервисного аккаунта `sa-loadtest`;
   * `SA_AUTHORIZED_KEY` — содержимое авторизованного ключа для сервисного аккаунта `sa-loadtest`;
   * `SECURITY_GROUP_ID` — идентификатор группы безопасности `agent-sg` агента тестирования;
   * `SUBNET_ID` — идентификатор подсети, в которой будет размещен агент тестирования;
   * `ZONE` — зона доступности, в которой будет размещен агент тестирования, например, `ru-central1-a`;
   * `YC_FOLDER_ID` — идентификатор каталога, в котором будут размещены ресурсы.

   Для добавления переменной:
   1. Нажмите кнопку **Add variable**.
   1. В появившемся окне в поле **Key** укажите имя переменной, в поле **Value** — значение переменной.
   1. Выключите опцию **Protect variable**.
   1. Нажмите кнопку **Add variable**.

## Добавьте этап нагрузочного тестирования в файл конфигурации сценария CI {#add-loadtesting-ci}

1. Добавьте в репозиторий вашего проекта на {{ GL }} файл конфигурации нагрузочного теста `test-config.yaml`:

   ```yaml
   pandora:
      enabled: true
      package: yandextank.plugins.Pandora
      config_content:
         pools:
            - id: HTTP
            gun:
               type: http
               target: 51.250.103.44
               ssl: false
            ammo:
               type: http/json
               file: httpjson.payload
            result:
               type: phout
               destination: ./phout.log
            startup:
               type: once
               times: 1000
            rps:
               - type: line
                  from: 0
                  to: 500
                  duration: 60s
            discard_overflow: true
         log:
            level: error
         monitoring:
            expvar:
               enabled: true
               port: 1234
   autostop:
      enabled: true
      package: yandextank.plugins.Autostop
      autostop:
         - limit(5m) # Обязательный параметр
         - quantile(50,100,5,)
   core: {}
   ```

   В поле `target` укажите адрес вашего приложения. Тест по этой конфигурации будет генерировать [линейную нагрузку](../../load-testing/concepts/load-profile) от 0 до 500 запросов в секунду в течение 60 секунд. Также настроен критерий [автостопа](../../load-testing/concepts/auto-stop). Этот критерий остановит тест, если в течение 5 секунд 50 процентиль превысит 100 миллисекунд.

1. Добавьте в файл `.gitlab-ci.yml` этап нагрузочного тестирования после развёртывания приложения:
  
   ```yaml
   stages:
      ...
      - loadtesting
      ...

   loadtesting-job:
      stage: loadtesting
      allow_failure: true
      artifacts: 
         when: always
         name: "tests_output"
         paths:
            - agent_id.txt
      before_script:
         # Установка инструментов.
         - sudo apt-get install -y jq
         - curl --fail --silent --location --remote-name https://storage.yandexcloud.net/yandexcloud-yc/install.sh
         - sudo bash install.sh -i /usr/local/yandex-cloud -n
         - sudo ln -f -s /usr/local/yandex-cloud/bin/yc /usr/local/bin/yc
         # Аутентификация с помощью ключа сервисного аккаунта
         - echo "$SA_AUTHORIZED_KEY" > key.json
         - yc config profile create sa-profile || echo "Profile already exists"
         - yc config set service-account-key key.json
         - yc config set folder-id ${YC_FOLDER_ID}
      script:
         # Создание агента тестирования
         - agent_id=$(yc loadtesting agent create --name agent${CI_JOB_ID} --zone ${ZONE} --service-account-id ${SERVICE_ACCOUNT_ID} --network-interface security-group-ids=${SECURITY_GROUP_ID},subnet-id=${SUBNET_ID} --format json | jq -r .id)
         - echo $agent_id > agent_id.txt
         # Ожидание готовности агента
         - |
           while true; do
              if ! _status=$(yc loadtesting agent get "$agent_id" --format json | jq -r '.status'); then
                 sleep 10
                 continue
              fi
              if [[ "$_status" == "READY_FOR_TEST" ]]; then
                 echo "Agent is ready"
                 break
              fi
              echo "Waiting for agent..."
              sleep 10
           done
         # Создание конфигурации
         - config_id=$(yc loadtesting test-config create --from-yaml-file test-config.yaml --format json | jq -r .id)
         # Запуск теста
         - test_id=$(yc loadtesting test create --name "test_${CI_COMMIT_SHORT_SHA}" --description "${CI_COMMIT_MESSAGE}" --labels auto=true --configuration agent-id=$agent_id,id=$config_id,test-data=httpjson.payload --test-data name=httpjson.payload,s3bucket=payload-bucket,s3file=httpjson.payload --wait --format json | jq -r .id)
         - yc loadtesting test wait --idle-timeout 120s $test_id
         # Оценка результатов теста
         - q50=$(yc loadtesting test get-report-table $test_id --format json | jq -r .overall.quantiles.q50)
         - |
           if [[ $q50 -gt 100 ]]; then
              echo "Q50 больше 100 мс, тест не пройден"
              exit 1
           fi
      after_script:
         # Удаление агента тестирования
         - agent_id=$(cat agent_id.txt)
         - yc loadtesting agent delete $agent_id
         - rm agent_id.txt
   ```

   На описанном этапе скрипт создаст агент тестирования, запустит тест и проверит результат тестирования. В качестве оценки результата используется 50 процентиль. Если его значение будет больше 100 миллисекунд, этап завершится с ошибкой.

   После сохранения файла конфигурации `.gitlab-ci.yml` запустится сценарий сборки.

   Подробнее результаты теста вы можете посмотреть в консоли управления:
      1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
      1. На панели слева выберите ![image](../../_assets/load-testing/test.svg) **{{ ui-key.yacloud.load-testing.label_tests-list }}**.
      1. Выберите созданный тест и перейдите на вкладку **{{ ui-key.yacloud.load-testing.label_test-report }}**.

   Логику подключения этого этапа можно сделать произвольной:
      * по коммитам в основную ветку;
      * по обновлению в Pull Request.

   Более сложные сценарии разобраны в видео:
   @[youtube](QrMMZu__2DI)

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. [Удалите сервисные аккаунты](../../iam/operations/sa/delete.md).
1. [Удалите бакет {{ objstorage-name }}](../../storage/operations/buckets/delete.md).
1. Убедитесь, что удален агент тестирования, созданный скриптом. Вы можете [удалить агент](../../compute/operations/vm-control/vm-delete.md) вручную.
1. [Удалите таблицу маршрутизации](../../vpc/operations/delete-route-table.md).
1. [Удалите NAT-шлюз](../../vpc/operations/delete-nat-gateway.md).
