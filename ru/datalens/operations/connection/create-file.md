---
title: Как создать подключение к файлу в {{ datalens-full-name }}
description: Следуя данной инструкции, вы сможете создать подключение к файлу.
---

# Создание подключения к файлу

Чтобы создать подключение к файлу:

1. Перейдите на [страницу создания нового подключения]({{ link-datalens-main }}/connections/new).
1. В разделе **Файлы и сервисы** выберите подключение **Файлы**.
1. Нажмите кнопку **Загрузить файлы** и укажите файл. Информация о добавленном файле и загружаемые данные отобразятся в центральной области экрана.

   {% note info %}

   * В настоящее время доступна загрузка файлов форматов CSV, TXT и Excel (только `xlsx`).
   * Количество файлов в одном подключении не может быть больше десяти. Каждый лист Excel считается как отдельный файл.
   * Размер каждого файла не должен превышать 200 МБ.
   * Максимальное число столбцов в одном файле — 300.
   * После загрузки файла в превью отображаются только первые 30 строк.

   {% endnote %}

1. Выберите параметры загрузки файла:

   {% list tabs %}

   - CSV или TXT

     1. Информация о добавленном файле и загружаемые данные отобразятся в центральной области экрана. В верхней части экрана выберите:

        * **Кодировка**. Укажите кодировку данных из файла. Доступны значения `utf-8`, `utf-16`, `windows-1251` и `utf-8-sig`.
        * **Разделитель**. Укажите разделитель, который используется в файле. Доступны значения `Запятая`, `Точка с запятой` и `Знак табуляции`.
        * **Заголовок столбцов**. Выберите опцию заголовка. Если выберете **Да**, то {{ datalens-short-name }} использует первую строку данных в качестве заголовка.

     1. (Опционально) Выберите тип данных для каждого столбца. Для этого нажмите значок слева от названия столбца.

   - Excel

     1. Если в загружаемом файле несколько листов, в окне **Добавить листы** укажите листы, которые следует загрузить. Пустые листы недоступны для выбора. Включите опцию **Листы**, чтобы выбрать все доступные. Каждый лист загружается в отдельную таблицу.
     1. Информация о добавленном файле и загружаемые данные отобразятся в центральной области экрана. В верхней части экрана выберите опцию **Заголовок столбцов**. Если выберете **Да**, то {{ datalens-short-name }} использует первую строку данных в качестве заголовка.

   {% endlist %}

1. Чтобы добавить файлы, повторите пункты 3 и 4.
1. Нажмите кнопку **Создать подключение**.


1. Выберите [воркбук](../../workbooks-collections/index.md), в котором сохранится подключение, или создайте новый. Если вы пользуетесь старой навигацией по папкам, выберите папку для сохранения подключения. Нажмите кнопку **Создать**.


1. Укажите название подключения и нажмите кнопку **Создать**.

В созданное подключение вы можете добавить новые файлы, а также переименовать, [заменить](#file-replace) или удалить уже добавленные.

## Замена файла {#file-replace}

Чтобы обновить данные в подключении, замените файл:

1. В строке с названием файла нажмите ![image](../../../_assets/console-icons/ellipsis.svg) → **Заменить** и укажите файл. После загрузки файла обновленные данные отобразятся в центральной области экрана.
1. Нажмите кнопку **Сохранить изменения**. Данные обновятся для всех датасетов и чартов, построенных на основе этого подключения.

{% note tip %}

Для работы с динамическими данными вы можете использовать другие источники, например, [{{ CH }}](./create-clickhouse.md).

{% endnote %}


## Примеры использования {#examples}

* [{#T}](../../tutorials/data-from-csv-visualization.md)
* [{#T}](../../tutorials/data-from-csv-to-public-visualization.md)
* [{#T}](../../tutorials/data-from-ch-visualization.md)


{% include [clickhouse-disclaimer](../../../_includes/clickhouse-disclaimer.md) %}