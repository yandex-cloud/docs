#### vpc.user {#vpc-user}

Роль `{{ roles-vpc-user }}` предоставляет возможность подключаться к сетевым ресурсам {{ vpc-short-name }} и использовать их. Она включает в себя все разрешения роли `{{ roles-vpc-viewer }}`, а также разрешение на:
- использование [сетей и подсетей](../vpc/concepts/network.md);
- применение [статических маршрутов](../vpc/concepts/static-routes.md);
- присвоение виртуальным машинам статических [адресов](../vpc/concepts/address.md);
- назначение [групп безопасности](../vpc/concepts/security-groups.md) сетевым интерфейсам виртуальных машин.

{% include [roles-restriction-only-parents](iam/roles-restriction-only-parents.md) %}