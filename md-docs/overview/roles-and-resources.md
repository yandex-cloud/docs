# Взаимодействие пользователей и ресурсов Yandex Cloud

Все сервисы платформы Yandex Cloud построены на принципах общей _ресурсно-ролевой модели_ взаимодействия. В основе модели лежат _организации_, которые объединяют разные типы ресурсов и пользователей в единое рабочее пространство. Добавление пользователей и управление пользователями происходит на уровне организации, подробнее см. в статье [Членство в организации](../organization/concepts/membership.md).

![users-and-resources](../_assets/overview/users-resources.svg "Users and resources hierarchy")

## Ресурсы Yandex Cloud {#resources}

При работе с сервисами Yandex Cloud вы создаете _ресурсы_: [виртуальные машины](../compute/concepts/vm.md), кластеры управляемых баз данных и [Kubernetes](../managed-kubernetes/concepts/index.md), [реестры](../container-registry/concepts/registry.md), [секреты](../lockbox/concepts/secret.md) и многие другие. Большинство сервисов хранит создаваемые ресурсы в [каталогах](../resource-manager/concepts/resources-hierarchy.md#folder). Каталоги принадлежат [облакам](../resource-manager/concepts/resources-hierarchy.md#cloud), а облака — организациям.

Кроме этого, в организации могут быть активированы [Yandex DataSphere](https://datasphere.yandex.cloud), экземпляр [Yandex DataLens](https://datalens.ru/promo) и сервисы [Яндекс Трекер](https://tracker.yandex.ru/), [Яндекс Вики](https://wiki.yandex.ru/), [Яндекс Формы](https://forms.yandex.ru/cloud/admin), [Yandex SpeechSense](https://speechsense.yandex.cloud/). Все они самостоятельно хранят свои ресурсы, но могут обмениваться информацией с другими сервисами в рамках одной организации. Организации не взаимодействуют друг с другом.

В [интерфейсе Cloud Center](https://center.yandex.cloud) можно посмотреть, какие сервисы существуют в вашей организации. 

[Подробнее об иерархии ресурсов Yandex Cloud](../resource-manager/concepts/resources-hierarchy.md).

## Пользователи {#users}

Каждый пользователь платформы Yandex Cloud имеет свой _аккаунт_, который используется для идентификации при выполнении операций с ресурсами. Это может быть аккаунт [Яндекс ID](https://yandex.ru/id/about), федеративный аккаунт [федерации удостоверений](../organization/concepts/add-federation.md) или локальный аккаунт из [пула пользователей](../organization/concepts/user-pools.md). Также существуют сервисные аккаунты — особый тип аккаунтов, от имени которых ваши программы могут выполнять операции с ресурсами Yandex Cloud. [Подробнее об аккаунтах](../iam/concepts/users/accounts.md).

Любой пользователь состоит как минимум в одной организации. При первом входе в Yandex Cloud с Яндекс ID появится приглашение зарегистрировать свою организацию. После создания организации можно подключать и отключать сервисы Yandex Cloud, создавать облака, каталоги и другие ресурсы.

В организацию можно [приглашать](../organization/operations/add-account.md) других участников с аккаунтами на Яндексе, чтобы они имели доступ к сервисам и ресурсам организации. Если в компании уже используется другая система управления учетными данными, например, [Active Directory](https://docs.microsoft.com/ru-ru/windows-server/identity/ad-ds/active-directory-domain-services) или [Keycloak](https://www.keycloak.org/), можно [настроить федерацию удостоверений](../organization/concepts/add-federation.md). Тогда сотрудники смогут использовать свои рабочие аккаунты для доступа к сервисам Yandex Cloud. Кроме того, в организации можно [создать пул пользователей](../organization/operations/user-pools/create-userpool.md) и, добавив в него [домен](../organization/concepts/domains.md), создавать в организации [локальные пользовательские аккаунты](../iam/concepts/users/accounts.md#local).

Для массового управления доступом пользователей можно [объединять](../organization/operations/add-member-group.md) в [группы](../organization/operations/manage-groups.md).

Подробнее про управление пользователями и группами пользователей в [документации Yandex Identity Hub](../organization/operations/index.md#manage-users).

## Управление доступом {#access}

Контроль над доступом к ресурсам Yandex Cloud осуществляется с помощью [ролей](../iam/concepts/access-control/roles.md) и [политик авторизации](../iam/concepts/access-control/access-policies.md). Чтобы аккаунт (_субъект_) мог выполнить действие с ресурсом (_объектом_), аккаунту или группе, в которой этот аккаунт состоит, должны быть [назначены](../organization/operations/add-role.md) соответствующие роли на этот ресурс, а само это действие не должно быть запрещено политиками авторизации. По сути, каждая роль — это список разрешенных операций, которые можно выполнять с объектом. За управление правами доступа в Yandex Cloud отвечает сервис [Yandex Identity and Access Management](../iam/concepts/index.md).

Для аутентификации пользователей сервисы Yandex Cloud запрашивают [учетные данные](../iam/concepts/authorization/index.md). Тип запрашиваемых данных зависит от типа аккаунта, сервиса и интерфейса обращения. При работе с [API](api.md) также требуется [идентификатор каталога](../resource-manager/operations/folder/get-id.md), чтобы однозначно определить ресурс и проверить разрешения. Если действия выполняются от имени сервисного аккаунта, по умолчанию используется идентификатор каталога этого аккаунта.