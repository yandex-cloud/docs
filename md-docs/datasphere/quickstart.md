# Как начать работать с DataSphere

Yandex DataSphere — среда для ML-разработки полного цикла, которая сочетает в себе привычные IDE, технологию бессерверных вычислений и возможность бесшовного использования разных конфигураций вычислительных ресурсов Yandex Cloud. Yandex DataSphere является частью платформы данных и предоставляет широкие возможности для простого взаимодействия с сервисами Yandex Cloud. В качестве IDE DataSphere предоставляет [Jupyter® Notebook](https://jupyter.org/).

В этом разделе вы научитесь:
1. [Создавать проект](#create-project).
1. [Запускать проект](#start-project).
1. [Настраивать окружение](#install-dependencies).
1. [Загружать данные в проект](#download-data).
1. [Запускать обучение](#start-ml).

## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь, если вы еще не зарегистрированы.
1. Перейдите в сервис [Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts) и убедитесь, что у вас подключен [платежный аккаунт](../billing/concepts/billing-account.md) и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md#create_billing_account).
1. Откройте [главную страницу](https://datasphere.yandex.cloud) DataSphere.
1. Примите пользовательское соглашение.
1. Выберите организацию, в которой вы будете работать с DataSphere, или создайте новую.

## Создайте проект {#create-project}

1. Откройте [главную страницу](https://datasphere.yandex.cloud) DataSphere.
1. На панели слева выберите ![image](../_assets/console-icons/circles-concentric.svg) **Сообщества**.
1. Выберите сообщество, в котором вы хотите создать проект.
1. На странице сообщества нажмите кнопку ![image](../_assets/console-icons/folder-plus.svg) **Создать проект**.
1. В открывшемся окне укажите имя и (опционально) описание проекта.
1. Нажмите кнопку **Создать**.

## Запустите проект {#start-project}

Чтобы запустить проект, нажмите кнопку **Открыть проект в JupyterLab**.

## Настройте окружение {#install-dependencies}

Популярные пакеты для [анализа данных](../glossary/data-analytics.md) и машинного обучения уже предустановлены и готовы к использованию, смотрите [список](concepts/preinstalled-packages.md).

Вы можете установить недостающие пакеты с помощью пакетного менеджера pip.

Чтобы установить пакет:

1. Напишите в ячейке ноутбука команду:

    ```
    %pip install <имя_пакета>
    ```

    Например, установите пакет [seaborn](https://github.com/mwaskom/seaborn) для визуализации статистических данных:

    ```
    %pip install seaborn
    ```

    Вы можете использовать различные опции, которые поддерживает команда [pip install](https://pip.pypa.io/en/stable/cli/pip_install/). Смотрите [примеры использования](https://pip.pypa.io/en/stable/cli/pip_install/#pip-install-examples) этой команды.
1. Выполните ячейку. Для этого нажмите значок ![Run](../_assets/datasphere/jupyterlab/run.svg).

    Результат установки пакета отобразится под ячейкой.

Вы также можете настроить окружение для выполнения вашего кода, [используя Docker-образы](operations/user-images.md).

## Загрузите данные в проект {#download-data}

{% note warning %}

После 20.04.2026 создание новых [датасетов](concepts/dataset.md) станет невозможным. Для хранения данных используйте [файловые хранилища](concepts/filestores.md). Датасеты, созданные до 20.04.2026, продолжат работать без изменений.

{% endnote %}

Данные небольшого объема (до 100 МБ) можно загрузить в проект DataSphere через интерфейс JupyterLab. Больший объем информации рекомендуем загружать из сетевых хранилищ и баз данных. Также для работы с большим объемом данных используются [датасеты](concepts/dataset.md).

Чтобы загрузить данные в проект через интерфейс JupyterLab:

1. В блоке ![folder](../_assets/datasphere/jupyterlab/folder.svg) **File Browser** выберите папку, в которую нужно загрузить данные.
1. Слева сверху нажмите кнопку ![upload](../_assets/datasphere/jupyterlab/upload.svg).
1. Выберите файлы, которые нужно загрузить.

[Подробнее о хранилище проекта](concepts/project.md#storage).

DataSphere позволяет загружать данные из разных источников:

* [Подключение к S3 с помощью библиотеки boto3](operations/data/connect-to-s3.md).
* [Подключение к Google Drive](operations/data/connect-to-google-drive.md).
* [Подключение к базе данных ClickHouse®](operations/data/connect-to-clickhouse.md).
* [Подключение к базе данных PostgreSQL](operations/data/connect-to-postgresql.md).
* [Подключение к Яндекс Диску](operations/data/connect-to-ya-disk.md).

## Запустите обучение {#start-ml}

Чтобы запустить вычисления:

1. В блоке ![folder](../_assets/datasphere/jupyterlab/folder.svg) **File Browser** выберите ноутбук, в котором содержится код на Python или bash.
1. Выберите одну или несколько ячеек с кодом и запустите их, выбрав в меню **Run → Run Selected Cells** (также можно использовать сочетание клавиш **Shift** + **Enter**).
1. Дождитесь завершения операции.

    Результат выполнения отобразится под ячейкой.

## Что дальше {#what-is-next}

* [Узнайте об особенностях сервиса](concepts/index.md).
* [Посмотрите другие инструкции по работе с сервисом](operations/index.md).
* [Разверните обученную модель как сервис](concepts/deploy/index.md).