---
title: "Инструкция по добавлению данных в датасет {{ datalens-full-name }} с помощью SQL-запроса"
description: "Из статьи вы узнаете, как добавить данные в датасет {{ datalens-full-name }} с помощью SQL-запроса."
---

# Описание датасета через SQL-запрос к источнику

{% note info %}

Чтобы использовать подзапросы в качестве источника, включите опцию **Уровень доступа SQL запросов** → **Разрешить подзапросы в датасетах** при создании или редактировании [подключения](../../concepts/connection.md).

{% endnote %}

Чтобы добавить данные в датасет с помощью SQL-запроса:


{% include [datalens-workbooks-collections-select-note](../../../_includes/datalens/operations/datalens-workbooks-collections-select-note.md) %}


1. На панели слева нажмите ![image](../../../_assets/console-icons/circles-intersection.svg) **Датасеты** и выберите нужный датасет. Если у вас нет датасета, [создайте его](create.md).
1. В левом верхнем углу переключитесь на вкладку **Источники**.
1. В левой части экрана под блоком **Таблицы** нажмите ![image](../../../_assets/console-icons/plus.svg)**Добавить**.

   {% note info %}

   Кнопка ![image](../../../_assets/console-icons/plus.svg)**Добавить** доступна только для источников-БД.

   {% endnote %}

1. Введите **Название источника** и текст SQL-запроса в поле **Подзапрос**.
1. Нажмите кнопку **Создать**.

{% cut "Пример SQL-запроса" %}

{% include [datalens-sql-join-example](../../../_includes/datalens/datalens-sql-join-example.md) %}

{% endcut %}
