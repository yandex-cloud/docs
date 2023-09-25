# Подключение к топикам в кластере Apache Kafka®

К хостам кластера {{ mkf-name }} можно подключиться:

* Через интернет, если вы настроили публичный доступ для кластера [при его создании](cluster-create.md). К такому кластеру можно подключиться только используя [SSL-соединение](#get-ssl-cert).


* С виртуальных машин {{ yandex-cloud }}, расположенных в той же [облачной сети](../../vpc/concepts/network.md). Если к кластеру нет публичного доступа, для подключения с таких ВМ SSL-соединение использовать необязательно.



К кластеру {{ KF }} можно подключиться как с использованием шифрования (`SASL_SSL`) — порт {{ port-mkf-ssl }}, так и без него (`SASL_PLAINTEXT`) — порт {{ port-mkf-text }}.


Чтобы подключиться к кластеру {{ KF }}:

1. [Создайте пользователей](cluster-accounts.md#create-user) для клиентов (производителей и потребителей) с доступами в нужные топики.
1. Подключите клиентов к кластеру:
   * производителей с помощью [Kafka Producer API](https://kafka.apache.org/documentation/#producerapi);
   * потребителей с помощью [Kafka Consumer API](https://kafka.apache.org/documentation/#consumerapi).

Для большинства популярных языков программирования существуют готовые реализации API {{ KF }}. Примеры кода для подключения к кластеру приведены в разделе [{#T}](#connection-string).


## Настройка групп безопасности {#configuring-security-groups}

{% include [sg-rules](../../_includes/mdb/sg-rules-connect.md) %}

Настройки правил будут различаться в зависимости от выбранного способа подключения:

{% list tabs %}

- Через интернет

  [Настройте все группы безопасности](../../vpc/operations/security-group-add-rule.md) кластера так, чтобы они разрешали входящий трафик с любых IP-адресов на порт {{ port-mkf-ssl }}. Для этого создайте следующее правило для входящего трафика:

  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-mkf-ssl }}`.
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}`.
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

  Чтобы разрешить подключение к [{{ mkf-msr }}](../concepts/managed-schema-registry.md), добавьте правило для входящего трафика:

  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-https }}`.
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}`.
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

- С ВМ в Облаке

  1. [Настройте все группы безопасности](../../vpc/operations/security-group-add-rule.md) кластера так, чтобы они разрешали входящий трафик из группы безопасности, в которой находится ВМ, на порты {{ port-mkf-ssl }}, {{ port-mkf-text }}. Для этого в этих группах создайте следующее правило для входящего трафика:

     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-mkf-ssl }}-{{ port-mkf-text }}`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}** — если кластер и ВМ находятся в одной и той же группе безопасности, выберите значение `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`). В противном случае укажите группу безопасности ВМ.

     Чтобы разрешить подключение к [{{ mkf-msr }}](../concepts/managed-schema-registry.md), добавьте правило для входящего трафика:

       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-https }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

  1. [Настройте группу безопасности](../../vpc/operations/security-group-add-rule.md), в которой находится ВМ так, чтобы можно было подключаться к ВМ и был разрешен трафик между ВМ и хостами кластера.

     Пример правил для ВМ:

     * Для входящего трафика:
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-ssh }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

       Это правило позволяет подключаться к ВМ по протоколу [SSH](../../glossary/ssh-keygen.md).

     * Для исходящего трафика:
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-any }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

       Это правило разрешает любой исходящий трафик, что позволяет не только подключаться к кластеру, но и устанавливать на ВМ необходимые для этого сертификаты и утилиты.

{% endlist %}

{% note info %}

Вы можете задать более детальные правила для групп безопасности, например, разрешающие трафик только в определенных подсетях.

Группы безопасности должны быть корректно настроены для всех подсетей, в которых будут размещены хосты кластера. При неполных или некорректных настройках групп безопасности можно потерять доступ к кластеру.

{% endnote %}

Подробнее о группах безопасности см. в разделе [{#T}](../concepts/network.md#security-groups).


## Получение SSL-сертификата {#get-ssl-cert}

Чтобы использовать шифрованное соединение, получите SSL-сертификат:

{% include [install-certificate](../../_includes/mdb/mkf/install-certificate.md) %}

Полученный SSL-сертификат также используется при работе с [{{ mkf-msr }}](../concepts/managed-schema-registry.md).

## Подготовка к подключению из Docker-контейнера {#connection-docker}

Чтобы подключаться к кластеру {{ mkf-name }} из Docker-контейнера, добавьте в Dockerfile строки:

{% list tabs %}


* Подключение без SSL

  ```bash
  RUN apt-get update && \
      apt-get install kafkacat --yes
  ```


* Подключение с SSL

  ```bash
  RUN apt-get update && \
      apt-get install wget kafkacat --yes && \
      mkdir --parents {{ crt-local-dir }} && \
      wget "{{ crt-web-path }}" \
           --output-document {{ crt-local-dir }}{{ crt-local-file }} && \
      chmod 0655 {{ crt-local-dir }}{{ crt-local-file }}
  ```

{% endlist %}

## Примеры строк подключения {#connection-string}

{% include [conn-strings-environment](../../_includes/mdb/mkf-conn-strings-env.md) %}

Перед подключением к хостам кластера с использованием SSL-соединения, [подготовьте сертификат](#get-ssl-cert). В примерах ниже предполагается, что сертификат `{{ crt-local-file }}` расположен в директории:
* `{{ crt-local-dir }}` для Ubuntu;
* `$HOME\.kafka\` для Windows.

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% include [mkf-connection-strings](../../_includes/mdb/mkf-conn-strings.md) %}
