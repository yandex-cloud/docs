```python
import json
import os
import subprocess
import uuid
from urllib.parse import urlencode

import boto3
import requests
import yandexcloud
from yandex.cloud.lockbox.v1.payload_service_pb2 import GetPayloadRequest
from yandex.cloud.lockbox.v1.payload_service_pb2_grpc import PayloadServiceStub

boto_session = None
storage_client = None
docapi_table = None
ymq_queue = None


def get_boto_session():
    global boto_session
    if boto_session is not None:
        return boto_session

    # initialize lockbox and read secret value
    yc_sdk = yandexcloud.SDK()
    channel = yc_sdk._channels.channel("lockbox-payload")
    lockbox = PayloadServiceStub(channel)
    response = lockbox.Get(GetPayloadRequest(secret_id=os.environ['SECRET_ID']))

    # extract values from secret
    access_key = None
    secret_key = None
    for entry in response.entries:
        if entry.key == 'ACCESS_KEY_ID':
            access_key = entry.text_value
        elif entry.key == 'SECRET_ACCESS_KEY':
            secret_key = entry.text_value
    if access_key is None or secret_key is None:
        raise Exception("secrets required")
    print("Key id: " + access_key)

    # initialize boto session
    boto_session = boto3.session.Session(
        aws_access_key_id=access_key,
        aws_secret_access_key=secret_key
    )
    return boto_session


def get_ymq_queue():
    global ymq_queue
    if ymq_queue is not None:
        return ymq_queue

    ymq_queue = get_boto_session().resource(
        service_name='sqs',
        endpoint_url='https://message-queue.api.cloud.yandex.net',
        region_name='ru-central1'
    ).Queue(os.environ['YMQ_QUEUE_URL'])
    return ymq_queue


def get_docapi_table():
    global docapi_table
    if docapi_table is not None:
        return docapi_table

    docapi_table = get_boto_session().resource(
        'dynamodb',
        endpoint_url=os.environ['DOCAPI_ENDPOINT'],
        region_name='ru-central1'
    ).Table('tasks')
    return docapi_table


def get_storage_client():
    global storage_client
    if storage_client is not None:
        return storage_client

    storage_client = get_boto_session().client(
        service_name='s3',
        endpoint_url='https://storage.yandexcloud.net',
        region_name='ru-central1'
    )
    return storage_client

# Converter handler

def download_from_ya_disk(public_key, dst):
    api_call_url = 'https://cloud-api.yandex.net/v1/disk/public/resources/download?' + \
                   urlencode(dict(public_key=public_key))
    response = requests.get(api_call_url)
    download_url = response.json()['href']
    download_response = requests.get(download_url)
    with open(dst, 'wb') as video_file:
        video_file.write(download_response.content)


def upload_and_presign(file_path, object_name):
    client = get_storage_client()
    bucket = os.environ['S3_BUCKET']
    client.upload_file(file_path, bucket, object_name)
    return client.generate_presigned_url('get_object', Params={'Bucket': bucket, 'Key': object_name}, ExpiresIn=3600)


def handle_process_event(event, context):
    for message in event['messages']:
        task_json = json.loads(message['details']['message']['body'])
        task_id = task_json['task_id']
        # Download video
        download_from_ya_disk(task_json['src'], '/tmp/video.mp4')
        # Convert with ffmpeg
        subprocess.run(['ffmpeg', '-i', '/tmp/video.mp4', '-r', '10', '-s', '320x240', '/tmp/result.gif'])
        result_object = task_id + ".gif"
        # Upload to Object Storage and generate presigned url
        result_download_url = upload_and_presign('/tmp/result.gif', result_object)
        # Update task status in DocAPI
        get_docapi_table().update_item(
            Key={'task_id': task_id},
            AttributeUpdates={
                'ready': {'Value': True, 'Action': 'PUT'},
                'gif_url': {'Value': result_download_url, 'Action': 'PUT'},
            }
        )
    return "OK"
```