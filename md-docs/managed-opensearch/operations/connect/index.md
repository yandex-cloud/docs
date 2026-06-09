# Предварительная настройка для подключения к кластеру {{ OS }}


К хостам кластера {{ mos-name }} с [ролью](../../concepts/host-roles.md#data) `DATA` можно подключиться:

* Через интернет, если вы настроили публичный доступ для нужной группы хостов.

* Через интернет по [особому FQDN](fqdn.md#special-fqdns), если вы настроили публичный доступ для группы хостов с [ролью](../../concepts/host-roles.md#dashboards) `DASHBOARDS`.

* С виртуальных машин {{ yandex-cloud }}, расположенных в той же [виртуальной сети](../../../vpc/concepts/network.md).


Вне зависимости от способа подключения, {{ mos-name }} поддерживает только соединения с [SSL-сертификатом](#ssl-certificate) к хостам кластера.


## Настройка групп безопасности {#security-groups}

## Настройка групп безопасности {#configuring-security-groups}

Для подключения к кластеру необходимо, чтобы [группы безопасности](../../../vpc/concepts/security-groups.md) содержали правила, которые разрешают трафик с определенных портов, IP-адресов или из других групп безопасности.

Настройки правил доступа будут различаться в зависимости от выбранного способа подключения:

{% list tabs group=connection_method %}

- Через интернет {#internet}

  [Настройте все группы безопасности](../../../vpc/operations/security-group-add-rule.md) кластера так, чтобы они разрешали входящий трафик с любых IP-адресов на порты {{ port-https }} (Dashboards) и {{ port-mos }} ({{ OS }}). Для этого создайте следующие правила для входящего трафика:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-https }}`, `{{ port-mos }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

  На каждый порт создается отдельное правило.

- С ВМ в {{ yandex-cloud }} {#cloud}

    1. [Настройте все группы безопасности](../../../vpc/operations/security-group-add-rule.md) кластера так, чтобы они разрешали входящий трафик из группы безопасности, в которой находится ВМ, на порты {{ port-https }} (Dashboards) и {{ port-mos }} ({{ OS }}). Для этого создайте в этих группах следующие правила для входящего трафика:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-https }}`, `{{ port-mos }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}** — если кластер и ВМ находятся в одной и той же группе безопасности, выберите значение `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`). В противном случае укажите группу безопасности ВМ.

       На каждый порт создается отдельное правило.

    1. [Настройте все группы безопасности](../../../vpc/operations/security-group-add-rule.md), в которых находится ВМ, так, чтобы можно было подключаться к ВМ и был разрешен трафик между ней и хостами кластера.

       Пример правил для ВМ:

        * Для входящего трафика:

            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-ssh }}`, `{{ port-https }}`, `{{ port-mos }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

          На каждый порт создается отдельное правило.

        * Для исходящего трафика:

            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-any }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

          Это правило разрешает любой исходящий трафик, что позволяет не только подключаться к кластеру, но и устанавливать на ВМ необходимые для этого сертификаты и утилиты.

{% endlist %}

{% note info %}

Вы можете задать более детальные правила для групп безопасности, например, разрешающие трафик только в определенных подсетях.

Группы безопасности должны быть корректно настроены для всех подсетей, в которых будут размещены хосты кластера. При неполных или некорректных настройках групп безопасности можно потерять доступ к кластеру.

{% endnote %}

Подробнее о группах безопасности см. в разделе [{#T}](../../concepts/network.md#security-groups).


## Получение SSL-сертификата {#ssl-certificate}

Чтобы использовать шифрованное соединение, получите SSL-сертификат:

{% list tabs group=operating_system %}

- Linux (Bash)/macOS (Zsh) {#linux-macos}

   ```bash
   mkdir -p ~/.opensearch && \
   wget "{{ crt-web-path }}" \
        --output-document ~/.opensearch/root.crt && \
   chmod 0600 ~/.opensearch/root.crt
   ```

   Сертификат будет сохранен в файле `~/.opensearch/root.crt`.

- Windows (PowerShell) {#windows}

   ```powershell
   mkdir $HOME\.opensearch; curl.exe -o $HOME\.opensearch\root.crt {{ crt-web-path }}
   ```

   Сертификат будет сохранен в файле `$HOME\.opensearch\root.crt`.

   Корпоративные политики и антивирус могут блокировать скачивание сертификата. Подробнее читайте в разделе [Вопросы и ответы](../../qa/index.md#get-ssl-error).

{% endlist %}

## Что дальше {#whats-next}

* [Получите FQDN хоста](fqdn.md), к которому будете подключаться.
* [Подключитесь](clients.md) к кластеру из Docker-контейнера.
* [Интегрируйте](code-examples.md) подключение к кластеру в код вашего приложения.
* [Настройте SAML-аутентификацию](../saml-authentication.md).