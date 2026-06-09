# Предварительная настройка для подключения к кластеру {{ CH }}

К хостам кластера {{ mch-short-name }} можно подключиться:

* Через интернет, если вы [настроили](../hosts.md#update) публичный доступ для нужного хоста. К таким хостам подключиться можно только используя SSL-соединение.

* С виртуальных машин {{ yandex-cloud }}, расположенных в той же [облачной сети](../../../vpc/concepts/network.md). Если к хосту нет публичного доступа, для подключения с таких виртуальных машин необязательно использовать SSL-соединение.


К кластеру можно подключиться как с использованием шифрования — через порты `{{ port-mch-cli }}` для [clickhouse-client]({{ ch.docs }}{{ lang }}/interfaces/cli) и `{{ port-mch-http }}` для [HTTP-интерфейса]({{ ch.docs }}{{ lang }}/interfaces/http), так и без него — через порты `9000` и `8123` соответственно.



## Настройка групп безопасности {#configuring-security-groups}

Для подключения к кластеру необходимо, чтобы [группы безопасности](../../../vpc/concepts/security-groups.md) содержали правила, которые разрешают трафик с определенных портов, IP-адресов или из других групп безопасности.

Настройки правил будут различаться в зависимости от выбранного способа подключения:

{% list tabs group=connection_method %}

- Через интернет {#internet}

  [Настройте все группы безопасности](../../../vpc/operations/security-group-add-rule.md) кластера так, чтобы они разрешали входящий трафик с любых IP-адресов на порты 8443, 9440. Для этого создайте следующие правила для входящего трафика:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `8443`, `9440`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

  На каждый порт создается отдельное правило.

  {% note warning %}

  Чтобы повысить безопасность кластера, укажите в поле **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** только доверенные IP-адреса или подсети.

  {% endnote %}

- С ВМ в {{ yandex-cloud }} {#cloud}

    1. [Настройте все группы безопасности](../../../vpc/operations/security-group-add-rule.md) кластера так, чтобы они разрешали входящий трафик из группы безопасности, в которой находится ВМ, на порты 8123, 8443, 9000, 9440. Для этого создайте в этих группах следующие правила для входящего трафика:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `8123` (или другой порт из перечисленных).
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}** — если кластер и ВМ находятся в одной и той же группе безопасности, выберите значение `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`). В противном случае укажите группу безопасности ВМ.

       На каждый порт создается отдельное правило.

    1. [Настройте группу безопасности](../../../vpc/operations/security-group-add-rule.md), в которой находится ВМ так, чтобы можно было подключаться к ВМ и был разрешен трафик между ВМ и хостами кластера.

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

Группы безопасности должны быть корректно настроены для всех подсетей, в которых будут размещены хосты кластера. При неполных или некорректных настройках групп безопасности можно потерять доступ к кластеру.

{% endnote %}

Подробнее о группах безопасности см. в разделе [Сеть и кластеры БД](../../concepts/network.md#security-groups).


## Получение SSL-сертификатов {#get-ssl-cert}

Чтобы использовать шифрованное соединение, получите SSL-сертификаты:

{% list tabs group=operating_system %}

- Linux (Bash) {#linux}

   ```bash
   sudo mkdir --parents {{ crt-local-dir }} && \
   sudo wget "{{ crt-web-path-root }}" \
        --output-document {{ crt-local-dir }}{{ crt-local-file-root }} && \
   sudo wget "{{ crt-web-path-int }}" \
        --output-document {{ crt-local-dir }}{{ crt-local-file-int }} && \
   sudo chmod 655 \
        {{ crt-local-dir }}{{ crt-local-file-root }} \
        {{ crt-local-dir }}{{ crt-local-file-int }} && \
   sudo update-ca-certificates
   ```

   Сертификаты будут сохранены в файлах:

   * `{{ crt-local-dir }}{{ crt-local-file-root }}`
   * `{{ crt-local-dir }}{{ crt-local-file-int }}`

- macOS (Zsh) {#macos}

   ```bash
   sudo mkdir -p {{ crt-local-dir }} && \
   sudo wget "{{ crt-web-path-root }}" \
        --output-document {{ crt-local-dir }}{{ crt-local-file-root }} && \
   sudo wget "{{ crt-web-path-int }}" \
        --output-document {{ crt-local-dir }}{{ crt-local-file-int }} && \
   sudo chmod 655 \
        {{ crt-local-dir }}{{ crt-local-file-root }} \
        {{ crt-local-dir }}{{ crt-local-file-int }} && \
   security import {{ crt-local-dir }}{{ crt-local-file-root }} -k ~/Library/Keychains/login.keychain; \
   security import {{ crt-local-dir }}{{ crt-local-file-int }} -k ~/Library/Keychains/login.keychain
   ```

   Сертификаты будут сохранены в файлах:

   * `{{ crt-local-dir }}{{ crt-local-file-root }}`
   * `{{ crt-local-dir }}{{ crt-local-file-int }}`

- Windows (PowerShell) {#windows}

   1. Скачайте и импортируйте сертификаты:

      ```powershell
      mkdir -Force $HOME\.yandex; `
      curl.exe {{ crt-web-path-root }} `
        --output $HOME\.yandex\{{ crt-local-file-root }}; `
      curl.exe {{ crt-web-path-int }} `
        --output $HOME\.yandex\{{ crt-local-file-int }}; `
      Import-Certificate `
        -FilePath $HOME\.yandex\{{ crt-local-file-root }} `
        -CertStoreLocation cert:\CurrentUser\Root; `
      Import-Certificate `
        -FilePath $HOME\.yandex\{{ crt-local-file-int }} `
        -CertStoreLocation cert:\CurrentUser\Root
      ```

      Корпоративные политики и антивирус могут блокировать скачивание сертификата. Подробнее см. в разделе [Вопросы и ответы](../../qa/connection.md#get-ssl-error).

   1. Подтвердите согласие с установкой сертификатов в хранилище <q>Доверенные корневые центры сертификации</q>.

   Сертификаты будут сохранены в файлах:

   * `$HOME\.yandex\{{ crt-local-file-root }}`
   * `$HOME\.yandex\{{ crt-local-file-int }}`

{% endlist %}

Для использования графических IDE [сохраните сертификат]({{ crt-web-path-root }}) в локальную папку и укажите путь к нему в настройках подключения.

## Что дальше {#whats-next}

* [Получите FQDN хоста](fqdn.md), к которому будете подключаться.
* [Подключитесь](clients.md) к кластеру из браузера, графической IDE или интерфейса командной строки.
* [Интегрируйте](code-examples.md) подключение к кластеру в код вашего приложения.

## См. также {#see-also}

* [Подключение к {{ CH }} — вопросы и ответы](../../qa/connection.md)

_{{ CH }} является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._