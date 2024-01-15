# Настроить сопоставление групп федеративных пользователей

{% include notitle [preview](../../_includes/note-preview-by-request.md) %}

Чтобы настроить права доступа пользователей к ресурсам {{ yandex-cloud }} с помощью [сопоставления групп](../concepts/add-federation.md#group-mapping):

1. [Создайте группы пользователей](#create-group) в {{ org-name }}.
1. [Настройте права доступа](#access) этих групп к ресурсам {{ yandex-cloud }}.
1. Создайте группы пользователей в вашем [поставщике удостоверений](../concepts/add-federation.md#federation-usage) и добавьте в них пользователей.

    {% note info %}

    Вы можете использовать существующие группы пользователей.

    {% endnote %}

1. Задайте сопоставление групп пользователей в настройках SAML-атрибутов поставщика удостоверений. Чтобы узнать, как это сделать, обратитесь к документации или в службу технической поддержки используемого поставщика удостоверений.

    Инструкции по настройке сопоставления групп некоторых поставщиков удостоверений:

   * [Microsoft AD FS](https://learn.microsoft.com/en-us/power-pages/security/authentication/saml2-settings#create-an-ad-fs-relying-party-trust)
   * [Google](https://support.google.com/a/answer/11143403?sjid=815248229840499495-EU)
   * [KeyCloak](https://www.keycloak.org/docs/22.0.3/server_admin/#_protocol-mappers). В дополнение к инструкции, задайте значение `member` для атрибута **Group attribute name**.

1. Задайте сопоставление групп пользователей в настройках федерации:

    1. [Войдите в аккаунт]({{ link-passport-login }}) администратора или владельца организации.
    1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-main }}).
    1. На панели слева выберите раздел ![icon-federation](../../_assets/console-icons/vector-square.svg) [{{ ui-key.yacloud_org.pages.federations }}]({{ link-org-federations }}).
    1. Выберите нужную федерацию и перейдите на вкладку **{{ ui-key.yacloud_org.form.group-mapping.note.tab-idp }}**.
    1. Включите опцию **{{ ui-key.yacloud_org.form.group-mapping.field.idp }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud_org.form.group-mapping.create.add }}** и задайте сопоставление:

        * **{{ ui-key.yacloud_org.form.group-mapping.note.group-name }}** — укажите имя группы поставщика удостоверений.
        * **{{ ui-key.yacloud_org.form.group-mapping.note.iam-group }}** — выберите группу {{ org-name }} из списка.

    1. Повторите предыдущий шаг для всех сопоставляемых групп.
