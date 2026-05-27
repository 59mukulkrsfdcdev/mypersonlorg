import { LightningElement, api} from 'lwc';

export default class EmployeDetails extends LightningElement {
    @api empDetail ={empName:'Johan',empAddress:'TX'}
}