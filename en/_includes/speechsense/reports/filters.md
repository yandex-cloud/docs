# Filtering in the report

You can use filtering to select the dialogs to include in your report. To do this, use the following settings:

* **{{ ui-key.yc-ui-talkanalytics.common.period }}**: Time period the report covers.
* **Filters**: The following filter types are available:

    * **Semantic attributes**: Dialog properties, such as reasons, topics, or outcomes. Read more about semantic attributes [here](../../../speechsense/concepts/reports/sense-attributes.md).
    * **{{ ui-key.yc-ui-talkanalytics.dialogs.operator }}**: Agent data.
    * **{{ ui-key.yc-ui-talkanalytics.dialogs.client }}**: Customer data.
    * **{{ ui-key.yc-ui-talkanalytics.dialogs.bot }}** (only for chats): Bot data.
    * **{{ ui-key.yc-ui-talkanalytics.dialogs.speech-statistics }}** (only for audio): Agent and customer speech quality criteria, e.g., speech rate, mutual interruptions, etc.
    * **{{ ui-key.yc-ui-talkanalytics.dialogs.common-metadata }}**: Data on the conversation audio (collected via PBX) or text chat. Metadata is uploaded to {{ speechsense-name }} together with the conversation audio or text chat and contains its key characteristics, e.g., date, topic, and dialog language.
    * **{{ ui-key.yc-ui-talkanalytics.dialogs.classifiers }}**: Classifiers applied to conversation audio recognition results or text chat messages.
    * **{{ ui-key.yc-ui-talkanalytics.projects.sumarization }}**: Agent performance criteria and the customer's behavioral patterns during the dialog, such as whether the agent was polite, whether the customer acted in a rude manner, etc.

    You can use multiple filters at the same time. They will be combined by the logical `AND` operation. As a result, the report will be built based on dialogs that satisfy all the conditions that were specified.

* **{{ ui-key.yc-ui-talkanalytics.reports.grouping-field }}**: Select how to group data in your report. You can only group by metadata fields, for example:

   * By agent, to analyze the performance of each one.
   * By product, to learn which products agents make fewer mistakes presenting in dialogs.

Data cross-sections depend on the dialog metadata. For example, if you want to filter or group data by product, make sure there is a relevant field in the [metadata file](../../../speechsense/quickstart.md#set-space). If you need a new set of metadata, prepare dialog recordings or chats with relevant metadata and [upload these recordings](../../../speechsense/operations/data/upload-data.md) or [chats](../../../speechsense/operations/data/upload-chat-text.md).
