#!/usr/bin/env python
import sys

import boto3

def get_messages_from_queue(sqs_client, queue_url):
    while True:
        resp = sqs_client.receive_message(
            QueueUrl=queue_url, AttributeNames=["All"], MaxNumberOfMessages=10
        )

        try:
            yield from resp["Messages"]
        except KeyError:
            return

        entries = [
            {"Id": msg["MessageId"], "ReceiptHandle": msg["ReceiptHandle"]}
            for msg in resp["Messages"]
        ]

        resp = sqs_client.delete_message_batch(QueueUrl=queue_url, Entries=entries)

        if len(resp["Successful"]) != len(entries):
            raise RuntimeError(f"Failed to delete messages: entries={entries!r} resp={resp!r}")


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print('usage: reprocess_dlq <queue_name>')
        sys.exit(1)
    queue_name = sys.argv[1]
    dlq_name = f"{queue_name}-dead-letter"

    sqs = boto3.client("sqs")
    queue_url = sqs.get_queue_url(QueueName=queue_name)["QueueUrl"]
    dlq_url = sqs.get_queue_url(QueueName=dlq_name)["QueueUrl"]

    num_msgs = 0

    for message in get_messages_from_queue(sqs, queue_url=dlq_url):
        num_msgs += 1
        sqs.send_message(QueueUrl=queue_url, MessageBody=message["Body"])

    print(f"sent {num_msgs} messages")
