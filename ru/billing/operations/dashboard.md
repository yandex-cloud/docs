# Посмотреть детализацию использования сервисов в {{ datalens-full-name }}

Вы можете посмотреть сведения по использованию сервисов {{ yandex-cloud }}, собрав дашборд в {{ datalens-full-name }}.

## Создайте подключение {#create-connection}

{% list tabs %}

- Консоль управления

  1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
  
  1. В списке платежных аккаунтов выберите нужный.
  1. На вкладке **{{ ui-key.yacloud.billing.account.switch_detail }}** нажмите **{{ ui-key.yacloud.billing.account.detail.button_move-to-datalens }}**.
  1. Нажмите **{{ ui-key.datalens.component.navigation.view.button_create-connection }}**.
  1. В открывшемся окне укажите название подключения и нажмите **{{ ui-key.datalens.component.navigation.view.button_create }}**.
  1. В списке выберите **{{ yandex-cloud }} Billing Dashboard**.
  1. Перейдите на вкладку **{{ ui-key.datalens.dc.mdb.section_resource }}**.
  1. В поле **Usage date** выберите нужный период времени. Дата определяется как диапазон с 0:00 до 23:59 по московскому времени (UTC +3).
  1. Справа от чарта **Resource total cost** нажмите ![options-grey](../../_assets/options-grey.svg) и выберите **{{ ui-key.datalens.dash.chartkit-menu.view.button_edit }}**.
  1. В открывшемся редакторе:
      1. В блоке **{{ ui-key.datalens.wizard.section_columns }}** удалите столбцы с названиями **{{ ui-key.datalens.dc.billing.column_cost }}** и **{{ ui-key.datalens.dc.billing.column_credit }}**.
      1. В блоке **{{ ui-key.datalens.wizard.section_filters }}** выберите фильтр **Resouce ID** и настройте его:
          1. В поле **{{ ui-key.datalens.component.dl-dialog-filter.view.label_operation }}** укажите **{{ ui-key.datalens.component.operations.label_operation-in }}**.
          1. В поле **{{ ui-key.datalens.component.dl-dialog-filter.view.label_select-column-left-title }}** выберите ID интересующих вас ресурсов.
          1. Нажмите **{{ ui-key.datalens.component.dl-dialog-filter.view.button_apply }}**.

  В результате отобразится стоимость использования ресурсов за заданный период времени.

{% endlist %}

## Откройте дашборд {#open-dashboard}

Перейдите на вкладку **{{ ui-key.datalens.component.navigation.view.switch_root }}** и откройте дашборд **{{ yandex-cloud }} Billing Dashboard**. Если необходимо, вы можете изменить настройки дашборда. Подробнее о [работе с дашбордами](../../datalens/concepts/dashboard.md).

Дашборд регулярно обновляется новыми данными. Информация за любой день может быть изменена в течение месяца.
