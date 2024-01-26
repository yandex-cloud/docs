---
title: "How to configure a {{ yds-full-name }} source endpoint in {{ data-transfer-full-name }}"
description: "Follow this guide to configure a {{ yds-full-name }} source endpoint in {{ data-transfer-full-name }}."
---

# Configuring {{ yds-full-name }} source endpoints

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can define:

* Stream [connection settings](#managed-service) in [{{ yds-full-name }}](#managed-service). These are required parameters.
* [Additional settings](#additional-settings).

## Basic settings {#managed-service}

{% list tabs group=instructions %}

- Management console {#console}

   {% include [Data Streams UI](../../../../_includes/data-transfer/necessary-settings/ui/yandex-data-streams-source.md) %}

{% endlist %}

## Advanced settings {#additional-settings}


{% include [Note processing order](../../../../_includes/data-transfer/notes/kafka-yds-evhub-processing-order.md) %}


{% list tabs group=instructions %}

- Management console {#console}

   
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSSourceAdvancedSettings.transformer.title }}**:

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.cloud_function.title }}**: Select one of the functions created in {{ sf-name }}.

         
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.service_account_id.title }}**: Select or [create](../../../../iam/operations/sa/create.md) a service account that the processing function will start under.


      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.number_of_retries.title }}**: Set the number of attempts to invoke the processing function.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.buffer_size.title }}**: Set the size of the buffer (in bytes) which when full data will be transferred to the processing function.

         The maximum buffer size is 3.5 MB. For more information about restrictions that apply when working with functions in {{ sf-name }}, see the [corresponding section](../../../../functions/concepts/limits.md).

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.buffer_flush_interval.title }}**: Set the duration of the interval (in seconds) after the expiration of which the data from the stream should be transferred to the processing function.

         {% note info %}

         If the buffer becomes full or the sending interval expires, the data is transferred to the processing function.

         {% endnote %}

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.invocation_timeout.title }}**: Set the allowed timeout of the response from the processing function (in seconds).

      {% note warning %}

      Values in the **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.buffer_flush_interval.title }}** and **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataTransformationOptions.invocation_timeout.title }}** fields are specified with the `s` postfix, for example, `10s`.

      {% endnote %}


   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSSourceAdvancedSettings.converter.title }}**:

      * {% include [conversion-rules](../../../../_includes/data-transfer/fields/yds/ui/conversion-rules.md) %}

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSSourceAdvancedSettings.supported_codecs.title }}**: Set the required data compression format (`{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YdsSupportedCodecs.gzip.title }}`, `{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YdsSupportedCodecs.zstd.title }}`, or `{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YdsSupportedCodecs.raw.title }}`).

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSSourceAdvancedSettings.allow_ttl_rewind.title }}**: Select this option to continue a transfer if a topic's TTL is exceeded (some data will be lost). If the option is not selected, a transfer will be aborted with a data loss error.

{% endlist %}
