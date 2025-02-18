# Filtering in the report

You can use filtering to select the dialogs to include in your report. To do this, use the following settings:

* **Period**: Time period of the report.
* **Filters**: The following filter types are available:

    * **Agent**: Agent data.
    * **Customer**: Customer data.
    * **Bot** (only for chats): Bot data.
    * **Speech statistics** (only for audio): Agent and customer speech quality criteria, e.g., speech rate, mutual interruptions, etc.
    * **General metadata**: Data about the conversation audio (collected via PBX) or text chat. Metadata is uploaded to {{ speechsense-name }} together with the conversation audio or text chat and contains its key characteristics, e.g., date, topic, and dialog language.
    * **Tags**: Classifiers applied to conversation audio recognition results or text chat messages.
    * **{{ yagpt-name }}** analysis: Agent’s performance criteria and customer’s behavioral characteristics during the dialog, such as whether the agent was polite, whether the customer acted in a rude manner, etc.

    You can also use [neuroparameters](../../../speechsense/concepts/reports/neuro-parameters.md) in filters.

    You can use multiple filters at the same time. They will be combined by the logical `AND` operation. As a result, the report will be built based on dialogs that satisfy all the conditions that were specified.

* **Grouping**: Choose how to group data in your report. You can only group by metadata fields, for example:

   * By agent, to analyze the performance of each one.
   * By product, to learn which products agents make fewer mistakes presenting in dialogs.

Data cross-sections depend on the dialog metadata. For example, if you want to filter or group data by product, make sure there is a relevant field in the [metadata file](../../../speechsense/quickstart.md#set-space). If you need a new set of metadata, prepare dialog recordings or chats with relevant metadata and [upload these recordings](../../../speechsense/operations/data/upload-data.md) or [chats](../../../speechsense/operations/data/upload-chat-text.md).
