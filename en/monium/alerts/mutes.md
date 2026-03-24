# Mutes 

Mutes allow you to temporarily disable notifications from a specific alert or group of alerts. Mutes do not affect the alert calculation process; the relevant status will be shown in the interface.

Mutes remain active for a specified period, then get turned off and, 7 days later, deleted by [TTL](../concepts/glossary.md#ttl).

## Mute parameters {#mute-parameters}

* **Mute period**: Mute start and end date and time.
* **Name**: Mute name.
* **Description**: Description of the reasons for adding the mute.
* **Selector**: Selector used to search for muted alerts.

Available labels for alert search:

* `alert.id` and `sub_alert.id`: Alert ID.
* `alert.name`: Alert name.
* `alert.labels.LABEL_NAME`: Alert labels.
* `sub_alert.labels.LABEL_NAME`: Multialert breakdown labels.

The selector supports [glob expressions](https://en.wikipedia.org/wiki/Glob_(programming)), e.g., `alert.id='*prod-???'`. You can specify multiple labels for a more accurate search, e.g., `alert.id='*-prod', alert.labels.serviceProviderId=compute`.

{% note info %}

The input field will autosuggest the alert labels and multialert breakdown labels available in the project.

{% endnote %}

When creating or editing a mute, you can see which alerts match the mute selectors under **Alerts that will be muted**.

## Examples of mute selectors {#example}

* Mute by alert ID:
    ```
    alert.id='test_alert'
    ```
* Mute all alerts by ID template:
    ```
    alert.id='test_alert*'
    ```
* Mute all alerts by name template:
    ```
    alert.name='*query*|*product*'
    ```
* Mute subalert by ID:
    ```
    sub_alert.id='500f279065221ba31a4feb9319b24eb2bd42c4ac'
    ```

## Mute states {#mute-states-regular}

Depending on its settings and current time, a mute can switch between the following states:

* **Pending**: The mute has been scheduled but is not affecting any alerts yet.
* **Active**: The mute is active and it mutes all messages from alerts and sub-alerts covered by its selectors.
* **Expired**: The mute has expired and no longer affects any alerts.
* **Archived**: The mute expired more than a day ago.

**Pending**, **Active**, and **Expired** mutes are shown in a special section on the status pages of linked alerts and sub-alerts. **Archived** mutes are not considered linked with any alerts, even if the alert ID is covered by the mute's selector. These mutes are stored for historical reasons and are deleted by TTL in six days after switching to the **Archived** status.

{% note alert %}

Once a mute expires, its status changes to **Archived** after 24 hours. Six days later, the mute is deleted.

{% endnote %}

## Interaction between mutes and escalations {#mutes-for-escalations}

If you configure a mute for a {{ monium-name }} alert, escalation will not start.