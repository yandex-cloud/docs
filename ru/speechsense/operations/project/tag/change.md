# Изменить тег

При работе с [тегом](../../../concepts/tags.md) проекта можно:

* [изменить его настройки](#edit);
* [изменить канал тега](#tag-channel).

Для изменения тега проекта нужна роль `{{ roles-speechsense-admin }}` или `{{ roles-speechsense-editor }}` в проекте.

После изменения тега {{ speechsense-name }} заново пронализирует диалоги, загруженные в течение месяца до изменения тега. Нужные теги назначатся автоматически. Ко всем диалогам, загруженным после изменения, новые правила будут применяться сразу.

## Изменить настройки тега {#edit}

1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
1. Перейдите в нужное пространство, затем выберите проект.
1. На вкладке **{{ ui-key.yc-ui-talkanalytics.dialogs.classifiers }}** откройте нужный тег и нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.common.edit }}**.
1. В открывшемся окне задайте настройки:

   {% include [tag-settings](../../../../_includes/speechsense/tag/tag-settings.md) %}

1. Нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.common.save }}**.

## Активировать или деактивировать тег {#activate-tag}

После создания тег активирован по умолчанию. Если вы не хотите, чтобы тег применялся к диалогам, деактивируйте его. Позднее его можно снова активировать.

Чтобы активировать или деактивировать тег:

1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
1. Перейдите в нужное пространство, затем выберите проект.
1. Перейдите на вкладку **Теги**.
1. В строке нужного тега включите опцию **Использовать в проектах**, чтобы активировать тег. Выключите, чтобы деактивировать тег.

{% include [changes-after-activation](../../../../_includes/speechsense/tag/changes-after-activation.md) %}

## Изменить канал тега {#tag-channel}

### Изменить канал одного тега {#single-tag}

1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
1. Перейдите в нужное пространство, затем выберите проект.
1. Перейдите на вкладку **{{ ui-key.yc-ui-talkanalytics.dialogs.classifiers }}**.
1. В строке нужного тега нажмите ![icon](../../../../_assets/console-icons/ellipsis.svg), затем ![icon](../../../../_assets/console-icons/arrow-right-arrow-left.svg) **Изменить канал**.
1. Укажите канал в зависимости от того, где {{ speechsense-name }} должен искать ключевые слова тега:

   * **{{ ui-key.yc-ui-talkanalytics.tags.channel.operator-and-client }}** — во всем диалоге;
   * **{{ ui-key.yc-ui-talkanalytics.tags.channel.operator }}** — только в речи или сообщениях оператора;
   * **{{ ui-key.yc-ui-talkanalytics.tags.channel.client }}** — только в речи или сообщениях клиента.

1. Нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.common.save }}**.

### Изменить канал нескольких тегов {#multiple-tags}

Вы можете изменить канал нескольких тегов одновременно:

1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
1. Перейдите в нужное пространство, затем выберите проект.
1. Перейдите на вкладку **{{ ui-key.yc-ui-talkanalytics.dialogs.classifiers }}** и выберите нужные теги.
1. Во всплывающем окне нажмите кнопку ![icon](../../../../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yc-ui-talkanalytics.tags.change-channel }}**.
1. Укажите канал для каждого тега. Если для всех тегов нужен один канал, выберите его в поле **{{ ui-key.yc-ui-talkanalytics.tags.new-channel }}** над списком тегов.
1. Нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.common.save }}**.
