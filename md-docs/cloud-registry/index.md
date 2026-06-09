# Yandex Cloud Registry

Yandex Cloud Registry — сервис для безопасного хранения <a href="concepts/artifacts/index.md">артефактов</a> программного обеспечения, которые используются при разработке и развертывании приложений. Храните артефакты, управляйте ими и защищайте их. Артефактами могут быть пакеты программного обеспечения и другие файлы, которые используются в процессе разработки и развертывания приложений.

<ul><li>Создайте безопасное хранилище для артефактов всего за несколько минут. Управляйте доступом и операциями с помощью ролей и разрешений, предоставляемых через сервис <a href="../iam/security/index.md">Identity and Access Management<a/>.</li> <li>Все ваши артефакты будут надежно защищены от несанкционированного доступа и угроз, поскольку хранятся в зашифрованном виде.</li> <li>Cloud Registry масштабируется под задачи без необходимости подключения нового оборудования и потери производительности.</li> <li>С помощью Cloud Registry вы можете создавать реестр для хранения артефактов и управлять им через API и консоль управления Yandex Cloud.</li> <li>Мы полностью берем на себя обслуживание инфраструктуры вашего реестра и гарантируем ее безопасность в соответствии с отраслевыми стандартами. Вы платите только за фактически используемое пространство для хранения артефактов.</li></ul>

Инфраструктура Yandex Cloud <a href="https://storage.yandexcloud.net/yc-compliance/conformance_ru_pdp.pdf">защищена</a> в соответствии с Федеральным законом Российской Федерации «О персональных данных» № 152-ФЗ и отвечает требованиям международных и национальных стандартов ISO, GDPR, PCI DSS и ГОСТ Р 57580.

# Yandex Cloud Registry

 - [Начало работы](quickstart/docker.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

### Управление реестром

 - [Создание реестра](operations/registry/create.md)

#### Управление правами доступа к реестру

 - [Посмотреть роли, назначенные на реестр](operations/registry/list-role.md)

 - [Назначить роль](operations/registry/add-role.md)

 - [Отозвать роль](operations/registry/remove-role.md)

#### Политика доступа для IP-адресов

 - [Получить информацию о политике доступа](operations/registry/list-access-policy.md)

 - [Настроить политику доступа](operations/registry/create-access-policy.md)

 - [Удалить политику доступа](operations/registry/remove-access-policy.md)

### Управление артефактами

#### Docker-образ

 - [Установить и настроить Docker](operations/docker/installation.md)

 - [Аутентифицироваться в {{ cloud-registry-name }}](operations/docker/authentication.md)

 - [Создать Docker-образ](operations/docker/create.md)

 - [Загрузить Docker-образ в реестр](operations/docker/push.md)

 - [Скачать Docker-образ из реестра](operations/docker/pull.md)

#### Helm-чарт

 - [Получить информацию об имеющихся Helm-чартах](operations/helm/list.md)

 - [Загрузить Helm-чарт в реестр](operations/helm/push.md)

 - [Скачать Helm-чарт из реестра](operations/helm/pull.md)

 - [Удалить Helm-чарт из реестра](operations/helm/delete.md)

#### Java-артефакт

 - [Настроить Maven](operations/maven/installation.md)

#### Node.js-артефакт

 - [Настроить npm](operations/npm/installation.md)

#### NuGet-артефакт

 - [Настроить NuGet](operations/nuget/installation.md)

#### Python-артефакт

 - [Настроить PyPI](operations/pypi/installation.md)

 - [Создать Python-пакет](operations/pypi/create.md)

 - [Загрузить Python-пакет в реестр](operations/pypi/push.md)

 - [Скачать Python-пакет из реестра](operations/pypi/pull.md)

 - [Удалить Python-пакет из реестра](operations/pypi/delete.md)

 - [Примеры работы с PyPI-реестрами](operations/pypi/examples.md)

#### Binary-артефакт

 - [Загрузить binary-артефакт в реестр](operations/binary/push.md)

 - [Скачать binary-артефакт из реестра](operations/binary/pull.md)

 - [Создание политики жизненного цикла](operations/lifecycle-policy/create.md)

## Практические руководства

 - [Запуск Docker-образа на виртуальной машине с помощью {{ cloud-registry-name }}](tutorials/docker-cloud-registry.md)

 - [Настройка политик жизненного цикла](tutorials/lifecycle-policy-examples.md)

## Концепции

 - [Обзор](concepts/index.md)

 - [Реестр](concepts/registry.md)

### Артефакты

 - [Обзор](concepts/artifacts/index.md)

 - [Docker-образ](concepts/artifacts/docker.md)

 - [Java-артефакт](concepts/artifacts/java.md)

 - [Node.js-артефакт](concepts/artifacts/nodejs.md)

 - [NuGet-артефакт](concepts/artifacts/nuget.md)

 - [Python-артефакт](concepts/artifacts/python.md)

 - [Binary-артефакт](concepts/artifacts/binary.md)

 - [Политика жизненного цикла](concepts/lifecycle-policy.md)

 - [Квоты и лимиты](concepts/limits.md)

 - [Управление доступом](security/index.md)

 - [Правила тарификации](pricing.md)

## Справочник CLI (англ.)

 - [Overview](cli-ref/index.md)

### artifact

 - [Overview](cli-ref/artifact/index.md)

 - [add-access-binding](cli-ref/artifact/add-access-binding.md)

 - [delete](cli-ref/artifact/delete.md)

 - [get](cli-ref/artifact/get.md)

 - [get-by-path](cli-ref/artifact/get-by-path.md)

 - [list-access-bindings](cli-ref/artifact/list-access-bindings.md)

 - [remove-access-binding](cli-ref/artifact/remove-access-binding.md)

 - [set-access-bindings](cli-ref/artifact/set-access-bindings.md)

 - [configure-docker](cli-ref/configure-docker.md)

### registry

 - [Overview](cli-ref/registry/index.md)

 - [add-access-binding](cli-ref/registry/add-access-binding.md)

 - [add-ip-permissions](cli-ref/registry/add-ip-permissions.md)

 - [create](cli-ref/registry/create.md)

 - [delete](cli-ref/registry/delete.md)

 - [force-delete](cli-ref/registry/force-delete.md)

 - [get](cli-ref/registry/get.md)

#### lifecycle-policy

 - [Overview](cli-ref/registry/lifecycle-policy/index.md)

 - [change-state](cli-ref/registry/lifecycle-policy/change-state.md)

 - [create](cli-ref/registry/lifecycle-policy/create.md)

 - [delete](cli-ref/registry/lifecycle-policy/delete.md)

 - [dry-run](cli-ref/registry/lifecycle-policy/dry-run.md)

 - [get](cli-ref/registry/lifecycle-policy/get.md)

 - [list](cli-ref/registry/lifecycle-policy/list.md)

 - [update](cli-ref/registry/lifecycle-policy/update.md)

 - [list](cli-ref/registry/list.md)

 - [list-access-bindings](cli-ref/registry/list-access-bindings.md)

 - [list-artifacts](cli-ref/registry/list-artifacts.md)

 - [list-ip-permissions](cli-ref/registry/list-ip-permissions.md)

 - [remove-access-binding](cli-ref/registry/remove-access-binding.md)

 - [remove-ip-permissions](cli-ref/registry/remove-ip-permissions.md)

 - [set-access-bindings](cli-ref/registry/set-access-bindings.md)

 - [set-ip-permissions](cli-ref/registry/set-ip-permissions.md)

 - [update](cli-ref/registry/update.md)

### v0

 - [Overview](cli-ref/v0/index.md)

#### artifact

 - [Overview](cli-ref/v0/artifact/index.md)

 - [add-access-binding](cli-ref/v0/artifact/add-access-binding.md)

 - [delete](cli-ref/v0/artifact/delete.md)

 - [get](cli-ref/v0/artifact/get.md)

 - [get-by-path](cli-ref/v0/artifact/get-by-path.md)

 - [list-access-bindings](cli-ref/v0/artifact/list-access-bindings.md)

 - [remove-access-binding](cli-ref/v0/artifact/remove-access-binding.md)

 - [set-access-bindings](cli-ref/v0/artifact/set-access-bindings.md)

 - [configure-docker](cli-ref/v0/configure-docker.md)

#### registry

 - [Overview](cli-ref/v0/registry/index.md)

 - [add-access-binding](cli-ref/v0/registry/add-access-binding.md)

 - [add-ip-permissions](cli-ref/v0/registry/add-ip-permissions.md)

 - [create](cli-ref/v0/registry/create.md)

 - [delete](cli-ref/v0/registry/delete.md)

 - [force-delete](cli-ref/v0/registry/force-delete.md)

 - [get](cli-ref/v0/registry/get.md)

##### lifecycle-policy

 - [Overview](cli-ref/v0/registry/lifecycle-policy/index.md)

 - [change-state](cli-ref/v0/registry/lifecycle-policy/change-state.md)

 - [create](cli-ref/v0/registry/lifecycle-policy/create.md)

 - [delete](cli-ref/v0/registry/lifecycle-policy/delete.md)

 - [dry-run](cli-ref/v0/registry/lifecycle-policy/dry-run.md)

 - [get](cli-ref/v0/registry/lifecycle-policy/get.md)

 - [list](cli-ref/v0/registry/lifecycle-policy/list.md)

 - [update](cli-ref/v0/registry/lifecycle-policy/update.md)

 - [list](cli-ref/v0/registry/list.md)

 - [list-access-bindings](cli-ref/v0/registry/list-access-bindings.md)

 - [list-artifacts](cli-ref/v0/registry/list-artifacts.md)

 - [list-ip-permissions](cli-ref/v0/registry/list-ip-permissions.md)

 - [remove-access-binding](cli-ref/v0/registry/remove-access-binding.md)

 - [remove-ip-permissions](cli-ref/v0/registry/remove-ip-permissions.md)

 - [set-access-bindings](cli-ref/v0/registry/set-access-bindings.md)

 - [set-ip-permissions](cli-ref/v0/registry/set-ip-permissions.md)

 - [update](cli-ref/v0/registry/update.md)

 - [Справочник {{ TF }}](tf-ref.md)

## Справочник API

 - [Аутентификация в API](api-ref/authentication.md)

### gRPC (англ.)

 - [Overview](api-ref/grpc/index.md)

#### Artifact

 - [Overview](api-ref/grpc/Artifact/index.md)

 - [Get](api-ref/grpc/Artifact/get.md)

 - [GetByPath](api-ref/grpc/Artifact/getByPath.md)

 - [Delete](api-ref/grpc/Artifact/delete.md)

 - [ListAccessBindings](api-ref/grpc/Artifact/listAccessBindings.md)

 - [SetAccessBindings](api-ref/grpc/Artifact/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/grpc/Artifact/updateAccessBindings.md)

 - [UpsertFolder](api-ref/grpc/Artifact/upsertFolder.md)

#### LifecyclePolicy

 - [Overview](api-ref/grpc/LifecyclePolicy/index.md)

 - [Create](api-ref/grpc/LifecyclePolicy/create.md)

 - [Update](api-ref/grpc/LifecyclePolicy/update.md)

 - [Delete](api-ref/grpc/LifecyclePolicy/delete.md)

 - [Get](api-ref/grpc/LifecyclePolicy/get.md)

 - [List](api-ref/grpc/LifecyclePolicy/list.md)

 - [ChangeState](api-ref/grpc/LifecyclePolicy/changeState.md)

 - [DryRun](api-ref/grpc/LifecyclePolicy/dryRun.md)

#### Operation

 - [Overview](api-ref/grpc/Operation/index.md)

 - [Get](api-ref/grpc/Operation/get.md)

 - [Cancel](api-ref/grpc/Operation/cancel.md)

#### Registry

 - [Overview](api-ref/grpc/Registry/index.md)

 - [Get](api-ref/grpc/Registry/get.md)

 - [List](api-ref/grpc/Registry/list.md)

 - [Create](api-ref/grpc/Registry/create.md)

 - [Update](api-ref/grpc/Registry/update.md)

 - [Delete](api-ref/grpc/Registry/delete.md)

 - [ForceDelete](api-ref/grpc/Registry/forceDelete.md)

 - [ListAccessBindings](api-ref/grpc/Registry/listAccessBindings.md)

 - [SetAccessBindings](api-ref/grpc/Registry/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/grpc/Registry/updateAccessBindings.md)

 - [ListIpPermissions](api-ref/grpc/Registry/listIpPermissions.md)

 - [SetIpPermissions](api-ref/grpc/Registry/setIpPermissions.md)

 - [UpdateIpPermissions](api-ref/grpc/Registry/updateIpPermissions.md)

 - [ListArtifacts](api-ref/grpc/Registry/listArtifacts.md)

#### Scanner

 - [Overview](api-ref/grpc/Scanner/index.md)

 - [Scan](api-ref/grpc/Scanner/scan.md)

 - [Get](api-ref/grpc/Scanner/get.md)

 - [GetLast](api-ref/grpc/Scanner/getLast.md)

 - [List](api-ref/grpc/Scanner/list.md)

 - [ListVulnerabilities](api-ref/grpc/Scanner/listVulnerabilities.md)

#### ScanPolicy

 - [Overview](api-ref/grpc/ScanPolicy/index.md)

 - [Get](api-ref/grpc/ScanPolicy/get.md)

 - [GetByRegistry](api-ref/grpc/ScanPolicy/getByRegistry.md)

 - [Create](api-ref/grpc/ScanPolicy/create.md)

 - [Update](api-ref/grpc/ScanPolicy/update.md)

 - [Delete](api-ref/grpc/ScanPolicy/delete.md)

### REST (англ.)

 - [Overview](api-ref/index.md)

#### Artifact

 - [Overview](api-ref/Artifact/index.md)

 - [Get](api-ref/Artifact/get.md)

 - [GetByPath](api-ref/Artifact/getByPath.md)

 - [Delete](api-ref/Artifact/delete.md)

 - [ListAccessBindings](api-ref/Artifact/listAccessBindings.md)

 - [SetAccessBindings](api-ref/Artifact/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/Artifact/updateAccessBindings.md)

 - [UpsertFolder](api-ref/Artifact/upsertFolder.md)

#### LifecyclePolicy

 - [Overview](api-ref/LifecyclePolicy/index.md)

 - [Create](api-ref/LifecyclePolicy/create.md)

 - [Update](api-ref/LifecyclePolicy/update.md)

 - [Delete](api-ref/LifecyclePolicy/delete.md)

 - [Get](api-ref/LifecyclePolicy/get.md)

 - [List](api-ref/LifecyclePolicy/list.md)

 - [ChangeState](api-ref/LifecyclePolicy/changeState.md)

 - [DryRun](api-ref/LifecyclePolicy/dryRun.md)

#### Operation

 - [Overview](api-ref/Operation/index.md)

 - [Get](api-ref/Operation/get.md)

 - [Cancel](api-ref/Operation/cancel.md)

#### Registry

 - [Overview](api-ref/Registry/index.md)

 - [Get](api-ref/Registry/get.md)

 - [List](api-ref/Registry/list.md)

 - [Create](api-ref/Registry/create.md)

 - [Update](api-ref/Registry/update.md)

 - [Delete](api-ref/Registry/delete.md)

 - [ForceDelete](api-ref/Registry/forceDelete.md)

 - [ListAccessBindings](api-ref/Registry/listAccessBindings.md)

 - [SetAccessBindings](api-ref/Registry/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/Registry/updateAccessBindings.md)

 - [ListIpPermissions](api-ref/Registry/listIpPermissions.md)

 - [SetIpPermissions](api-ref/Registry/setIpPermissions.md)

 - [UpdateIpPermissions](api-ref/Registry/updateIpPermissions.md)

 - [ListArtifacts](api-ref/Registry/listArtifacts.md)

#### ScanPolicy

 - [Overview](api-ref/ScanPolicy/index.md)

 - [Get](api-ref/ScanPolicy/get.md)

 - [GetByRegistry](api-ref/ScanPolicy/getByRegistry.md)

 - [Create](api-ref/ScanPolicy/create.md)

 - [Update](api-ref/ScanPolicy/update.md)

 - [Delete](api-ref/ScanPolicy/delete.md)

 - [Аудитные логи {{ at-name }}](at-ref.md)