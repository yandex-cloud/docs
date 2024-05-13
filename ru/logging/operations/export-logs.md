---
title: "Инструкция о том, как выгружать логи из {{ cloud-logging-name }} в {{ objstorage-name }}"
description: "Из статьи вы узнаете, как выгружать логи из {{ cloud-logging-name }} в {{ objstorage-name }}."
---

# Выгрузить логи в {{ objstorage-name }}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находятся лог-группа и приемник логов.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
    1. Выберите лог-группу, из которой хотите выгрузить логи.
    1. Перейдите на вкладку **{{ ui-key.yacloud.common.logs }}**.
    1. Справа от кнопки **{{ ui-key.yacloud.logging.button_execute }}** нажмите значок ![image](../../_assets/console-icons/chevron-down.svg) → **{{ ui-key.yacloud.logging.label_export }}**.
    1. В открывшемся окне:
        1. Укажите период выгрузки.
        1. Выберите приемник логов.
        1. Укажите имя файла выгрузки.
        1. Нажмите кнопку **{{ ui-key.yacloud.logging.label_export }}**.

    Файл сохранится в бакет, который указан в настройках выбранного приемника логов.

- API {#api}

    Чтобы выгрузить логи, воспользуйтесь методом REST API [run](../api-ref/Export/run.md) для ресурса [Export](../api-ref/Export/index.md) или вызовом gRPC API [ExportService/Run](../api-ref/grpc/export_service.md#Run).

{% endlist %}