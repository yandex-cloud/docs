[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for MySQL®](../index.md) > [Пошаговые инструкции](index.md) > Кластеры > Управление балансировщиком нагрузки DB Proxy

# Управление балансировщиком нагрузки DB Proxy

В Managed Service for MySQL® доступен [балансировщик нагрузки DB Proxy](../concepts/load-balancer.md), который автоматически распределяет запросы по хостам БД в зависимости от их роли и доступности.

{% note info %}

Функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md) и предоставляется по запросу в техническую поддержку.

{% endnote %}

Вы можете:

* [Получить FQDN балансировщика](#fqdn).
* [Включить или отключить балансировщик](#enable-balancer).

## Получить FQDN балансировщика {#fqdn}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите](https://console.yandex.cloud/link/managed-mysql) в сервис **Managed Service for&nbsp;MySQL**.
  1. Нажмите на имя нужного кластера.
  1. Скопируйте значение в поле **FQDN балансировщика**.

{% endlist %}

## Включить балансировщик {#enable-balancer}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите](https://console.yandex.cloud/link/managed-mysql) в сервис **Managed Service for&nbsp;MySQL**.
  1. Выберите кластер и нажмите кнопку ![image](../../_assets/console-icons/pencil.svg) **Редактировать** на панели сверху.
  1. В блоке **DB Proxy** включите опцию **Балансировка DB Proxy** и укажите параметры балансировки по репликам в блоке **Настройки портов**:

      * **Лаг** — максимальное отставание реплик, в секундах. При превышении этого отставания реплика не попадет в балансировку.
      * **Политика балансировки** — способ распределения запросов по репликам кластера. Подробнее читайте в разделе [Политики балансировки](../concepts/load-balancer.md#balancing-policies).

  Если балансировщик вам больше не нужен, таким же образом отключите опцию **Балансировка DB Proxy**.

{% endlist %}