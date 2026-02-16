---
title: Предварительная настройка подключения к кластеру {{ OS }} в {{ mos-full-name }}
description: Следуя данной инструкции, вы сможете подготовиться к подключению к базе данных в кластере {{ OS }}.
keywords:
  - подключение кластера OpenSearch
  - кластер OpenSearch
  - OpenSearch
---

# Предварительная настройка для подключения к кластеру {{ OS }}

К хостам кластера {{ mos-name }} с [ролью](../../concepts/host-roles.md#data) `DATA` можно подключиться:

* Через интернет, если вы настроили публичный доступ для нужной группы хостов.

* Через интернет по [особому FQDN](./fqdn.md#special-fqdns), если вы настроили публичный доступ для группы хостов с [ролью](../../concepts/host-roles.md#dashboards) `DASHBOARDS`.


* С виртуальных машин {{ yandex-cloud }}, расположенных в той же [виртуальной сети](../../../vpc/concepts/network.md).


Вне зависимости от способа подключения, {{ mos-name }} поддерживает только соединения с [SSL-сертификатом](#ssl-certificate) к хостам кластера.


## Настройка групп безопасности {#security-groups}

{% include notitle [Configuring security groups](../../../_includes/mdb/mos/configuring-security-groups.md) %}


## Получение SSL-сертификата {#ssl-certificate}

Чтобы использовать шифрованное соединение, получите SSL-сертификат:

{% include [install-certificate](../../../_includes/mdb/mos/install-certificate.md) %}

## Что дальше {#whats-next}

* [Получите FQDN хоста](./fqdn.md), к которому будете подключаться.
* [Подключитесь](./clients.md) к кластеру из Docker-контейнера.
* [Интегрируйте](./code-examples.md) подключение к кластеру в код вашего приложения.
* [Настройте SAML-аутентификацию](../saml-authentication.md).
