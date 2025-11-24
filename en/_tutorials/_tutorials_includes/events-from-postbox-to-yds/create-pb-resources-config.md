{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/list-ul.svg) **{{ ui-key.yacloud.postbox.label_configuration-sets }}** and click **{{ ui-key.yacloud.postbox.button_create-configuration-set }}**.
  1. In the **{{ ui-key.yacloud.common.name }}** field, specify the configuration name: `postbox-events-config`.
  1. Under **{{ ui-key.yacloud.postbox.label_event-destinations }}**, click **{{ ui-key.yacloud.common.add }}** and fill out the form that opens:

      1. In the **{{ ui-key.yacloud.postbox.label_name }}** field, specify the [subscription](../../../postbox/concepts/glossary.md#subscription) name: `postbox-events-subscribe`.
      1. In the **{{ ui-key.yacloud.postbox.label_data-stream }}** field, select the [data stream](../../../data-streams/concepts/glossary.md#stream-concepts) named `postbox-events-stream`.
      1. Toggle the **{{ ui-key.yacloud.common.enabled }}** option on to activate the subscription.

  1. Do not edit the other configuration settings. Click **{{ ui-key.yacloud.postbox.button_create-configuration-set }}**.

{% endlist %}