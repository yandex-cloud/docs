---
title: Настройка тарифного плана {{ datalens-full-name }}
description: 'Из статьи вы узнаете, как настроить тарифный план для {{ datalens-short-name }}: выбрать тариф и добавить платежный аккаунт.'
---

# Настройка тарифного плана {{ datalens-short-name }}

Вы можете использовать {{ datalens-short-name }} с одним из двух [тарифов](../pricing.md#service-plans): тариф Community бесплатен, а для оплаты тарифа Business нужно добавить [платежный аккаунт](../../billing/concepts/billing-account.md) в организацию.

Текущий тарифный план [отображается](#info) в настройках сервиса. Там же можно [изменить тариф](#change-service-plan) и [добавить платежный аккаунт](#add-billing-account).

## Посмотреть тарифный план и платежный аккаунт {#info}

Чтобы посмотреть информацию о текущем тарифном плане и выбранном платежном аккаунте:

1. Перейдите на [главную страницу]({{ link-datalens-main }}) {{ datalens-short-name }}.
1. На панели слева выберите ![sliders](../../_assets/console-icons/sliders.svg) **Настройки сервиса**. Информация о текущем тарифном плане и платежном аккаунте отображается в верхней части экрана.

## Изменить тарифный план {#change-service-plan}

При изменении тарифного плана действуют правила:

* Перейти на тарифный план Business можно в любой момент. Цена за первый месяц рассчитывается пропорционально оставшемуся числу дней месяца.

* Перейти на тарифный план Community можно только с начала следующего месяца. До этого запланированный переход можно [отменить](#cancel-change-service-plan).

* Если включен пробный период тарифа Business, то по окончании пробного периода цена за второй месяц использования будет рассчитана пропорционально оставшемуся числу дней. Если во время пробного периода сменить тарифный план на Community, пробный период будет действовать до конца своего срока, а затем тариф Business изменится на Community.

Чтобы перейти на другой тарифный план:

1. Перейдите на [главную страницу]({{ link-datalens-main }}) {{ datalens-short-name }}.
1. На панели слева выберите ![sliders](../../_assets/console-icons/sliders.svg) **Настройки сервиса**.
1. В верхней части экрана нажмите кнопку **Изменить тариф**.
1. Выберите тарифный план и нажмите кнопку **Перейти**. Если у вас еще нет платежного аккаунта, откроется форма его создания. Подробнее см. в разделе [Добавить платежный аккаунт](#add-billing-account).
1. Нажмите кнопку **Подтвердить**.

## Добавить платежный аккаунт {#add-billing-account}

{% note info %}

Создание нового платежного аккаунта доступно только пользователям с учетной записью Яндекс ID или Яндекс 360. Федеративные учетные записи для этого не подходят.

Для привязки платежного аккаунта у пользователя должны быть [роли](../security/roles.md#service-roles):

* на платежный аккаунт — `billing.accounts.editor` или выше;
* на организацию с {{ datalens-short-name }} — `{{ roles-datalens-admin }}` или роли, включающие ее полномочия: например, `{{ roles-admin }}` или `{{ roles-organization-owner }}`.

{% endnote %}

Чтобы добавить платежный аккаунт:

1. Перейдите на [главную страницу]({{ link-datalens-main }}) {{ datalens-short-name }}.
1. На панели слева выберите ![sliders](../../_assets/console-icons/sliders.svg) **Настройки сервиса**.
1. В верхней части экрана нажмите кнопку **Изменить тариф**.
1. Если у вас нет привязанного к [организации](../concepts/organizations.md) платежного аккаунта, нажмите кнопку **Добавить**. Если есть — нажмите кнопку **Изменить аккаунт**.
1. Выберите платежный аккаунт или создайте новый:

   1. Нажмите кнопку **Создать аккаунт**.
   1. Введите общую информацию:

      * **Имя аккаунта** — будет отображаться в списке ваших платежных аккаунтов и поможет выбрать нужный.
      * **Страна** — выберите страну, резидентом которой является [плательщик](../../billing/concepts/glossary.md#payer).
      * **Плательщик** — выберите из списка доступных плательщиков.
      * **Тип аккаунта** — выберите физическое или юридическое лицо. Для юридического лица выберите способ оплаты: `Банковская карта` или `Банковский перевод`.

      Нажмите кнопку **Вперед**.

   1. Введите данные плательщика, в зависимости от типа аккаунта:

      * Физическое лицо: фамилия, имя, отчество, почтовый адрес.
      * Юридическое лицо: краткое название организации, полное название организации, почтовый индекс, фактический адрес, юридический адрес, ИНН, КПП.

      Нажмите кнопку **Вперед**.

   1. (если плательщик — юридическое лицо и способ оплаты — `Банковский перевод`, пропустите этот шаг) Привяжите к аккаунту банковскую карту:

      * Нажмите кнопку **Добавить карту**.
      * Укажите данные карты: 16-значный номер, срок действия, код CVV (с обратной стороны карты).
      * Нажмите кнопку **Привязать**.
      * Выберите карту.

      Если плательщик — юридическое лицо, поставьте отметку: **Я подтверждаю, что могу распоряжаться указанной корпоративной картой**.

      Нажмите кнопку **Вперед**.

   1. Укажите контактную информацию:

      * Введите адрес электронной почты и нажмите кнопку **Получить код**. Подтвердите адрес электронной почты.
      * Введите номер телефона и нажмите кнопку **Получить код**. Подтвердите номер телефона.

   1. Нажмите кнопку **Создать**.

1. Нажмите кнопку **Привязать**.

## Отменить переход на другой тарифный план {#cancel-change-service-plan}

Чтобы отменить переход на другой тарифный план:

1. Перейдите на [главную страницу]({{ link-datalens-main }}) {{ datalens-short-name }}.
1. На панели слева выберите ![sliders](../../_assets/console-icons/sliders.svg) **Настройки сервиса**.
1. Рядом с сообщением о планируемой дате перехода нажмите кнопку **Отменить**.
1. Нажмите кнопку **Да**. Запланированный переход будет отменен.

#### См. также {#see-also}

* [Вопросы про тарификацию](../qa/pricing.md)
