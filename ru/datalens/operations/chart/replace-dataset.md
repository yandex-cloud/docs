---
title: Как заменить датасет в чарте в {{ datalens-full-name }}
description: Следуя данной инструкции, вы сможете заменить датасет в чарте.
---

# Замена датасета в чарте

Чтобы заменить датасет в чарте:


{% include [datalens-workbooks-collections-select-note](../../../_includes/datalens/operations/datalens-workbooks-collections-select-note.md) %}


1. На панели слева нажмите ![image](../../../_assets/console-icons/chart-column.svg) **Чарты** и выберите нужный чарт.
1. В левой части экрана нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) у датасета и выберите **Заменить датасет**.
1. Выберите другой датасет.

   {% note info %}

   Новый датасет должен содержать поля с теми же названиями, что и старый. Если после замены датасета чарт отображается с ошибкой `ERR.DS_API.DB.COLUMN_DOES_NOT_EXIST`, воспользуйтесь инструкцией [{#T}](../../dataset/create-dataset.md#update-fields).

   {% endnote %}

1. В правом верхнем углу нажмите кнопку **Сохранить**.
