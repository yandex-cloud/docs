---
title: "Как разместить свой продукт в {{ marketplace-full-name }}"
description: "Следуя данной инструкции, вы сможете разместить свой продукт в {{ marketplace-full-name }}." 
---

# Как разместить свой продукт в {{ marketplace-full-name }}

{{ marketplace-name }} дает возможность размещать свои продукты в каталоге готовых решений {{ yandex-cloud }} и зарабатывать на них. Вы можете разместить различные типы продуктов:
* готовые образы для сервиса {{ compute-full-name }};
* приложения для {{ managed-k8s-name }};
* решения для сервиса {{ datalens-full-name }}.

## Подайте заявку {#send-application}

Чтобы стать партнером {{ marketplace-short-name }}, заполните анкету на [странице Marketplace](/marketplace) и опишите ваш продукт. Подробное описание полезных для пользователей функций и особенностей продукта поможет быстрее рассмотреть вашу заявку. Отправка заявки означает принятие [оферты](https://yandex.ru/legal/marketplace_offer/?lang=ru) на предоставление доступа к программному продукту в {{ marketplace-short-name }}. Если у вашего юридического лица уже есть платежный аккаунт, укажите его при подаче заявки.

После прохождения модерации вы получите письмо с подтверждением на электронный адрес, указанный в анкете. 

## Зарегистрируйте аккаунт {#registration}

Для доступа в кабинет партнера {{ marketplace-short-name }} вам потребуется платежный аккаунт юридического лица — резидента РФ или РК. Если у вас еще нет платежного аккаунта, [создайте его](operations/registration.md).

{% include [billing-note](../_includes/marketplace/billing-note.md) %}

## Создайте продукт в кабинете партнера {#create-product}

[Создайте продукт](operations/create-product.md). Дальнейшие действия будут доступны после одобрения заявки. Вы можете уточнить заявку и связаться с менеджером {{ marketplace-short-name }} в разделе **{{ ui-key.yacloud_portal.marketplace_v2.common.menu_ticket }}**.

## Создайте тариф {#create-tariff}

{% include [tariff-note](../_includes/marketplace/tariff-note.md) %}

Тариф определяет стоимость использования вашего продукта.

[Создайте тариф](operations/create-tariff.md), чтобы назначить его версии продукта.

## Создайте и загрузите образ ВМ или пакеты для {{ managed-k8s-name }} {#create-image}

В {{ marketplace-short-name }} можно размещать образы ВМ из публичных образов {{ yandex-cloud }} и приложения для {{ managed-k8s-name }}. Требования к образам и приложениям и рекомендации по их созданию описаны в разделах:
* [{#T}](operations/create-image.md)
* [{#T}](operations/create-container.md)

## Создайте первую версию продукта {#create-version}

О том, как создать первую версию продукта в кабинете партнера {{ marketplace-name }}, см. на странице [{#T}](operations/create-new-version.md).