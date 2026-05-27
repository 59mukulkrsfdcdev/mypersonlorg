import { api, LightningElement } from 'lwc';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import Expense__c from "@salesforce/schema/Expense__c"


export default class ExpenseEditForm extends LightningElement {
    objectName = Expense__c;
    @api recordId;
    record;
    handleSuccess(event) {
    console.log('onsuccess event recordEditForm',event.detail.id)
    this.record= event.detail.name;
    }
 
    resetForm() {
        const inputFields = this.template.querySelectorAll(
            'lightning-input-field'
        );
        if (inputFields) {
            inputFields.forEach(field => {
                field.reset();
            });
        }
    }
    get acceptedFormats() {
    
    return ['.pdf', '.png','.jpg','.jpeg'];
}
handleFinish(event) {
    // Get the list of uploaded files
    const uploadedFiles = event.detail.files;
    let uploadedFileNames = '';
    for(let i = 0; i < uploadedFiles.length; i++) {
        uploadedFileNames += uploadedFiles[i].name + ', ';
    }
    this.dispatchEvent(
        new ShowToastEvent({
            title: 'Success',
            message: uploadedFiles.length + ' Files uploaded Successfully: ' + uploadedFileNames,
            variant: 'success',
        }),
    );
}
   
}