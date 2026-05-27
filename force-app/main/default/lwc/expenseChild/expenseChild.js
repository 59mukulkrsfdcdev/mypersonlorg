import { LightningElement ,api} from 'lwc';

export default class ExpenseChild extends LightningElement {
    @api
    myRecordId;

    get acceptedFormats() {
        return ['.pdf', '.png'];
    }
@api
    handleUploadFinished(event) {
        // Get the list of uploaded files
        const uploadedFiles = event.detail.files;
        
        // eslint-disable-next-line no-alert
        alert('No. of files uploaded : ' + uploadedFiles.length);
    }
}