---
title: Как добавить описание к чарту в {{ datalens-full-name }}
description: Следуя данной инструкции, вы сможете добавить описание к чарту.
---

# Добавление описания к чарту

Чтобы добавить описание к чарту:

1. Откройте чарт, к которому необходимо добавить описание.
1. В верхней части экрана нажмите значок ![image](../../../_assets/console-icons/circle-info.svg).
1. Введите описание и нажмите **Сохранить**.

   {% cut "Добавить описание к чарту" %}

   {% list tabs group=charts %}

   - Визард {#wizard}
  
     ![add-description](../../../_assets/datalens/chart/chart-add-description.png)
 
   - QL-чарт {#ql}
  
     ![add-description](../../../_assets/datalens/chart/ql-chart-add-description.png)

   
   - Editor {#editor}
  
     ![add-description](../../../_assets/datalens/chart/editor-chart-add-description.png)


   {% endlist %}

   {% endcut %}

1. В правом верхнем углу экрана нажмите **Сохранить**.

Теперь в правом верхнем углу чарта для всех пользователей появится значок ![image](../../../_assets/console-icons/circle-info.svg). При нажатии на него откроется окно **Информация о чарте** с описанием.

{% cut "Посмотреть описание к чарту" %}

{% list tabs group=charts %}

- Визард {#wizard}

  ![description](../../../_assets/datalens/chart/chart-description.png)

- QL-чарт {#ql}

  ![description](../../../_assets/datalens/chart/ql-chart-description.png)


- Editor {#editor}

  ![description](../../../_assets/datalens/chart/editor-chart-description.png)


{% endlist %}

{% endcut %}

Чтобы удалить описание к чарту, сохраните пустое описание в окне **Информация о чарте**. После этого у всех пользователей значок ![image](../../../_assets/console-icons/circle-info.svg) отображаться не будет.
