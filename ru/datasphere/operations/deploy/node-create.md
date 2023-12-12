# Создать ноду

Вы можете развернуть отдельную ячейку ноутбука или сторонний [Docker-образ](../../../container-registry/concepts/docker-image.md) в виде самостоятельного сервиса, используя [ноды](../../concepts/resource-model.md#resources).

{% note warning %}

{% include [pricing nodes](../../../_includes/datasphere/nodes-pricing-warn.md) %}

{% endnote %}

Если вы используете в проекте пакеты и библиотеки, не входящие в [список предустановленного ПО](../../concepts/preinstalled-packages.md), предварительно [настройте окружение](node-customization.md) ноды с помощью Docker-образа.

## Создайте ноду {#create-node}

1. {% include [include](../../../_includes/datasphere/ui-before-begin.md) %}
1. Выберите ячейку, которую нужно развернуть в виде ноды, и запустите ее (используйте сочетание клавиш **Shift** + **Enter**). При этом в проекте будет автоматически создана [контрольная точка](../projects/checkpoints.md).

   {% note info %}

   Если вы работаете в [режиме автоматического сохранения состояния](../../concepts/save-state.md#auto-save), вам нужно принудительно сохранить состояние. Для этого нажмите сочетания клавиш **Cmd** + **K** или **Ctrl** + **K** и [создайте контрольную точку](../projects/checkpoints.md#create). 

   {% endnote %}

1. Закрепите контрольную точку:
    1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
    1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** выберите **{{ ui-key.yc-ui-datasphere.resources.checkpoint }}**.
    1. Выберите в списке последнюю добавленную контрольную точку с именем `Cell run` и убедитесь, что в ней содержится нужный код.
    1. В правом верхнем углу нажмите кнопку ![Pin](../../../_assets/datasphere/pin.svg) **{{ ui-key.yc-ui-datasphere.common.pin }}**.
    1. Во всплывающем окне введите имя контрольной точки и нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.pin }}**.
1. Создайте ноду:
    1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
    1. В правом верхнем углу нажмите кнопку **{{ ui-key.yc-ui-datasphere.project-page.project-card.create-resource }}**. Во всплывающем окне выберите **{{ ui-key.yc-ui-datasphere.resources.node }}**.
    1. Задайте основные параметры ноды:
        * **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.type }}** — ресурс, на основе которого создается нода: **{{ ui-key.yc-ui-datasphere.common.cell }}** или **{{ ui-key.yc-ui-datasphere.common.docker }}**.
        * **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.name }}** — имя ноды.
        * (Опционально) **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.Description }}** — описание ноды.
    1. В зависимости от типа ноды задайте прочие параметры:

        {% list tabs %}

        - Ячейка

          * В поле **{{ ui-key.yc-ui-datasphere.resources.checkpoint }}** выберите ранее созданную контрольную точку.
          * В блоках **{{ ui-key.yc-ui-datasphere.new-node.title.input-variables }}** и **{{ ui-key.yc-ui-datasphere.new-node.title.output-variables }}** определите имена и типы выходных и входных переменных, на основе которых будет автоматически сгенерирован [API](../../../glossary/rest-api.md). Вы можете добавить переменные, нажимая кнопку ![Add](../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-ui-datasphere.common.add-new }}**.
          * (Опционально) Если для выполнения кода ячейки используется [нестандартное окружение](node-customization.md), в блоке **{{ ui-key.yc-ui-datasphere.new-node.title.kernel-docker-image }}** выберите **{{ ui-key.yc-ui-datasphere.new-node.user-custom }}** и укажите:
            * **{{ ui-key.yc-ui-datasphere.new-node.kdi-form-label.user-name }}** — `json_key`.
            * **{{ ui-key.yc-ui-datasphere.new-node.kdi-form-label.password-secret }}** — [секрет](../../concepts/secrets.md) с паролем для вашего реестра контейнеров.

        - Docker-образ

          * В блоке **{{ ui-key.yc-ui-datasphere.new-node.title.docker-image }}** задайте путь к образу в {{container-registry-name}}. Нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.show-additional-parameters }}** и укажите:
            * **{{ ui-key.yc-ui-datasphere.new-node.kdi-form-label.user-name }}** — `json_key`.
            * **{{ ui-key.yc-ui-datasphere.new-node.kdi-form-label.password-secret }}** — [секрет](../../concepts/secrets.md) с паролем для вашего реестра контейнеров. См. [{#T}](node-customization.md).
          * В блоке **{{ ui-key.yc-ui-datasphere.new-node.title.endpoint }}**:
            * **{{ ui-key.yc-ui-datasphere.new-node.endpoint-form-label.type }}** — выберите протокол подключения к ноде: **HTTP** (**HTTP/2**) или **gRPC**.
            * **{{ ui-key.yc-ui-datasphere.new-node.endpoint-form-label.port }}** — укажите порт для подключения к ноде.
            * **{{ ui-key.yc-ui-datasphere.common.timeout }}** — укажите продолжительность сессии в секундах.
            * **{{ ui-key.yc-ui-datasphere.new-node.endpoint-form-label.idle-timeout }}** — укажите время простоя соединения до разъединения в секундах.
          * (Опционально) В блоке **{{ ui-key.yc-ui-datasphere.new-node.title.telemetry }}**:
            * **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.type }}** — выберите сервис для телеметрии: **{{ ui-key.yc-ui-datasphere.new-node.telemetry-form-label.prometheus }}** или **{{ ui-key.yc-ui-datasphere.new-node.telemetry-form-label.yandex-monitoring }}**. 
            * **{{ ui-key.yc-ui-datasphere.new-node.telemetry-form-label.http-path }}** — укажите адрес, на который будут отправляться данные телеметрии.
            * **{{ ui-key.yc-ui-datasphere.new-node.telemetry-form-label.port }}** — укажите порт, на который будут отправляться данные телеметрии.
          * (Опционально) В блоке **{{ ui-key.yc-ui-datasphere.new-node.title.healthcheck }}**:
            * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.type }}** — протокол, по которому проверяется состояние ноды: **HTTP** или **gRPC**.
            * **{{ ui-key.yc-ui-datasphere.common.port }}** — порт, с которого проверяется состояние ноды.
            * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.path }}** — путь к проверяемому ресурсу.
            * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.timeout }}** — продолжительность проверки в секундах.
            * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.interval }}** — интервал между проверками в секундах.
            * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.fails-threshold }}** — допустимое количество неудачных проверок.
            * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.passes-threshold }}** — необходимое количество пройденных проверок.

        {% endlist %}

    1. В блоке **{{ ui-key.yc-ui-datasphere.new-node.title.folder }}** выберите каталог, в котором будут создаваться новые ресурсы.
    1. В блоке **{{ ui-key.yc-ui-datasphere.new-node.title.provisioning }}** выберите [конфигурацию](../../concepts/configurations.md) вычислительных ресурсов [инстанса](../../concepts/deploy/index.md), [зону доступности](../../../overview/concepts/geo-scope.md) и идентификатор [подсети](../../../vpc/concepts/network.md#subnet) в которых будет размещен инстанс. 
    1. В блоке **{{ ui-key.yc-ui-datasphere.new-node.title.acl }}** нажмите кнопку ![Add](../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-ui-datasphere.new-node.add-acl }}** и укажите [идентификаторы каталогов](../../../resource-manager/operations/folder/get-id.md), из которых можно будет подключаться к ноде. По умолчанию указывается идентификатор каталога пользователя, создающего ноду.
    1. Нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.create }}**.

Чтобы посмотреть все созданные ноды:
1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** выберите **{{ ui-key.yc-ui-datasphere.resources.node }}**.

## Примеры {#examples}

### Развертывание ноды с генератором случайных чисел из ячейки {#randomizer}

Рассмотрим пример создания эндпоинта API, который принимает на вход границы числового диапазона и возвращает из него случайное целое число.

1. [Создайте проект](../projects/create.md) в **{{ ml-platform-name }}** и откройте его.
1. Создайте ноутбук, выбрав в меню **File** → **New** → **Notebook**.
1. Объявите входные параметры и не переопределяйте их в коде самого сервиса. Для этого создайте ячейку с кодом:

    ```python
    input_data = dict(left_bound=1, right_bound=10)
    ```

1. Выделите ячейку с кодом и запустите ее, выбрав в меню **Run** → **Run Selected Cells** (или используйте сочетание клавиш **Shift** + **Enter**).
1. Опишите сервис, который будет обрабатывать запросы к API. Создайте новую ячейку с кодом:

    ```python
    from random import randint
    from random import seed

    seed()

    def generate_value(input_data):
        return dict(generated_value=randint(
            input_data["left_bound"],
            input_data["right_bound"]
        ))

    output_data = generate_value(input_data)
    print(output_data)
    ```

1. Запустите ячейку. Результатом выполнения кода должна быть строка вида:

    ```json
    {'generated_value': <число от 1 до 10>}
    ```

    При этом в проекте будет автоматически создана контрольная точка. 
1. Закрепите контрольную точку:
    1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
    1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** выберите **{{ ui-key.yc-ui-datasphere.resources.checkpoint }}**.
    1. Выберите в списке последнюю добавленную контрольную точку с именем `Cell run` и убедитесь, что в ней содержится нужный код.
    1. В правом верхнем углу нажмите кнопку ![Pin](../../../_assets/datasphere/pin.svg) **{{ ui-key.yc-ui-datasphere.common.pin }}**.
    1. Во всплывающем окне введите имя контрольной точки, например `randomizer-checkpoint`, и нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.pin }}**.
1. Создайте ноду:
    1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
    1. В правом верхнем углу нажмите **{{ ui-key.yc-ui-datasphere.project-page.project-card.create-resource }}**. Во всплывающем окне выберите **{{ ui-key.yc-ui-datasphere.resources.node }}**.
    1. Задайте параметры ноды:
        * **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.type }}** — **{{ ui-key.yc-ui-datasphere.common.cell }}**.
        * **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.name }}** — имя ноды, например `randomizer-node`.
        * В поле **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.checkpoint }}** выберите контрольную точку `randomizer-checkpoint`.
        * В блоке **{{ ui-key.yc-ui-datasphere.new-node.title.input-variables }}** нажмите кнопку ![Add](../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-ui-datasphere.common.add-new }}** и создайте переменную со следующими параметрами:
          * **{{ ui-key.yc-ui-datasphere.new-node.variables-form-placeholder.name }}** — `input_data`.
          * **{{ ui-key.yc-ui-datasphere.common.type }}** — `{{ ui-key.yc-ui-datasphere.node-page.type.dict }}`.
        * В блоке **{{ ui-key.yc-ui-datasphere.new-node.title.output-variables }}** нажмите кнопку ![Add](../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-ui-datasphere.common.add-new }}** и создайте переменную со следующими параметрами:
          * **{{ ui-key.yc-ui-datasphere.new-node.variables-form-placeholder.name }}** — `output_data`.
          * **{{ ui-key.yc-ui-datasphere.common.type }}** — `{{ ui-key.yc-ui-datasphere.node-page.type.dict }}`.
    1. В блоке **{{ ui-key.yc-ui-datasphere.new-node.title.folder }}** выберите свой каталог.
    1. В блоке **{{ ui-key.yc-ui-datasphere.new-node.title.provisioning }}** выберите:
        * **{{ ui-key.yc-ui-datasphere.new-node.provisioning-form-label.instance-spec }}** — `c1.4`.
        * В блоке **{{ ui-key.yc-ui-datasphere.node-page.provisioning.distribution-by-zones }}** нажмите **{{ ui-key.yc-ui-datasphere.new-node.add-new-zone }}** и выберите `{{ region-id }}-a`. 
          * В появившемся меню в поле **{{ ui-key.yc-ui-datasphere.common.subnet }}** нажмите **{{ ui-key.yc-ui-datasphere.common.add-new }}**.
          * В открывшемся окне укажите идентификатор подсети, доступной в вашем каталоге. Если у вас нет подсети, [создайте](../../../vpc/operations/subnet-create.md) ее. 
          * Нажмите **{{ ui-key.yc-ui-datasphere.common.add }}**. 
    1. Нажмите **{{ ui-key.yc-ui-datasphere.common.create }}**.
1. Узнайте идентификатор ноды:
    1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
    1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** выберите **{{ ui-key.yc-ui-datasphere.resources.node }}**.
    1. Выберите созданную ноду и скопируйте ее идентификатор (он имеет вид `xxxxxxxxxxxxxxxxxxxx`).
1. [Получите IAM-токен](../../../iam/operations/iam-token/create.md) для аутентификации в API.
1. Установите утилиту [cURL](https://curl.se/) для отправки запросов REST API.
1. Запустите терминал и отправьте POST-запрос к API созданного сервиса, например:

    ```bash
    curl -X POST 'https://datasphere.{{ api-host }}/datasphere/v1/nodes/<идентификатор ноды>:execute' \
         -H 'Authorization: Bearer <IAM-токен>' \
         -H 'Content-Type: application/json' \
         --data-raw '{
            "folder_id": "<идентификатор каталога>",
            "input": {
              "input_data": {
                "left_bound": 1,
                "right_bound": 10
              }
            }
          }'
    ```

    Где:
    * `<идентификатор ноды>` — полученный ранее идентификатор ноды;
    * `<IAM-токен>` — IAM-токен для аутентификации;
    * `<идентификатор каталога>` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md), в котором создана нода.

    В ответе должно прийти случайное число в заданном диапазоне от 1 до 10:

    ```json
    {
      "output": {
        "output_data": {
          "generated_value": 6
        }
      }
    }
    ```

    Подробнее см. [{#T}](node-api.md).
1. Измените значения параметров запроса `left_bound` и `right_bound`. Отправьте к API несколько запросов и убедитесь, что возвращаются случайные значения из заданного диапазона.

#### См. также {#see-also}

* [{#T}](node-customization.md)
* [{#T}](node-api.md)
* [{#T}](node-update.md)
* [{#T}](node-delete.md)
* [{#T}](alias-create.md)
* [{#T}](../../tutorials/node-from-docker.md)
* [{#T}](../../tutorials/node-from-cell.md)
