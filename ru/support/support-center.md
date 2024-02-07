---
title: "{{ yandex-cloud }} {{ support-center-name }}"
description: "Эта инструкция поможет начать работу с {{ yandex-cloud }} {{ support-center-name }} — найти решение возникших проблем, создать обращения в поддержку и просмотреть их, а также изменить тарифный план."
---

# Работа с {{ support-center-name }}

Сервис {{ support-center-name }} поможет вам найти решение возникших в {{ yandex-cloud }} проблем, создать обращения в поддержку и просмотреть их. Также в {{ support-center-name }} вы можете изменить тарифный план.

## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.
1. Откройте [главную страницу]({{ link-console-support }}) {{ support-center-name }}.
1. Выберите [организацию](../organization/quickstart.md), в которой вы будете работать с {{ support-center-name }}, или [создайте новую](../organization/operations/enable-org).

Если вы работаете с центром поддержки из собственной организации, то на странице [**{{ ui-key.yacloud.billing.label_service }}**]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../billing/concepts/billing-account.md) и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`.

## Поиск решения проблемы {#search-for-solution}

Чтобы найти ответы на вопросы по работе {{ yandex-cloud }} в {{ support-center-name }}:

1. Откройте [главную страницу]({{ link-console-support }}) {{ support-center-name }}.
1. Перейдите в раздел **{{ ui-key.support-center.common.tickets }}**.
1. Посмотрите ответы на наиболее популярные вопросы, используя кнопки быстрого поиска.
1. Если вы не нашли свой вопрос среди наиболее популярных:
   1. В окне **{{ ui-key.support-center.search.common.value_search-input-placeholder }}** введите краткое описание проблемы, с которой вы столкнулись, например, `Как восстановить доступ к платежному аккаунту`. {{ yandex-cloud }} {{ support-center-name }} выполнит поиск по вашему запросу в базе знаний технической поддержки и покажет все релевантные статьи. 
   1. Если подходящих статей не нашлось, под строкой поиска появится окно с соответствующим сообщением. В этом окне нажмите кнопку **{{ ui-key.support-center.search.common.action_search-in-documentation }}**, чтобы найти ответ на ваш вопрос в документации {{ yandex-cloud }}.

## Создание обращения {#create-request}

Если [поиск решения проблемы](#finding-solution) в базе знаний технической поддержки и документации {{ yandex-cloud }} не дал результата, создайте обращение в поддержку:

1. Откройте [главную страницу]({{ link-console-support }}) {{ support-center-name }}.
1. Перейдите в раздел **{{ ui-key.support-center.common.tickets }}**.
1. Нажмите кнопку **{{ ui-key.support-center.tickets.common.action_create-ticket }}**.
1. Откроется форма **{{ ui-key.support-center.ticket.create.title_create-ticket-page }}**, заполните в ней поля:
   * **{{ ui-key.yacloud.support.ticket.create.field_type }}** — выберите тип запроса, наиболее подходящий для решения вашей проблемы.
   * **{{ ui-key.yacloud.support.ticket.create.field_service }}** — укажите сервис, в котором вы столкнулись с проблемой.
   * **{{ ui-key.yacloud.support.ticket.create.field_summary }}** — укажите тему обращения.
   * **{{ ui-key.yacloud.support.ticket.create.field_description }}** — подробно опишите, с какой проблемой вы столкнулись. Желательно при этом указать ID ресурса, дату и время, когда произошло событие.
   * **{{ ui-key.yacloud.support.ticket.create.field_attachments }}** — при необходимости прикрепите скриншоты или другие файлы, которые помогут полнее описать ваш запрос.
   * **{{ ui-key.yacloud.support.ticket.create.field_access-type }}** — выберите, кому будет видно это обращение.
1. Нажмите кнопку **{{ ui-key.support-center.ticket.create.action_create-ticket }}**.

## Просмотр обращений {#view-requests}

Все отправленные обращения, к которым у вас есть доступ, отображаются на [главной странице]({{ link-console-support }}) {{ support-center-name }} в блоке **{{ ui-key.support-center.tickets.list.title_ticket_table }}**. 

Чтобы быстро найти нужное обращение, используйте функции фильтрации и сортировки по:
* автору обращения;
* статусу обращения;
* сервису, указанному в обращении;
* статусу ответа;
* типу обращения. 

Если вы хотите очистить настройки фильтрации обращений, нажмите кнопку **{{ ui-key.support-center.tickets.filters.action_reset-filters }}**.

## Изменение тарифного плана {#change-pricing}

{% include [change-tariff](../_includes/support/change-pricing.md) %}

## Изменение платежного аккаунта для действующего тарифа {#change-ba}

{% include [change-ba](../_includes/support/change-ba.md) %}