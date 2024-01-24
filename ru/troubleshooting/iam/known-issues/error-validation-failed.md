# Устранение ошибки `Validation failed: - access_binding_deltas: Number of elements must be in the range of 1 to 1000`


## Описание проблемы {#issue-description}

При попытке назначить или отозвать роли на организацию, каталог или любую другую сущность, являющуюся подходящим ресурсом, возникает ошибка `Validation failed: - access_binding_deltas: Number of elements must be in the range of 1 to 1000`.

## Решение {#issue-resolution}

Ошибка `Validation failed: - access_binding_deltas: Number of elements must be in the range of 1 to 1000` возникает, когда при настройке доступа не была добавлена или удалена ни одна роль. Вероятнее всего, роль уже была назначена на выбранный ресурс.