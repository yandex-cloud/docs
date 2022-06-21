---
title: Квоты и лимиты в Yandex Managed Service for YDB
description: 'В Yandex Managed Service for YDB действуют лимиты и квоты на суммарное количество ядер процессора для всех хостов баз данных, суммарный объем виртуальной памяти для всех хостов баз данных, максимальное количество хостов, максимальное количество баз данных в одном облаке. Более подробно об ограничениях в сервисе вы узнаете из данной статьи.'

editable: false
sourcePath: overlay/concepts/limits.md
---

# Квоты и лимиты в {{ ydb-name }}

В сервисе Yandex {{ ydb-name }} действуют следующие ограничения:

* [_Квоты_]({{ link-console-quotas }}) — организационные ограничения, которые можно изменить по запросу в техническую поддержку.
* _Лимиты_ — технические ограничения, обусловленные особенностями архитектуры {{ ydb-short-name }}. Изменение лимитов невозможно.

{% include [ydb-limits.md](../../_includes/ydb/ydb-limits.md) %}

#### Лимиты {#ydb-limits}

О лимитах базы данных {{ ydb-short-name }} читайте в [документации]{% if lang == "ru" %}(https://ydb.tech/ru/docs/concepts/limits-ydb){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/concepts/limits-ydb){% endif %}.
