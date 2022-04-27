import boto3
client = boto3.client('events')

def handle(event, context):
    print('------- Processing OCR Request -----')
    if(event['detail-type'] == 'ocr-event-requested'):
        print('------ Sending Final Result to The Client -----')
        entries = [
        {
            'DetailType': 'application-response-event',
            'Source': 'ocr.events',
            'Detail': '{ \"id\": \"123\"}'
        }
        ]
        result = client.put_events(
        Entries=entries
        )
        print(result)
    return