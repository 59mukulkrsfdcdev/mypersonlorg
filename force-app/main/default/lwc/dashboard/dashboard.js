import { LightningElement, track } from 'lwc';
import getAllUsers from '@salesforce/apex/ApiDataService.getAllUsers';

export default class Dashboard extends LightningElement {
    @track usersData = [];
    @track usersLoading = false;
    @track showUsersTable = false;
    @track error;

    // Define columns for the users table
    usersColumns = [
        { label: 'ID', fieldName: 'id', type: 'number' },
        { label: 'Name', fieldName: 'name', type: 'text' },
        { label: 'Email', fieldName: 'email', type: 'email' },
        { label: 'Role', fieldName: 'role', type: 'text' },
        { 
            label: 'Avatar', 
            fieldName: 'avatar', 
            type: 'url',
            typeAttributes: {
                label: { fieldName: 'name' },
                target: '_blank'
            }
        }
    ];

    handleGetUsers() {
        // Reset state
        this.showUsersTable = false;
        this.error = undefined;
        this.usersLoading = true;
        
        getAllUsers()
            .then(result => {
                this.usersData = result.map(user => {
                    // Transform data if needed
                    return {
                        ...user,
                        // Add any transformations here
                        // For example, make name title case:
                        name: this.toTitleCase(user.name)
                    };
                });
                this.showUsersTable = true;
            })
            .catch(error => {
                this.error = error.body?.message || error.message || 'Error fetching users';
                console.error('Error fetching users:', error);
            })
            .finally(() => {
                this.usersLoading = false;
            });
    }

    // Helper function to format names
    toTitleCase(str) {
        return str.replace(/\w\S*/g, function(txt) {
            return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();
        });
    }
}