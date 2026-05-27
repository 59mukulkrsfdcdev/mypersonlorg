import { LightningElement ,track} from 'lwc';

export default class TodoManager extends LightningElement {
    @track todaytime="12:00PM";
    @track greeting="Good Afternoon";
    @track todos=[];


    connectedCallback(){
        this.gettime();

        setInterval(() => {
            this.gettime();
        }, 1000*60);
    }

    gettime(){
        const date = new Date();
        const hour = date.getHours();
        const min = date.getMinutes(); 

        this.todaytime= `${this.getHour(hour)}:${this.getDigit(min)} ${this.getMiday(hour)}`;
        this.setGreeting(hour);
    }
    getHour(hour){
        return hour=== 0 ? 12 : hour > 12 ? (hour-12) : hour;
    }

    getMiday(hour){
        return hour >= 12 ? "PM": "AM";
    }

    getDigit(digit){
        return digit < 10 ? "0"+digit : digit;  
    }

    setGreeting(hour){
        if(hour < 12){
            this.greeting="Good Morning";

        }
        else if(hour >= 12 && hour < 17){
            this.greeting = "Good Afternoon";
        }
        else {

            this.greeting="Good Evening";
        }
        
    }
    addtodoHandler(){
        const inputbox = this.template.querySelector("lightning-input");
        
        const todo = {
            todoId : this.todos.length,
            todoName : inputbox.value,
            done: false,
            todoDate: new Date()
        }

        this.todos.push(todo);

        inputbox.value="";

    }
    get upcomintask(){
        return this.todos && this.todos.length ? this.todos.filter( todo => !todo.done)
         : [];
    }
    get completedtask(){
        return this.todos && this.todos.length ? this.todos.filter( todo => todo.done)
         : [];
    }
   
}