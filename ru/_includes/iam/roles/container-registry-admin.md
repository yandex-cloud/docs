#### container-registry.admin {#cr-admin}

Роль `{{ roles-cr-admin }}` назначается на облако или каталог.
Дает право управлять доступом к реестрам, Docker-образам и репозиториям.

Роль включает все разрешения, которые дают роли `{{ roles-cr-viewer }}` и `{{ roles-cr-editor }}`.