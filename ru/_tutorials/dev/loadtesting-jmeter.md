# Нагрузочный тест с помощью JMeter


{{ load-testing-name }} можно использовать для тестирования сервиса с постоянной нагрузкой по протоколу HTTPS с помощью [генератора нагрузки](../../load-testing/concepts/load-generator.md) [JMeter](../../load-testing/concepts/load-generator.md#jmeter).

Чтобы провести нагрузочное тестирование:
1. [Подготовьте облако к работе](#before-begin).
1. [Подготовьте цель тестирования](#target-prepare).
1. [Подготовьте инфраструктуру](#infrastructure-prepare).
1. [Создайте агент](#create-agent).
1. [Подготовьте файл с тестовыми данными](#test-file).
1. [Запустите тест](#run-test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

Если [агент](../../load-testing/concepts/agent.md) размещается на платформе {{ yandex-cloud }}, взимается плата за вычислительные ресурсы (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).

На стадии [Preview](../../overview/concepts/launch-stages.md) использование сервиса {{ load-testing-name }} не тарифицируется.

## Подготовьте цель тестирования {#target-prepare}

В этом примере будет тестироваться сервис с [внутренним IP-адресом](../../vpc/concepts/address.md#internal-addresses) `172.17.0.10` в той же [подсети](../../vpc/concepts/network.md#subnet), где будет размещен агент.

Убедитесь, что для доступа к сервису по протоколу HTTPS используется порт по умолчанию — `443`.

{{ load-testing-name }} также можно использовать для нагрузочного тестирования сервиса, доступного публично или находящегося в другой подсети и [группе безопасности](../../vpc/concepts/security-groups.md) относительно агента.

Для сервиса, доступного публично, разрешите входящий HTTPS-трафик на порт `443`.

Для сервиса, находящегося в другой подсети и группе безопасности относительно агента, [создайте](#security-group-setup) правило для входящего HTTPS-трафика на порт `443` в группе безопасности, где размещается цель тестирования.

## Подготовьте инфраструктуру {#infrastructure-prepare}

### Создайте сервисный аккаунт {#sa-create}

{% include [sa-create](../../_includes/load-testing/sa-create.md) %}

### Настройте сеть {#network-setup}

[Создайте и настройте NAT-шлюз](../../vpc/operations/create-nat-gateway.md) в подсети, где размещается цель тестирования и будет размещен агент. Это обеспечит доступ агента к сервису {{ load-testing-name }}.

### Настройте группы безопасности {#security-group-setup}

1. Настройте группу безопасности агента тестирования:

   {% include [security-groups-agent](../../_includes/load-testing/security-groups-agent.md) %}

1. Настройте группу безопасности цели тестирования:

   {% include [security-groups-target](../../_includes/load-testing/security-groups-target.md) %}

## Создайте агент тестирования {#create-agent}

{% include [create-agent](../../_includes/load-testing/create-agent.md) %}

## Подготовьте сценарий нагрузочного тестирования {#test-scenario}

Создайте сценарий нагрузочного тестирования в UI JMeter и сохраните его в файл с расширением `.jmx`. Подробнее см. в [документации JMeter](https://jmeter.apache.org/usermanual/index.html)

{% cut "Пример сценария JMeter" %}

Создайте файл `test.jmx` и поместите в него следующий код, указав в поле `HTTPSampler.domain` актуальный IP-адрес вашей цели тестирования:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<jmeterTestPlan version="1.2" properties="5.0" jmeter="5.6.2">
  <hashTree>
    <TestPlan guiclass="TestPlanGui" testclass="TestPlan" testname="Test Plan" enabled="true">
      <boolProp name="TestPlan.functional_mode">false</boolProp>
      <boolProp name="TestPlan.tearDown_on_shutdown">false</boolProp>
      <boolProp name="TestPlan.serialize_threadgroups">false</boolProp>
      <elementProp name="TestPlan.user_defined_variables" elementType="Arguments" guiclass="ArgumentsPanel" testclass="Arguments" testname="User Defined Variables" enabled="true">
        <collectionProp name="Arguments.arguments"/>
      </elementProp>
    </TestPlan>
    <hashTree>
      <ThreadGroup guiclass="ThreadGroupGui" testclass="ThreadGroup" testname="Thread Group" enabled="true">
        <stringProp name="ThreadGroup.on_sample_error">continue</stringProp>
        <elementProp name="ThreadGroup.main_controller" elementType="LoopController" guiclass="LoopControlPanel" testclass="LoopController" testname="Loop Controller" enabled="true">
          <stringProp name="LoopController.loops">600</stringProp>
          <boolProp name="LoopController.continue_forever">false</boolProp>
        </elementProp>
        <stringProp name="ThreadGroup.num_threads">1</stringProp>
        <stringProp name="ThreadGroup.ramp_time">1</stringProp>
        <boolProp name="ThreadGroup.delayedStart">false</boolProp>
        <boolProp name="ThreadGroup.scheduler">false</boolProp>
        <stringProp name="ThreadGroup.duration"></stringProp>
        <stringProp name="ThreadGroup.delay"></stringProp>
        <boolProp name="ThreadGroup.same_user_on_next_iteration">true</boolProp>
      </ThreadGroup>
      <hashTree>
        <HTTPSamplerProxy guiclass="HttpTestSampleGui" testclass="HTTPSamplerProxy" testname="HTTP Request" enabled="true">
          <boolProp name="HTTPSampler.postBodyRaw">false</boolProp>
          <elementProp name="HTTPsampler.Arguments" elementType="Arguments" guiclass="HTTPArgumentsPanel" testclass="Arguments" testname="User Defined Variables" enabled="true">
            <collectionProp name="Arguments.arguments"/>
          </elementProp>
          <stringProp name="HTTPSampler.domain">172.17.0.10</stringProp>
          <stringProp name="HTTPSampler.path">/test?sleep=100</stringProp>
          <stringProp name="HTTPSampler.method">GET</stringProp>
          <boolProp name="HTTPSampler.follow_redirects">true</boolProp>
          <boolProp name="HTTPSampler.auto_redirects">false</boolProp>
          <boolProp name="HTTPSampler.use_keepalive">true</boolProp>
          <boolProp name="HTTPSampler.DO_MULTIPART_POST">false</boolProp>
          <boolProp name="HTTPSampler.BROWSER_COMPATIBLE_MULTIPART">false</boolProp>
          <boolProp name="HTTPSampler.image_parser">false</boolProp>
          <boolProp name="HTTPSampler.concurrentDwn">false</boolProp>
          <stringProp name="HTTPSampler.concurrentPool">6</stringProp>
          <boolProp name="HTTPSampler.md5">false</boolProp>
          <intProp name="HTTPSampler.ipSourceType">0</intProp>
        </HTTPSamplerProxy>
        <hashTree/>
        <ConstantThroughputTimer guiclass="TestBeanGUI" testclass="ConstantThroughputTimer" testname="Constant Throughput Timer" enabled="true">
          <intProp name="calcMode">1</intProp>
          <doubleProp>
            <name>throughput</name>
            <value>600.0</value>
            <savedValue>0.0</savedValue>
          </doubleProp>
        </ConstantThroughputTimer>
        <hashTree/>
      </hashTree>
    </hashTree>
  </hashTree>
</jmeterTestPlan>
```

В этом примере создается одна Thread-группа с одним HTTP-запросом (запрос `sleep` на 100 миллисекунд) и задается IP-адрес тестируемого ресурса. Запросы отправляются с периодичностью 600 запросов в минуту, длительность теста составляет 600 запросов.

{% endcut %}

## Запустите тест {#run-test}

1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
1. На панели слева выберите ![image](../../_assets/load-testing/test.svg) **{{ ui-key.yacloud.load-testing.label_tests-list }}**. Нажмите **{{ ui-key.yacloud.load-testing.button_create-test }}**. 
1. В поле **{{ ui-key.yacloud.load-testing.label_agents-list }}** выберите агент `agent-008`.
1. В блоке **{{ ui-key.yacloud.load-testing.test-data-section }}** нажмите **{{ ui-key.yacloud_portal.component.file-input.button_choose-multiple }}** и выберите файл со сценарием, созданный [ранее](#test-scenario).
1. В блоке **{{ ui-key.yacloud.load-testing.label_test-settings }}**:

    1. В поле **{{ ui-key.yacloud.load-testing.field_load-generator }}** выберите `JMETER`.
    1. В поле **Сценарий jmx** выберите `Прикрепленный файл`.
    
        Если в блоке **{{ ui-key.yacloud.load-testing.test-data-section }}** вы загрузили несколько файлов, выберите `Указать файл` и в поле **Имя прикрепленного файла или URL для скачивания** укажите имя файла со сценарием. Если ваш сценарий недоступен локально, укажите в этом поле URL для его скачивания.

1. (опционально) В меню **Переопределить значения переменных jmx сценария** вы можете добавить переменные со значениями в формате `var=value`. В этом случае в сценарий будут переданы пользовательские переменные, а внутри сценария к таким переменным можно будет обращаться в формате `${var}`.
1. (опционально) В меню **Параметры запуска JMeter**:

    1. Если вы используете свою версию JMeter, которую предварительно вручную скопировали на агент, в поле **Путь до исполняемого файла jmeter** укажите путь к исполняемому файлу JMeter.
    1. В поле **Дополнительные аргументы запуска jmeter** укажите дополнительные аргументы — они позволяют использовать команды запуска Non-GUI режима. Подробнее см. в [документации JMeter](https://jmeter.apache.org/usermanual/get-started.html#non_gui).

1. В меню **Автостоп** нажмите ![image](../../_assets/plus-sign.svg) **Автостоп** и введите описание:
    * **Тип автостопа 1** — `QUANTILE`.
    * **Квантиль** — `75`.
    * **Лимит времени ответов** — `100ms`.
    * **Размер окна** — `10s`.

    Этот критерий остановит тест, если в течение 10 секунд 75 процентиль превысит 100 миллисекунд (в течение 10 секунд время обработки 25% запросов превысит 100 миллисекунд).

1. В блоке **{{ ui-key.yacloud.load-testing.meta-section }}** укажите имя, описание и номер тестируемой версии. Это поможет сделать отчет читаемым.
1. Нажмите **{{ ui-key.yacloud.common.create }}**.

После этого конфигурация пройдет проверки, и агент начнет нагружать тестируемый сервис.

Чтобы наблюдать за результатами выполнения тестирования, выберите созданный тест и перейдите на вкладку **{{ ui-key.yacloud.load-testing.label_test-report }}**.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы, достаточно [удалить агент](../../compute/operations/vm-control/vm-delete.md).