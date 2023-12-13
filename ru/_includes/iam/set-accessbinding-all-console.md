{% include [set-access-to-all](./set-access-to-all.md) %}

Например, разрешите любому прошедшему аутентификацию пользователю просматривать информацию об облаке `my-cloud`:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) [выберите](../../resource-manager/operations/cloud/switch-cloud.md) облако.
  1. Перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
  1. В окне **{{ ui-key.yacloud.component.acl.update-dialog.label_title }}** нажмите кнопку **{{ ui-key.yacloud.component.acl.update-dialog.button_select-subject }}**.
  1. Выберите раздел `{{ ui-key.yacloud.common.resource-acl.label_groups }}`.
  1. Выберите группу `All authenticated users`.
  1. Нажмите кнопку **{{ ui-key.yacloud.component.acl.update-dialog.button_add-role }}**.
  1. Выберите роль `resource-manager.viewer`.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- CLI

  Назначьте роль `viewer` системной группе `allAuthenticatedUsers`. В типе субъекта укажите `system`:

  ```bash
  yc resource-manager cloud add-access-binding my-cloud \
    --role viewer \
    --subject system:allAuthenticatedUsers
  ```

- {{ TF }}

  1. Назначьте роль `viewer` системной группе `allAuthenticatedUsers`: 

      ```hcl
      data "yandex_resourcemanager_cloud" "project1" {
        name = "Project 1"
      }

      resource "yandex_resourcemanager_cloud_iam_member" "viewer" {
        cloud_id = "${data.yandex_resourcemanager_cloud.project1.id}"
        role     = "viewer"
        member   = "system:allAuthenticatedUsers"
      }
      ```

  1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
  1. Проверьте корректность конфигурационного файла с помощью команды:
      
      ```bash
      terraform validate
      ```
     
      Если конфигурация является корректной, появится сообщение:
     
      ```bash
      Success! The configuration is valid.
      ```

  1. Выполните команду:
      
      ```bash
      terraform plan
      ```
  
      В терминале будет выведен список создаваемых ресурсов и их параметров. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Примените изменения конфигурации:

      ```bash
      terraform apply
      ```
     
  1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      После этого будут назначены права доступа к облаку.

- API

  Назначьте роль `viewer` системной группе `allAuthenticatedUsers`. В свойстве `subject` укажите тип `system`:

  ```bash
  curl -X POST \
      -H 'Content-Type: application/json' \
      -H "Authorization: Bearer <IAM-токен>" \
      -d '{
      "accessBindingDeltas": [{
          "action": "ADD",
          "accessBinding": {
              "roleId": "viewer",
              "subject": {
                  "id": "allAuthenticatedUsers",
                  "type": "system"
      }}}]}' \
      https://resource-manager.{{ api-host }}/resource-manager/v1/clouds/b1gg8sgd16g7********:updateAccessBindings
  ```

{% endlist %}