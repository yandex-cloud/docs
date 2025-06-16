# Политики резервного копирования

Резервные копии ресурсов {{ yandex-cloud }} создаются в {{ backup-name }} автоматически в соответствии с _политиками резервного копирования_.

[Создание](../operations/policy-vm/create.md) политик доступно после [активации](index.md#providers) сервиса {{ backup-name }}.

{% note info %}

Создать или [изменить](../operations/policy-vm/update.md) политику можно с помощью консоли управления {{ yandex-cloud }}, {{ TF }}, а также задать по [спецификации](#specification) в формате [JSON](https://ru.wikipedia.org/wiki/JSON), используя [CLI](../../cli/quickstart.md) {{ yandex-cloud }} или API.

В консоли управления {{ yandex-cloud }} поддерживаются не все параметры из JSON-спецификации политик.

{% endnote %}

{% include [default-policies](../../_includes/backup/default-policies.md) %}

По умолчанию ВМ и серверы {{ baremetal-full-name }} в {{ backup-name }} не связаны ни с одной политикой резервного копирования. Чтобы начать создавать резервные копии, привяжите [виртуальную машину](../operations/policy-vm/attach-and-detach-vm.md) или [сервер {{ baremetal-name }}](../operations/backup-baremetal/backup-baremetal.md#agent-install) к одной или нескольким политикам.

В политике вы указываете:

* Периодичность создания копий: по часам, дням, неделям или месяцам. Время указывается в часовом поясе [UTC±00:00](https://{{ lang }}.wikipedia.org/wiki/UTC±00:00).
* Тип создаваемых копий: полные или инкрементальные. Подробнее см. в разделе [{#T}](backup.md#types).

  {% include [av-note](../../_includes/backup/av-note.md) %}

* Настройки [хранения резервных копий](#retention).

{% include [policy-execute-time](../../_includes/backup/policy-execute-time.md) %}

## Хранение копий {#retention}

Для политики можно настроить хранение копий. Для каждой ВМ или сервера {{ baremetal-name }}, входящих в политику, могут храниться:

* Все копии, созданные по этой политике.
* Только последние несколько копий.
* Только копии младше определенного возраста, например созданные за последние несколько дней.

Настройки действуют на все ВМ и серверы {{ baremetal-name }} в политике.

{% include [vm-and-bms-backup-incompatibility](../../_includes/backup/vm-and-bms-backup-incompatibility.md) %}

Если вы вносите изменения в правила хранения резервных копий, то по умолчанию они вступят в силу после создания очередной резервной копии. Подробное описание параметров настройки правил хранения резервных копий см. в следующем разделе.

## Спецификация политики резервного копирования {#specification}

Политику резервного копирования в {{ backup-name }} можно [создать](../operations/policy-vm/create.md) или [изменить](../operations/policy-vm/update.md) по спецификации в формате [JSON](https://ru.wikipedia.org/wiki/JSON) с помощью [командной строки](../../cli/quickstart.md) {{ yandex-cloud }} или API-запроса.

Полная спецификация политики резервного копирования в {{ backup-name }}:

{% include [full-config](../../_includes/backup/operations/full-config.md) %}


## Примеры использования {#examples}

* [{#T}](../tutorials/vm-with-backup-policy/index.md)


#### См. также {#see-also}

* [{#T}](../operations/policy-vm/create.md)
* [{#T}](../operations/policy-vm/attach-and-detach-vm.md)
* [{#T}](../operations/policy-vm/detach-vm.md)
* [{#T}](../operations/policy-vm/update.md)
* [{#T}](../operations/policy-vm/get-info.md)