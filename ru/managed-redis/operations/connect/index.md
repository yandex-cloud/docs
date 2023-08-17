# Подготовка к подключению

Доступные способы подключения зависят от того, включено ли в кластере [шардирование](../../concepts/sharding.md):

* [Подключение к нешардированному кластеру](./non-sharded.md).
* [Подключение к шардированному кластеру](./sharded.md).

## Поддержка шифрования {#tls-support}

Для кластеров {{ mrd-short-name }} поддерживается шифрованное SSL-соединение. Чтобы пользоваться SSL, при [создании кластера](../cluster-create.md) включите настройку **{{ ui-key.yacloud.redis.field_tls-support }}**.

При SSL-подключении к кластеру с поддержкой шифрования отключите проверку соответствия FQDN и сертификата на стороне приложения. Иначе подключиться к кластеру не получится, т. к. {{ RD }} вместо FQDN хоста возвращает его IP-адрес, в результате при проверке имени хоста возникнет ошибка.

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




## Настройка групп безопасности {#configuring-security-groups}

{% include [security-groups-note](../../../_includes/vpc/security-groups-note-services.md) %}

{% include [Security groups notice](../../../_includes/mdb/sg-rules-connect.md) %}

{% include [Security groups rules for VM](../../../_includes/mdb/mrd/connect/sg-rules-for-vm.md) %}

Настройки групп безопасности для шардированного и нешардированного кластеров различаются.

{% list tabs %}

* Кластер без шардирования

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

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}** — группа безопасности, в которой находится ВМ. Если она совпадает с настраиваемой группой, то укажите **{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}**.

* Шардированный кластер

    [Настройте все группы безопасности](../../../vpc/operations/security-group-add-rule.md) кластера так, чтобы они разрешали входящий трафик из группы безопасности, в которой находится ВМ, на порт `{{ port-mrd }}`. Если кластер создан с поддержкой SSL-шифрования, то укажите только порт `{{ port-mrd-tls }}`.

    Для этого создайте следующее правило для входящего трафика:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-mrd }}` или только `{{ port-mrd-tls }}` для кластера с поддержкой SSL-шифрования.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}`.
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
