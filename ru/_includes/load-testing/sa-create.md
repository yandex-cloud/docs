1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт `sa-loadtest` в каталоге, где будет размещаться агент, с которого будет подаваться нагрузка.
1. [Назначьте](../../iam/operations/roles/grant.md) роли сервисному аккаунту:
    * [`loadtesting.generatorClient`](../../load-testing/security/index.md#roles-list) — позволяет запускать агент, тест на агенте и загружать результаты в хранилище.
    * [`compute.admin`](../../compute/security/index.md#service-roles) — позволяет управлять виртуальной машиной в {{ compute-name }}.
    * [`vpc.user`](../../vpc/security/index.md#choosing-roles) — позволяет подключаться к сетевым ресурсам {{ vpc-name }} и использовать их.