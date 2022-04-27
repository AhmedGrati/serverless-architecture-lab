import boto3
client = boto3.client('events')

def handle(event, context):
    print('------- Processing Risk Request -----')
    if(event['detail-type'] == 'risk-event-requested'):
        print('------ Application Request Sent to OCR Microservice -----')
        entries = [
        {
            'DetailType': 'ocr-event-requested',
            'Source': 'risk.events',
            'Detail': '{ \"id\": \"123\"}'
        }
        ]
        result = client.put_events(
        Entries=entries
        )
        print(result)
    return