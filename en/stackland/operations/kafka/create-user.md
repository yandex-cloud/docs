# Creating a user

If you have a [project](../projects/create-project.md), you can create an [{{ KF }}](../../concepts/components/kafka.md) user in it.

## Using the CLI

1. If the project does not exist yet, create it: `kubectl create namespace <project name>`.
1. Create a file of the `KafkaUserAccess` resource, e.g., using the `touch kafkauseraccess.yaml` command.
1. Open the file and paste the configuration below into it. Create a secret along with the user:

    {% list tabs %}

    - Admin

        {% include notitle [YAML-file](../../_includes/yamls/operations/kafka/user-admin.md) %}

    - Consumer

        {% include notitle [YAML-file](../../_includes/yamls/operations/kafka/user-consumer.md) %}

    - Producer

        {% include notitle [YAML-file](../../_includes/yamls/operations/kafka/user-producer.md) %}

    {% endlist %}

1. Apply the manifest: `kubectl apply -f kafkauseraccess.yaml -n <project name>`. Optionally, you can specify the project name in the `metadata.namespace` resource property and skip it in the command.

## Using the management console

1. If you have not opened a project yet, select one.
1. In the left-hand menu, select **Kafka Clusters**.
1. Select a cluster.
1. Go to the **Users** tab.
1. Click **Create user**.
1. Enter the username and password.
1. Click **Use pattern** below the topic selection.
1. To select all topics, enter "*".
1. Choose the role.
1. Click **Create**.
