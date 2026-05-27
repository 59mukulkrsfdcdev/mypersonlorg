import { LightningElement, track } from 'lwc';

export default class PrivateComponent extends LightningElement {
    @track reactivePrivateProperty;
    nonreactivePrivateProperty;

    changeHandler1(event)
    {
        this.reactivePrivateProperty= event.target.value;
    }
    changeHandler2(event)
    {
        this.nonreactivePrivateProperty = event.target.value;
    }

}