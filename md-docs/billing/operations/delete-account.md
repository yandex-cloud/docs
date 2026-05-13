# Удалить платежный аккаунт и расторгнуть договор с Yandex Cloud

Чтобы перестать работать с платформой, расторгнуть договор и удалить ваш платежный аккаунт:



1. Перейдите в сервис [**Yandex Cloud Billing**](https://center.yandex.cloud/billing/accounts).
1. Выберите платежный аккаунт из списка.

    {% note info %}
    
    Если доступ к аккаунту утерян, обратитесь в [техническую поддержку](https://center.yandex.cloud/support).
    
    {% endnote %}

1. На странице ![image](../../_assets/console-icons/flag.svg) **Аккаунт** в правом верхнем углу нажмите кнопку **Ещё** и выберите пункт ![image](../../_assets/console-icons/trash-bin.svg) **Удалить**.
1. Подтвердите ваше намерение и дождитесь окончания проверки.
1. Если аккаунт может быть удален, вы увидите уведомление о начале удаления. В этот момент вы еще можете прервать операцию, нажав кнопку **Отменить**.
1. Если аккаунт не может быть удален, нажмите кнопку **Подробнее**, чтобы посмотреть причину отказа.
   Перечень причин включает, но не ограничивается следующими фактами:
     * У аккаунта остались привязанные:
       * [ресурсы](../../resource-manager/concepts/resources-hierarchy.md#rm-resources),
       * [облака](../../resource-manager/concepts/resources-hierarchy.md#cloud),
       * [организации](../../organization/concepts/organization.md) Yandex Identity Hub,
       * [сообщества](../../datasphere/concepts/community.md) Yandex DataSphere, 
       * [пространства](../../speechsense/concepts/resources-hierarchy.md#space) Yandex SpeechSense,
       * экземпляры [Yandex DataLens](../../datalens/index.md),
       * пространства [Yandex Cloud Video](../../video/index.md). 
     * Остались ресурсы, приобретенные по модели потребления [CVoS](../concepts/cvos.md).
     * Не отключен платный тарифный план [Технической поддержки](../../support/overview.md).
     * Платежный аккаунт имеет статус [партнера](../../partner/terms.md#referral-partner) либо вы являетесь [клиентом партнера](../../partner/terms.md#sub-account).
     * Не [завершены взаиморасчеты](../concepts/act.md) по оказанным услугам.
 
   Если вам не удалось самостоятельно устранить причину, по которой аккаунт не может быть удален, [обратитесь](https://center.yandex.cloud/support/tickets/create) в техническую поддержку. Обратите внимание, что удалить ресурсы может только пользователь.

1. После удовлетворения всех условий, платежный аккаунт становится неактивным и не может быть использован для работы с ресурсами Yandex Cloud. Для удаления неактивного аккаунта отправьте письмо на адрес [cloud@support.yandex.ru](mailto:cloud@support.yandex.ru).

   {% note info %}
   
   После блокировки платежного аккаунта отменить удаление привязанных к нему облаков нельзя.
   
   {% endnote %}

Чтобы вернуть денежные средства, которые не будут использованы для оплаты услуг Yandex Cloud, [обратитесь](https://center.yandex.cloud/support) в Cloud Center или отправьте письмо на адрес [cloud@support.yandex.ru](mailto:cloud@support.yandex.ru).

{% note warning %}

После удаления платежного аккаунта вы не сможете его восстановить, а договор с ООО «Яндекс.Облако», ТОО «Облачные Сервисы Казахстан», Iron Hive doo Beograd (Serbia) или Direct Cursus Technology L.L.C. (Dubai) соответственно будет расторгнут.

{% endnote %}


Пожалуйста, обратите внимание, что данная процедура необратима.

#### См. также {#see-also}

* [Перепривязать облако к другому платежному аккаунту](pin-cloud.md)
* [Удалить каталог](../../resource-manager/operations/folder/delete.md)
* [Удалить облако](../../resource-manager/operations/cloud/delete.md)
* [Удалить организацию](../../organization/operations/delete-org.md)
* [Удалить сообщество DataSphere](../../datasphere/operations/community/delete.md)
* [Удалить пространство SpeechSense](../../speechsense/operations/space/delete.md)