import { LightningElement, wire } from 'lwc';
import getAllAccounts from '@salesforce/apex/AccountManager.getAccount'

export default class FetchRecordsViaApex2 extends LightningElement {
     @wire(getAllAccounts) accounts;
     get responseReceived()
     {
          if(this.accounts){
               return true;
          }
          return false;
     }
}