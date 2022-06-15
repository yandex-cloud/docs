Системной группе можно назначить любые роли, кроме `resource-manager.clouds.owner` и `resource-manager.clouds.member`.

{% note alert %}

Не назначайте системной группе роли `editor` и `admin` на каталог или облако. Это позволит любому, кто узнает идентификатор каталога, пользоваться ресурсами {{ yandex-cloud }}{% if product == "yandex-cloud" %} за ваш счет{% endif %}.

{% endnote %}