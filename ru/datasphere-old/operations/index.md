---
title: Инструкции по работе с {{ ml-platform-full-name }}
description: "Страница содержит все инструкции для работы с {{ ml-platform-full-name }} в Yandex Cloud. Рассказываем о том, как создать проект, установить зависимости, запустить примеры кода в ноутбуке, работать с контрольными точками, управлять вычислительными ресурсами, публиковать ноутбук, работать с Git, загрузить данные из различных источников и развернуть обученную модель как микросервис."
---

# Пошаговые инструкции для {{ ml-platform-name }}

{% include [link-on-new-ui-datasphere-in-old-ui](../../_includes/datasphere/datasphere-old-note.md) %}

* [{#T}](projects/create.md)
* [{#T}](projects/install-dependencies.md)
* [{#T}](projects/snippets.md)
* [{#T}](projects/checkpoints.md)
* [{#T}](projects/control-compute-resources.md)
* [{#T}](projects/custom-limits.md)
* [{#T}](projects/set-ds-budget.md)
* [{#T}](projects/storage-resize.md)
* [{#T}](user-images.md)
* [{#T}](user-images-cell.md)
* [{#T}](projects/clear-kernel-state.md)
* [{#T}](projects/publication.md)
* [{#T}](projects/export.md)
* [{#T}](projects/update.md)
* [{#T}](projects/delete.md)
* [{#T}](projects/work-with-git.md)
{% if product == "yandex-cloud" %}
* [{#T}](data-proc-integration.md)
{% endif %}


## Работа с данными внутри проекта {#data-in-project}

* [{#T}](data/secret-create.md)
* [{#T}](data/secret-call.md)
* [{#T}](data/secret-copy.md)
* [{#T}](data/secret-change.md)
* [{#T}](data/secret-delete.md)
* [{#T}](taas-run.md)
  
## Получение данных из источников {#data-source}

* [{#T}](data/connect-to-clickhouse.md)
* [{#T}](data/connect-to-postgresql.md)

## Развертывание эксплуатации моделей {#deployment}
* [{#T}](node-cell.md)
* [{#T}](node-customization.md)
* [{#T}](node-api.md)