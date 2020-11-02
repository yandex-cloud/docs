# Вопросы и ответы про {{ container-registry-short-name }}

#### Почему тег latest отсутствует или установлен не на последнем загруженном Docker-образе? {#latest}

Потому что вы указали другой тег при загрузке Docker-образа.  

Docker-клиент подставляет тег `latest` автоматически, если Docker-образ создается и загружается без тега. Также можно указать тег `latest` явно. 

{% include [latest-info](../../_includes/container-registry/info-about-latest.md) %}

#### Как сделать реестр публичным? {#public-registry}

Можно выдать роль [container-registry.images.puller](../security/index.md) на ваш реестр для системной группы [allUsers](../../iam/concepts/access-control/system-group.md).

{% note alert %}

При этом все образы из этого реестра станут доступны без аутентификации. 

Не назначайте системной группе роли `container-registry.images.pusher`, `editor` и `admin` на реестр. Это позволит любому, кто узнает идентификатор вашего реестра, пользоваться им за ваш счет.

{% endnote %} 

#### У меня возникла ошибка. Что делать? {#error}

Ознакомьтесь с информацией в разделе [{#T}](../error/index.md), там перечислены часто встречающиеся ошибки и способы их решения.

{% include [qa-logs.md](../../_includes/qa-logs.md) %}

