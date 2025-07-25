В блоке **{{ ui-key.yacloud_org.application.overview.secret_section_title }}** нажмите кнопку **{{ ui-key.yacloud_org.application.overview.secret_section_add_new_secret_action }}** и в открывшемся окне:

1. (Опционально) Добавьте произвольное описание создаваемого секрета.
1. Нажмите **{{ ui-key.yacloud.common.create }}**.

В окне отобразится сгенерированный [секрет приложения](../../organization/concepts/applications.md#oidc-secret). Сохраните полученное значение.

{% note warning %}

После обновления или закрытия страницы с информацией о приложении посмотреть секрет будет невозможно.

{% endnote %}

Если вы закрыли или обновили страницу, не сохранив сгенерированный секрет, используйте кнопку **{{ ui-key.yacloud_org.application.overview.secret_section_add_new_secret_action }}**, чтобы создать новый.

Чтобы удалить секрет, в списке секретов на странице OIDC-приложения в строке с нужным секретом нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.