The limit of responsibility depends on the service and its consumption method. The general principle is described in the [{{ yandex-cloud }} shared responsibility model](../../../../security/respons.md).

{{ yandex-cloud }} is responsible for the managed part of the service within the limits of the published documentation. The organization operating an AI system is responsible for:

* Choice of clouds, folders, services, and their operating modes.
* Accounts, service account, keys, roles, and binding scope.
* Public entry points, network routes, and communication with external systems.
* Data storage permissibility, minimization, classification, and duration.
* Application-level validation of the model’s input, context, and output.
* Authorization of documents prior to feeding them to the RAG context.
* Authority of the agent and its tools.
* Application-level logs, event correlation, and response action.
* Releasing, replacing, and decommissioning data, indexes, models, and configurations.

The fact that a feature is present in the cloud service does not mean the requirement is fulfilled. The owner of the system must demonstrate that the feature is enabled or disabled for the resource in question, covers the actual data stream, and was tested in relevant scenarios.
