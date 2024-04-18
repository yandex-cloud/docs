# История изменений в {{ org-full-name }}

В разделе представлена история изменений сервиса {{ org-name }}.

{% include [Tags-nosql](../_includes/release-notes-tags-nosql.md) %}

## I квартал 2024 {#q1-2024}

* Добавлена возможность удалять федеративных пользователей через [CLI](../cli/cli-ref/managed-services/organization-manager/federation/saml/delete-user-accounts.md) и [API](api-ref/Federation/deleteUserAccounts.md). {{ tag-cli }} {{ tag-api }}
* Устранена уязвимость к Replay Attack для SAML.