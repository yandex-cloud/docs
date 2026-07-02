[Документация Yandex Cloud](../../../index.md) > [Yandex DataSphere](../../index.md) > [Пошаговые инструкции](../index.md) > DataSphere Jobs > Работа с заданиями из Visual Studio Code

# Работа с заданиями из Visual Studio Code

Расширение DataSphere Jobs Toolkit позволяет работать с [заданиями](../../concepts/jobs/index.md) DataSphere из IDE [Visual Studio Code](https://code.visualstudio.com/). Для этого потребуется аккаунт Yandex Cloud и [проект](../../concepts/project.md) DataSphere.

DataSphere Jobs Toolkit использует утилиту [DataSphere CLI](../../concepts/jobs/cli.md) для анализа среды и обнаружения зависимостей. Она будет автоматически установлена в текущую виртуальную среду при первом запуске любого задания.

{% note info %}

Чтобы использовать расширение, понадобится установленная IDE [Visual Studio Code](https://code.visualstudio.com/), [Python 3.10](https://www.python.org/downloads/release/python-3100/) и [Python extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-python.python).

{% endnote %}

При запуске задания библиотека `datasphere` анализирует окружение, собирает зависимости кода и может передавать их в DataSphere для развертывания окружения на ВМ в облаке. Чтобы избежать лишних системных зависимостей, которые могут нарушить работу задания, рекомендуем использовать виртуальное окружение [venv](https://docs.python.org/3/library/venv.html) или [conda](https://docs.conda.io/en/latest/#).

{% note info %}

Для запуска заданий DataSphere используется Python [venv](https://docs.python.org/3/tutorial/venv.html). Поддерживаются версии Python 3.8–3.12. 

{% endnote %}

## Установите расширение DataSphere Jobs Toolkit {#setup}

1. Откройте [страницу расширения в маркетплейсе](https://marketplace.visualstudio.com/items?itemName=yandex-cloud.ds-toolkit-vscode).
1. Нажмите **Install**.
1. Браузер предложит открыть приложение Visual Studio Code. Нажмите **Открыть приложение**.
1. На открывшейся странице расширения DataSphere Jobs Toolkit в Visual Studio Code нажмите **Install**.

После успешного завершения установки на странице расширения появится надпись **This extension is enabled globally**.

## Аутентифицируйтесь в DataSphere Jobs {#authentication}

Чтобы работать с DataSphere Jobs, аутентифицируйтесь с аккаунтом на Яндексе или федеративным аккаунтом.

{% list tabs group=authentication %}

- Аккаунт на Яндексе {#yandex-account}

  1. Получите [OAuth-токен](../../../iam/concepts/authorization/oauth-token.md).

     Срок жизни OAuth-токена — 1 год. После этого необходимо [получить новый OAuth-токен](https://oauth.yandex.ru/authorize?response_type=token&client_id=1a6990aa636648e9b2ef855fa7bec2fb) и повторить процедуру аутентификации.

  1. В верхней части окна Visual Studio Code нажмите **Search** и введите команду `> DataSphere Jobs: Set OAuth token`. В открывшемся окне нажмите **Open**, чтобы перейти на страницу получения OAuth-токена.

      Если у вас уже есть OAuth-токен, нажмите **Cancel**.
  1. В открывшемся поле **Input OAuth-token** введите OAuth-токен.

  Чтобы удалить OAuth-токен, воспользуйтесь командой `> DataSphere Jobs: Remove OAuth token`.

- Федеративный или локальный аккаунт {#federated-account}

  Для аутентификации федеративного или локального аккаунта необходим установленный и настроенный интерфейс [CLI](../../../cli/quickstart.md). Если CLI установлен в каталог по умолчанию или путь к нему задан в переменной среды `Path`, то расширение обнаружит его автоматически. Если этого не произошло, то укажите путь к исполняемому файлу CLI в настройках расширения:

  1. На панели слева выберите **DataSphere Jobs** и нажмите **Settings**.
  1. В поле **Datasphere: Yandex Cloud Console Path** укажите путь к исполняемому файлу CLI, например:

      ```text
      C:\Users\<имя_пользователя>\yandex-cloud\bin\yc.exe
      ```

{% endlist %}

## Запустите задание {#run-job}

1. На панели слева выберите ![logo](../../../_assets/datasphere/ds-logo.svg) **DataSphere Jobs** и нажмите **Settings**.
1. В поле **Datasphere: Project** введите идентификатор проекта. Чтобы получить идентификатор проекта, нажмите значок **ID** на странице вашего проекта в [интерфейсе DataSphere](https://datasphere.yandex.cloud/projects).
1. Откройте Python-файл с помощью DataSphere Jobs Toolkit. Для этого в проводнике Visual Studio Code нажмите на нужный файл правой кнопкой мыши и выберите **Run File in DataSphere Jobs**.

    Вы также можете предварительно открыть файл с кодом задания в Visual Studio Code, в правом верхнем углу окна редактирования нажать **Run and Debug** и выбрать **Run File in DataSphere Jobs**.

    При тестировании расширения вы можете воспользоваться [примером кода](work-with-jobs.md#example). Другие примеры для запуска заданий доступны в [репозитории](https://github.com/yandex-cloud-examples/yc-datasphere-jobs-examples) на GitHub.

1. В открывшемся окне **DataSphere Job Configuration** выполните настройки:

    {% list tabs %}

    - BASIC

      Настройте основные параметры запуска, соответствующие значениям в [файле](work-with-jobs.md#create-job) `config.yaml`:

      * **Working directory** — рабочая директория с необходимыми для запуска задания файлами.
      * **Inputs** — файлы с входными данными в формате `<путь>=<имя_переменной>`. Каждую пару значений указывайте в отдельной строке.
      * **Outputs** — файлы с результатами в формате `<путь>=<имя_переменной>`. Каждую пару значений указывайте в отдельной строке.

    - ADVANCED

      Настройте дополнительные параметры:

      * **Project Identifier** — идентификатор проекта DataSphere.
      * **Configuration file path** — путь к готовому файлу конфигурации `config.yaml`.
      * **Instance Type** — параметры [конфигурации ВМ](../../concepts/configurations.md), на которой будет выполняться задание.
      * **S3 mounts** — идентификаторы [коннекторов S3](../../concepts/s3-connector.md). При передаче нескольких коннекторов S3 указывайте каждый идентификатор в отдельной строке.
      * **Datasets** — [датасеты](../../concepts/dataset.md) в формате `<датасет>=<имя_переменной>`. Каждую пару значений указывайте в отдельной строке.

    - ENVIRONMENT

      Настройте [Docker-образ](../../concepts/docker.md):

      * **Variables** — необходимые для запуска кода переменные в формате `<имя>:<значение>`. Каждую пару значений указывайте в отдельной строке.
      * **Docker** — параметры Docker-образа:
          * **Image** — ссылка на Docker-образ.
          * **User** — системный аккаунт с паролем или именем секрета, содержащего [авторизованный ключ](../../../iam/concepts/authorization/key.md).

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

    В результате успешного запуска задания в расширении DataSphere Jobs Toolkit откроется окно **DEBUG CONSOLE** со ссылкой на задание в DataSphere:

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

Расширение DataSphere Jobs Toolkit позволяет просматривать историю заданий и работать с ними.

Чтобы посмотреть историю заданий DataSphere Jobs, на панели слева выберите ![logo](../../../_assets/datasphere/ds-logo.svg) **DataSphere Jobs**. В открывшейся панели **DATASPHERE JOBS: LAUNCH HISTORY** вы увидите историю заданий, отсортированных по времени запуска.

Панель с историей заданий DataSphere Jobs позволяет выполнять следующие действия:

* **Cancel** — останавливать задание.
* **Attach** — подключаться к заданию.
* **Copy job ID** — копировать идентификатор задания.
* **Open job** — открывать задание в браузере.

#### Полезные ссылки {#see-also}

* [DataSphere Jobs](../../concepts/jobs/index.md)
* [Запуск заданий DataSphere Jobs](work-with-jobs.md)