# Включение экранирования источников

Экранирующие серверы расположены в разных географических локациях:

| Провайдер | Идентификатор локации | Название локации
| --- | --- | --- |
| {{ cdn-full-name }} | 1 | Russia / Moscow / msk |

Чтобы включить [экранирование источников](../../concepts/origins-shielding.md) для [ресурса](../../concepts/resource.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором расположен ресурс.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. Нажмите на имя необходимого ресурса.
  1. Перейдите на вкладку **{{ ui-key.yacloud.cdn.label_shielding }}**.
  1. В правом верхнем углу включите опцию экранирования источников.
  1. В окне **{{ ui-key.yacloud.cdn.label_shielding-settings-title }}** в поле **{{ ui-key.yacloud.cdn.label_shielding-location }}** выберите необходимую локацию.
  1. Нажмите кнопку **{{ ui-key.yacloud.cdn.button_activate-shielding }}**.
  
  После включения статус экранирования изменится с `Not activated` на `Active`.

{% endlist %}

Чтобы новые настройки существующего ресурса применились к CDN-серверам, может потребоваться до 15 минут. После этого рекомендуется [очистить кеш ресурса](purge-cache.md).