import boto3
client = boto3.client('events')

def handle(event, context):
    print('------- Processing Commercial Request -----')
    if(event['detail-type'] == 'commercial-event-requested'):
        print('------ Application Request Sent to Risk Microservice -----')
        entries = [
        {
            'DetailType': 'risk-event-requested',
            'Source': 'commercial.events',
            'Detail': '{ \"id\": \"123\"}'
        }
        ]
        result = client.put_events(
        Entries=entries
        )
        print(result)
    return