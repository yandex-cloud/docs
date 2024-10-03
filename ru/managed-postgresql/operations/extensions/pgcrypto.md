---
title: Инструкция по использованию pgcrypto в {{ mpg-name }}
description: Из статьи вы узнаете, как использовать pgcrypto в {{ mpg-name }}.
---

# Использование pgcrypto в {{ mpg-name }}

Расширение [pgcrypto]({{ pg-docs }}/static/pgcrypto.html) предоставляет криптографические функции, которые позволяют администраторам баз данных хранить определенные столбцы данных в зашифрованном виде.

## Установить расширение pgcrypto в кластер {{ PG }} {#pgcrypto-install}

[Добавьте расширение](./cluster-extensions.md#update-extensions) `pgcrypto` к базе данных.

{% note warning %}

Установка расширения `pgcrypto` приведет к последовательной перезагрузке {{ PG }} на всех хостах кластера.

{% endnote %}

Подробнее о расширении `pgcrypto` см. в [официальной документации]({{ pg-docs }}/static/pgcrypto.html).

{% include [example-pgcrypto](../../../_includes/mdb/mgp-mpg-example-pgcrypto.md) %}
