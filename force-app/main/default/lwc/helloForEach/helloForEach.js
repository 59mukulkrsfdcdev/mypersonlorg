import { LightningElement } from 'lwc';

export default class HelloForEach extends LightningElement {
    contacts = [
        {
            Id:1,
            Name: 'Amy Taylor',
            Title: 'VP of Engineering'
        },
        {
            Id:2,
            Name: 'Amon Taylor',
            Title: 'AVP of Engineering'
        },
        {
            Id:3,
            Name: 'Andy Taylor',
            Title: 'Manager'
        }
    ]
}