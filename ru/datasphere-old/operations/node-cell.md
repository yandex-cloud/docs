# Создание ноды из ячейки с кодом на Python

{% include [link-on-new-ui-datasphere-in-old-ui](../../_includes/datasphere/datasphere-old-note.md) %}

Для развертывания ячейки в виде микросервиса необходима [контрольная точка](projects/checkpoints.md).

{% note info %}

Если в проекте вы используете пакеты и библиотеки, не входящие в [список предустановленного ПО](../concepts/preinstalled-packages.md), [настройте окружение](node-customization.md) ноды с помощью {% if lang == "ru" %}[Docker-образа](https://cloud.yandex.ru/blog/posts/2022/03/docker-containers){% else %}Docker-образа{% endif %}.

{% endnote %}

{% note warning %}

{% include [pricing nodes](../../_includes/datasphere/nodes-pricing-warn.md) %}

{% endnote %}

1. Откройте вкладку ![Checkpoints](../../_assets/datasphere/jupyterlab/checkpoints-panel.svg) **Checkpoints** и сохраните контрольную точку, подготовленную для развертывания.

1. Откройте ноутбук и выберите ячейку для развертывания.

1. Вызовите контекстное меню правой кнопкой мыши и выберите пункт **Deploy selected cell**.

1. В диалоговом окне задайте:
   * В поле **Name** — имя ноды.
   * В выпадающем списке **Select checkpoint to use for deployment** выберите нужную контрольную точку.
   * В блоках **Output variables** и **Input variables** определите имена и типы выходных и входных переменных, на основе которых будет автоматически сгенерирован API. Вы можете добавить переменные, нажимая на кнопку **Add new**.
   * В поле **Instance count** введите количество ВМ в ноде.

1. Нажмите кнопку **Create**, чтобы создать ноду.

После создания ноды вы увидите ее идентификатор внизу окна. Посмотреть все созданные ноды можно на вкладке ![Node](../../_assets/datasphere/node.svg) **Nodes**.

Если развернутая нода вам больше не нужна, [удалите ее](node-delete.md).

## Примеры {#examples}

### Развертывание ноды с генератором случайных чисел {#randomizer}

Рассмотрим пример создания эндпоинта API, который принимает на вход границы числового диапазона и возвращает из него случайное целое число.

1. [Создайте проект](../operations/projects/create) в **{{ ml-platform-name }}** и откройте его.
1. Создайте ноутбук, выбрав в меню **File** → **New** → **Notebook**.
1. Объявите входные параметры и не переопределяйте их в коде самого сервиса. Для этого создайте ячейку с кодом:

    ```python
    input_data = dict(left_bound=1, right_bound=10)
    ```

1. Выделите ячейку с кодом и запустите ее, выбрав в меню **Run** → **Run Selected Cells**

    {% note tip %}

    Для запуска ячеек можно использовать сочетание клавиш **Shift+Enter**.

    {% endnote %}

1. Определите сервис, который будет обрабатывать запросы к API. Создайте новую ячейку с кодом:

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

1. [Сохраните контрольную точку](../operations/projects/checkpoints.md#pin).

1. Вызовите контекстное меню ячейки с кодом сервиса и выберите пункт **Deploy selected cell**.
1. В открывшейся форме задайте параметры ноды:

    * **Name** — задайте произвольное имя ноды.
    * **Select checkpoint to use for deployment** — выберите сохраненную ранее контрольную точку.
    * **Output variables** — нажмите кнопку **Add new** и создайте переменную со следующими параметрами:

        * **name** — `output_data`;
        * **type** — `dict`.

    * **Required input variables** — нажмите кнопку **Add new** и создайте переменную со следующими параметрами:

        * **name** — `input_data`;
        * **type** — `dict`.

    * **Instance count** — Укажите количество хостов, на которых будет выполняться ячейка ноутбука. Минимальное значение — `2`.

1. Нажмите кнопку **Create**.
1. В меню слева перейдите на вкладку ![Node](../../_assets/datasphere/node.svg) **Nodes**.
1. Дождитесь, когда созданная нода перейдет в состояние **HEALTHY**. Обновите страницу, чтобы узнать текущий статус ноды.
1. Выберите ноду и скопируйте ее идентификатор из правой части страницы (он имеет вид `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx`).
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
    * `<IAM-токен>` — [IAM-токен](../../iam/operations/iam-token/create.md);
    * `<идентификатор каталога>` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором созданы проект и нода.

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

1. Измените значения параметров запроса `left_bound` и `right_bound`. Отправьте к API несколько запросов и убедитесь, что возвращаются случайные значения из заданного диапазона.

#### См. также {#see-also}

* [{#T}](node-customization.md).
* [{#T}](node-api.md)
* [{#T}](node-delete.md).
