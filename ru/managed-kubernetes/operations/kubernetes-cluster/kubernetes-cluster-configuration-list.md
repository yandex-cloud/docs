---
title: Получение списка доступных конфигураций мастера в кластере {{ k8s }}
description: Следуя данной инструкции, вы получите список доступных конфигураций мастера в кластере {{ k8s }}.
---

# Получение списка доступных конфигураций мастера в кластере {{ k8s }}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
    1. Выберите кластер и в правом верхнем углу страницы нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**. Откроется страница редактирования кластера.  
    1. В блоке **{{ ui-key.yacloud.k8s.clusters.create.section_main-cluster }}** раскройте секцию **{{ ui-key.yacloud.k8s.clusters.create.label_master-computing-resources }}**.

       Доступные конфигурации перечислены на вкладках:

          * **{{ ui-key.yacloud.k8s.clusters.create.label_master-preset-group-standard }}**,
          * **{{ ui-key.yacloud.k8s.clusters.create.label_master-preset-group-cpu-optimized }}**,
          * **{{ ui-key.yacloud.k8s.clusters.create.label_master-preset-group-memory-optimized }}**.

- CLI {#cli}

  Выполните команду:

  ```bash
  yc managed-kubernetes resource-preset list
  ```

  Результат:

  ```text
  +------------+-------+----------+---------------+
  |     ID     | CORES |  MEMORY  | CORE FRACTION |
  +------------+-------+----------+---------------+
  | s-c2-m8    |     2 | 8.0 GB   |           100 |
  | m-c2-m16   |     2 | 16.0 GB  |           100 |
  | c-c4-m8    |     4 | 8.0 GB   |           100 |
  | s-c4-m16   |     4 | 16.0 GB  |           100 |
  | m-c4-m32   |     4 | 32.0 GB  |           100 |
  | c-c8-m16   |     8 | 16.0 GB  |           100 |
  | s-c8-m32   |     8 | 32.0 GB  |           100 |
  | m-c8-m64   |     8 | 64.0 GB  |           100 |
  | c-c16-m32  |    16 | 32.0 GB  |           100 |
  | s-c16-m64  |    16 | 64.0 GB  |           100 |
  | m-c16-m128 |    16 | 128.0 GB |           100 |
  | c-c32-m64  |    32 | 64.0 GB  |           100 |
  | s-c32-m128 |    32 | 128.0 GB |           100 |
  | m-c32-m256 |    32 | 256.0 GB |           100 |
  | s-c64-m256 |    64 | 256.0 GB |           100 |
  | s-c80-m320 |    80 | 320.0 GB |           100 |
  +------------+-------+----------+---------------+  
    ```

- API {#api}

  Чтобы получить список доступных конфигураций мастера в кластере, воспользуйтесь методом [list](../../managed-kubernetes/api-ref/grpc/ResourcePreset/list.md) для ресурса [ResourcePreset](../../managed-kubernetes/api-ref/grpc/ResourcePreset/).

{% endlist %}

[Подробнее о вычислительных ресурсах мастера](../../concepts/index.md#master-resources)
