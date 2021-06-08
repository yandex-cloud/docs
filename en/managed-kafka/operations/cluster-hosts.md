# Managing hosts {{ KF }}

You can change the class of broker hosts in {{ KF }} clusters and get a list of these hosts in a cluster.

{% include [mkf-zk-hosts](../../_includes/mdb/mkf-zk-hosts.md) %}

# Change the host class {#change-resource-preset}

{% list tabs %}


- API

  Use the [update](../api-ref/Cluster/update.md) API method and pass the following in the request:
  - The cluster ID in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - New [host class](../concepts/instance-types.md) in the `resourcePresetId` parameter. Restrict changes to cluster settings using the `updateMask` parameter so that only the host class is changed (otherwise, the other cluster settings will be reset to the default settings).

    ```
    {
      "clusterId": "<cluster ID>",
      "updateMask": "resourcePresetId",
      "configSpec: {
        "kafka": {
          "resources": {
            "resourcePresetId": "<new host class>"
          }
        }
      }  
    }
    ```

  {% note warning %}

  This API method resets any topic settings that aren't explicitly specified in the `topicSpec` parameter to their default values.
  To avoid this, list the settings you want to change in the `updateMask` parameter (in a single line, separated by commas, as shown above).

  {% endnote %}

{% endlist %}

# Getting a list of cluster hosts {#list-hosts}

{% list tabs %}


- API

  Use the [listHosts](../api-ref/Cluster/listHosts.md) API method: pass the ID of the required cluster in the `clusterId` request parameter.

  To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}
