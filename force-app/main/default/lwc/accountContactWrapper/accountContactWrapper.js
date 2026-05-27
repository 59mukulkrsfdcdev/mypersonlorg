import { LightningElement, track, wire } from 'lwc';
import fetchData from '@salesforce/apex/AccountController.fetchData';
import processWrapper from '@salesforce/apex/AccountController.processWrapper';

export default class AccountContactWrapper extends LightningElement {
    @track accounts = [];
    @track contacts = [];

    accountColumns = [
        { label: 'Name', fieldName: 'Name' },
        { label: 'Industry', fieldName: 'Industry' },
        { label: 'Phone', fieldName: 'Phone' }
    ];

    contactColumns = [
        { label: 'First Name', fieldName: 'FirstName' },
        { label: 'Last Name', fieldName: 'LastName' },
        { label: 'Email', fieldName: 'Email' },
        { label: 'Phone', fieldName: 'Phone' }
    ];

    @wire(fetchData)
    wiredWrapper({ data, error }) {
        if (data) {
            this.accounts = data.accounts;
            this.contacts = data.contacts;
        } else if (error) {
            console.error('Error loading wrapper data', error);
        }
    }

    handleSendData() {
        const wrapper = {
            accounts: this.accounts,
            contacts: this.contacts
        };

        processWrapper({ wrapper })
            .then(() => {
                alert('Wrapper data sent successfully');
            })
            .catch(error => {
                console.error('Error sending wrapper data:', error);
            });
    }
}