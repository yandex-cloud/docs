---
title: "Подготовка к подключению в {{ mrd-full-name }}"
description: "Следуя данной инструкции, вы сможете подключиться к кластеру {{ RD }}." 
---

# Подготовка к подключению

Доступные способы подключения зависят от того, включено ли в кластере [шардирование](../../concepts/sharding.md):

* [Подключение к нешардированному кластеру](./non-sharded.md).
* [Подключение к шардированному кластеру](./sharded.md).

## Доступ к хостам кластера {#connect}

К хостам кластера {{ mrd-name }} можно подключиться:

* Через интернет, если выполнены следующие условия:

    * к хостам [настроен публичный доступ](../hosts.md#public-access);
    * используется SSL-соединение;
    * кластер создан с поддержкой TLS.

* С виртуальных машин {{ yandex-cloud }}, расположенных в той же облачной сети:

    
    1. [Создайте виртуальную машину](../../../compute/operations/vm-create/create-linux-vm.md) с публичным IP-адресом в той же виртуальной сети, что и кластер.
    1. [Подключитесь](../../../compute/operations/vm-connect/ssh.md) к созданной виртуальной машине через [SSH](../../../glossary/ssh-keygen.md).
    1. Из виртуальной машины подключитесь к {{ RD }} с помощью одного из примеров строк подключений.



## Поддержка шифрования {#tls-support}

Для кластеров {{ mrd-short-name }} поддерживается шифрованное SSL-соединение. Чтобы пользоваться SSL, при [создании кластера](../cluster-create.md) включите настройку **{{ ui-key.yacloud.redis.field_tls-support }}**.

{{ RD }} по умолчанию оперирует IP-адресами хостов, а не их [FQDN](../../concepts/network.md#hostname), что может [препятствовать подключению к хостам {{ RD }}](../../concepts/network.md#fqdn-ip-setting) в кластерах с поддержкой TLS. Чтобы получить возможность подключения к хостам, выполните одно из действий:

* Включите настройку, разрешающую использование FQDN вместо IP-адресов, чтобы IP-адрес хоста подменялся на его FQDN. Эту настройку можно включить при [создании](../cluster-create.md) или [изменении](../update.md#configure-fqdn-ip-behavior) кластера.

    Это позволит [клиенту {{ RD }}](../../concepts/supported-clients.md) подключаться к хостам {{ RD }} как с виртуальных машин {{ yandex-cloud }}, так и через интернет, а также при необходимости требовать проверки соответствия FQDN хоста и сертификата.

    {% include [fqdn-option-compatibility-note](../../../_includes/mdb/mrd/connect/fqdn-option-compatibility-note.md) %}

* Отключите проверку соответствия FQDN хоста и сертификата на стороне клиента {{ RD }}.

    Это позволит подключаться к хостам {{ RD }} с виртуальных машин {{ yandex-cloud }}.


## Настройка групп безопасности {#configuring-security-groups}

{% include [Security groups notice](../../../_includes/mdb/sg-rules-connect.md) %}

{% include [Security groups rules for VM](../../../_includes/mdb/mrd/connect/sg-rules-for-vm.md) %}

Настройки групп безопасности для шардированного и нешардированного кластеров различаются.

{% list tabs group=cluster %}

- Нешардированный кластер {#non-sharded}

    [Настройте все группы безопасности](../../../vpc/operations/security-group-add-rule.md) кластера так, чтобы они разрешали входящий трафик из группы безопасности, в которой находится ВМ, на порт `{{ port-mrd }}` для подключения напрямую к мастеру или `{{ port-mrd-sentinel }}` для подключения с помощью Sentinel. Если кластер создан с поддержкой SSL-шифрования, то укажите порт `{{ port-mrd-tls }}` для шифрованного подключения напрямую к мастеру или `{{ port-mrd-sentinel }}` для нешифрованного подключения с помощью Sentinel.

    {% note warning %}

    Подключение к порту `{{ port-mrd-sentinel }}` позволяет запросить информацию о кластере без аутентификации. Чтобы ограничить неавторизованный доступ к кластеру при включенном публичном доступе к хостам, не указывайте этот порт в настройках групп безопасности.

    {% endnote %}

    Для этого создайте следующее правило для входящего трафика:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — создайте отдельное правило для каждого порта:

        * `{{ port-mrd }}` — для подключения напрямую к хостам без использования шифрования.
        * `{{ port-mrd-tls }}` — для подключения напрямую к хостам с использованием SSL-шифрования.
        * `{{ port-mrd-sentinel }}` — для работы с кластером через Sentinel.

            Для подключения к кластеру с использованием Sentinel требуется также создать правило, разрешающее подключение через порт `{{ port-mrd }}` или `{{ port-mrd-tls }}`.

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}** — группа безопасности, в которой находится ВМ. Если она совпадает с настраиваемой группой, то укажите **{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}**.

- Шардированный кластер {#sharded}

    [Настройте все группы безопасности](../../../vpc/operations/security-group-add-rule.md) кластера так, чтобы они разрешали входящий трафик из группы безопасности, в которой находится ВМ, на порт `{{ port-mrd }}`. Если кластер создан с поддержкой SSL-шифрования, то укажите только порт `{{ port-mrd-tls }}`.

    Для этого создайте следующее правило для входящего трафика:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-mrd }}` или только `{{ port-mrd-tls }}` для кластера с поддержкой SSL-шифрования.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}** — если кластер и ВМ находятся в одной и той же группе безопасности, выберите значение `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}`. В противном случае укажите группу безопасности ВМ.

{% endlist %}

{% note info %}

Вы можете задать более детальные правила для групп безопасности, например, разрешающие трафик только в определенных подсетях.

Группы безопасности должны быть корректно настроены для всех подсетей, в которых будут размещены хосты кластера. При неполных или некорректных настройках групп безопасности можно потерять доступ к кластеру, если произойдет [ручная](../failover.md) или [автоматическая](../../concepts/replication.md#availability) смена мастера.

{% endnote %}

Подробнее о группах безопасности см. в разделе [{#T}](../../concepts/network.md#security-groups).


## Получение SSL-сертификата {#get-ssl-cert}

Чтобы использовать шифрованное SSL-соединение, получите SSL-сертификат:

{% include [install-certificate](../../../_includes/mdb/mrd/install-certificate.md) %}

{% include [ide-ssl-cert](../../../_includes/mdb/mdb-ide-ssl-cert.md) %}

## FQDN хоста {{ RD }} {#fqdn}

Для подключения к хосту потребуется его [FQDN](../../concepts/network.md#hostname) — доменное имя. Его можно получить несколькими способами:

* [Запросите список хостов в кластере](../hosts.md#list-hosts).
* Скопируйте команду для подключения к кластеру в [консоли управления]({{ link-console-main }}). Команда содержит заполненный FQDN хоста. Чтобы получить команду, перейдите на страницу кластера и нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-connect }}**.
* Посмотрите FQDN в консоли управления:

   1. Перейдите на страницу кластера.
   1. Перейдите в раздел **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
   1. Скопируйте значение в столбце **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_name }}**.
