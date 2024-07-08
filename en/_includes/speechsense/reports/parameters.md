* **Agent**: Agent data.
* **Customer**: Customer data.
* **Bot** (only for chats): Bot data.
* **Speech statistics** (only for audio): Agent and customer speech quality criteria, e.g., speech rate, mutual interruptions, etc.
* **General metadata**: Data about the conversation audio (collected via PBX) or text chat. Metadata is uploaded to {{ speechsense-name }} together with the conversation audio or text chat and contains its key characteristics, e.g., date, topic, and dialog language.
* **Customer tags** and **Agent tags**: Classifiers applied to conversation audio recognition results or text chat messages. {{ speechsense-name }} scans the dialog for specific keywords, phrases, or intonations, classifies the dialog, and adds a tag to it.

   {{ speechsense-name }} has preconfigured tags. These can give you a clue as to whether there was an informal greeting or goodbye, whether the agent thanked the customer for waiting, whether it was the customer's repeat call to support, etc. You can learn more about tags [here](../../../speechsense/concepts/tags.md).

* **YandexGPT analysis**: Agent's performance criteria and customer's behavioral characteristics during the dialog, such as whether the agent was polite, whether the customer was on the rude side, etc.
