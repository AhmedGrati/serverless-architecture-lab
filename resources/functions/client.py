import boto3
client = boto3.client('events')

def handle(event, context):
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