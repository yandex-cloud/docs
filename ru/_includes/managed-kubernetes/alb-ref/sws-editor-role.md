{% note info %}

Для подключения профиля безопасности к виртуальному хосту {{ alb-name }} у сервисного аккаунта, от имени которого работает Ingress-контроллер, должна быть роль [smart-web-security.editor](../../../smartwebsecurity/security/index.md#smart-web-security-editor) на каталог, в котором размещены ресурсы {{ alb-name }} и {{ sws-name }}. Подробнее см. [Назначение роли сервисному аккаунту](../../../iam/operations/sa/assign-role-for-sa.md).

{% endnote %}