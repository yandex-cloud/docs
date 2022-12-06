# Adding data to a table

To add two records to the `series` table:

{% list tabs %}

* AWS CLI

   Run the command by replacing `https://your-database-endpoint` the [previously prepared Document API endpoint](index.md#before-you-begin) your DB:

   {% note warning %}

   To work with the AWS CLI from Windows, we recommend using the [WSL]({{ ms.docs }}/windows/wsl/).

   {% endnote %}

   ```bash
   endpoint="https://your-database-endpoint"
   aws dynamodb put-item \
       --table-name series \
       --item '{"series_id": {"N": "1"}, "title": {"S": "IT Crowd"}, "series_info": {"S": "The IT Crowd is a British sitcom produced by Channel 4, written by Graham Linehan, produced by Ash Atalla and starring Chris ODowd, Richard Ayoade, Katherine Parkinson, and Matt Berry."}, "release_date": {"S": "2006-02-03"}}' \
       --endpoint $endpoint
   ```

   and

   ```bash
   endpoint="https://your-database-endpoint"
   aws dynamodb put-item \
       --table-name series \
       --item '{"series_id": {"N": "2"}, "title": {"S": "Silicon Valley"}, "series_info": {"S": "Silicon Valley is an American comedy television series created by Mike Judge, John Altschuler and Dave Krinsky."}, "release_date": {"S": "2014-04-06"}}' \
       --endpoint $endpoint
   ```

{% endlist %}
