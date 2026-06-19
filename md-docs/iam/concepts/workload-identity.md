# Федерации сервисных аккаунтов

Федерация сервисных аккаунтов (Workload Identity Federation) — это инструмент Yandex Identity and Access Management, позволяющий настроить процесс обмена токенов любой системы, совместимой с протоколом [OpenID Connect](https://openid.net/developers/how-connect-works/), на [IAM-токены](authorization/iam-token.md), которые можно использовать для обращения к [API Yandex Cloud](../../api-design-guide/index.md).

Популярные варианты использования этого инструмента:

* Запрос пода Kubernetes к API Yandex Cloud для получения содержимого [секрета](../../lockbox/concepts/secret.md) Yandex Lockbox.
* Запрос к API Yandex Cloud из [CI/CD](https://yandex.cloud/ru/blog/posts/2022/10/ci-cd) системы, такой как GitLab или [SourceCraft](https://sourcecraft.dev/portal/docs/ru/), для развертывания облачных сервисов с помощью [Terraform](../../tutorials/infrastructure-management/terraform-quickstart.md).

Такое взаимодействие не предусматривает создания долгоживущих ключей, что повышает удобство и безопасность пользователей.

Подробнее о протоколе OpenID Connect в [спецификации OIDC](https://openid.net/specs/openid-connect-core-1_0.html).

[Настроить](../operations/wlif/setup-wlif.md) федерацию сервисных аккаунтов можно в [консоли управления](https://console.yandex.cloud) или с помощью [Yandex Cloud CLI](../../cli/quickstart.md).

Чтобы создать федерацию сервисных аккаунтов, необходима [роль](../security/index.md#iam-workloadIdentityFederations-editor) `iam.workloadIdentityFederations.editor` или выше.

## Схема работы федерации {#work-scheme}

Федерация сервисных аккаунтов создается в [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder) и требует настройки обязательных параметров совместимого с OpenID Connect провайдера (OIDC-провайдера):

* `audience` — ресурс, для которого будет предназначен выданный IAM-токен. Передается в формате `StringOrURI`.

    Для одной федерации может быть задано как одно, так и целый массив значений `audience`.
* `issuer` — URL сервера OIDC-провайдера.
* `jwks-url` — URL, по которому можно получить актуальный открытый ключ, выпущенный OIDC-провайдером и используемый для проверки подписи [JWT](https://ru.wikipedia.org/wiki/JSON_Web_Token).

В одном каталоге можно создать несколько федераций сервисных аккаунтов.

Федерация сервисных аккаунтов состоит из набора [_привязок_](#federated-credentials), каждая из которых содержит информацию о связи определенного [сервисного аккаунта](users/service-accounts.md) с определенным _внешним субъектом_.

Внешний субъект — это авторизованный у стороннего OIDС-провайдера субъект внешнего по отношению к Yandex Cloud сервиса, которому требуется получить IAM-токен Yandex Cloud. Например, это может быть [сервисный аккаунт Kubernetes](../../managed-kubernetes/concepts/index.md#service-accounts), задание [GitLab](../../managed-gitlab/index.md) или [кубик](https://sourcecraft.dev/portal/docs/ru/sourcecraft/concepts/ci-cd#cubes) в SourceCraft.

Этапы получения IAM-токена с помощью сервисного аккаунта, привязанного к федерации:

1. При необходимости получить IAM-токен Yandex Cloud внешний субъект обращается к OIDС-провайдеру, который на своей стороне выпускает для него JWT-токен.
1. Внешний субъект передает полученный JWT-токен в федерацию сервисных аккаунтов Identity and Access Management.
1. Сервис Identity and Access Management проверяет полномочия внешнего субъекта (по наличию подходящей [привязки](#federated-credentials)) и действительность переданного JWT-токена (с помощью публичного ключа).
1. Если полномочия подтверждены, а JWT-токен действителен, Identity and Access Management обменивает этот JWT-токен на IAM-токен сервисного аккаунта Yandex Cloud, связанного с этим внешним субъектом в соответствующей привязке.
1. Внешний субъект выполняет необходимые запросы к API Yandex Cloud с помощью полученного IAM-токена от имени заданного в привязке сервисного аккаунта.

[Обменять](../operations/wlif/setup-wlif.md#exchange-jwt-for-iam) JWT-токен внешнего субъекта на IAM-токен сервисного аккаунта можно с помощью POST-запроса к эндпоинту `https://auth.yandex.cloud/oauth/token`.

## Привязки в федерации {#federated-credentials}

{% note info %}

Привязка сервисных аккаунтов к федерациям сервисных аккаунтов может быть запрещена [политиками авторизации](access-control/access-policies.md) на уровне [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder), [облака](../../resource-manager/concepts/resources-hierarchy.md#cloud) или [организации](../../organization/concepts/organization.md).

{% endnote %}

_Привязка_ — это связь, настроенная между федерацией сервисных аккаунтов, одним сервисным аккаунтом Yandex Cloud и одним внешним субъектом.

Привязка создается в федерации удостоверений и требует настройки обязательных параметров:

* `Идентификатор или имя сервисного аккаунта` — данные сервисного аккаунта, для которого будет выдаваться IAM-токен при запросе от внешнего субъекта.

    Сервисный аккаунт может быть расположен в каталоге, отличном от каталога федерации сервисных аккаунтов (только при [создании](../operations/wlif/setup-wlif.md#create-federated-credential) привязки через CLI, Terraform или API).

    Сервисному аккаунту должны быть назначены [роли](access-control/roles.md), предоставляющие разрешения на выполнение необходимых действий с ресурсами или данными в Yandex Cloud.
* `Идентификатор федерации сервисных аккаунтов` — данные федерации сервисных аккаунтов, для которой добавляется привязка.
* `subject` — идентификатор, присвоенный OIDС-провайдером внешнему субъекту, выполняющему запрос к API Yandex Cloud.

Создать привязку можно с помощью [CLI](../../cli/quickstart.md).

Чтобы создать привязку, пользователю необходимы:
* [роль](../security/index.md#iam-serviceAccounts-federatedCredentialEditor) `iam.serviceAccounts.federatedCredentialEditor` или выше, выданная на сервисный аккаунт, который будет использоваться в привязке.
* [роль](../security/index.md#iam-workloadIdentityFederations-user) `iam.workloadIdentityFederations.user` или выше на каталог, в котором находится нужная федерация сервисных аккаунтов.

## Примеры использования {#examples}

* [Получение значения секрета Yandex Lockbox на стороне GitHub](../tutorials/wlif-github-integration.md)
* [Доступ к API Yandex Cloud из кластера Managed Service for Kubernetes с помощью федерации сервисных аккаунтов Identity and Access Management](../tutorials/wlif-managed-k8s-integration.md)
* [Получение значения секрета Yandex Lockbox на стороне пользовательской инсталляции Kubernetes](../tutorials/wlif-k8s-integration.md)