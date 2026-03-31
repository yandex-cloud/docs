# Экспортировать расширенную детализацию

Вы можете получать CSV-файл с общей или поресурсной детализацией расходов. Файл можно [скачать](#single-time-download) разово или [настроить](#regular-download) получение на постоянной основе.

## Разовый экспорт {#single-time-download}

{% list tabs group=instructions %}

- {{ billing-interface }} {#billing}

  1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
  1. Выберите аккаунт, для которого хотите получить детализацию.
  1. На панели слева выберите ![image](../../_assets/console-icons/square-chart-column.svg) **{{ ui-key.yacloud_billing.billing.account.switch_detail }}**.
  1. Справа вверху нажмите **Ещё** и выберите **{{ ui-key.yacloud_org.billing.account.detail.button_download-details }}**.
  1. В открывшемся окне выберите:
     * Формат выгрузки — `CSV` или `PDF`.
     * Промежуток времени, за который хотите получить детализацию.
     * Язык отображения названий продуктов — `{{ ui-key.yacloud_org.billing.account.exports.locale_value_ru-lang }}` или `{{ ui-key.yacloud_org.billing.account.exports.locale_value_en-lang }}`.
     * Тип детализации — `{{ ui-key.yacloud_billing.billing.account.exports.label_not-include-resources }}` или `{{ ui-key.yacloud_billing.billing.account.exports.label_include-resources }}`.
  1. Нажмите кнопку **{{ ui-key.yacloud_org.billing.account.detail.popup-export_button_download }}**.

{% endlist %}

## Регулярный экспорт {#regular-download}

### Перед началом работы {#before-you-begin}

1. Если у вас еще нет разделения на [каталоги](../../resource-manager/concepts/resources-hierarchy.md#folder), [создайте каталог](../../resource-manager/operations/folder/create.md). В названии каталога укажите имя проекта или клиента, который будет использовать его.

1. [Создайте бакет](../../storage/operations/buckets/create.md) в сервисе {{ objstorage-full-name }}. В этом бакете {{ yandex-cloud }} будет сохранять файлы с детализацией. Вы можете сохранять детализацию в нескольких бакетах.
   
    {% note alert %}
    
    {% include [billing-partner-bucket-alert](../../_includes/billing-partner-bucket-alert.md) %}

    {% endnote %}

1. (Опционально) Для дополнительной защиты детализации настройте [шифрование бакета](../../storage/operations/buckets/encrypt.md).
   Чтобы экспортировать детализацию в бакет с шифрованием, необходим сервисный аккаунт, который будет обслуживать экспорт. Для управления этим сервисным аккаунтом платежному аккаунту должна быть назначена роль `iam.serviceAccounts.user`.

1. Убедитесь, что вашему платежному аккаунту назначены необходимые роли для операций с регулярным экспортом.
   Создание, прекращение и возобновление регулярных экспортов доступны пользователям с одной из следующих ролей:
     * `billing.accounts.editor`;
     * `billing.accounts.accountant`;
     * `billing.accounts.varWithoutDiscounts`.
   
   Просмотр регулярных экспортов доступен пользователям с одной из следующих ролей:
     * `billing.accounts.viewer`;
     * `billing.accounts.varWithoutDiscount`.
  
  Подробнее см. [Сервисные роли в {{ billing-name }}](../../billing/security/index.md).

### Настроить регулярный экспорт {#set-up-regular-download}

{% list tabs group=instructions %}

- {{ billing-interface }} {#billing}

  1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
  1. Выберите аккаунт, для которого хотите получить детализацию.
  1. Перейдите к настройке регулярного экспорта:
   
      {% list tabs %}

       - Раздел {{ ui-key.yacloud_billing.billing.account.switch_detail }}
  
         1. На панели слева выберите ![image](../../_assets/console-icons/square-chart-column.svg) **{{ ui-key.yacloud_billing.billing.account.switch_detail }}**.
         1. Справа вверху нажмите **Ещё** и выберите **{{ ui-key.yacloud_org.billing.account.detail.button_create-periodic-export }}**.

      - Раздел {{ ui-key.yacloud_billing.billing.account.switch_exports }}

          1. На панели слева выберите ![image](../../_assets/console-icons/arrow-up-from-square.svg) **{{ ui-key.yacloud_billing.billing.account.switch_exports }}**.
          1. Нажмите **{{ ui-key.yacloud_billing.billing.account.exports.button_create-periodic-export }}**.

      {% endlist %}

  1. В открывшемся окне укажите:
     * Имя бакета, где будет храниться CSV-файл с детализацией.
     * При выборе бакета с шифрованием укажите существующий сервисный аккаунт или создайте новый:
  
        {% list tabs %}

          - Существующий аккаунт
  
              1. В поле **{{ ui-key.yacloud_org.billing.account.exports.column_service_account }}** укажите сервисный аккаунт.
              1. При появлении сообщения о недостающих ролях нажмите кнопку **{{ ui-key.yacloud_org.billing.providers.button_ca-roles-update }}** и дождитесь сообщения об их добавлении.

          - Новый аккаунт

              1. В поле **{{ ui-key.yacloud_org.billing.account.exports.column_service_account }}** нажмите **{{ ui-key.yacloud_org.billing.exports.ServiceAccountAddField.addNewServiceAccount  }}**.
              1. Введите имя сервисного аккаунта.
              1. Нажмите **{{ ui-key.yacloud_org.iam.folder.service-account.popup-robot_button_save }}**.
          
          {% endlist %}
    
      {% note info %}

       Один сервисный аккаунт может обслуживать несколько регулярных экспортов. При этом на каждый зашифрованный бакет и KMS-ключ необходимо назначать [роли](#before-you-begin) отдельно.

      {% endnote %}

     * Название папки для файла детализации. Последний символ должен быть `/`.
     * Язык отображения названий продуктов – `{{ ui-key.yacloud_org.billing.account.exports.locale_value_ru-lang }}` или `{{ ui-key.yacloud_org.billing.account.exports.locale_value_en-lang }}`.
     * Тип детализации — `{{ ui-key.yacloud_billing.billing.account.exports.label_not-include-resources }}` или `{{ ui-key.yacloud_billing.billing.account.exports.label_include-resources }}`.

         {% note tip %}

         Выбирая тип `{{ ui-key.yacloud_billing.billing.account.exports.label_include-resources }}` для регулярного экспорта детализации, вы сможете просматривать в [поле `resource_id`](#format) ресурсы сервисов {{ datalens-full-name }}, {{ tracker-full-name }} и {{ ml-platform-name }}, например [идентификаторы сообществ {{ ml-platform-name }}](../../datasphere/concepts/community.md).

         {% endnote %}

  1. (Опционально) Чтобы добавить данные за предыдущий период, включите опцию **{{ ui-key.yacloud_org.billing.account.exports.field_period }}**. В появившемся поле **{{ ui-key.yacloud_org.billing.account.exports.field_date }}** выберите дату, с которой вы хотите получить детализацию. Данные доступны с момента создания платежного аккаунта.

  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

{% include [billing-partner-detalization-file-info](../../_includes/billing-partner-detalization-file-info.md) %}

### Прекратить регулярный экспорт {#stop-export}

{% list tabs group=instructions %}

- {{ billing-interface }} {#billing}

  1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
  1. Выберите аккаунт, для которого хотите прекратить регулярный экспорт.
  1. На панели слева выберите ![image](../../_assets/console-icons/arrow-up-from-square.svg) **{{ ui-key.yacloud_billing.billing.account.switch_exports }}**.
  1. Напротив регулярного экспорта нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **Удалить**.

{% endlist %}

### Возобновить регулярный экспорт {#recover-export}

Экспорт, который завершился с ошибкой (статус `Failed`), можно возобновить. Устраните ошибку и возобновите выгрузку:

{% list tabs group=instructions %}

- {{ billing-interface }} {#billing}

  1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
  1. Выберите аккаунт, для которого хотите возобновить экспорт.
  1. На панели слева выберите ![image](../../_assets/console-icons/arrow-up-from-square.svg) **{{ ui-key.yacloud_billing.billing.account.switch_exports }}**.
  1. Напротив регулярного экспорта нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_billing.billing.account.exports.button_resume-export }}**.

{% endlist %}

### Просмотреть регулярные экспорты {#view-export}

Для просмотра доступны все созданные регулярные экспорты и информация о них: бакет, префикс, тип детализации, статус, идентификатор, дата последнего изменения и дата создания.

{% list tabs group=instructions %}

- {{ billing-interface }} {#billing}

  1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
  1. Выберите аккаунт, у которого хотите посмотреть детализацию.
  1. На панели слева выберите ![image](../../_assets/console-icons/arrow-up-from-square.svg) **{{ ui-key.yacloud_billing.billing.account.switch_exports }}**.
  1. Выберите файл с детализацией.

{% endlist %}

## Формат файла с детализацией расходов {#format}

Выгружаемый файл с детализацией — это таблица в CSV-формате (столбцы разделены запятой). Каждая строка отражает потребление продукта за день для указанного каталога.

Таблица содержит следующие столбцы:

* `billing_account_id` — идентификатор [платежного аккаунта](../concepts/billing-account.md).
* `billing_account_name` — имя платежного аккаунта.
* `cloud_id` — идентификатор [облака](../../resource-manager/concepts/resources-hierarchy.md#cloud), для которого собрана детализация.
* `cloud_name` — имя облака.
* `folder_id` — идентификатор каталога.
* `folder_name` — имя каталога на момент выгрузки детализации. Значение поля может быть пустым, если вы удалили каталог до выгрузки детализации.
* `resource_id` — (только для регулярного экспорта) идентификатор ресурса, имя ресурса или идентификатор подписки. Значение поля может быть пустым, если использование сервиса относится ко всему каталогу или не содержит ресурсов. Соответствие сервисов и значения столбца `resource_id`:
   * {{ compute-name }} и {{ marketplace-name }} — идентификатор виртуальной машины, снимка диска, образа диска или другого ресурса, установленного через {{ marketplace-name }}.
   * {{ objstorage-name }} — имя бакета.
   * {{ vpc-name }} — идентификатор ресурса, работающего с входящим или исходящим трафиком.
   * {{ kms-short-name }} — идентификатор ключа.
   * {{ network-load-balancer-name }} — идентификатор балансировщика.
   * {{ container-registry-short-name }} — идентификатор контейнера.
   * {{ k8s }} и {{ dataproc-name }} — идентификатор кластера.
   * {{ mpg-short-name }}, {{ mch-short-name }}, {{ mmg-short-name }}, {{ mmy-short-name }}, {{ mrd-short-name }} и {{ mkf-name }} — идентификатор хоста в кластере.
   * {{ message-queue-name }} — идентификатор запроса.
   * {{ sf-name }} — идентификатор функции.
   * {{ monitoring-short-name }}, {{ iot-name }}, {{ speechkit-short-name }}, {{ translate-name }} и {{ vision-short-name }} — пустое значение.
   * {{ datalens-short-name }} — идентификатор экземпляра {{ datalens-short-name }}.
   * Техническая поддержка — идентификатор подписки.
* `service_id` — идентификатор сервиса, которому принадлежит потребленный продукт.
* `service_name` — имя сервиса, которому принадлежит потребленный продукт.
* `sku_id` — идентификатор потребленного продукта.
* `sku_name` — имя продукта.
* `date` — дата, за которую начислена стоимость потребления. Дата определяется как диапазон с 0:00 до 23:59 по московскому времени (UTC +3).
* `currency` — валюта платежного аккаунта. Возможные значения: `RUB`, `USD` и `KZT`.
* `pricing_quantity` — количество потребленных единиц продукта. Десятичный разделитель — точка.
* `pricing_unit` — единица измерения потребления продукта.
* `cost` — общая стоимость потребления. Десятичный разделитель — точка.
* `credit` — сумма скидок. Не учитывается в общей стоимости потребления (`credit`). Всегда отрицательна. Десятичный разделитель — точка.
* `monetary_grant_credit` — скидка по гранту, в том числе по гранту на знакомство с платформой. Десятичный разделитель — точка.
* `volume_incentive_credit` — скидка за объем потребления продукта. Десятичный разделитель — точка.
* `cud_credit` — скидка за [резервированное потребление](../concepts/cvos.md) ресурса. Стоимость объема потребления сверх резервированного будет равна сумме значений столбцов `cost` и `credit`. Десятичный разделитель — точка.
* `misc_credit` — остальные виды скидок, в том числе скидки за потребление ресурсов после окончания действия гранта на знакомство с платформой, но до перехода на платную версию. Десятичный разделитель — точка.
* `label.user_labels.<имя_метки>` — метки, проставленные ресурсам. Как управлять метками описано в разделе [{#T}](../../resource-manager/operations/manage-labels.md).
* `locale` — язык каждой строки в выгрузке. От значения поля зависит язык столбца `sku_name`. Возможные значения: `en` и `ru`.
* `updated_at` — дата и время последнего изменения строки в формате [Unix Timestamp](https://www.unixtimestamp.com).
* `exported_at` — дата и время добавления строки в файл детализации.

{% cut "Устаревшие параметры" %}

* `created_at` — дата и время, в которое начислена указанная стоимость потребления. В формате [Unix Timestamp](https://www.unixtimestamp.com).
* `label.system_labels.folder_id` — идентификатор каталога. Теперь значение отображается в столбце `folder_id`.

{% endcut %}


##### См. также {#see-also}

* [Посмотреть детализацию для облака](./check-charges.md)

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
