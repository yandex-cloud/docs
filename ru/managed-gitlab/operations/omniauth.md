# Настройка OmniAuth

Чтобы интегрировать провайдеров аутентификации для {{ GL }} с помощью [OmniAuth](https://rubygems.org/gems/omniauth/):

1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.gitlab.title_omniauth }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.gitlab.button_setup-omniauth }}**.
1. Чтобы добавить провайдера аутентификации, нажмите кнопку **Add**.
1. Выберите тип провайдера и заполните поля:

    {% list tabs %}

    - Bitbucket Cloud

        {% include [omniauth-common](../../_includes/managed-gitlab/omniauth-common.md) %}

        О том, как получить идентификатор и секретный ключ приложения, см. в [инструкции по настройке провайдера]({{ gl.docs }}/ee/integration/bitbucket.html#bitbucket-omniauth-provider).

    - Gitlab self-managed

        {% include [omniauth-common](../../_includes/managed-gitlab/omniauth-common.md) %}
        * **Site** — ссылка на репозиторий в GitLab.

        О том, как получить идентификатор и секретный ключ приложения, см. в [инструкции по настройке провайдера]({{ gl.docs }}/ee/integration/gitlab.html).

    - Github Enterprise

        {% include [omniauth-common](../../_includes/managed-gitlab/omniauth-common.md) %}
        * **URL** — ссылка на репозиторий в GitHub.

        О том, как получить идентификатор и секретный ключ приложения, см. в [инструкции по настройке провайдера]({{ gl.docs }}/ee/integration/github.html).

    {% endlist %}

1. Нажмите кнопку **Создать**.

Подробнее о работе OmniAuth в {{ GL }} см. в [документации {{ GL }}]({{ gl.docs }}/ee/integration/omniauth.html).
