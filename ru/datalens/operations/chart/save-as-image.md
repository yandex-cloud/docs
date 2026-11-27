---
title: Как сохранить чарт как изображение в {{ datalens-full-name }}
description: Следуя данной инструкции, вы сможете в {{ datalens-name }} сохранить чарт как изображение.
alternate:
  - href: ru/datalens/operations/chart/save-as-image.md
    type: text/markdown
    title: Markdown version
---

# Сохранить чарт как изображение в {{ datalens-full-name }}

Вы можете сохранить чарт в формате `PNG`. Доступно для [чартов в визарде](../../concepts/chart/dataset-based-charts.md), [QL-чартов](../../concepts/chart/ql-charts.md) и [чартов в Editor](../../charts/editor/index.md).

Чтобы сохранить чарт как изображение:

1. Откройте чарт и в правом верхнем углу чарта нажмите ![image](../../../_assets/console-icons/ellipsis.svg) → ![icon](../../../_assets/console-icons/arrow-down-to-line.svg) **Сохранить как** → **Изображение**.
   Или на дашборде у чарта вверху справа нажмите ![image](../../../_assets/console-icons/ellipsis.svg) → ![icon](../../../_assets/console-icons/arrow-down-to-line.svg) **Сохранить как** → **Изображение**.

   {% cut "Сохранить чарт на дашборде как изображение" %}

   ![image](../../../_assets/datalens/chart/save-chart-on-dashboard-as-image.png)

   {% endcut %}

1. Выберите разрешение:

   * Стандартное 900 x 600 px.
   * Широкоформатное 1 600 x 720 px.
   * Укажите вручную другое. Область отрисовки не превышает 6 000 пикселей по ширине и высоте. Большие значения {{ datalens-name }} уменьшает до этого размера и может обрезать часть изображения.
  
1. При необходимости включите опцию **Отображать элементы интерфейса**.
1. Нажмите кнопку **Скачать**.
