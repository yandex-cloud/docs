# Выбор агента

При [создании теста](../operations/create-test-bucket.md#create-test), агент тестирования можно либо указать сразу, выбрав из списка, либо настроить функцию выбора первого освободившегося агента. Функция выбора агента позволяет отфильтровать агентов тестирования по заданным параметрам.

## Указать агент тестирования {#select}

Для того, чтобы указать агент тестирования:

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите каталог для тестирования.
   1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
   1. На вкладке ![image](../../_assets/load-testing/test.svg) **{{ ui-key.yacloud.load-testing.label_tests-list }}** нажмите **{{ ui-key.yacloud.load-testing.button_create-test }}**.
   1. В секции **{{ ui-key.yacloud.load-testing.label_agents-list }}** нажмите **{{ ui-key.yacloud.load-testing.label_agent-from-list-selector }}**.
   1. В выпадающем списке выберите имя нужного агента.

      {% note info %}

      В рамках одного теста вы можете назначить несколько агентов, которые будут [работать синхронно](../tutorials/loadtesting-multiply), что позволит увеличить нагрузку на цель тестирования.
      Для этого либо выберите несколько имен агентов из списка, либо используйте кнопки **Только** и **Кроме** в строке списка с именем одного из агентов. Кнопки позволяют выбрать соответственно только данный агент или всех агентов, кроме данного. 

      {% endnote %}

- CLI {#cli}

   Укажите идентификаторы агентов при создании теста:

   ```bash
   export AGENT_ID1='<идентификатор_агента_1>'
   export AGENT_ID2='<идентификатор_агента_2>'

   yc loadtesting test create \
       --name "yc-examples-test" \
       --description "Test has been created using YC" \
       --labels source=gh,type=tutorial,kind=multi \
       --configuration id=$TEST_CONFIG_ID,agent-id=$AGENT_ID1,test-data=$TEST_PAYLOAD_FILE_IN_CONFIG \
       --configuration id=$TEST_CONFIG_ID,agent-id=$AGENT_ID2,test-data=$TEST_PAYLOAD_FILE_IN_CONFIG \
       --test-data name=$TEST_PAYLOAD_FILE_IN_CONFIG,s3bucket=$S3_PAYLOAD_BUCKET,s3file=$S3_PAYLOAD_FILENAME

   ```

{% endlist %}

## Настроить выбор первого освободившегося агента тестирования {#filter}

Для того, чтобы настроить функцию выбора первого освободившегося агента тестирования:

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите каталог для тестирования.
   1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
   1. На вкладке ![image](../../_assets/load-testing/test.svg) **{{ ui-key.yacloud.load-testing.label_tests-list }}** нажмите **{{ ui-key.yacloud.load-testing.button_create-test }}**.
   1. В секции **{{ ui-key.yacloud.load-testing.label_agents-list }}** нажмите **{{ ui-key.yacloud.load-testing.label_agent-by-filter-selector }}**.
   1. Если для теста подходит любой из имеющихся агентов, выберите опцию **{{ ui-key.yacloud.load-testing.label_agent-by-filter-any-option }}**. В противном случае, выберите опцию **{{ ui-key.yacloud.load-testing.label_agent-by-filter-condition-option }}** и настройте условия фильтрации агентов:
      * (Опционально) В секции **{{ ui-key.yacloud.load-testing.filter_label_tags }}** нажмите **{{ ui-key.yacloud.component.label-set.button_add-label }}** и укажите метки в формате `ключ:значение`, по которым будут отобраны агенты тестирования.
      * (Опционально) В поле **{{ ui-key.yacloud.load-testing.field_name-filter }}** укажите строку, которую должны содержать имена агентов, на которых необходимо запустить тестовую конфигурацию.
   1. В поле **{{ ui-key.yacloud.load-testing.label_agents-count }}** укажите число агентов, с которых будет синхронно выполняться тест. Это позволит увеличить нагрузку на цель тестирования.

- CLI {#cli}

   Задайте условия фильтрации:

   ```bash
   
   export ANY_AGENT_SELECTOR=""
   export SPECIFIC_AGENT_SELECTOR="labels.key IN (value1, value2)"

   yc loadtesting test create \
      --name "yc-examples-test" \
      --description "Test has been created using YC" \
      --labels source=gh,type=tutorial \
      --configuration id=$TEST_CONFIG_ID,agent-by-filter=$ANY_AGENT_SELECTOR,test-data=$TEST_PAYLOAD_FILE_IN_CONFIG \
      --configuration id=$TEST_CONFIG_ID,agent-by-filter={$SPECIFIC_AGENT_SELECTOR},test-data=$TEST_PAYLOAD_FILE_IN_CONFIG \
      --test-data name=$TEST_PAYLOAD_FILE_IN_CONFIG,s3bucket=$S3_PAYLOAD_BUCKET,s3file=$S3_PAYLOAD_FILENAME

   ```

   В данном примере первая часть теста будет выполнена на любом подходящем агенте (т.к. условия фильтрации в `ANY_AGENT_SELECTOR` не заданы), а вторая часть теста — на любом агенте, у которого есть метка `key` со значением `value1` или `value2`.

{% endlist %}

