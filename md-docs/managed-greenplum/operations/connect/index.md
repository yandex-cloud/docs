# Предварительная настройка для подключения к кластеру {{ mgp-name }}

В кластере {{ mgp-name }} вы можете развернуть СУБД {{ GP }} или {{ CB }}. Обе СУБД основаны на {{ PG }}, поэтому для подключения к ним используются те же инструменты, что и для {{ PG }}.

Подключение к кластеру {{ mgp-name }} производится только через [первичный хост-мастер](../../concepts/index.md). Чтобы определить роли хостов, получите [список хостов в кластере](../cluster-list.md#get-hosts).

К кластеру можно подключиться:

* С виртуальных машин {{ yandex-cloud }}, расположенных в той же [облачной сети](../../../vpc/concepts/network.md). Если к хосту нет публичного доступа, для подключения с таких виртуальных машин необязательно использовать SSL-соединение.
* Через интернет, если вы настроили публичный доступ для кластера. Через интернет можно подключиться следующими способами:

  * используя SSL-соединение;
  * используя авторизацию через IAM.


## Настройка групп безопасности {#configuring-security-groups}

Кластеру {{ mgp-name }} может быть назначена одна или несколько групп безопасности. Для подключения к кластеру необходимо, чтобы группы безопасности содержали правила, разрешающие входящий трафик на порт {{ port-mgp }} с определенных IP-адресов или из других групп безопасности.

{% note info %}

Группа безопасности, назначенная на кластер, регулирует трафик между кластером и другими ресурсами в облаке или вне его. Взаимодействие хостов кластера между собой регулируется отдельной системной группой безопасности и не требует настройки.

{% endnote %}

Настройки правил будут различаться в зависимости от выбранного способа подключения:

{% list tabs group=connection_method %}

- Через интернет {#internet}

    1. Для входящего трафика:
    
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-mgp }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — диапазон адресов, с которых производится подключение.
    
    1. Для исходящего трафика:
    
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-any }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.
    
       Это правило позволит {{ mgp-name }} работать с внешними источниками данных, например PXF или GPFDIST.

- С ВМ в {{ yandex-cloud }} {#cloud}

    1. Добавьте в группу безопасности кластера следующие правила:

        1. Для входящего трафика:

            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-mgp }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}** — если кластер и ВМ находятся в одной и той же группе безопасности, выберите значение `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`). В противном случае укажите группу безопасности ВМ.

         1. Для исходящего трафика:

            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-any }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

            Это правило позволит {{ mgp-name }} работать с внешними источниками данных, например PXF или GPFDIST.

    1. [Настройте группу безопасности](../../../vpc/operations/security-group-add-rule.md), в которой находится ВМ, так, чтобы можно было подключаться к ВМ и был разрешен трафик между ВМ и хостами кластера:

        * Для входящего трафика:
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `22`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — диапазон адресов, с которых производится подключение.

            Это правило позволяет подключаться к ВМ по протоколу [SSH](../../../glossary/ssh-keygen.md).

        * Для исходящего трафика:
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-any }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

            Это правило разрешает любой исходящий трафик, что позволяет не только подключаться к кластеру, но и устанавливать на ВМ необходимые для этого сертификаты и утилиты.

{% endlist %}


### Группы безопасности для работы с {{ mtr-full-name }} {#sg-for-trino}

Для подключения к кластеру {{ GP }} [коннектор](../../../managed-trino/concepts/greenplum-connector.md) {{ TR }} использует протокол GPFDIST:

* Координаторы и воркеры {{ TR }} выполняют запросы к мастеру {{ GP }} через TCP-порт `{{ port-mgp }}`.
* Сегменты {{ GP }} передают данные на воркеры {{ TR }} через TCP-порт GPFDIST.

Данные, передающиеся по протоколу GPFDIST между кластерами {{ GP }} и {{ TR }}, не шифруются. Чтобы обеспечить безопасное подключение, настройте группы безопасности [на стороне {{ mgp-name }}](#configuring-security-groups-greenplum) и (опционально) [на стороне {{ mtr-name }}](#configuring-security-groups-trino).

Если {{ GP }} взаимодействует с другими кластерами или другими сущностями внутри пользовательской сети, то для них нужно отдельно настроить правила группы безопасности.

#### Настройка на стороне {{ GP }} {#configuring-security-groups-greenplum}

{% list tabs group=traffic %}

- Входящий трафик {#incoming}

    * Правило для трафика внутри кластера {{ GP }}:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-any }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`).

    * Правило для подключения из кластера {{ TR }}:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-mgp }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}** — укажите группу безопасности кластера {{ TR }}.

- Исходящий трафик {#outgoing}

    * Правило для трафика внутри кластера {{ GP }}:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-any }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`).

    * Правило для подключения к кластеру {{ TR }}:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `0-65535`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}** — укажите группу безопасности кластера {{ TR }}.

{% endlist %}

#### Настройка на стороне {{ mtr-name }} {#configuring-security-groups-trino}

Правила групп безопасности на стороне {{ TR }} настраиваются зеркально правилам на стороне {{ GP }}. Настройка правил для кластера {{ TR }} является опциональной, но позволяет дополнительно обезопасить кластер.

{% list tabs group=traffic %}

- Входящий трафик {#incoming}

  Правило для приема данных от сегментов {{ GP }}:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `0-65535`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}** — укажите группу безопасности кластера {{ GP }}.

- Исходящий трафик {#outgoing}

  Правило для подключения к мастеру {{ GP }}:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-mgp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}** — укажите группу безопасности кластера {{ GP }}.

{% endlist %}


## Получение SSL-сертификата {#get-ssl-cert}

Чтобы использовать [SSL-соединение](../../../glossary/ssl-certificate.md), получите сертификат:

{% list tabs group=operating_system %}

- Linux (Bash)/macOS (Zsh) {#linux-macos}

   ```bash
   mkdir -p ~/.postgresql && \
   wget "{{ crt-web-path }}" \
        --output-document ~/.postgresql/root.crt && \
   chmod 0655 ~/.postgresql/root.crt
   ```

   Сертификат будет сохранен в файле `~/.postgresql/root.crt`.

- Windows (PowerShell) {#windows}

   ```powershell
   mkdir $HOME\.postgresql; curl.exe -o $HOME\.postgresql\root.crt {{ crt-web-path }}
   ```

   Сертификат будет сохранен в файле `$HOME\.postgresql\root.crt`.

   Корпоративные политики и антивирус могут блокировать скачивание сертификата. Подробнее см. в разделе [Вопросы и ответы](../../qa/connection.md#get-ssl-error).

{% endlist %}

Для использования графических IDE [сохраните сертификат]({{ crt-web-path-root }}) в локальную папку и укажите путь к нему в настройках подключения.

## Что дальше {#whats-next}

* [Получите FQDN хоста](fqdn.md), к которому будете подключаться.
* [Подключитесь](clients.md) к кластеру из графической IDE, {{ pgadmin }} или Docker-контейнера.
* [Интегрируйте](code-examples.md) подключение к кластеру в код вашего приложения.

_Greenplum® и Greenplum Database® являются зарегистрированными товарными знаками или товарными знаками Broadcom Inc в США и/или других странах._

_Apache® и Apache Cloudberry™ являются зарегистрированными товарными знаками или товарными знаками Apache Software Foundation в США и/или других странах._