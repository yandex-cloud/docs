# Отключить {{ datalens-name }}

## Отключить компонент {#disable}

1. Откройте ресурс `DataLensConfig` для редактирования:

   ```bash
   kubectl edit datalensconfig main
   ```

1. Установите значение `spec.enabled: false`:

   ```yaml
   spec:
     enabled: false
   ```

1. Сохраните изменения и закройте редактор.

1. Проверьте, что поды компонента удалены:

   ```bash
   kubectl get pods -n stackland-datalens
   ```

   Список подов должен быть пустым.

{% note warning %}

При отключении {{ datalens-name }} все созданные компонентом данные будут удалены.

{% endnote %}
