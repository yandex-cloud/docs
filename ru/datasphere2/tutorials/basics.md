# Знакомство с {{ ml-platform-name }}

{{ ml-platform-full-name }} позволяет анализировать данные и строить модели машинного обучения, используя привычный интерфейс Jupyter Notebook. Этот сценарий использования познакомит вас с возможностями сервиса на примере работы с ноутбуком для набора данных [2017 Kaggle ML & DS Survey](https://www.kaggle.com/kaggle/kaggle-survey-2017) (опрос пользователей [Kaggle](https://www.kaggle.com/) 2017 года).

Чтобы познакомиться с сервисом:

1. [{#T}](#get-cwd).
1. [{#T}](#unzip-dataset).
1. [{#T}](#satisfy-dependencies).
1. [{#T}](#load-dataset).
1. [{#T}](#analyze-dataset).

## Перед началом работы {#before-you-begin}

1. [Создайте новый пустой проект](../operations/projects/create) в **{{ ml-platform-name }}** и откройте его.
1. [Склонируйте](../operations/projects/work-with-git.md#clone) Git-репозиторий, в котором находится подготовленный ноутбук с набором данных:

    ```text
    https://github.com/dalyona/Yandex_Scale_DataSphere_demo
    ```

    Дождитесь, когда клонирование завершится, это может занять некоторое время. После завершения операции в блоке ![folder](../../_assets/datasphere/jupyterlab/folder.svg) **File Browser** появится каталог склонированного репозитория.

1. Откройте каталог **Yandex_Scale_DataSphere_demo** и ознакомьтесь с содержимым ноутбука **kaggle2017.ipynb**.

    {% include [safe-state-warn](../../_includes/datasphere/safe-state.md) %}

## Определите текущий рабочий каталог {#get-cwd}

1. Выберите первую ячейку с кодом:

    ```python
    # Let's check our current directory and change it
    import os
    os.getcwd()
    ```

    Вызов функции `getcwd()` из модуля `os` при выполнении вернет имя текущего каталога.

1. Запустите эту ячейку, выбрав в меню **Run → Run Selected Cells** (также можно использовать сочетание клавиш **Shift** + **Enter**).

    {% note info %}

    По умолчанию все ячейки запускаются на [конфигурации <q>c1.4</q>](../concepts/configurations.md) c минимальными вычислительными ресурсами. Вы можете выполнить одну или несколько ячеек (или даже ноутбук целиком) на разных конфигурациях, при этом состояние ноутбука сохранится — переменные и результаты уже сделанных вычислений не будут сброшены. Подробнее см. в разделе [{#T}](../operations/projects/control-compute-resources.md).

    {% endnote %}

1. Дождитесь завершения операции.

{{ ml-platform-full-name }} запустит виртуальную машину, выполнит код в ячейке и вернет результат прямо под этой ячейкой, например:

```text
'/home/jupyter/work/resources/Yandex_Scale_DataSphere_demo'
```

## Разархивируйте набор данных {#unzip-dataset}

1. Добавьте новую ячейку с кодом для разархивации файлов, выбрав в меню **Snippets → Extract ZIP file.py**. Ячейка с кодом будет добавлена сразу после текущей выбранной ячейки.

1. Измените значение переменной `fname` в ячейке:

    ```bash
    fname=./input.zip
    ```

1. Запустите эту ячейку с кодом.
1. Дождитесь завершения операции.

Архив `input.zip` будет разархивирован в каталог `input` внутри текущего рабочего каталога.

## Установите зависимости {#satisfy-dependencies}

1. Выберите и запустите ячейку с кодом в разделе **Introduction for this demo and Kaggle data**:

    ```python
    # Let's start with import and install all necessary libraries and packages
    # Import packages that are pre-installed already and install through %pip packages that are not in the list, although requires
    import pandas as pd
    %pip install seaborn
    import seaborn as sns
    import matplotlib.pyplot as plt
    ...
    ```

1. Дождитесь завершения операции.

Часть пакетов уже установлена и импортируется с помощью команды `import`, часть устанавливается с помощью команды `%pip install` и затем импортируется. Полный список предустановленных в {{ ml-platform-name }} пакетов см. в разделе [{#T}](../concepts/preinstalled-packages.md).

## Загрузите набор данных из файла {#load-dataset}

В этом сценарии для загрузки данных из файла `input/multipleChoiceResponses.csv` и вывода первых нескольких строк используются возможности библиотеки Pandas. Чтобы загрузить набор данных и получить первые пять строк из этого набора:

1. Выделите следующие две ячейки с кодом, удерживая **Shift** и нажимая слева от них:

    ```python
    response=pd.read_csv('input/multipleChoiceResponses.csv',encoding='ISO-8859-1')
    ```

    ```python
    response.head()
    ```

    Подробнее метод `head()` рассматривается в [документации Pandas](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.head.html#pandas.DataFrame.head).

1. Запустите эти ячейки.

1. Дождитесь завершения операции.

## Получите статистику по набору данных {#analyze-dataset}

1. Выделите ячейку в разделе **Some Basic Analysis**:

    ```python
    print('The total number of respondents:',response.shape[0])
    print('Total number of Countries with respondents:',response['Country'].nunique())
    print('Country with highest respondents:',response['Country'].value_counts().index[0],'with',response['Country'].value_counts().values[0],'respondents')
    print('Youngest respondent:',response['Age'].min(),' and Oldest respondent:',response['Age'].max())
    ```

1. Запустите процесс выполнения этой и всех последующих ячеек, выбрав в меню **Run → Run Selected Cell and All Below**.

1. Дождитесь завершения операции.

{% note info %}

Вы можете [поделиться](../operations/projects/publication.md) готовым ноутбуком с расчетами или [экспортировать проект](../operations/projects/export.md) целиком.

{% endnote %}
