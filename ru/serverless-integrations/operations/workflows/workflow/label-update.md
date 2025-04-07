---
title: Изменить метку рабочего процесса
description: Следуя данной инструкции, вы сможете изменить метку рабочего процесса.
---

# Изменить метку рабочего процесса

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  Чтобы изменить метку [рабочего процесса](../../../concepts/workflows/workflow.md), выполните команду:

  {% include [labels-rewrite-warning](../../../../_includes/labels-rewrite-warning.md) %}

  ```bash
  yc serverless workflow update <имя_или_идентификатор_рабочего_процесса> \
    --yaml-spec <файл_спецификации> \
    --labels <список_меток>
  ```

  Где:

  * `--yaml-spec` — путь к файлу с [YaWL-спецификацией](../../../concepts/workflows/yawl/index.md) рабочего процесса. Например: `./yawl-spec.json`.
  * `--labels` — список меток. Вы можете указать одну или несколько меток через запятую в формате `<ключ1>=<значение1>,<ключ2>=<значение2>`.

  Результат:

  ```text
  id: dfqjl5hh5p90********
  folder_id: b1g681qpemb4********
  specification:
    spec_yaml: "yawl: ..."
  created_at: "2025-03-11T09:27:51.691990Z"
  name: my-workflow
  description: created via cli
  labels:
    owner: "admin"
    version: "alpha"
  status: ACTIVE
  log_options: {}
  service_account_id: aje4tpd9coa********
  network_id: enpm8v48ehcl********
  ```

- API {#api}

  Чтобы изменить метку [рабочего процесса](../../../concepts/workflows/workflow.md), воспользуйтесь методом REST API [Update](../../../../serverless-integrations/workflows/api-ref/Workflow/update.md) для ресурса [Workflows](../../../../serverless-integrations/workflows/api-ref/Workflow/index.md) или вызовом gRPC API [workflow/Update](../../../../serverless-integrations/workflows/api-ref/grpc/Workflow/update.md).

{% endlist %}