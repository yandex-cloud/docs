The `functions.admin` role enables managing functions, triggers, API gateways, and connections to managed databases, as well as access to those.

Users with this role can:
* View info on the granted [access permissions](../../iam/concepts/access-control/index.md) to the Cloud Functions resources and modify such access permissions.
* View the list of [functions](../../functions/concepts/function.md) and info on them, create functions and their [versions](../../functions/concepts/function.md#version), and modify, invoke, and delete functions.
* View the function version [environment variables](../../functions/concepts/runtime/environment-variables.md) and code.
* View the list of [triggers](../../functions/concepts/trigger/index.md) and info on them, as well as create, stop, run, modify, and delete them.
* View the list of database connections and the info on them, as well as create, modify, and delete database connections and connect to databases through functions.
* Create, modify, and delete [API gateways](../../api-gateway/concepts/index.md).
* View info on Cloud Functions [quotas](../../functions/concepts/limits.md#functions-quotas).
* View info on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud).
* View info on the relevant [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

This role includes the `functions.editor` permissions.