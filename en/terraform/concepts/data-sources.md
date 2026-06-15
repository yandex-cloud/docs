# Data sources in {{ TF }}

In {{ TF }}, data sources represent a mechanism for retrieving information about resources, infrastructure, and other objects from various sources. They enable access to data you can then use to create, modify, or delete resources in your infrastructure.

Data sources yield information about existing resources, such as virtual machines, networks, databases, and other infrastructure components. {{ TF }} requests data from sources during the `plan` stage and fetches them into resource attributes when building the dependency graph. If the result of a data source depends on an attribute of a resource that has not yet been created, reading is delayed until the `apply` stage.

Each data source has its own syntax and usage patterns. For example, for local files, you provide the file paths; for HTTP, you provide the URL and query parameters.

With data sources, you can automate your infrastructure management workflow to make sure that your real needs are met. This is of special value in large, complex environments where manual configuration is impractical or impossible.

## Difference from resources {#difference-from-resources}

A `data` section only reads an existing object: it does not create, modify, or delete it. A `resource` section fully manages the lifecycle of an object: it creates it during `apply` and deletes it during `destroy`.

#|
|| **Action** {align="center"} | **{{ TF }} section** {align="center"} | > ||
|| ^ | `resource` {align="center"} | `data` {align="center"} ||
|| Create object | ![yes](../../_assets/common/yes.svg) {align="center"} | ![no](../../_assets/common/no.svg) {align="center"} ||
|| Deleting an object | ![yes](../../_assets/common/yes.svg) {align="center"} | ![no](../../_assets/common/no.svg) {align="center"} ||
|| Reading attributes | ![yes](../../_assets/common/yes.svg) {align="center"} | ![yes](../../_assets/common/yes.svg) {align="center"} ||
|#