---
title: Порядок оказания технической поддержки
description: Из статьи вы узнаете про порядок оказания технической поддержки.
---


# Порядок оказания технической поддержки

{{ yandex-cloud }} оказывает техническую поддержку с разными тарифными планами — вы можете выбрать тот, который подходит вам. Стоимость поддержки по платным тарифным планам складывается из двух частей: фиксированной и дополнительной. Дополнительная рассчитывается как доля от стоимости потребленных за месяц ресурсов. Подробнее о тарифных планах — в [Правилах тарификации](pricing.md).

## Как обратиться в поддержку {#response-time}

В зависимости от тарифного плана, вы можете обратиться в службу технической поддержки одним из способов:

{% include [support-channels](../_includes/support/channels.md) %}

Ожидаемое время, за которое вы получите ответ от специалиста поддержки, указано в таблице ниже.


| Канал обращения | Базовый | Бизнес | Премиум |
| --------------- | ------- | ------ | ------- |
|  | Для домашних и исследовательских проектов | Для бизнес‑проектов | Для бизнес‑проектов с повышенными требованиями к отказоустойчивости |
| Запрос в [центре поддержки](cloud-center.md) | Вопрос: 24 часа<br>Проблема: 24 часа<br>Квоты: 24 часа<br>Предложение: 5 рабочих дней | Вопрос: 4 часа<br>Проблема, приоритет «средний»: 4 часа<br>Проблема, приоритет «важный»: 4 часа<br>Проблема, приоритет «критичный»: 30 минут<br>Квоты: 24 часа<br>Предложение: 5 рабочих дней | Вопрос: 2 часа<br>Проблема, приоритет «средний»: 2 часа<br>Проблема, приоритет «важный»: 2 часа<br>Проблема, приоритет «критичный»: 15 минут<br>Квоты: 24 часа<br>Предложение: 5 рабочих дней |
| Увеличить квоты в разделе [Квоты](https://console.yandex.cloud/cloud?section=quotas) | 30 минут в рамках установленных [лимитов](../overview/concepts/quotas-limits.md) | 30 минут в рамках установленных [лимитов](../overview/concepts/quotas-limits.md) | 30 минут в рамках установленных [лимитов](../overview/concepts/quotas-limits.md) |
| Чат в интерфейсе {{ yandex-cloud }},<br>[Чат в Telegram](tg-chat.md) | 15 минут | 5 минут | 5 минут |
| Электронная почта | 24 часа | 24 часа | 24 часа |



Создать запрос в центре поддержки может только [пользователь](../overview/roles-and-resources.md#users) {{ yandex-cloud }}. [Убедитесь](./cloud-center.md#before-you-begin), что вы создаете запрос от имени нужной организации. Если возникла проблема с продакшн-средой вашей инфраструктуры, выберите тип обращения ![image](../_assets/console-icons/hand-stop.svg) **{{ ui-key.yacloud_org.support.tickets.common.label_ticket-type-v2-high-problem }}** с приоритетом _{{ ui-key.support-center.tariff-plans.info.context_response-critical }}_.

Рекомендуем создавать для каждой проблемы отдельное обращение. Если в обращении будет описано несколько проблем, техническая поддержка может создать отдельные обращения для каждой из них.

Подробнее о том, как найти свое обращение в {{ yandex-cloud }}, см. [Как найти свое обращение в {{ yandex-cloud }}](../support/qa.md#how-to-find-request).

## С какими запросами можно обратиться {#request-types}

Доступные виды запросов зависят от выбранного тарифа и приведены в таблице ниже.


| Вид обращения | Базовый | Бизнес | Премиум |
| ------------- | ------- | ------ | ------- |
| Восстановление доступа в консоль управления | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Консультации по вопросам, связанным с Биллингом | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Предоставление ссылок на документацию | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Запросы о ваших данных в {{ yandex-cloud }}, включая запросы о персональных данных | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Диагностика ошибок в работе сервисов {{ yandex-cloud }} и решение выявленных проблем, не связанных со сторонним программным обеспечением (ПО) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Консультации по часто возникающим вопросам (в том числе по общим вида «Как это работает?» и «Что это такое?») о сервисах и функциональных возможностях {{ yandex-cloud }} | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Рассмотрение идей по развитию функциональности сервисов и предоставление обратной связи | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Помощь в восстановлении работоспособности сервисов в случае критических обращений | ![image](../_assets/common/no.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Консультации по настройке сервисов {{ yandex-cloud }} | ![image](../_assets/common/no.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Возможность повышения приоритета обращения по запросу | ![image](../_assets/common/no.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Базовые рекомендации по построению отказоустойчивой инфраструктуры в облаке | ![image](../_assets/common/no.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Подготовка RCA по обращениям с приоритетом «критичный» | ![image](../_assets/common/no.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Проведение HA/DR-тестов | ![image](../_assets/common/no.svg) | ![image](../_assets/common/no.svg) | ![image](../_assets/common/yes.svg) |
| Инфраструктурный чекап | ![image](../_assets/common/no.svg) | ![image](../_assets/common/no.svg) | ![image](../_assets/common/yes.svg) |
| Поддержка обслуживания и изменений архитектуры облачных ресурсов | ![image](../_assets/common/no.svg) | ![image](../_assets/common/no.svg) | ![image](../_assets/common/yes.svg) |
| Проведение видеоконференции с экспертами поддержки по запросу | ![image](../_assets/common/no.svg) | ![image](../_assets/common/no.svg) | ![image](../_assets/common/yes.svg) |



## Какие задачи не решает техническая поддержка {#not-supported}

Инженеры службы технической поддержки {{ yandex-cloud }} не решают задачи:

* Разработки программного кода.
* Отладки программного обеспечения стороннего производителя.
* Сопровождения продуктов [{{ marketplace-full-name }}](../marketplace/operations/users/quickstart.md#support), где издатель не {{ yandex-cloud }}.
* Использования {{ adv-ddos-protection }}.
* {{ tracker-full-name }}, {{ forms-full-name }}, {{ wiki-full-name }}.
* Работы с сервисами управляемых баз данных (MDB) в рамках [зоны контроля клиентов {{ yandex-cloud }}](../overview/concepts/mdb-responsibilities.md#customer-responsibilities).
* Работы с сервисом {{ managed-k8s-name }} в рамках [зоны контроля клиентов {{ yandex-cloud }}](../overview/concepts/kubernetes-responsibilities.md#client-responsibility).

Если служба технической поддержки не сможет решить проблему с программным обеспечением стороннего производителя, вам нужно будет обратиться в техническую поддержку этого производителя. В некоторых случаях обращение в техническую поддержку требует действующего договора на техническую поддержку с этими производителями или их партнерами.

## Как изменить тарифный план {#change-service-plan}

{% include [change-tariff](../_includes/support/change-pricing.md) %}

