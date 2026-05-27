import { LightningElement, track} from 'lwc';

export default class SimpleIntrestCalculator extends LightningElement {
    @track currentOutput;
    principal;
    rateofInterest;
    noOfYears;
    principalChangeHandler(event)
    {
        this.principal = parseInt(event.target.value);
    }
    timeChangeHandler(event)
    {
        this.noOfYears = parseInt(event.target.value);

    }
    rateChangeHandler(event)
    {
        this.rateofInterest = parseInt(event.target.value);
    }
    calculateSIHandler()
    {
        this.currentOutput = 'Simple Interest is : '+(this.principal*this.rateofInterest*this.noOfYears)/100;
    }
}