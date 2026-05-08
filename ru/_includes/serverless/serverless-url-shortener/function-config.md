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
    # Всегда отдаём строку в body
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
        raise AssertionError("Нужно указать обе переменные окружения: endpoint и database")
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

    # Учитываем структуру результата от ydb
    return result_set[0].rows[0].link

def shorten(event):
    try:
        body = event.get('body')
        if body is None:
            return response(400, {'Content-Type': 'application/json'}, False,
                            {'error': 'В теле запроса отсутствует тело'})

        body = decode(event, body)

        # Попробуем распарсить JSON с ключом url, иначе считаем body как plain string
        url_value = None
        try:
            parsed = json.loads(body)
            if isinstance(parsed, dict):
                url_value = parsed.get('url')
            else:
                # если отправили не-объект JSON, игнорируем
                url_value = None
        except Exception:
            # body не JSON — считаем, что это plain URL
            url_value = body

        if not url_value:
            return response(400, {'Content-Type': 'application/json'}, False,
                            {'error': 'Ожидался параметр url в теле запроса'})

        # Очищаем URL от эвентуальных кодированных символов
        clean_url = urllib.parse.unquote(url_value).strip()
        if not clean_url:
            return response(400, {'Content-Type': 'application/json'}, False,
                            {'error': 'Пустой url'})

        link_id = hashlib.sha256(clean_url.encode('utf8')).hexdigest()[:6]
        insert_link(link_id, clean_url)

        # Возвращаем относительный путь — фронт сам допишет origin
        return response(200, {'Content-Type': 'application/json'}, False,
                        {'url': f'/r/{link_id}'})
    except Exception as e:
        print("Exception in shorten():", e)
        traceback.print_exc()
        return response(500, {'Content-Type': 'application/json'}, False,
                        {'error': 'internal server error'})

def redirect(event):
    try:
        # защитно доставать path params
        path_params = event.get('pathParams') or event.get('pathParameters') or {}
        link_id = path_params.get('id')
        if not link_id:
            # возможно пришёл полный путь в event['url'] или ['path']
            url = event.get('url') or event.get('path') or ''
            if url and url.startswith('/r/'):
                link_id = url.split('/r/')[-1].split('?')[0]

        if not link_id:
            return response(400, {'Content-Type': 'application/json'}, False, {'error': 'id отсутствует'})

        redirect_to = find_link(link_id)

        if redirect_to:
            return response(302, {'Location': redirect_to}, False, '')
        return response(404, {'Content-Type': 'application/json'}, False, {'error': 'Данной ссылки не существует'})
    except Exception as e:
        print("Exception in redirect():", e)
        traceback.print_exc()
        return response(500, {'Content-Type': 'application/json'}, False, {'error': 'internal server error'})

def get_result(url, event):
    if url == "/shorten" or url.startswith("/shorten"):
        return shorten(event)
    if url.startswith("/r/"):
        return redirect(event)
    return response(404, {'Content-Type': 'application/json'}, False, {'error': 'Данного пути не существует'})

def handler(event, context):
    url = event.get('url') or event.get('path') or ''
    if url:
        # Иногда URL из шлюза приходит с вопросительным знаком на конце
        if url.endswith('?'):
            url = url[:-1]
        return get_result(url, event)
    return response(404, {'Content-Type': 'application/json'}, False, {'error': 'Функция должна вызываться через API Gateway.'})
```