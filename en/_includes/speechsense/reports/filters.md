# Filtering in the report

You can use filtering to select the dialogs to include in your report. To do this, use the following settings:

* **{{ ui-key.yc-ui-talkanalytics.common.period }}**: Time period the report covers.
* **Filters**: The following filter types are available:

    * **Semantic attributes**: Dialog properties, such as reasons, topics, or outcomes. Read more about semantic attributes [here](../../../speechsense/concepts/reports/sense-attributes.md).
    * **{{ ui-key.yc-ui-talkanalytics.dialogs.operator }}**: Agent data.
    * **{{ ui-key.yc-ui-talkanalytics.dialogs.client }}**: Customer data.
    * **{{ ui-key.yc-ui-talkanalytics.dialogs.bot }}** (only for chats): Bot data.
    * **{{ ui-key.yc-ui-talkanalytics.dialogs.speech-statistics }}**: Quality criteria for speech or text messages exchanged between the agent and the customer. For example, for audio, it is the agent's or customer's speech rate, whether any of them interrupted the other party; for chats it is the number of characters in the dialog, how long it was taking the agent to respond to the customer's message.
    * **{{ ui-key.yc-ui-talkanalytics.dialogs.common-metadata }}**: Data on the conversation audio (collected via PBX) or text chat. Metadata is uploaded to {{ speechsense-name }} together with the conversation audio or text chat and contains its key characteristics, e.g., date, topic, and dialog language.
    * **{{ ui-key.yc-ui-talkanalytics.dialogs.classifiers }}**: Classifiers applied to conversation audio recognition results or text chat messages.

    You can use multiple filters at the same time. They will be combined by the logical `AND` operation. As a result, the report will be built based on dialogs that satisfy all the conditions that were specified.

* **{{ ui-key.yc-ui-talkanalytics.reports.grouping-field }}**: Select how to group data in your report. You can only group by metadata fields, for example:

   * By agent, to analyze the performance of each one.
   * By product, to learn which products agents make fewer mistakes presenting in dialogs.

Data cross-sections depend on the dialog metadata. For example, if you want to filter or group data by product, make sure there is a relevant field in the [metadata file](../../../speechsense/quickstart.md#set-space). If you need a new set of metadata, prepare dialog recordings or chats with relevant metadata and [upload these recordings](../../../speechsense/operations/data/upload-data.md) or [chats](../../../speechsense/operations/data/upload-chat-text.md).

You can add filters based on the agent performance criteria and the client’s behavior, such as whether the agent was polite, whether the client was rude, etc. To do this, create the appropriate [semantic tag](../../../speechsense/concepts/tags.md#use-sense-tags-for-dialog-evaluation) and apply it as a filter. 

> For example, if you are interested in dialogs where the customer was rude to the agent, select:
> * Semantic attribute: **{{ ui-key.yc-ui-talkanalytics.statements.common_question }}**.
> * Search query: **Was the client rude or aggressive at least once during the conversation?**

