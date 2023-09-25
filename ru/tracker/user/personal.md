# Персональные настройки

Чтобы вам было удобнее работать с задачами, вы можете настроить интерфейс {{ tracker-name }} на ваш вкус.

## Настроить начальную страницу {#sec_my_page}

Вы можете настроить вашу [стартовую страницу](startpage.md) в старом интерфейсе так, чтобы на ней отображался любой из предложенных вариантов:

* [**{{ ui-key.startrek.ui_components_page-my_PageMy.page-title }}**](startpage.md#my-page);
* [фильтр](create-filter.md);
* [дашборд](dashboard.md);
* [доска задач](../manager/create-agile-board.md).

1. Перейдите по ссылке [{{ link-settings }}]({{ link-settings }}).

1. В блоке **{{ ui-key.startrek.ui_components_NavigationBar.start-page-title }}** укажите какой фильтр, дашборд или доску задач вы хотите видеть на главной странице. Чтобы сделать стартовой **Мою страницу**, выберите ее в списке.

1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

## Настроить язык интерфейса {#choose-language}

Для работы в {{ tracker-name }} вы можете выбрать русский и английский язык. Для этого:

1. {% include [open-personal-settings](../../_includes/tracker/open-personal-settings.md) %}

1. В блоке **{{ ui-key.yacloud.settings.switch_lang }}** выберите нужный язык.

## Настроить оформление {#choose-theme}

Чтобы настроить тему интерфейса и способ открытия задач на странице: 

1. {% include [open-personal-settings](../../_includes/tracker/open-personal-settings.md) %}

1. В блоке **{{ ui-key.yacloud.settings.switch_appearance }}** выберите нужную тему.

1. Чтобы при нажатии на название или ключ (например, **TEST-123**) задача открывалась на боковой панели справа, выберите вариант **{{ ui-key.startrek.ui_components_Confirm.ok-button-text }}**.

## Настроить отображение пользователей {#sec_display}

По умолчанию в полях **{{ ui-key.startrek.blocks-desktop_st-field-utils.field--author }}**, **{{ ui-key.startrek.blocks-desktop_st-field-utils.field--assignee }}** и **{{ ui-key.startrek.blocks-desktop_st-field-utils.field--followers }}** отображаются имена и фамилии пользователей. Чтобы на странице задачи вместо имен и фамилий отображались логины или портреты, измените способ отображения пользователей.

{% cut "Скриншот" %}

![](../../_assets/tracker/followers-disp-style-3.png)

{% endcut %}

Чтобы изменить способ отображения:

1. Перейдите по ссылке [{{ link-settings }}]({{ link-settings }}).

1. В блоке **{{ ui-key.startrek.blocks-desktop_b-page-settings.users-display-format }}** выберите удобный для вас способ:
    - Выберите **{{ ui-key.startrek.blocks-desktop_b-page-settings.prefer-login }}**, чтобы в системных полях задачи вместо имен и фамилий отображались логины.

        {% cut "Скриншот" %}

        ![](../../_assets/tracker/followers-disp-style-4.png)

        {% endcut %}

    - Выберите **{{ ui-key.startrek.blocks-desktop_b-page-settings.prefer-icons-in-lists }}**, чтобы в полях со списком пользователей отображались только аватары. Настройка не влияет на поля **{{ ui-key.startrek.blocks-desktop_st-field-utils.field--author }}** и **{{ ui-key.startrek.blocks-desktop_st-field-utils.field--assignee }}**.	

        {% cut "Скриншот" %}

        ![](../../_assets/tracker/followers-disp-style-5.png)

        {% endcut %}

1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

## Настроить отображение дат {#sec_display_date}

Параметры, содержащие дату, и время могут отображаться в задаче в полном (день, месяц, год и время) и сокращенном (день и месяц) форматах.

Чтобы изменить формат отображения таких параметров:

1. Перейдите по ссылке [{{ link-settings }}]({{ link-settings }}).

1. В блоке **{{ ui-key.startrek.blocks-desktop_b-page-settings.date-format }}** выберите нужный формат.

1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

## Настроить уведомления {#sec_notifications}

{{ tracker-name }} отправляет по почте уведомления об изменениях в задачах, на которые вы подписаны. На странице персональных настроек вы можете настроить параметры уведомлений:

1. Перейдите по ссылке [{{ link-settings }}]({{ link-settings }}).

1. Задайте настройки уведомлений: 
    - Включите или отключите [регулярные отчеты об изменениях задач, на которые вы подписаны](notification-digest.md).
    - Настройте [отображение имен и типа события в письмах](notification-settings.md#section_u1f_3w5_xgb).
    - Включите или отключите [уведомления об изменениях, которые вы сделали в задачах](subscribe.md#sec_self).

1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

Подробнее об уведомлениях читайте в разделах:

- [{#T}](subscribe.md)
- [Настройки уведомлений](notification-settings.md)

## Настроить порядок отображения комментариев {#sec_mssg_sort}

По умолчанию комментарии в задаче сортируются от старых к новым. Вы можете включить сортировку комментариев от новых к старым на странице персональных настроек:

1. Перейдите по ссылке [{{ link-settings }}]({{ link-settings }}).

1. В блоке **{{ ui-key.startrek.blocks-desktop_b-page-settings.comments-and-history }}** включите опцию **{{ ui-key.startrek.blocks-desktop_b-page-settings.comments-new-on-top }}**.

1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

## Новый интерфейс {#sec_beta}

Чтобы включить новый интерфейс {{ tracker-name }}:

1. Перейдите по ссылке [{{ link-settings }}]({{ link-settings }}).

1. В разделе **{{ ui-key.startrek.ui_components_NavigationBar.appearance-title }}** включите опцию **{{ ui-key.startrek.ui_components_NavigationBar.new-ui }}**.
