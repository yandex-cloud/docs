# Завершение пробного периода

Автоматическое завершение пробного периода зависит от способа оплаты, который вы выбрали при [создании платежного аккаунта для юридического лица](../../../billing/quickstart/index.md).

Способ оплаты | Условие завершения
----- | -----  
Банковский перевод | Использован весь [грант](../../usage-grant.md) или истек срок его действия.
Банковская карта  | Использован весь [грант](../../usage-grant.md) или одна из частей гранта и / или истек срок его действия.

Если вы не перешли на платную версию после завершения пробного периода, доступ к вашим ресурсам будет приостановлен на срок 60 дней:
* Ваши виртуальные машины и кластеры баз данных будут остановлены.
* Вы не сможете прочитать или скачать сохраненные данные.

Вы можете восстановить доступ к вашим ресурсам, если перейдете на платную версию в течение 60 дней после завершения пробного периода. В противном случае все ресурсы в вашем облаке будут удалены без возможности восстановления.

{% note info %}

После того как доступ к ресурсам восстановится, вы можете самостоятельно [запустить виртуальные машины](../../../compute/operations/vm-control/vm-stop-and-start.md) и кластеры баз данных.

{% endnote %}

Вы также можете прекратить пользоваться ресурсами {{ yandex-cloud }} до окончания пробного периода.

Чтобы перестать работать с платформой, расторгнуть договор и удалить ваш платежный аккаунт:



1. Перейдите в сервис [**{{ billing-name }}**]({{ link-console-billing }}).
1. Выберите платежный аккаунт из списка.

    {% note info %}
    
    Если доступ к аккаунту утерян, обратитесь в [техническую поддержку]({{ link-console-support }}).
    
    {% endnote %}

1. На странице ![image](../../../_assets/console-icons/flag.svg) **{{ ui-key.yacloud_org.billing.account.switch_overview }}** в правом верхнем углу нажмите кнопку **{{ ui-key.yacloud_components.cloud-center.action_more }}** и выберите пункт ![image](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud_billing.billing.account.dashboard.label_inactivation }}**.
1. Подтвердите ваше намерение и дождитесь окончания проверки.
1. Если аккаунт может быть удален, вы увидите уведомление о начале удаления. В этот момент вы еще можете прервать операцию, нажав кнопку **{{ ui-key.yacloud_billing.billing.account.dashboard.popup-go-pay_button_cancel }}**.
1. Если аккаунт не может быть удален, нажмите кнопку **{{ ui-key.yacloud_billing.billing.account.dashboard.card_label_threshold-description }}**, чтобы посмотреть причину отказа.
   Перечень причин включает, но не ограничивается следующими фактами:
     * У аккаунта остались привязанные:
       * [ресурсы](../../../resource-manager/concepts/resources-hierarchy.md#rm-resources),
       * [облака](../../../resource-manager/concepts/resources-hierarchy.md#cloud),
       * [организации](../../../organization/concepts/organization.md) {{ org-full-name }},
       * [сообщества](../../../datasphere/concepts/community.md) {{ ml-platform-full-name }}, 
       * [пространства]({{ link-docs-ai }}speechsense/concepts/resources-hierarchy#space) {{ speechsense-full-name }},
       * экземпляры [{{ datalens-full-name }}](../../../datalens/index.md),
       * пространства [{{ video-full-name }}](../../../video/index.md). 
     * Остались ресурсы, приобретенные по модели потребления [CVoS](../../../billing/concepts/cvos.md).
     * Не отключен платный тарифный план [Технической поддержки](../../../support/overview.md).
     * Платежный аккаунт имеет статус [партнера](../../../partner/terms.md#referral-partner) либо вы являетесь [клиентом партнера](../../../partner/terms.md#sub-account).
     * Не [завершены взаиморасчеты](../../../billing/concepts/act.md) по оказанным услугам.
 
   Если вам не удалось самостоятельно устранить причину, по которой аккаунт не может быть удален, [обратитесь]({{ link-console-support }}/tickets/create) в техническую поддержку. Обратите внимание, что удалить ресурсы может только пользователь.

1. После удовлетворения всех условий, платежный аккаунт становится неактивным и не может быть использован для работы с ресурсами {{ yandex-cloud }}. Для удаления неактивного аккаунта отправьте письмо на адрес [{{ link-support-mail }}](mailto:{{ link-support-mail }}).

   {% note info %}
   
   После блокировки платежного аккаунта отменить удаление привязанных к нему облаков нельзя.
   
   {% endnote %}

Чтобы вернуть денежные средства, которые не будут использованы для оплаты услуг {{ yandex-cloud }}, [обратитесь]({{ link-console-support }}) в {{ support-center-name }} или отправьте письмо на адрес [{{ link-support-mail }}](mailto:{{ link-support-mail }}).

{% note warning %}

После удаления платежного аккаунта вы не сможете его восстановить, а договор с ООО «Яндекс.Облако», ТОО «Облачные Сервисы Казахстан», Iron Hive doo Beograd (Serbia) или Direct Cursus Technology L.L.C. (Dubai) соответственно будет расторгнут.

{% endnote %}


Пожалуйста, обратите внимание, что данная процедура необратима.

#### См. также {#see-also}

* [Перепривязать облако к другому платежному аккаунту](../../../billing/operations/pin-cloud.md)
* [Удалить каталог](../../../resource-manager/operations/folder/delete.md)
* [Удалить облако](../../../resource-manager/operations/cloud/delete.md)
* [Удалить организацию](../../../organization/operations/delete-org.md)
* [Удалить сообщество {{ ml-platform-name }}](../../../datasphere/operations/community/delete.md)
* [Удалить пространство {{ speechsense-name }}]({{ link-docs-ai }}speechsense/operations/space/delete)