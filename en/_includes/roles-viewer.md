The `{{ roles-viewer }}` role grants permission to read resources.

The `{{ roles-viewer }}` role includes all permissions granted by the `{{ roles-auditor }}` role. Unlike `{{ roles-auditor }}`, the `{{ roles-viewer }}` role allows access to service data in read mode.

For example, the `{{ roles-viewer }}` role allows you to perform the following operations:
* View information about a resource.
* Get a list of nested resources, such as a list of VMs in a folder.
* View a list of operations with a resource.