1. Перейдите в сервис [**{{ billing-name }}**]({{ link-console-billing }}).
1. Выберите платежный аккаунт из списка.

    {% include [account-access-lost](../../_includes/billing/account-access-lost.md) %}

1. На странице **{{ ui-key.yacloud_billing.billing.account.switch_overview }}** в правом верхнем углу нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud_billing.billing.account.dashboard.label_inactivation }}**.
1. Подтвердите ваше намерение и дождитесь окончания проверки.
1. Если аккаунт может быть удален, вы увидите уведомление о начале удаления. В этот момент вы еще можете прервать операцию, нажав кнопку **{{ ui-key.yacloud_billing.billing.account.dashboard.popup-go-pay_button_cancel }}**.
1. Если аккаунт не может быть удален, нажмите кнопку **{{ ui-key.yacloud_billing.billing.account.dashboard.card_label_threshold-description }}**, чтобы посмотреть причину отказа.
   Перечень причин включает, но не ограничивается следующими фактами:
     * У аккаунта остались привязанные [ресурсы](../../resource-manager/concepts/resources-hierarchy.md#rm-resources), [облака](../../resource-manager/concepts/resources-hierarchy.md#cloud), [организации](../../organization/concepts/organization.md), [сообщества](../../datasphere/concepts/community.md) {{ ml-platform-name }} или [пространства](../../speechsense/concepts/resources-hierarchy.md#space) {{ speechsense-name }}. 
     * Остались ресурсы, приобретенные по модели потребления [CVoS](../../billing/concepts/cvos.md).
     * Не отключен платный тарифный план [Технической поддержки](../../support/overview.md).
     * Платежный аккаунт имеет статус [партнера](../../partner/terms.md#referral-partner) либо вы являетесь [клиентом партнера](../../partner/terms.md#sub-account).
     * Не [завершены взаиморасчеты](../../billing/concepts/act.md) по оказанным услугам.
 
   Если вам не удалось самостоятельно устранить причину, по которой аккаунт не может быть удален, [обратитесь]({{ link-console-support }}/tickets/create) в техническую поддержку.

1. После удовлетворения всех условий, платежный аккаунт становится неактивным и не может быть использован для работы с ресурсами {{ yandex-cloud }}. Для удаления неактивного аккаунта отправьте письмо на адрес [{{ link-support-mail }}](mailto:{{ link-support-mail }}).

   {% include [delete-cancel-note](delete-cancel-note.md) %}

{% include [payment-refund](../../_includes/billing/payment-refund.md) %}

{% note warning %}

После удаления платежного аккаунта вы не сможете его восстановить, а договор с ООО «Яндекс.Облако», ТОО «Облачные Сервисы Казахстан», Iron Hive doo Beograd (Serbia) или Direct Cursus Technology L.L.C. (Dubai) соответственно будет расторгнут.

{% endnote %}
