Запустите генератор данных, указав идентификатор фолдера и базы данных {{ydb-name}}.

{% cut "data_generator.py" %}

```python
import time
import boto3
from hashlib import md5
from datetime import datetime, timedelta
import random
import json
from urllib.parse import urlsplit


stream_endpoint = "https://yds.serverless.yandexcloud.net/ru-central1/b1k917jf99v66n47p7u6/etngkq6nkp47nkrec127"
stream_name = "yellow-taxi"


def create_record(vendor_id,
                  tpep_pickup_datetime,
                  tpep_dropoff_datetime,
                  passenger_count,
                  trip_distance,
                  rate_code_id,
                  store_and_fwd_flag,
                  pu_location_id,
                  do_location_id,
                  payment_type,
                  fare_amount,
                  extra,
                  mta_tax,
                  tip_amount,
                  tolls_amount,
                  improvement_surcharge,
                  total_amount):
    return {
        "vendor_id": vendor_id,
        "tpep_pickup_datetime": tpep_pickup_datetime,
        "tpep_dropoff_datetime": tpep_dropoff_datetime,
        "passenger_count": passenger_count,
        "trip_distance": trip_distance,
        "RatecodeID": rate_code_id,
        "store_and_fwd_flag": store_and_fwd_flag,
        "PULocationID": pu_location_id,
        "DOLocationID": do_location_id,
        "payment_type": payment_type,
        "fare_amount": fare_amount,
        "extra": extra,
        "mta_tax": mta_tax,
        "tip_amount": tip_amount,
        "tolls_amount": tolls_amount,
        "improvement_surcharge": improvement_surcharge,
        "total_amount": total_amount
    }


def to_kinesis_endpoint(stream_endpoint):
    parsed = urlsplit(stream_endpoint)
    return {
                "kinesis_endpoint": f"{parsed.scheme}://{parsed.netloc}",
                "kinesis_region": parsed.path.split("/")[1],
                "stream_path": f'/{"/".join(parsed.path.split("/")[2:])}'
          }


def put_record(stream_endpoint, stream_name, message):
    stream_endpoints = to_kinesis_endpoint(stream_endpoint)
    client = boto3.client('kinesis', endpoint_url=stream_endpoints["kinesis_endpoint"])
    response = client.put_record(
        StreamName=f'/{stream_endpoints["kinesis_region"]}{stream_endpoints["stream_path"]}/{stream_name}',
        Data=message,
        PartitionKey=md5(message.encode()).hexdigest()
    )
    return response


def format_time(tm):
    return tm.strftime("%Y-%m-%d %H:%M:%S")


def main():
    while True:
        ride_start = datetime.now()
        ride_len_minutes = random.randint(20, 1000)
        ride_record = create_record(
            vendor_id=1,
            tpep_pickup_datetime=format_time(ride_start),
            tpep_dropoff_datetime=format_time(ride_start + timedelta(minutes=ride_len_minutes)),
            passenger_count=random.randint(1, 4),
            trip_distance=random.random() * 100,
            rate_code_id="1",
            store_and_fwd_flag="N",
            pu_location_id=str(random.randint(110, 140)),
            do_location_id=str(random.randint(110, 190)),
            payment_type=2,
            fare_amount=random.random() * 100,
            extra=random.random() * 10,
            mta_tax=random.random() * 10,
            tip_amount=random.random() * 10,
            tolls_amount=random.random() * 10,
            improvement_surcharge=random.random() * 10,
            total_amount=random.random() * 1000)

        put_record(
            stream_endpoint=stream_endpoint,
            stream_name=stream_name,
            message=json.dumps(ride_record))

        print("The record has been sent successfully")

        time.sleep(1)


if __name__ == '__main__':
    main()
```

{% endcut %}