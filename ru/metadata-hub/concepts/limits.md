---
title: Квоты и лимиты в {{ metadata-hub-full-name }}
description: В {{ metadata-hub-full-name }} действуют квоты на количество соединений, количество пространств имен в облаке и количество схем в облаке. Более подробно об ограничениях в сервисе вы узнаете из данной статьи.
---

# Квоты в {{ metadata-hub-full-name }}

{% include notitle [preview](../../_includes/note-preview.md) %}

Для сервиса {{ metadata-hub-full-name }} действуют следующие ограничения:

* [_Квоты_]({{ link-console-quotas }}) — организационные ограничения, которые можно изменить по запросу в техническую поддержку.

## Квоты {{ connection-manager-name }} {#connection-manager-quota}

{% include [connection-manager-quotas](../../_includes/metadata-hub/connection-manager-quotas.md) %}

## Квоты {{ metastore-name }} {#metastore-quota}

{% include [metastore-quotas](../../_includes/metadata-hub/metastore-quotas.md) %}

## Квоты {{ schema-registry-name }} {#schema-registry-quota}

{% include [schema-registry-quotas](../../_includes/metadata-hub/schema-registry-quotas.md) %}

## Квоты {{ data-catalog-name }} {#data-catalog-quota}

{% include [schema-registry-quotas](../../_includes/metadata-hub/data-catalog-quotas.md) %}

{% include [increase-quotas.md](../../_includes/increase-quotas.md) %}