# Предварительная настройка для подключения к кластеру {{ PG }}

К хостам кластера {{ mpg-short-name }} можно подключиться:

* Через интернет, если вы [настроили](../hosts.md#update) публичный доступ для нужного хоста. Через интернет можно подключиться следующими способами:
  * используя SSL-соединение;
  * используя авторизацию через IAM.

* С виртуальных машин {{ yandex-cloud }}, расположенных в той же [облачной сети](../../../vpc/concepts/network.md). Если к хосту нет публичного доступа, для подключения с таких виртуальных машин необязательно использовать SSL-соединение.

* Из контейнера [{{ serverless-containers-name }}](../../../serverless-containers/concepts/index.md). Если к хосту нет публичного доступа, контейнер должен располагаться в той же облачной сети.


{% note warning %}

Если публичный доступ в кластере настроен только для некоторых хостов, [автоматическая смена мастера](../../concepts/replication.md#replication-auto) может привести к невозможности подключиться к мастеру из интернета.

{% endnote %}

## Настройка групп безопасности {#configuring-security-groups}

Для подключения к кластеру необходимо, чтобы [группы безопасности](../../../vpc/concepts/security-groups.md) содержали правила, которые разрешают трафик с определенных портов, IP-адресов или из других групп безопасности.

Настройки правил будут различаться в зависимости от выбранного способа подключения:

{% list tabs group=connection_method %}

- Через интернет {#internet}

  [Настройте все группы безопасности](../../../vpc/operations/security-group-add-rule.md) кластера так, чтобы они разрешали входящий трафик с любых IP-адресов на порт 6432. Для этого создайте следующее правило для входящего трафика:

  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `6432`.
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
  * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

- С ВМ в {{ yandex-cloud }} {#cloud}

  1. [Настройте все группы безопасности](../../../vpc/operations/security-group-add-rule.md) кластера так, чтобы они разрешали входящий трафик из группы безопасности, в которой находится ВМ, на порт 6432. Для этого в этих группах создайте следующее правило для входящего трафика:

     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `6432`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}** — если кластер и ВМ находятся в одной и той же группе безопасности, выберите значение `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`). В противном случае укажите группу безопасности ВМ.

  1. [Настройте группу безопасности](../../../vpc/operations/security-group-add-rule.md), в которой находится ВМ, так, чтобы можно было подключаться к ВМ и был разрешен трафик между ВМ и хостами кластера.

     Пример правил для ВМ:

     * Для входящего трафика:
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `22`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

       Это правило позволяет [подключаться](../../../compute/operations/vm-connect/ssh.md#vm-connect) к ВМ по протоколу [SSH](../../../glossary/ssh-keygen.md).

     * Для исходящего трафика:
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-any }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

       Это правило разрешает любой исходящий трафик, что позволяет не только подключаться к кластеру, но и устанавливать на ВМ необходимые для этого сертификаты и утилиты.

{% endlist %}

{% note info %}

Вы можете задать более детальные правила для групп безопасности, например, разрешающие трафик только в определенных подсетях.

Группы безопасности должны быть корректно настроены для всех подсетей, в которых будут размещены хосты кластера. При неполных или некорректных настройках групп безопасности можно потерять доступ к кластеру, если произойдет [ручная](../hosts.md#update) или [автоматическая](../../concepts/replication.md#replication-auto) смена мастера.

{% endnote %}

Подробнее о группах безопасности см. в разделе [{#T}](../../concepts/network.md#security-groups).


## Получение SSL-сертификата {#get-ssl-cert}

Хосты {{ PG }} с публичным доступом поддерживают только шифрованные соединения. Чтобы использовать их, получите [SSL-сертификат](../../../glossary/ssl-certificate.md):

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
* [Подключитесь](clients.md) к кластеру с помощью инструментов командной строки, из графических IDE, {{ websql-full-name }}, {{ pgadmin }}, {{ google-looker }} и Docker-контейнера.
* [Интегрируйте](code-examples.md) подключение к кластеру в код вашего приложения.