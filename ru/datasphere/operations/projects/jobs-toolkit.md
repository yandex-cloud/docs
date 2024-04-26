# Работа с заданиями из Visual Studio Code

Расширение {{ ds-jobs }} Toolkit позволяет работать с [заданиями](../../concepts/jobs/index.md) {{ ml-platform-name }} из IDE [Visual Studio Code](https://code.visualstudio.com/). Для этого потребуется аккаунт {{ yandex-cloud }} и [проект](../../concepts/project.md) {{ ml-platform-name }}.

{{ ds-jobs }} Toolkit использует утилиту [{{ ds-cli }}](../../concepts/jobs/cli.md) для анализа среды и обнаружения зависимостей. Она будет автоматически установлена в текущую виртуальную среду при первом запуске любого задания.

{% note info %}

Чтобы использовать расширение, понадобится установленная IDE [Visual Studio Code](https://code.visualstudio.com/), [Python 3.10](https://www.python.org/downloads/release/python-3100/) и [Python extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-python.python).

{% endnote %}

При запуске задания библиотека `datasphere` анализирует окружение, собирает зависимости кода и может передавать их в {{ ml-platform-name }} для развертывания окружения на ВМ в облаке. Чтобы избежать лишних системных зависимостей, которые могут нарушить работу задания, рекомендуем использовать виртуальное окружение [venv](https://docs.python.org/3/library/venv.html) или [conda](https://docs.conda.io/en/latest/#).

{% include [jobs-info](../../../_includes/datasphere/jobs-environment.md) %}

## Установите расширение {{ ds-jobs }} Toolkit {#setup}

1. Откройте [страницу расширения в маркетплейсе](https://marketplace.visualstudio.com/items?itemName=yandex-cloud.ds-toolkit-vscode).
1. Нажмите **Install**.
1. Браузер предложит открыть приложение Visual Studio Code. Нажмите **Открыть приложение**.
1. На открывшейся странице расширения {{ ds-jobs }} Toolkit в Visual Studio Code нажмите **Install**.

После успешного завершения установки на странице расширения появится надпись **This extension is enabled globally**.

## Аутентифицируйтесь в {{ ds-jobs }} {#authentication}

Чтобы работать с {{ ds-jobs }}, аутентифицируйтесь с аккаунтом на Яндексе или федеративным аккаунтом.

{% list tabs group=authentication %}

- Аккаунт на Яндексе {#yandex-account}

  1. Получите [OAuth-токен](../../../iam/concepts/authorization/oauth-token.md).
     
     {% include [описание](../../../_includes/oauth-token-lifetime.md) %}

  1. В верхней части окна Visual Studio Code нажмите **Search** и введите команду `> DataSphere Jobs: Set OAuth token`. В открывшемся окне нажмите **Open**, чтобы перейти на страницу получения OAuth-токена.

      Если у вас уже есть OAuth-токен, нажмите **Cancel**.
  1. В открывшемся поле **Input OAuth-token** введите OAuth-токен.

  Чтобы удалить OAuth-токен, воспользуйтесь командой `> DataSphere Jobs: Remove OAuth token`.

- Федеративный аккаунт {#federated-account}

  Для аутентификации федеративного аккаунта необходим установленный и настроенный интерфейс [YC CLI](../../../cli/quickstart.md). Если YC CLI установлен в каталог по умолчанию или путь к нему задан в переменной среде `Path`, то расширение обнаружит его автоматически. Если этого не произошло, то укажите путь к исполняемому файлу YC CLI в настройках расширения:

  1. На панели слева выберите **{{ ds-jobs }}** и нажмите **Settings**.
  1. В поле **Datasphere: Yandex Cloud Console Path** укажите путь к исполняемому файлу YC CLI, например:

      ```text
      C:\Users\<имя_пользователя>\yandex-cloud\bin\yc.exe
      ```

{% endlist %}

## Запустите задание {#run-job}

1. На панели слева выберите ![logo](../../../_assets/datasphere/ds-logo.svg) **{{ ds-jobs }}** и нажмите **Settings**.
1. В поле **Datasphere: Project** введите идентификатор проекта. Чтобы получить идентификатор проекта, нажмите значок **ID** на странице вашего проекта в [интерфейсе {{ ml-platform-name }}]({{ link-datasphere-main }}/projects).
1. Откройте Python-файл с помощью {{ ds-jobs }} Toolkit. Для этого в проводнике Visual Studio Code нажмите на нужный файл правой кнопкой мыши и выберите **Run File in DataSphere Jobs**.

    Вы также можете предварительно открыть файл с кодом задания в Visual Studio Code, в правом верхнем углу окна редактирования нажать **Run and Debug** и выбрать **Run File in DataSphere Jobs**.

    При тестировании расширения вы можете воспользоваться [примером кода](./work-with-jobs.md#example). Другие примеры для запуска заданий доступны в [репозитории](https://github.com/yandex-cloud-examples/yc-datasphere-jobs-examples) на GitHub.

1. В открывшемся окне **DataSphere Job Configuration** выполните настройки:

    {% list tabs %}

    - BASIC
  
      Настройте основные параметры запуска, соответствующие значениям в [файле](./work-with-jobs.md#create-job) `config.yaml`:

      * **Working directory** — рабочая директория с необходимыми для запуска задания файлами.
      * **Inputs** — файлы с входными данными в формате `<путь>=<имя_переменной>`. Каждую пару значений указывайте в отдельной строке.
      * **Outputs** — файлы с результатами в формате `<путь>=<имя_переменной>`. Каждую пару значений указывайте в отдельной строке.
  
    - ADVANCED
  
      Настройте дополнительные параметры:

      * **Project Identifier** — идентификатор проекта {{ ml-platform-name }}.
      * **Configuration file path** — путь к готовому файлу конфигурации `config.yaml`.
      * **Instance Type** — параметры [конфигурации ВМ](../../concepts/configurations.md), на которой будет выполняться задание.
      * **S3 mounts** — идентификаторы [коннекторов S3](../../concepts/s3-connector.md). При передаче нескольких коннекторов S3 указывайте каждый идентификатор в отдельной строке.
      * **Datasets** — [датасеты](../../concepts/dataset.md) в формате `<датасет>=<имя_переменной>`. Каждую пару значений указывайте в отдельной строке.
  
    - ENVIRONMENT
  
      Настройте [Docker-образ](../../concepts/docker.md):

      * **Variables** — необходимые для запуска кода переменные в формате `<имя>:<значение>`. Каждую пару значений указывайте в отдельной строке.
      * **Docker** — параметры Docker-образа:
          * **Image** — ссылка на Docker-образ.
          * **User** — системный аккаунт с паролем или идентификатором секрета, содержащего [авторизованный ключ](../../../iam/concepts/authorization/key.md).
  
    - PYTHON
  
      Настройте рабочее пространство Python:

      * **Environment dependency build method** — выберите автоматический или ручной метод определения зависимостей рабочего пространства.
      * **Extra root paths** — дополнительные корневые папки. Каждое значение указывайте в отдельной строке.
      * **Extra index urls** — дополнительные индексные URL-адреса.
      * При необходимости включите опцию **No Dependencies**, чтобы не определять зависимости рабочего пространства.

    {% endlist %}

    Чтобы сохранить текущие параметры в файл `launch.json` для использования в последующих заданиях, нажмите кнопку **Save**. Чтобы выгрузить конфигурацию задания в файл `config.yaml`, нажмите кнопку **Export**.

    Вы также можете загрузить сохраненную ранее готовую конфигурацию задания. Для этого нажмите кнопку **Load**.

1. Чтобы запустить конфигурацию, нажмите кнопку **Invoke**.

    В результате успешного запуска задания в расширении {{ ds-jobs }} Toolkit откроется окно **DEBUG CONSOLE** со ссылкой на задание в {{ ml-platform-name }}:

    ```txt
    creating job ...
    uploading 37 files (129.7MB) ...
    files are uploaded
    created job `bt19qb2pb0ji********`
    executing job ...
    job link: https://datasphere.yandex.ru/communities/bt11e3m29qti********/projects/bt1eq06id8kv********/job/bt19qb2pb0ji********
    ```

    В окне **OUTPUT** также доступны вкладки со следующей информацией:

    * **DataSphere Jobs Invocation** — результаты выполнения кода пользователя.
    * **DataSphere Jobs Toolkit** — сообщения о запуске, завершении задачи и ошибках.
    * **DataSphere Jobs Toolkit Logs** — информация о работе расширения.

## Посмотрите историю заданий {#job-history}

Расширение {{ ds-jobs }} Toolkit позволяет просматривать историю заданий и работать с ними.

Чтобы посмотреть историю заданий {{ ds-jobs }}, на панели слева выберите ![logo](../../../_assets/datasphere/ds-logo.svg) **{{ ds-jobs }}**. В открывшейся панели **DATASPHERE JOBS: LAUNCH HISTORY** вы увидите историю заданий, отсортированных по времени запуска.

Панель с историей заданий {{ ds-jobs }} позволяет выполнять следующие действия:

* **Cancel** — останавливать задание.
* **Attach** — подключаться к заданию.
* **Copy job ID** — копировать идентификатор задания.
* **Open job** — открывать задание в браузере.

#### См. также {#see-also}

* [{#T}](../../concepts/jobs/index.md)
* [{#T}](./work-with-jobs.md)