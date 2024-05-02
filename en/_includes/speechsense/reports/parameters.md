* **Operator**: Defines how well the agent does their job, e.g., speech rate, whether they interrupted the customer, etc.

* **Customer**: Refers to the customer's behavior during the call, e.g., speech rate, whether they interrupted the agent, etc.

* **General metada**: Recording data collected using the PBX. The metadata is uploaded to {{ speechsense-name }} together with the call recording and contains its key characteristics, such as full names of the agent and customer, call date, call language, etc.

   General metadata also contains numerical characteristics, e.g., how long the silence lasted during the dialog or how many words the dialog was comprised of.

* **Customer tags** and **Operator tags**: Classifiers applied to the dialog recognition results. {{ speechsense-name }} scans the dialog for specific keywords, phrases, or intonations, classifies the dialog, and adds a tag to it.

   {{ speechsense-name }} has preconfigured tags. These can give you a clue as to whether there was an informal greeting or goodbye, whether the agent thanked the customer for waiting, whether it was the customer's repeat call to support, etc. You can learn more about tags [here](../../../speechsense/concepts/tags.md).
