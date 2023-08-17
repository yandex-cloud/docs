# Подключение к базе данных в кластере {{ MY }}

К хостам кластера {{ mmy-short-name }} можно подключиться:

{% include [cluster-connect-note](../../_includes/mdb/mmy/cluster-connect-note.md) %}

{% note warning %}

Если публичный доступ в кластере настроен только для некоторых хостов, [автоматическая смена мастера](../concepts/replication.md#master-failover) может привести к невозможности подключиться к мастеру из интернета.

{% endnote %}

Максимальное количество подключений определяется настройкой [Max connections](../concepts/settings-list.md#setting-max-connections), которая [зависит от класса хостов](../concepts/settings-list.md#settings-instance-dependent).

Подробнее см. в разделе [{#T}](../concepts/network.md).


## Настройка групп безопасности {#configure-security-groups}

{% include [security-groups-note](../../_includes/vpc/security-groups-note-services.md) %}

{% include [sg-rules](../../_includes/mdb/sg-rules-connect.md) %}

Настройки правил будут различаться в зависимости от выбранного способа подключения:

{% list tabs %}

- Через интернет

    [Настройте все группы безопасности](../../vpc/operations/security-group-add-rule.md) кластера так, чтобы они разрешали входящий трафик с любых IP-адресов на порт {{ port-mmy }}. Для этого создайте следующее правило для входящего трафика:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-mmy }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

- С ВМ в {{ yandex-cloud }}

    1. [Настройте все группы безопасности](../../vpc/operations/security-group-add-rule.md) кластера так, чтобы они разрешали входящий трафик из группы безопасности, в которой находится ВМ, на порт {{ port-mmy }}. Для этого в этих группах создайте следующее правило для входящего трафика:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-mmy }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
        * Группа безопасности — если кластер и ВМ находятся в одной и той же группе безопасности, выберите значение `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`). В противном случае укажите группу безопасности ВМ.

    1. [Настройте группу безопасности](../../vpc/operations/security-group-add-rule.md), в которой находится ВМ так, чтобы можно было подключаться к ВМ и был разрешен трафик между ВМ и хостами кластера.

        Пример правил для ВМ:

        * Для входящего трафика:
           * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-ssh }}`.
           * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}`.
           * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
           * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

            Это правило позволяет [подключаться](../../compute/operations/vm-connect/ssh.md#vm-connect) к ВМ по протоколу [SSH](../../glossary/ssh-keygen.md).

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

Подробнее о группах безопасности см. в разделе [{#T}](../concepts/network.md#security-groups).


## Получение SSL-сертификата {#get-ssl-cert}

{{ MY }}-хосты с публичным доступом поддерживают только шифрованные соединения. Чтобы использовать их, получите SSL-сертификат:

{% include [install-certificate](../../_includes/mdb/mmy/install-certificate.md) %}

{% include [ide-ssl-cert](../../_includes/mdb/mdb-ide-ssl-cert.md) %}

## Особые FQDN {#special-fqdns}

Наравне с обычными FQDN, которые можно запросить со [списком хостов в кластере](./hosts.md#list), {{ mmy-name }} предоставляет несколько особых FQDN, которые также можно использовать при подключении к кластеру.

{% note warning %}

Если при [автоматической смене мастера](../concepts/replication.md#master-failover) новым мастером или наименее отстающей репликой станет хост без публичного доступа, подключиться к ним из интернета будет невозможно. Чтобы этого избежать, [включите публичный доступ](../operations/hosts.md#update) для всех хостов кластера.

{% endnote %}

### Текущий мастер {#fqdn-master}

FQDN вида `c-<идентификатор кластера>.rw.{{ dns-zone }}` всегда указывает на текущий хост-мастер в кластере. Идентификатор кластера можно получить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

При подключении к этому FQDN разрешено выполнять операции чтения и записи.

Пример подключения к хосту-мастеру для кластера с идентификатором `c9qash3nb1v9ulc8j9nm`:

```bash
mysql --host=c-c9qash3nb1v9ulc8j9nm.rw.{{ dns-zone }} \
      --port=3306 \
      --ssl-ca=~/.mysql/root.crt \
      --ssl-mode=VERIFY_IDENTITY \
      --user=<имя пользователя> \
      --password \
      <имя БД>
```

### Наименее отстающая реплика {#fqdn-replica}

FQDN вида `c-<идентификатор кластера>.ro.{{ dns-zone }}` указывает на наименее отстающую от мастера [реплику](../concepts/replication.md). Идентификатор кластера можно запросить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

**Особенности:**

* При подключении к этому FQDN разрешено выполнять только операции чтения.
* Если в кластере нет активных реплик, то подключиться к этому FQDN невозможно: соответствующая CNAME-запись в [DNS](../../glossary/dns.md) будет указывать на пустой объект (`null`).

Пример подключения к наименее отстающей реплике для кластера с идентификатором `c9qash3nb1v9ulc8j9nm`:

```bash
mysql --host=c-c9qash3nb1v9ulc8j9nm.ro.{{ dns-zone }} \
      --port=3306 \
      --ssl-ca=~/.mysql/root.crt \
      --ssl-mode=VERIFY_IDENTITY \
      --user=<имя пользователя> \
      --password \
      <имя БД>
```

## Подключение из графических IDE {#connection-ide}

{% include [ide-environments](../../_includes/mdb/mdb-ide-envs.md) %}

Подключаться из графических IDE можно только к хостам кластера в публичном доступе с использованием SSL-сертификата.

{% include [note-connection-ide](../../_includes/mdb/note-connection-ide.md) %}

{% list tabs %}

- DataGrip

  1. Создайте источник данных:
     1. Выберите в меню **File** → **New** → **Data Source** → **{{ MY }}**.
     1. На вкладке **General**:
        1. Укажите параметры подключения:
           * **Host** — <имя хоста>.{{ dns-zone }} или один из [особых FQDN](#special-fqdns);
           * **Port** — `{{ port-mmy }}`;
           * **User**, **Password** — имя и пароль пользователя БД;
           * **Database** — имя БД для подключения.
        1. Нажмите ссылку **Download**, чтобы загрузить драйвер соединения.
     1. На вкладке **SSH/SSL**:
         1. Включите настройку **Use SSL**.
         1. В поле **CA file** укажите путь к файлу [SSL-сертификата для подключения](#get-ssl-cert).
  1. Чтобы проверить подключение, нажмите ссылку **Test Connection**. При успешном подключении будет выведен статус подключения, информация о СУБД и драйвере.
  1. Нажмите кнопку **OK**, чтобы сохранить источник данных.

- DBeaver

  1. Создайте новое соединение с БД:
     1. Выберите в меню **База данных** пункт **Новое соединение**.
     1. Выберите из списка БД **{{ MY }}**.
     1. Нажмите кнопку **Далее**.
     1. Укажите параметры подключения на вкладке **Главное**:
        * **Сервер** — <имя хоста>.{{ dns-zone }} или один из [особых FQDN](#special-fqdns);
        * **Порт** — `{{ port-mmy }}`;
        * **База данных** — имя БД для подключения;
        * **Пользователь**, **Пароль** — имя и пароль пользователя БД.
     1. На вкладке **SSL**:
         1. Включите настройку **Использовать SSL**.
         1. В поле **Корневой сертификат** укажите путь к сохраненному файлу [SSL-сертификата](#get-ssl-cert).
         1. В блоке **Дополнительные**:
            1. Включите настройку **Только SSL**.
            1. Выключите настройку **Проверять сертификат сервера**.
  1. Нажмите кнопку **Тест соединения ...** для проверки подключения. При успешном подключении будет выведен статус подключения, информация о СУБД и драйвере.
  1. Нажмите кнопку **Готово**, чтобы сохранить настройки соединения с БД.

{% endlist %}

## Подключение из Docker-контейнера {#connection-docker}

Подключаться из Docker-контейнера можно только к хостам кластера в публичном доступе с [использованием SSL-сертификата](#get-ssl-cert).

Для подключения к кластеру {{ mmy-name }} добавьте в Dockerfile строки:

```bash
RUN apt-get update && \
    apt-get install wget mysql-client --yes && \
    mkdir -p ~/.mysql && \
    wget "{{ crt-web-path }}" \
         --output-document ~/.mysql/root.crt && \
    chmod 0600 ~/.mysql/root.crt
```

## Примеры строк подключения {#connection-string}

{% include [conn-strings-environment](../../_includes/mdb/mdb-conn-strings-env.md) %}

Подключиться к {{ MY }}-хостам в публичном доступе можно только с использованием SSL-сертификата.

{% include [mmy-connection-strings](../../_includes/mdb/mmy/code-examples.md) %}
