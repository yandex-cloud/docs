1. Перейдите в сервис [**{{ billing-name }}**](https://billing.yandex.cloud/accounts/).
1. Выберите платежный аккаунт из списка.
1. На странице **{{ ui-key.yacloud_billing.billing.account.switch_overview }}** в правом верхнем углу нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud_billing.billing.account.dashboard.label_inactivation }}**.
1. Подтвердите ваше намерение и дождитесь окончания проверки, можно ли удалить платежный аккаунт.
1. Если аккаунт может быть удален, вы увидите уведомление о начале удаления. В этот момент вы еще можете прервать операцию, нажав кнопку **{{ ui-key.yacloud_billing.billing.account.dashboard.popup-go-pay_button_cancel }}**.
1. Если аккаунт не может быть удален, нажмите кнопку **{{ ui-key.yacloud_billing.billing.account.dashboard.card_label_threshold-description }}**, чтобы посмотреть причину отказа.
   Перечень причин включает, но ограничивается следующими фактами:
     * У аккаунта остались привязанные [ресурсы](../../resource-manager/concepts/resources-hierarchy.md#rm-resources), [облака](../../organization/concepts/manage-services.md#cloud), [организации](../../organization/concepts/membership.md), [сообщества](../../datasphere/concepts/community.md) {{ ml-platform-name }} или [пространства](../../speechsense/concepts/resources-hierarchy.md#space) {{ speechsense-name }}. 
     * Остались ресурсы, приобретенные по модели потребления [CVoS](../../billing/concepts/cvos.md).
     * Не отключен платный тарифный план [Технической поддержки](../../support/overview.md).
     * Платежный аккаунт имеет статус [партнера](../../partner/terms.md#referral-partner) либо вы являетесь [клиентом партнера](../../partner/terms.md#sub-account).
     * Не [завершены взаиморасчеты](../../billing/concepts/act.md) по оказанным услугам.
 
   Если вам не удалось самостоятельно устранить причину, по которой аккаунт не может быть удален, [обратитесь]({{ link-console-support }}/create-ticket) в техническую поддержку.

Пожалуйста, обратите внимание, что после удаления аккаунта вы не сможете его восстановить.