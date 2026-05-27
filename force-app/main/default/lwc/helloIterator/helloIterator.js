import { LightningElement } from 'lwc';

export default class HelloIterator extends LightningElement {
    contacts = [
        {ID:1,
            Name: 'Praveen Kumar',
            Title: 'Developer'

        },
        {ID:2,
            Name: 'Michal Jone',
            Title: 'VP of Engineering'

        },
        
        {ID:2,
            Name: 'Michal Jordan',
            Title: 'CEO'

        }

    ]
}