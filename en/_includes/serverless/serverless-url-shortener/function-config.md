```py
import ydb
import urllib.parse
import hashlib
import base64
import json
import os
import traceback

def decode(event, body):
    is_base64_encoded = event.get('isBase64Encoded')
    if is_base64_encoded:
        body = str(base64.b64decode(body), 'utf-8')
    return body

def response(statusCode, headers, isBase64Encoded, body):
    # Always returning string to body
    if not isinstance(body, str):
        body = json.dumps(body, ensure_ascii=False)
    return {
        'statusCode': statusCode,
        'headers': headers,
        'isBase64Encoded': isBase64Encoded,
        'body': body,
    }

def get_config():
    endpoint = os.getenv("endpoint")
    database = os.getenv("database")
    if endpoint is None or database is None:
        raise AssertionError("You need to specify both environment variables: endpoint and database")
    credentials = ydb.iam.MetadataUrlCredentials()
    return ydb.DriverConfig(endpoint, database, credentials=credentials)

def execute(config, query, params):
    with ydb.Driver(config) as driver:
        try:
            driver.wait(timeout=5, fail_fast=True)
        except Exception as e:
            print("Connect failed to YDB:", e)
            print(driver.discovery_debug_details())
            raise

        session = driver.table_client.session().create()
        prepared_query = session.prepare(query)
        return session.transaction(ydb.SerializableReadWrite()).execute(
            prepared_query,
            params,
            commit_tx=True
        )

def insert_link(id, link):
    config = get_config()
    query = """
    DECLARE $id AS Utf8;
    DECLARE $link AS Utf8;

    UPSERT INTO links (id, link) VALUES ($id, $link);
    """
    params = {'$id': id, '$link': link}
    execute(config, query, params)

def find_link(id):
    config = get_config()
    query = """
    DECLARE $id AS Utf8;

    SELECT link FROM links where id=$id;
    """
    params = {'$id': id}
    result_set = execute(config, query, params)

    if not result_set or not result_set[0].rows:
        return None

    # Paying attention to the structure of the result from ydb
    return result_set[0].rows[0].link

def shorten(event):
    try:
        body = event.get('body')
        if body is None:
            return response(400, {'Content-Type': 'application/json'}, False,
                            {'error': 'No body in the request body'})

        body = decode(event, body)

        # Attempting to parse JSON with a url key; otherwise, treating body as a plain string
        url_value = None
        try:
            parsed = json.loads(body)
            if isinstance(parsed, dict):
                url_value = parsed.get('url')
            else:
                # If not a JSON object is sent, ignoring
                url_value = None
        except Exception:
            # If body is not JSON, treating it as plain URL
            url_value = body

        if not url_value:
            return response(400, {'Content-Type': 'application/json'}, False,
                            {'error': 'The url parameter was expected in the request body'})

        # Cleaning the URL from eventual coded characters
        clean_url = urllib.parse.unquote(url_value).strip()
        if not clean_url:
            return response(400, {'Content-Type': 'application/json'}, False,
                            {'error': 'Empty url'})

        link_id = hashlib.sha256(clean_url.encode('utf8')).hexdigest()[:6]
        insert_link(link_id, clean_url)

        # Returning the relative path; the frontend will add the origin by themselves
        return response(200, {'Content-Type': 'application/json'}, False,
                        {'url': f'/r/{link_id}'})
    except Exception as e:
        print("Exception in shorten():", e)
        traceback.print_exc()
        return response(500, {'Content-Type': 'application/json'}, False,
                        {'error': 'internal server error'})

def redirect(event):
    try:
        # Securely retrieving path params
        path_params = event.get('pathParams') or event.get('pathParameters') or {}
        link_id = path_params.get('id')
        if not link_id:
            # Probably, the full path was received in event['url'] or ['path']
            url = event.get('url') or event.get('path') or ''
            if url and url.startswith('/r/'):
                link_id = url.split('/r/')[-1].split('?')[0]

        if not link_id:
            return response(400, {'Content-Type': 'application/json'}, False, {'error': 'No ID'})

        redirect_to = find_link(link_id)

        if redirect_to:
            return response(302, {'Location': redirect_to}, False, '')
        return response(404, {'Content-Type': 'application/json'}, False, {'error': 'The link does not exist'})
    except Exception as e:
        print("Exception in redirect():", e)
        traceback.print_exc()
        return response(500, {'Content-Type': 'application/json'}, False, {'error': 'internal server error'})

def get_result(url, event):
    if url == "/shorten" or url.startswith("/shorten"):
        return shorten(event)
    if url.startswith("/r/"):
        return redirect(event)
    return response(404, {'Content-Type': 'application/json'}, False, {'error': 'The path does not exist'})

def handler(event, context):
    url = event.get('url') or event.get('path') or ''
    if url:
        # Sometimes, the URL from the gateway comes with a question mark at the end
        if url.endswith('?'):
            url = url[:-1]
        return get_result(url, event)
    return response(404, {'Content-Type': 'application/json'}, False, {'error': 'The function must be called via API Gateway.'})
```