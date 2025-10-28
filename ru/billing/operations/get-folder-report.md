# Экспортировать расширенную детализацию

Вы можете получать CSV-файл с общей или поресурсной детализацией расходов. Файл можно скачать разово или настроить получение на постоянной основе.

## Разовый экспорт {#single-time-download}

{% list tabs group=instructions %}

- {{ billing-interface }} {#billing}

  1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
  1. Выберите аккаунт, для которого хотите получить детализацию.
  1. На панели слева выберите ![image](../../_assets/console-icons/square-chart-column.svg) **{{ ui-key.yacloud_billing.billing.account.switch_detail }}**.
  1. Справа вверху нажмите **Еще** и выберите **{{ ui-key.yacloud_billing.billing.account.detail.button_download-csv }}**.
  1. Выберите промежуток времени, за который хотите получить детализацию.
  1. Нажмите кнопку **{{ ui-key.yacloud_billing.billing.account.detail.popup-csv_button_download }}**.

{% endlist %}

## Настройка регулярного экспорта {#set-up-regular-download}

### Перед началом работы {#before-you-begin}

1. Если у вас еще нет разделения на [каталоги](../../resource-manager/concepts/resources-hierarchy.md#folder), [создайте каталог](../../resource-manager/operations/folder/create.md). В названии каталога укажите имя проекта или клиента, который будет использовать его.

1. [Создайте бакет](../../storage/operations/buckets/create.md) в сервисе {{ objstorage-full-name }}. В этом бакете {{ yandex-cloud }} будет сохранять файлы с детализацией. Вы можете сохранять детализацию в нескольких бакетах.

   {% note alert %}

   Требования к бакету:
 
   * Не делайте бакет публичным, иначе любой сможет скачать вашу детализацию по ссылке на бакет.
   * Не добавляйте [шифрование](../../storage/concepts/encryption.md) бакету.
   * Не настраивайте [политику доступа](../../storage/concepts/policy.md) для бакета.

   {% endnote %}

1. Проверьте, что у вас есть одна из ролей: `billing.accounts.owner`, `billing.accounts.admin`, `billing.accounts.editor`.

### Получите детализацию расходов {#download-detail}

{% list tabs group=instructions %}

- {{ billing-interface }} {#billing}

  1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
  1. Выберите аккаунт, для которого хотите получить детализацию.
  1. На панели слева выберите **{{ ui-key.yacloud_billing.billing.account.switch_exports }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud_billing.billing.account.exports.button_create-periodic-export }}**.
  1. В открывшемся окне **{{ ui-key.yacloud_billing.billing.account.exports.label_create-export-title }}**:
     * В поле **{{ ui-key.yacloud_org.billing.account.exports.field_bucket }}** укажите имя бакета, где будет храниться CSV-файл с детализацией.
     * В поле **{{ ui-key.yacloud_org.billing.account.exports.field_prefix }}** укажите название папки для файла. Последний символ должен быть `/`.
     * В поле **{{ ui-key.yacloud_org.billing.account.exports.field_locale }}** выберите язык отображения названий продуктов – `{{ ui-key.yacloud_org.billing.account.exports.locale_value_ru-lang }}` или `{{ ui-key.yacloud_org.billing.account.exports.locale_value_en-lang }}`.
     * В поле **{{ ui-key.yacloud_org.billing.account.exports.field_detail-type }}** выберите тип детализации — `{{ ui-key.yacloud_billing.billing.account.exports.label_not-include-resources }}` или `{{ ui-key.yacloud_billing.billing.account.exports.label_include-resources }}`.

         {% note tip %}

         Выбирая тип `{{ ui-key.yacloud_billing.billing.account.exports.label_include-resources }}` для регулярного экспорта детализации, вы сможете просматривать в [поле `resource_id`](#format), в том числе, и ресурсы сервисов {{ datalens-full-name }}, {{ tracker-full-name }} и {{ ml-platform-name }}, например [идентификаторы сообществ {{ ml-platform-name }}](../../datasphere/concepts/community.md).

         {% endnote %}

  1. (Опционально) Чтобы экспортировать данные за предыдущий период, активируйте соответствующую опцию. В появившемся поле **Загрузить отчеты начиная с** выберите дату начала загрузки отчетов.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

Каждый день в бакете создается новый файл с детализацией. В имени файла указывается префикс и дата, за которую собрана детализация. Файл перезаписывается каждый час, дополняясь новыми данными.

Информация может быть обновлена в любом дневном файле в течение месяца.

{% note tip %}

Файлы с детализацией из бакета автоматически не удаляются, но вы можете настроить периодическое удаление файлов. Подробнее читайте в разделе [Жизненный цикл объектов](../../storage/concepts/lifecycles.md) (в терминах {{ objstorage-name }} файлы в бакете называются _объектами_).

{% endnote %}

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
   * {{ monitoring-short-name }}, {{ datalens-short-name }}, {{ iot-name }}, {{ speechkit-short-name }}, {{ translate-name }} и {{ vision-short-name }} — пустое значение.
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
* `credit` — сумма скидок. Всегда отрицательна. Десятичный разделитель — точка.
* `monetary_grant_credit` — скидка по гранту, в том числе по гранту на знакомство с платформой. Десятичный разделитель — точка.
* `volume_incentive_credit` — скидка за объем потребления продукта. Десятичный разделитель — точка.
* `cud_credit` — скидка за [резервированное потребление](../concepts/cvos.md) ресурса. Стоимость объема потребления сверх резервированного будет равна сумме значений столбцов `cost` и `credit`. Десятичный разделитель — точка.
* `misc_credit` — остальные виды скидок, в том числе скидки за потребление ресурсов после окончания действия гранта на знакомство с платформой, но до перехода на платную версию. Десятичный разделитель — точка.
* `label.user_labels.<имя_метки>` — метки, проставленные ресурсам. Как управлять метками описано в разделе [{#T}](../../resource-manager/operations/manage-labels.md).
* `locale` — язык каждой строки в выгрузке. От значения поля зависит язык столбца `sku_name`. Возможные значения `en` и `ru`.
* `updated_at` — дата и время последнего изменения строки в формате [Unix Timestamp](https://www.unixtimestamp.com).
* `exported_at` — дата и время добавления строки в файл детализации.

{% cut "Устаревшие параметры" %}

* `created_at` — дата и время, в которое начислена указанная стоимость потребления. В формате [Unix Timestamp](https://www.unixtimestamp.com).
* `label.system_labels.folder_id` — идентификатор каталога. Теперь значение отображается в столбце `folder_id`.

{% endcut %}


##### См. также

* [Посмотреть детализацию для облака](check-charges.md)

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}