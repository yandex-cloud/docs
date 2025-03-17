# Сравнение результатов нагрузочных тестов

В данном сценарии вы настроите окружение для нагрузочного тестирования, проведете тесты и сравните результаты нагрузочных тестов.

В сценарии используется [генератор нагрузки](../../load-testing/concepts/load-generator.md) [Pandora](../../load-testing/concepts/load-generator.md#pandora) и простейший веб-сервис в качестве цели тестирования.

Чтобы провести нагрузочное тестирование и сравнить результаты тестов:
1. [Подготовьте облако к работе](#before-begin).
1. [Подготовьте инфраструктуру](#infrastructure-prepare).
1. [Подготовьте цель тестирования](#target-prepare).
1. [Создайте агент](#create-agent).
1. [Подготовьте файл с тестовыми данными](#test-file).
1. [Запустите тест](#run-test).
1. [Перезапустите тест несколько раз](#rerun-test).
1. [Сравните результаты](#compare-results).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

Если [агент](../../load-testing/concepts/agent.md) размещается на платформе {{ yandex-cloud }}, взимается плата за вычислительные ресурсы (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).

На стадии [Preview](../../overview/concepts/launch-stages.md) использование сервиса {{ load-testing-name }} не тарифицируется.

## Подготовьте инфраструктуру {#infrastructure-prepare}

### Создайте сервисный аккаунт {#sa-create}

{% include [sa-create](../../_includes/load-testing/sa-create.md) %}

### Настройте сеть {#network-setup}

[Создайте и настройте NAT-шлюз](../../vpc/operations/create-nat-gateway.md) в подсети, где будет размещаться цель тестирования и будет размещен агент. Это обеспечит доступ агента к сервису {{ load-testing-name }}.

### Настройте группы безопасности {#security-group-setup}

1. Настройте группу безопасности агента тестирования:

   {% include [security-groups-agent](../../_includes/load-testing/security-groups-agent.md) %}

1. Настройте группу безопасности цели тестирования:

   {% include [security-groups-target](../../_includes/load-testing/security-groups-target.md) %}

## Подготовьте цель тестирования {#target-prepare}

Чтобы подготовить цель тестирования:

1. [Создайте ВМ](../../compute/operations/vm-create/create-linux-vm.md) из публичного образа Linux:
	1. В качестве имени задайте `load-target`.
	1. В качестве логина укажите, например, `ycuser`.
   1. Укажите группу безопасности `load-target-sg` в блоке сетевых настроек.

1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к ВМ по SSH, выполнив команду:
	```bash
	ssh ycuser@<публичный_IP-адрес_ВМ>
	```

1. Создайте файл веб-сервиса, выполнив:
	```bash
	mkdir app
	cd app
	nano app.py
	```

1. Скопируйте в файл веб-сервиса следующий код:
	```bash
	from flask import Flask, make_response
	from flask_cors import CORS
	import os

	app = Flask(__name__)
	CORS(app)

	@app.route('/')
	def index():
		 res = make_response({"message":"Root URL"}, status_code=200)
		 return res

	@app.route('/test')
	def get_test():
		 res = make_response({"message":"Get test URL"}, status_code=200)
		 return res

	# Run application
	if __name__ == '__main__':
		 app.run(host='0.0.0.0', debug=False, port=443)	
	```
1. Установите необходимые пакеты:
	```bash
	pip install flask flask-cors
	```

1. Запустите сервис:
	```bash
	python3 app.py
	```
	
	Сервис будет ожидать запросы на порт 443. Убедитесь что порт открыт и сконфигурирован для HTTPS-запросов.

## Создайте агент тестирования {#create-agent}

{% include [create-agent](../../_includes/load-testing/create-agent.md) %}

## Подготовьте файл с тестовыми данными {#test-file}

1. Сформируйте тестовые данные в формате [URI](../../load-testing/concepts/payloads/uri.md):
   ```text
   [Host: <внутренний_IP-адрес_цели_тестирования>]
   [Connection: Close]
   / index
   /test?param1=1&param2=2 get_test
   ```

   Обратите внимание на заголовок `Connection: Close` — каждое соединение будет закрываться после запроса. Для приложения и генератора нагрузки такой режим тяжелее. Если не нужно закрывать соединения, следует указать значение `Keep-Alive`.

   Также указаны два запроса, отмеченные тегами `index` и `get_test`. Генератор будет повторять их по очереди в пределах заданного [профиля нагрузки](../../load-testing/concepts/load-profile.md).

1. Сохраните тестовые данные в файл `data.uri`.

## Запустите тест {#run-test}

1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
1. На панели слева выберите ![image](../../_assets/load-testing/test.svg) **{{ ui-key.yacloud.load-testing.label_tests-list }}**. Нажмите **{{ ui-key.yacloud.load-testing.button_create-test }}**.
1. В параметре **{{ ui-key.yacloud.load-testing.label_agents-list }}** выберите агент `agent-008`.
1. В блоке **Прикрепленные файлы** нажмите **Выбрать файлы** и выберите сохраненный ранее файл `data.uri`.
1. В блоке **{{ ui-key.yacloud.load-testing.label_test-settings }}** выберите способ настройки: **{{ ui-key.yacloud.load-testing.label_settings-type-form }}** или **{{ ui-key.yacloud.load-testing.label_settings-type-config }}**.
1. В зависимости от выбранного способа задайте параметры теста:

   {% list tabs %}

   - {{ ui-key.yacloud.load-testing.label_settings-type-form }}

      1. В поле **{{ ui-key.yacloud.load-testing.field_load-generator }}** выберите **PANDORA**.
      1. В поле **Адрес цели** укажите внутренний IP-адрес тестируемого сервиса.
      1. В поле **Порт цели** укажите `443` (порт для HTTPS по умолчанию). Разрешите использовать защищенное соединение.
      1. В поле **Тестирующие потоки** укажите значение `5000`.

         Это означает, что генератор нагрузки сможет параллельно обрабатывать 5000 операций: создать 5000 соединений или ждать 5000 ответов от сервиса одновременно.

         {% note tip %}

         Для большинства тестов хватит 1000–10 000 [потоков](../../load-testing/concepts/testing-stream.md).

         Использование большего количества тестирующих потоков задействует больше ресурсов [виртуальной машины](../../compute/concepts/vm.md), на которой запущен агент. Также существует ограничение {{ compute-name }} на 50 000 одновременных соединений с ВМ.

         {% endnote %}

      1. В меню **Тип нагрузки** выберите `RPS`.
      1. Нажмите ![image](../../_assets/plus-sign.svg) **Профиль нагрузки** и введите описание:
         * **Профиль 1** — `step`.
         * **От** — `1000`.
         * **До** — `5000`.
         * **Шаг** — `1000`.
         * **Длительность** — `120s`.

         Это указание генератору наращивать нагрузку от 1000 до 5000 запросов в секунду с шагом в 1000 запросов, с длительностью каждого шага 120 секунд.
      1. В поле **Тип запросов** выберите `URI`.
      1. В поле **{{ ui-key.yacloud.load-testing.test-data-section }}** выберите **Прикрепленный файл**.
      1. В меню **Автостоп** нажмите ![image](../../_assets/plus-sign.svg) **Автостоп** и введите описание:
         * **Тип автостопа 1** — `QUANTILE`.
         * **Квантиль** — `75`.
         * **Лимит времени ответов** — `100ms`.
         * **Размер окна** — `10s`.

         Этот критерий остановит тест, если в течение 10 секунд 75 процентиль превысит 100 миллисекунд (в течение 10 секунд время обработки 25% запросов превысит 100 миллисекунд).
      1. Укажите еще один [автостоп](../../load-testing/concepts/auto-stop.md):
         * **Тип автостопа 2** — `INSTANCES`.
         * **Предел** — `90%`.
         * **Размер окна** — `60s`.

         Этот критерий остановит тест, если в течение 60 секунд будет занято 90% тестирующих потоков.

         При увеличении нагрузки ожидается, что в какой-то момент тестируемая система начнет деградировать. Дальнейшее повышение нагрузки приведет к увеличению времени ответа или росту количества ошибок. Чтобы избежать существенного увеличения времени тестирования, обязательно выставляйте в таких тестах критерий завершения — **Автостоп**.
      1. В поле **Время принудительной остановки теста** укажите время, после которого сработает автостоп, если тест не будет остановлен по другим причинам. Значение параметра должно быть немного больше ожидаемой продолжительности теста.
      1. В блоке **{{ ui-key.yacloud.load-testing.meta-section }}** укажите имя, описание и номер тестируемой версии. Это поможет сделать отчет читаемым.

   - {{ ui-key.yacloud.load-testing.label_settings-type-config }}

      1. В поле для ввода конфигурации введите настройки тестирующих потоков в формате `yaml`:

         ```yaml
         pandora:
            enabled: true
            package: yandextank.plugins.Pandora
            config_content:
            pools:
               - id: HTTP
                  gun:
                  type: http # Протокол.
                  target: <внутренний_IP-адрес_цели_тестирования>:443 
                  ssl: true
                  ammo:
                  type: uri
                  file: data.uri
                  result:
                  type: phout
                  destination: ./phout.log
                  rps:
                  - duration: 120s # Время теста.
                     type: step # Тип нагрузки.
                     from: 1000
                     to: 5000
                     step: 1000
                  startup:
                  type: once
                  times: 5000 # Количество тестирующих потоков.
            log:
               level: error
            monitoring:
               expvar:
                  enabled: true
                  port: 1234
         autostop: # Автостоп.
            enabled: true
            package: yandextank.plugins.Autostop
            autostop:
            - limit (5m) # Обязательно укажите предельное время работы теста.
            - quantile(75,100ms,10s) # Завершение теста, если в течение 10 секунд 75 процентиль
                                       # превысит 100 миллисекунд (в течение 10 секунд время
                                       # обработки 25% запросов превысит 100 миллисекунд).
            - instances(90%,60s)  # Завершение теста, если в течение 60 секунд будет занято
                                    # 90% тестирующих потоков.
         core: {}
         uploader:
            enabled: true
            package: yandextank.plugins.DataUploader
            job_name: '[example][pandora][step]'
            job_dsc: 'example'
            ver: '0.5.5'
            api_address: loadtesting.{{ api-host }}:443
         ```

         При увеличении нагрузки ожидается, что в какой-то момент тестируемая система начнет деградировать. Дальнейшее повышение нагрузки приведет к увеличению времени ответа или росту количества ошибок. Чтобы избежать существенного увеличения времени тестирования, обязательно выставляйте в таких тестах критерий завершения — **Автостоп**.

         {% note tip %}

         Посмотрите [пример файла конфигурации](../../load-testing/concepts/testing-stream.md#config_example). Также пример файла конфигурации можно посмотреть в уже имеющихся тестах.

         {% endnote %}

   {% endlist %}

1. Нажмите **{{ ui-key.yacloud.common.create }}**.

После этого конфигурация пройдет проверки, и агент начнет нагружать тестируемый сервис.

## Перезапустите тест {#rerun-test}

1. По завершении теста справа вверху нажмите кнопку ![image](../../_assets/load-testing/restart.svg) **{{ ui-key.yacloud.load-testing.restart }}**.
1. На открывшейся странице создания теста загрузите тот же файл `data.uri`, который использовали при создании теста.
1. Нажмите **{{ ui-key.yacloud.common.create }}**.

Повторите эти действия несколько раз, чтобы получить несколько завершенных тестов.

## Сравните результаты {#compare-results}


<iframe width="640" height="360" src="https://runtime.strm.yandex.ru/player/video/vplvlfh7uue6z55k7ek6?autoplay=0&mute=0" allow="autoplay; fullscreen; picture-in-picture; encrypted-media" frameborder="0" scrolling="no"></iframe>

[Смотреть видео на YouTube](https://www.youtube.com/watch?v=eEKKZ1M7IWU).



Чтобы сравнить результаты:

1. На панели слева выберите ![image](../../_assets/load-testing/test.svg) **{{ ui-key.yacloud.load-testing.label_tests-list }}** и в таблице тестов выберите завершенные тесты, которые нужно сравнить.
1. Внизу на всплывающей панели нажмите **{{ ui-key.yacloud.load-testing.button_comparison-test-add }}**.
1. На панели слева выберите ![image](../../_assets/load-testing/compare.svg) **{{ ui-key.yacloud.load-testing.label_tests-comparison-section-title }}** и просмотрите совмещенные графики результатов нагрузочных тестов.
1. Для сравнения результатов по конкретному запросу (например, по запросу `get_test`), выберите нужный запрос в выпадающем списке **Case** вверху страницы.
1. Сравнение результатов в табличном виде можно посмотреть на странице **{{ ui-key.yacloud.load-testing.label_tables }}**.

## Как удалить созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. [Удалите агент](../../compute/operations/vm-control/vm-delete.md).
1. [Удалите таблицу маршрутизации](../../vpc/operations/delete-route-table.md).
1. [Удалите NAT-шлюз](../../vpc/operations/delete-nat-gateway.md).

