---
title: '{{ metadata-hub-full-name }} release notes'
description: This section contains {{ metadata-hub-name }} release notes.
---

# {{ metadata-hub-full-name }} release notes: 2024

## August {#august}

### New features {#new-features-august}

1. Added support for custom {{ RD }} DB installation and [{{ mrd-name }}](../../managed-redis/concepts/index.md) cluster connections.

## July {#july}

### New features {#new-features-july}

1. Added [{{ connection-manager-name }}](../concepts/connection-manager.md) integration with [{{ mch-short-name }}](../../managed-clickhouse). Connections for {{ mch-short-name }} clusters [will be created automatically](../quickstart/connection-manager.md).

## June {#june}

### New features {#new-features-june}

1. Added filtering by name in the [list of connections](../operations/view-connection.md).
1. Added viewing the [operations](../operations/view-connection.md#operations) of any selected connection.

### Fixed issues {#problems-solved-june}

1. Fixed a bug with viewing connections to user database installations.
1. You can now edit connection parameters.

## May {#may}

### New features {#new-features-may}

1. Added [{{ connection-manager-name }}](../concepts/connection-manager.md) integration with [{{ mmy-short-name }}](../../managed-mysql). Connections for {{ mmy-short-name }} clusters [will be created automatically](../quickstart/connection-manager.md).
1. Now you can specify databases in connections to [{{ CH }}](../operations/create-connection.md#mdb-clickhouse).


{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}