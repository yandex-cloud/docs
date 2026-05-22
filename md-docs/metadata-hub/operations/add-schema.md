# Добавление схемы в существующий субъект



{% note info %}

Функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md).

{% endnote %}



Вы можете загрузить схему в существующий субъект [на странице этого субъекта](#from-subject-page) или [на странице со списком схем](#from-schema-list).

## Добавить схему на странице субъекта {#from-subject-page}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно добавить схему в субъект.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex MetaData Hub**.
  1. Hа панели слева выберите ![image](../../_assets/console-icons/layout-cells.svg) **Schema Registry**.
  1. Выберите пространство имен, в котором находится нужный субъект.
  1. На панели слева выберите ![image](../../_assets/console-icons/layers-3-diagonal.svg) **Субъекты**.
  1. Нажмите на имя нужного субъекта, а затем в правом верхнем углу нажмите кнопку ![add](../../_assets/console-icons/plus.svg) **Загрузить схему**.
  1. Нажмите кнопку **Загрузить файл** и прикрепите файл.
  1. Если схема ссылается на другую схему, то нажмите ![add](../../_assets/console-icons/plus.svg) и введите имя [референса](../concepts/schema-registry.md#reference), имя субъекта, под которым зарегистрирована схема для ссылки, и версию субъекта, которая содержит схему для референса.
  1. Чтобы применить [нормализацию схем данных](https://docs.confluent.io/platform/current/schema-registry/fundamentals/serdes-develop/index.html#schema-normalization), включите настройку **Нормализация**.
  1. Если вы хотите пропустить проверку совместимости схем, включите соответствующую настройку.
  1. Нажмите кнопку **Загрузить схему**.

{% endlist %}

## Добавить схему на странице со списком схем {#from-schema-list}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно добавить схему в субъект.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex MetaData Hub**.
  1. Hа панели слева выберите ![image](../../_assets/console-icons/layout-cells.svg) **Schema Registry**.
  1. Выберите пространство имен, в котором находится нужный субъект.
  1. На панели слева выберите ![image](../../_assets/console-icons/branches-down.svg) **Схемы**.
  1. Нажмите кнопку **Загрузить схему**.
  1. Выберите способ загрузки схемы — в существующий субъект.
  1. В поле **Имя** выберите субъект из списка.
  1. Нажмите кнопку **Загрузить файл** и прикрепите файл.
  1. Если схема ссылается на другую схему, то нажмите ![add](../../_assets/console-icons/plus.svg) и введите имя [референса](../concepts/schema-registry.md#reference), имя субъекта, под которым зарегистрирована схема для ссылки, и версию субъекта, которая содержит схему для референса.
  1. Чтобы применить [нормализацию схем данных](https://docs.confluent.io/platform/current/schema-registry/fundamentals/serdes-develop/index.html#schema-normalization), включите настройку **Нормализация**.
  1. Если вы хотите пропустить проверку совместимости схем, включите соответствующую настройку.
  1. Нажмите кнопку **Загрузить схему**.

{% endlist %}