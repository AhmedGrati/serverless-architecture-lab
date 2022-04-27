import http
import boto3
client = boto3.client('events')

def handle(event, context):
    if(event['detail-type'] == 'application-response-event'):
        print('------- Result of The Processed Application -----------')
        return {
            'status_code': http.HTTPStatus.OK,
            'message' : "Application Processed Successfully!"
        }
    

    entries = [
        {
            'DetailType': 'application-event-requested',
            'Source': 'client.events',
            'Detail': '{ \"id\": \"123\"}'
        }
    ]
    result = client.put_events(
        Entries=entries
    )
    print(result)
    return result