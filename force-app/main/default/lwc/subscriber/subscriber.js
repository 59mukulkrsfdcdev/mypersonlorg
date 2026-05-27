import { LightningElement, wire } from 'lwc';
import { subscribe, MessageContext } from 'lightning/messageService';
import LMS_MESSAGE from '@salesforce/messageChannel/lmsMessageChannel__c';

export default class Subscriber extends LightningElement {
    receivedMessage = '';

    @wire(MessageContext)
    messageContext;

    connectedCallback() {
        this.subscription = subscribe(this.messageContext, LMS_MESSAGE, (message) => {
            this.receivedMessage = message.messageText;
        });
    }
}