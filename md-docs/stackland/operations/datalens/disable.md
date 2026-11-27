[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Stackland](../../index.md) > [Пошаговые инструкции](../index.md) > DataLens > Отключить DataLens

# Отключить DataLens

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

Удаление ресурса `DataLensConfig/main` также удаляет установку. Ресурс остаётся в состоянии удаления, пока не будут удалены все ресурсы компонента и пространство имён `stackland-datalens`.

{% note warning %}

При отключении DataLens или удалении `DataLensConfig/main` все созданные компонентом данные будут удалены.

{% endnote %}