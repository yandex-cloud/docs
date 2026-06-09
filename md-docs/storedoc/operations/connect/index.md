# Предварительная настройка для подключения к кластеру {{ SD }}

К хостам кластера {{ mmg-short-name }} можно подключиться:

* Через интернет, если вы настроили публичный доступ для нужного хоста. Это можно сделать при [создании кластера](../cluster-create.md) или при [редактировании настроек хоста](../hosts.md#update). К таким хостам подключиться можно только используя SSL-соединение.

* С виртуальных машин {{ yandex-cloud }}, расположенных в той же [облачной сети](../../../vpc/concepts/network.md). Если к хосту нет публичного доступа, для подключения с таких виртуальных машин необязательно использовать SSL-соединение.

Для подключения к хостам кластера используйте порт:

* `{{ port-mmg }}` — если кластер нешардированный;
* `{{ port-mmg-sharded }}` — если кластер [шардированный](../../concepts/sharding.md).

Запросы на запись будут автоматически направлены к первичной реплике кластера.


{% note info %}

Чтобы вы могли подключиться к кластеру из интернета, публичный доступ должен быть настроен для первичной реплики.

Если публичный доступ настроен только для некоторых хостов, [автоматическая смена первичной реплики](../../concepts/replication.md) может привести к тому, что вы не сможете подключиться к кластеру из интернета.

{% endnote %}



## Настройка групп безопасности {#configuring-security-groups}

Для подключения к кластеру необходимо, чтобы [группы безопасности](../../../vpc/concepts/security-groups.md) содержали правила, которые разрешают трафик с определенных портов, IP-адресов или из других групп безопасности.

Настройки правил будут различаться в зависимости от выбранного способа подключения:

{% list tabs group=connection_method %}

- Через интернет {#internet}

    [Настройте все группы безопасности](../../../vpc/operations/security-group-add-rule.md) кластера так, чтобы они разрешали входящий трафик с любых IP-адресов на порт `{{ port-mmg }}` для нешардированного кластера или на порт `{{ port-mmg-sharded }}` для [шардированного](../shards.md). Для этого создайте следующее правило для входящего трафика:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**:
        * `{{ port-mmg }}` — для нешардированного кластера;
        * `{{ port-mmg-sharded }}` — для шардированного кластера.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

- С ВМ в {{ yandex-cloud }} {#cloud}

    1. [Настройте все группы безопасности](../../../vpc/operations/security-group-add-rule.md) кластера так, чтобы они разрешали входящий трафик из группы безопасности, в которой находится ВМ, на порт `{{ port-mmg }}` для нешардированного кластера или на порт `{{ port-mmg-sharded }}` для [шардированного](../shards.md). Для этого в этих группах создайте следующее правило для входящего трафика:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**:
            * `{{ port-mmg }}` — для нешардированного кластера;
            * `{{ port-mmg-sharded }}` — для шардированного кластера.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}** — группа безопасности, в которой находится ВМ. Если она совпадает с настраиваемой группой, то укажите `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`).
        
    1. [Настройте группу безопасности](../../../vpc/operations/security-group-add-rule.md), в которой находится ВМ, так, чтобы можно было подключаться к ВМ и был разрешен трафик между ВМ и хостами кластера.

        Пример правил для ВМ:

        * Для входящего трафика:

            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-ssh }}`;
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`;
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`;
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

            Это правило позволяет подключаться к ВМ по протоколу [SSH](../../../glossary/ssh-keygen.md).

        * Для исходящего трафика:

            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-any }}`;
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`);
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`;
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

            Это правило разрешает любой исходящий трафик, что позволяет не только подключаться к кластеру, но и устанавливать на ВМ необходимые для этого сертификаты и утилиты.

{% endlist %}

{% note info %}

Вы можете задать более детальные правила для групп безопасности, например, разрешающие трафик только в определенных подсетях.

Группы безопасности должны быть корректно настроены для всех подсетей, в которых будут размещены хосты кластера. При неполных или некорректных настройках групп безопасности можно потерять доступ к кластеру, если произойдет [автоматическая смена первичной реплики](../../concepts/replication.md).

{% endnote %}

Подробнее см. в разделе [{#T}](../../concepts/network.md#security-groups).


## Получение SSL-сертификата {#get-ssl-cert}

Чтобы подключиться к хостам {{ SD }} с публичным доступом, получите SSL-сертификат:

{% list tabs group=operating_system %}

- Linux (Bash)/macOS (Zsh) {#linux-macos}

   ```bash
   mkdir -p ~/.mongodb && \
   wget "{{ crt-web-path }}" \
        --output-document ~/.mongodb/root.crt && \
   chmod 0644 ~/.mongodb/root.crt
   ```

   Сертификат будет сохранен в файле `~/.mongodb/root.crt`.

- Windows (PowerShell) {#windows}

   ```powershell
   mkdir $HOME\.mongodb; curl.exe -o $HOME\.mongodb\root.crt {{ crt-web-path }}
   ```

   Сертификат будет сохранен в файле `$HOME\.mongodb\root.crt`.

   Корпоративные политики и антивирус могут блокировать скачивание сертификата. Подробнее см. в разделе [Вопросы и ответы](../../qa/storedoc.md#get-ssl-error).

{% endlist %}

Для использования графических IDE [сохраните сертификат]({{ crt-web-path-root }}) в локальную папку и укажите путь к нему в настройках подключения.

## Получение FQDN хостов {{ SD }} {#get-fqdn}

Для подключения к хосту потребуется его [FQDN](../../concepts/network.md#hostname) — доменное имя. Пример FQDN хоста {{ SD }}:

```text
{{ host-name }}.{{ dns-zone }}
```

FQDN можно получить несколькими способами:

* Посмотрите FQDN в консоли управления:

    1. Перейдите на страницу кластера.
    1. Перейдите в раздел **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
    1. Скопируйте значение в столбце **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_name }}**.

* Скопируйте команду для подключения к кластеру в [консоли управления]({{ link-console-main }}). Команда содержит заполненный FQDN хоста. Чтобы получить команду, перейдите на страницу кластера и нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-connect }}**.

* [Запросите список хостов в кластере](../hosts.md#list-hosts) с помощью CLI или API.

## Ограничения на количество подключений {#connection-limits}

Максимальное доступное количество одновременных подключений к отдельному хосту кластера {{ mmg-name }} зависит от объема оперативной памяти этого хоста:

| Объем оперативной памяти | Максимальное количество подключений |
| ------------------------:| -----------------------------------:|
| 2 ГБ | 2048 |
| 4 ГБ | 4096 |
| 8 ГБ | 8192 |
| 16 ГБ и выше | 16 384 |

Объем оперативной памяти хоста определяется его классом. Все доступные варианты перечислены в разделе [Классы хостов](../../concepts/instance-types.md).

## Установка MongoDB Shell {#mongosh-install}

Для подключения к кластеру {{ mmg-name }} из Linux (Bash) и Windows (PowerShell) установите утилиту MongoDB Shell:

{% list tabs group=connection %}

- Linux {#linux}

  1. Если у вас не установлен менеджер пакетов brew, установите его:

      ```bash
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      ```

  1. Добавьте brew в `PATH`:

      ```bash
      echo >> /home/<имя_пользователя>/.bashrc && \
      echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/<пользователя>/.bashrc && \
      eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
      ```

  1. Установите зависимости:

      ```bash
      sudo apt-get install build-essential
      ```

  1. Установите пакет `mongodb-atlas-cli`:

      ```bash
      brew install mongodb-atlas-cli
      ```

- Windows 10/11 {#windows}

  Используйте один из способов:

  * Скачайте установщик MongoDB Shell в формате `*.msi` из [официального репозитория GitHub](https://github.com/mongodb-js/mongosh/releases) и установите его.
  * Установите MongoDB Shell с помощью пакетного менеджера [Chocolatey](https://chocolatey.org/install), используя команду:

    ```bash
    choco install mongodb-shell
    ```

{% endlist %}

## Что дальше {#whats-next}

* [Подключитесь](clients.md) к кластеру с помощью инструментов командной строки, из графической IDE или Docker-контейнера.
* [Интегрируйте](code-examples.md) подключение к кластеру в код вашего приложения.