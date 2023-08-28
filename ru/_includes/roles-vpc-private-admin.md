#### vpc.privateAdmin {#vpc-private-admin}

Роль `{{ roles-vpc-private-admin }}` позволяет управлять связностью между виртуальными машинами и кластерами управляемых баз данных внутри {{ yandex-cloud }}:
- создавать, удалять, изменять [сети и подсети](../vpc/concepts/network.md);
- настраивать [статические маршруты](../vpc/concepts/static-routes.md) и внутренние адреса.

Данная роль не позволяет сделать виртуальную машину или кластер доступной вне сети, которой они принадлежат. Для управления внешним доступом используйте роль `{{ roles-vpc-public-admin }}`.

{% include [roles-restriction-only-parents](iam/roles-restriction-only-parents.md) %}
