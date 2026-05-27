import { LightningElement,wire  } from 'lwc';
import { publish, MessageContext } from 'lightning/messageService';
import LMS_MESSAGE from '@salesforce/messageChannel/lmsMessageChannel__c';

export default class Publisher extends LightningElement {
    message = 'Hello from Publisher';

    @wire(MessageContext)
    messageContext;

    handleClick() {
        publish(this.messageContext, LMS_MESSAGE, {
            messageText: this.message
        });
    }
}