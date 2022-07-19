---
sourcePath: overlay/quickstart/document-api/aws-cli/get-item.md
---
# Reading data from a table

To read data from the `series` table:

{% list tabs %}

* AWS CLI

   Run the command by replacing `https://your-database-endpoint` [the previously prepared Document API endpoint](index.md#before-you-begin) your DB:

   {% note warning %}

   To work with the AWS CLI from Windows, we recommend using the [WSL]({{ ms.docs }}/windows/wsl/).

   {% endnote %}

   ```bash
   endpoint="https://your-database-endpoint"
   aws dynamodb get-item --consistent-read \
       --table-name series \
       --key '{"series_id": {"N": "1"}, "title": {"S": "IT Crowd"}}' \
       --endpoint $endpoint
   ```

   Result:

   ```text
   {
       "Item": {
           "series_id": {
               "N": ".1e1"
           },
           "title": {
               "S": "IT Crowd"
           },
           "release_date": {
               "S": "2006-02-03"
           },
           "series_info": {
               "S": "The IT Crowd is a British sitcom produced by Channel 4, written by Graham Linehan, produced by Ash Atalla and starring Chris ODowd, Richard Ayoade, Katherine Parkinson, and Matt Berry."
           }
       }
   }
   ```

{% endlist %}
