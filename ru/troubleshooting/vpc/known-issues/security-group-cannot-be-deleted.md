# Не удаляется группа безопасности


## Описание проблемы {#issue-description}

При попытке удалить группу безопасности возникает ошибка:
```
code = FailedPrecondition desc = Security group with id *** not empty
```

## Решение {#issue-resolution}

Перед тем, как удалить группу безопасности, нужно отвязать ее от виртуальной машины. Для этого небходимо:

1. В консоли управления зайти в **{{ ui-key.yacloud_components.services.service_compute }}**.
1. Выбрать целевую ВМ.
1. В параметрах ВМ прокрутить до настроек сети.
1. Нажать на кнопку ![***](../../../_assets/options.svg) и в выпадающем списке выбрать **{{ ui-key.yacloud.compute.instance.overview.button_edit-network-interface }}**.
1. Отвязать группу безопасности.
1. Нажать **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.
