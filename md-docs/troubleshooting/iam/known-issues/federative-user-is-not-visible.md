# В списке пользователей организации не отображается федеративный пользователь


## Описание проблемы {#issue-description}

На [странице пользователей федерации]({{ link-org-users }}) не отображается пользователь, который есть в федерации, которая, в свою очередь, находится в этой организации.

В выводе `yc organization-manager federation saml list-user-accounts --id federation_id` пользователь есть, а в выводе `yc organization-manager user list --organization-id organization_id` - нет.

## Решение {#issue-resolution}

Вероятнее всего, федеративный пользователь удален из организации. Его можно вернуть его в организацию с помощью [YC CLI](../../../cli/quickstart.md). 

Общий вид команды: 
```
yc organization-manager federation saml add-user-accounts --id=id_федерации --name-ids="e-mail пользователя"
```

{% note info %}

Минимальная роль для выполнения этой команды — `{{ roles-organization-admin }}` на организацию.

{% endnote %}