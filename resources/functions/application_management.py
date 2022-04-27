import boto3
client = boto3.client('events')

def handle(event, context):
    print('------- Processing Client Request For Application -----')
    if(event['detail-type'] == 'application-event-requested'):
        print('------ Application Request Sent to Commercial Microservice -----')
        entries = [
        {
            'DetailType': 'commercial-event-requested',
            'Source': 'client.events',
            'Detail': '{ \"id\": \"123\"}'
        }
        ]
        result = client.put_events(
        Entries=entries
        )
        print(result)
    return