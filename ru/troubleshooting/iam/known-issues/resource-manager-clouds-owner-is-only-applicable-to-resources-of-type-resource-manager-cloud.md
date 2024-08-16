# Устранение ошибок при назначении роли `{{ roles-cloud-owner }}` пользователю облака


## Описание проблемы {#issue-description}

При попытке назначить учетной записи роль `{{ roles-cloud-owner }}` возникает ошибка вида:
```
Не удалось обновить права доступа
Role 'resource-manager.clouds.owner' is only applicable to resources of type 'resource-manager.cloud'
```

## Решение проблемы {#issue-resolution}

Вероятно, вы пытаетесь назначить пользователю роль из вкладки **{{ ui-key.yacloud_billing.iam.cloud.label_acl }}** на уровне каталога или организации. Права `{{ roles-cloud-owner }}` необходимо назначать из вкладки **{{ ui-key.yacloud_billing.iam.cloud.label_acl }}** на уровне облака:

![image](../../../_assets/troubleshooting/iam/assigning-cloud-owner-role.png)