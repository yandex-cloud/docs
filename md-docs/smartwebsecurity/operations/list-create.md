# Управление списками

{% note info %}

Функциональность списков адресов находится на стадии [Preview](../../overview/concepts/launch-stages.md).

{% endnote %}

Вы можете управлять только [пользовательскими списками](../concepts/lists.md#user-rules). Предустановленные [списки Yandex Cloud](../concepts/lists.md#yc-rules) изменять нельзя.


## Создать список {#create}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. Перейдите в сервис **Smart Web Security**.
  1. На панели слева выберите ![image](../../_assets/console-icons/files.svg) **Списки** и нажмите **Создать список**.
  1. Выберите тип списка:

      * `IP-адреса` — IP-адреса, диапазоны адресов или префиксы в формате [CIDR](https://ru.wikipedia.org/wiki/Бесклассовая_адресация). Примеры:

          ```text
          111.222.33.44
          2001:0db8:85a3:0000:0000:8a2e:5678:1234
          10.123.1.1/32
          10::1234:1abc:1/64
          1.2.0.0-1.2.1.1
          ```

      * `Номера ASN` — номера [автономных систем](https://ru.wikipedia.org/wiki/Автономная_система_(Интернет)). Примеры:

          ```text
          AS64512
          AS4294967294
          15169
          1.10
          ```

      * `Регулярные выражения` — [регулярные выражения](../concepts/conditions.md#regular-expressions), например для анализа заголовка `User-Agent`. Примеры:

          ```text
          User-Agent:\s*
          \\[\'\"\.\;]
          a{100,}
          --.*
          ```

      * `Строковые значения` — текстовые строки, например идентификаторы. Примеры:

          ```text
          fev4ct8l9infabcd1234
          id345678
          ```

  1. Введите имя и описание списка.
  1. При необходимости добавьте метку.
  1. Нажмите **Создать список** и затем **Добавить в список**.
  1. Введите значения в список вручную или загрузите их из файла TXT или CSV.

     В списке или в файле каждое значение указывайте с новой строки. Дополнительно можно добавить описание через запятую без пробела:

     ```text
     <значение_1>,<описание_1>
     <значение_2>,<описание_2>
     <значение_3>
     <значение_4>
     ```

     При загрузке файла прежний список не сохранится, а будет заменен на новый.

  1. Нажмите **Сохранить изменения**.

Теперь при добавлении правила в [профиле безопасности](rule-add.md) или [ARL](arl-rule-add.md) вы можете выбрать созданный список.

{% endlist %}


## Скачать список {#download}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. Перейдите в сервис **Smart Web Security**.
  1. На панели слева выберите ![image](../../_assets/console-icons/files.svg) **Списки**.
  1. Нажмите строку с нужным списком.
  1. Перейдите на вкладку **IP-адреса**.
  1. Нажмите ![image](../../_assets/console-icons/arrow-down-to-line.svg) **Скачать список**.
      
      Список будет сохранен в формате CSV.

{% endlist %}


## Изменить параметры списка {#update-params}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. Перейдите в сервис **Smart Web Security**.
  1. На панели слева выберите ![image](../../_assets/console-icons/files.svg) **Списки**.
  1. В строке с нужным списком нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../_assets/console-icons/pencil.svg) **Редактировать**.
  1. Измените имя и описание списка, добавьте или удалите метки.
  1. Нажмите **Сохранить изменения**.

{% endlist %}

## Изменить список значений {#update-values}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. Перейдите в сервис **Smart Web Security**.
  1. На панели слева выберите ![image](../../_assets/console-icons/files.svg) **Списки**.
  1. Нажмите строку с нужным списком.
  1. Перейдите на вкладку **IP-адреса**.

      * Чтобы изменить описание для одного или нескольких значений, выберите их и нажмите ![image](../../_assets/console-icons/pencil-to-line.svg) **Изменить описание**.
      * Чтобы удалить одно или несколько значений, выберите их и нажмите ![image](../../_assets/console-icons/trash-bin.svg) **Удалить**.
      * Чтобы отредактировать список в текстовом формате или загрузить новый файл со списком:

          1. Нажмите **Изменить список**.
          1. Отредактируйте список или загрузите новый файл.
          1. Нажмите **Сохранить изменения**.

{% endlist %}

## Удалить список {#delete}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. Перейдите в сервис **Smart Web Security**.
  1. На панели слева выберите ![image](../../_assets/console-icons/files.svg) **Списки** 
  1. В строке с нужным списком нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../_assets/console-icons/trash-bin.svg) **Удалить**.

{% endlist %}

#### Полезные ссылки {#see-also}

* [Списки](../concepts/lists.md)
* [Условия](../concepts/conditions.md)
* [Добавить правило в профиль безопасности](rule-add.md)
* [Добавить правило в профиль ARL](arl-rule-add.md)