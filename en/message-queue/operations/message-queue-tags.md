---
title: How to manage queue labels in {{ message-queue-full-name }}
description: Follow this tutorial to add or delete queue labels.
---

# Managing queue labels

[Labels](../concepts/tags.md) are key-value pairs for logical tagging of queues.

## Adding labels when creating a queue {#add-edit-tags-new-queue}

{% list tabs group=instructions %}

- AWS CLI {#cli}

  1. [Install and configure](configuring-aws-cli.md) the AWS CLI.
  1. When creating a queue, specify the labels you need:

      ```bash
      aws sqs create-queue \
        --queue-name <queue_name> \
        --endpoint <endpoint>
        --tags <labels>
      ```

     Where:

     * `--queue-name`: Name of the new queue, e.g., `sample-queue`.
     * `--endpoint`: Endpoint in the `https://message-queue.{{ api-host }}/` value.
     * `--tags`: List of queue labels, e.g., `key1=string,key2=string`.

     Result:

     ```json
     {
         "QueueUrl": "https://message-queue.{{ api-host }}/aoeaql9r10cd********/000000000000********/sample-queue"
     }
     ```

{% endlist %}

## Adding or updating labels of an existing queue {#add-edit-tags-existing-queue}

{% list tabs group=instructions %}

- AWS CLI {#cli}

  1. [Install and configure](configuring-aws-cli.md) the AWS CLI.
  1. [Create](message-queue-new-queue.md) a message queue.
  1. Add labels:

      ```bash
      aws sqs tag-queue \
        --queue-url <queue_URL> \
        --endpoint <endpoint>
        --tags <labels>
      ```

      Where:

      * `--queue-url`: URL of the queue to add or update labels for.
      * `--endpoint`: Endpoint in the `https://message-queue.{{ api-host }}/` value.
      * `--tags`: List of queue labels, e.g., `key1=string,key2=string`.

{% endlist %}

## Deleting queue labels {#delete-tags}

{% list tabs group=instructions %}

- AWS CLI {#cli}

  1. Delete the labels of an existing queue:

      ```bash
      aws sqs untag-queue \
        --queue-url <queue_URL> \
        --endpoint <endpoint>
        --tag-keys <label_keys>
      ```

      Where:

      * `--queue-url`: URL of the queue whose labels you need to delete.
      * `--endpoint`: Endpoint in the `https://message-queue.{{ api-host }}/` value.
      * `--tag-keys`: List of queue label keys, e.g., `key1 key2`.

{% endlist %}

## Viewing queue labels {#list-tags}

{% list tabs group=instructions %}

- AWS CLI {#cli}

  1. To view the labels of an existing queue, run this command:

      ```bash
      aws sqs list-queue-tags \
        --queue-url <queue_URL> \
        --endpoint <endpoint>
      ```

      Where:

      * `--queue-url`: URL of the queue whose labels you need to get.
      * `--endpoint`: Endpoint in the `https://message-queue.{{ api-host }}/` value.

     Result:

     ```json
     {
         "Tags": {
             "key1": "value1"
         }
     }
     ```


{% endlist %}
