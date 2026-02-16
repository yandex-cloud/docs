---
title: Как настроить права доступа к дашборду в {{ datalens-full-name }}
description: Следуя данной инструкции, вы сможете настроить права доступа к дашборду.
---

# Управление доступом к дашборду



Настройка доступа зависит от расположения дашборда — в [воркбуке](../../workbooks-collections/index.md#enable-workbooks) или в папке.

Чтобы узнать расположение дашборда, на панели слева нажмите ![image](../../../_assets/console-icons/layout-cells-large.svg) **{{ ui-key.datalens.component.aside-header.view.switch_dashboards }}**. При необходимости для поиска нужного дашборда используйте фильтр по имени.

![image](../../../_assets/datalens/dashboard-navigation.png)

1. ![image](../../../_assets/datalens/icons/square-house.svg) — дашборд в воркбуке.
1. ![image](../../../_assets/console-icons/folder.svg) — дашборд в папке.

Убедитесь, что у пользователя есть [роль для доступа к сервису](../../security/roles.md#service-roles) {{ datalens-name }}, то есть открывается ли у него {{ datalens-name }}. Если это не так, обратитесь к администратору, чтобы он добавил пользователя [по инструкции](../../security/add-new-user.md).

Чтобы настроить права доступа к дашборду:

{% list tabs %}

- В воркбуке

  1. Назначьте пользователю роль на воркбук, в котором хранится дашборд. Для этого:

     1. Перейдите на страницу воркбука, справа сверху нажмите ![image](../../../_assets/console-icons/lock-open.svg) **Доступ**.

     1. Нажмите кнопку **Добавить пользователя**.

     1. В открывшемся окне выберите пользователя, укажите [роль](../../security/roles.md#workbook-roles) и нажмите кнопку **Сохранить**. Пользователю будут назначены права на воркбук и объекты внутри него.

- В папке

  1. В строке с нужным дашбордом нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.datalens.component.access-rights.view.section_main-title }}**.

     ![screen02-1](../../../_assets/datalens/operations/dashboard/manage-access/screen02-1.png)

  1. Нажмите кнопку **{{ ui-key.datalens.component.access-rights.view.button_access-to-dash }}**.

     ![screen03-1](../../../_assets/datalens/operations/dashboard/manage-access/screen03-1.png)

  1. Введите имя пользователя или группу **Все**.

  1. (опционально) Напишите комментарий для пользователя, которому выдаете доступ.

  1. Укажите права доступа и нажмите кнопку **{{ ui-key.datalens.component.access-rights.view.button_add }}**.

     ![screen04-1](../../../_assets/datalens/operations/dashboard/manage-access/screen04-1.png)  

  {% endlist %}

{% include [datalens-federation-user-link](../../../_includes/datalens/datalens-federation-user-link.md) %}

