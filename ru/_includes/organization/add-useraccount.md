{% list tabs %}

- Cloud Organization

    1. [Войдите в аккаунт]({{ link-passport-login }}) администратора или владельца организации.
    1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-main }}).
    1. На левой панели выберите раздел [Пользователи]({{ link-org-users }}) ![icon-users](../../_assets/organization/icon-users.svg).
    1. В правом верхнем углу нажмите {% if product == "yandex-cloud" %}**Добавить пользователя**{% endif %}{% if product == "cloud-il" %}**Пригласить пользователей**{% endif %}.
    1. Введите почтовые адреса пользователей {% if product == "yandex-cloud" %}Яндекса{% endif %}{% if product == "cloud-il" %}Google{% endif %}, которых вы хотите пригласить в организацию (например, `{{ login-example }}`).
{% if product == "cloud-il" %}
    1. Выберите срок действия приглашения.
{% endif %}
    1. Нажмите {% if product == "yandex-cloud" %}**Добавить**{% endif %}{% if product == "cloud-il" %}**Отправить приглашение**{% endif %}.

{% if product == "yandex-cloud" %}
    
    Чтобы получить доступ к [сервисам](../../organization/manage-services.md#collaboration), которые подключены к организации, приглашенным пользователям будет достаточно войти в свой аккаунт на Яндексе.

{% endif %}
    
{% if product == "cloud-il" %}
    
    Чтобы присоединиться к организации, приглашенным пользователям необходимо:
    
    1. Перейти по ссылке в письме с приглашением и принять приглашение.
    1. Войти в организацию.

{% endif %}

{% endlist %}