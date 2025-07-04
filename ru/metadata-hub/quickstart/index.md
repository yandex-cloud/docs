---
title: Как начать работу с {{ metadata-hub-full-name }}
description: Из статьи вы узнаете, как создать первое подключение и как начать работать с реестром данных.
---

# Начало работы с сервисами {{ metadata-hub-full-name }}

{% include notitle [preview](../../_includes/note-preview.md) %}


{{ metadata-hub-full-name }} позволяет управлять данными в {{ yandex-cloud }}. Вы можете:

* создавать подключения к базам данных и управлять параметрами этих подключений;
* получать и хранить схемы обмена данными, проверять эволюцию этих схем;
* получать, категоризировать и визуализировать метаинформацию о хранилищах данных и связях между ними.

Начните работу с инструментами {{ metadata-hub-name }}:

* [{{ connection-manager-full-name }}](connection-manager.md). С его помощью вы можете управлять подключениями к своим базам данных. Подробнее о возможностях {{ connection-manager-name }} см. в [Концепциях](../concepts/connection-manager.md).

* [{{ metastore-full-name }}](metastore.md). С его помощью вы можете управлять данными в приложениях, которые поддерживают интеграцию с {{ metastore-name }}. Подробнее о кластерах {{ metastore-name }} см. в [Концепциях](../concepts/metastore.md).

* [{{ schema-registry-name }}](schema-registry.md). С его помощью вы сможете создать субъекты и схемы для управления, задавать параметры эволюции схем, добавлять референсы, сравнивать версии схем. Подробнее о реестре схем см. в [Концепциях](../concepts/schema-registry.md).


* Data Catalog. С его помощью вы можете собирать, искать и визуализировать метаданные об объектах {{ yandex-cloud }} и связях между ними. Подробнее о реестре схем см. в [Концепциях](../concepts/data-catalog.md).

  Вы можете работать с сервисом Data Catalog в следующих ролях:

  * [управляющий метаданными](data-steward-quickstart.md)
  * [аналитик метаданных](data-analyst-quickstart.md).

