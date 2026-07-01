# Пошаговые инструкции для Cloud Registry

## Управление реестром {#registry}

### Создание реестра {#create-registry}

* [Создать локальный реестр](registry/local.md)
* [Создать удаленный реестр](registry/remote.md)
* [Создать виртуальный реестр](registry/virtual.md)

### Управление правами доступа к реестру {#access-registry}

* [Просмотреть роли, назначенные на реестр](registry/list-role.md)
* [Назначить роль](registry/add-role.md)
* [Отозвать роль](registry/remove-role.md)

### Политика доступа для IP-адресов {#ip}

* [Получить информацию о политике доступа](registry/list-access-policy.md)
* [Настроить политику доступа](registry/create-access-policy.md)
* [Удалить политику доступа](registry/remove-access-policy.md)


## Управление артефактами {#artifact}

### Docker {#docker}

* [Установить и настроить Docker](docker/installation.md)
* [Аутентифицироваться в Cloud Registry](docker/authentication.md)
* [Создать Docker-образ](docker/create.md)
* [Загрузить Docker-образ](docker/push.md)
* [Скачать Docker-образ](docker/pull.md)

### Helm {#helm}

* [Получить информацию об имеющихся Helm-чартах](helm/list.md)
* [Загрузить Helm-чарт](helm/push.md)
* [Скачать Helm-чарт](helm/pull.md)
* [Удалить Helm-чарт](helm/delete.md)

### Java {#java}

* [Настроить Maven](maven/installation.md)

### Node.js {#nodejs}

* [Настроить npm](npm/installation.md)

### NuGet {#nuget}

* [Настроить NuGet](nuget/installation.md)

### Python {#python}

* [Настроить PyPI](pypi/installation.md)
* [Создать Python-пакет](pypi/create.md)
* [Загрузить Python-пакет](pypi/push.md)
* [Скачать Python-пакет](pypi/pull.md)
* [Примеры работы с PyPI-реестрами](pypi/examples.md)

### Binary {#binary}

* [Загрузить binary-артефакт](binary/push.md)
* [Скачать binary-артефакт](binary/pull.md)

### Go {#go}

* [Создать Go-модуль](go/create.md)
* [Загрузить Go-модуль](go/push.md)
* [Скачать Go-модуль](go/pull.md)


## Другие инструкции {#other}

* [Удаление артефакта из реестра](artifacts/delete.md)
* [Создание политики жизненного цикла](lifecycle-policy/create.md)