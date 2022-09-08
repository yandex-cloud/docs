# Managing labels

Custom labels are a pair of `<label name>=<label value>`. You can label resources so that a file with [expense details](get-folder-report.md#format) contains a column like `label.user_labels.<label name>`. Each resource can be assigned multiple labels.

For example, if all VMs belong to two projects, you can add the `project=1` or `project=2` label to each VM. After that, the `label.user_labels.project` column with the corresponding values appears in the file with details.

## Adding a label {#add-label}

{% list tabs %}

- CLI

    {% include [cli-install](../_includes/cli-install.md) %}

    Add a label to a service resource:

    ```
    yc <service name> <resource type> add-labels <resource name or ID> \
      --labels <label name>=<label value>
    ```

{% endlist %}

## Updating a label {#update-label}

{% list tabs %}

- CLI

    {% include [cli-install](../_includes/cli-install.md) %}

    {% note warning %}

    The existing set of `labels` is completely replaced by the set transmitted.

    {% endnote %}

    Update a service resource label:

    ```
    yc <service name> <resource type> update <resource name or ID> \
      --labels <label name>=<label value>
    ```

{% endlist %}

## Deleting a label {#remove-label}

{% list tabs %}

- CLI

    {% include [cli-install](../_includes/cli-install.md) %}

    Delete a service resource label:

    ```
    yc <service name> <resource type> remove-labels <resource name or ID> \
      --labels <label name>
    ```

{% endlist %}

## Examples of label management {#examples}

### Adding a label

Add a label to a VM:

```
yc compute instance add-labels cl123g4dridnn5cna6df-yduv --labels project=test
```

Result:

```
done (5s)
id: fhm1pr2bu3p45s6ildh7
folder_id: b1g23ga45mev6cljderg
created_at: "2020-08-07T11:29:18Z"
name: cl123g4dridnn5cna6df-yduv
labels:
  project: test
zone_id: {{ region-id }}-a
...
```

### Updating a label

Change the {{ k8s }} cluster label:

```
yc managed-kubernetes cluster update k8s-gpu --labels new_lable=test_label
```

Result:

```
done (1m36s)
id: cat1hknor2345e6d7rr8
folder_id: b1g23ga45mev6cljderg
created_at: "2020-08-07T11:15:59Z"
name: cluster
labels:
  new_lable: test_label
status: RUNNING
...
```

### Deleting a label

Remove a label from a {{ mmy-short-name }} cluster:

```
yc managed-mysql cluster remove-labels mysql123 --labels my_lable
```

Result:

```
id: c1qmjaatlurm2bcoi34i
folder_id: b1g23ga45mev6cljderg
created_at: "2020-08-20T11:53:20.015543Z"
name: mysql123
environment: PRODUCTION
...
```

