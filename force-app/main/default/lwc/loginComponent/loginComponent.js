import { LightningElement, track } from 'lwc';
import loginUser from '@salesforce/apex/ApiAuthService.login';
import getAllUsers from '@salesforce/apex/ApiAuthService.getAllUsers';
import fetchAllCategories from '@salesforce/apex/ApiAuthService.fetchAllCategories';
import getAllProducts from '@salesforce/apex/ApiAuthService.getAllProducts';

export default class LoginComponent extends LightningElement {
    @track email = '';
    @track password = '';
    
     // State management
     @track isLoading = false;
     @track error = '';
     @track successMessage = '';
     @track showLoginForm = true;
     @track showDataButtons = false;
     @track showUserTable = false;
     @track showCategoryTable = false;
     @track showProductTable = false;

    @track users = [];
    userColumns = [
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
    
    @track categories = [];
    categoryColumns = [
        { label: 'ID', fieldName: 'id', type: 'number' },
        { label: 'Name', fieldName: 'name', type: 'text' },
        { label: 'Slug', fieldName: 'slug', type: 'text' },
        { 
            label: 'Image', 
            fieldName: 'image', 
            type: 'url',
            typeAttributes: {
                label: { fieldName: 'name' },
                target: '_blank'
            }
        }
    ];

     // Product data
     @track products = [];
     productColumns = [
         { label: 'ID', fieldName: 'id', type: 'number' },
         { label: 'Title', fieldName: 'title', type: 'text' },
         { label: 'Slug', fieldName: 'slug', type: 'text' },
         { label: 'Price', fieldName: 'price', type: 'currency' }
     ];
 

    // Debugging method
    logApiCall(methodName, result) {
        console.log(`${methodName} call successful:`, result);
        if (Array.isArray(result)) {
            console.log(`Received ${result.length} items`);
        }
    }

    // Handle form field changes
    handleEmailChange(event) {
        this.email = event.target.value;
    }

    handlePasswordChange(event) {
        this.password = event.target.value;
    }

    handleLogin() {
        if (!this.email || !this.password) {
            this.error = 'Please enter both email and password';
            return;
        }

        this.isLoading = true;
        this.error = '';
        
        loginUser({ 
            email: this.email, 
            password: this.password 
        })
        .then(result => {
            this.logApiCall('loginUser', result);
            this.successMessage = 'Login successful!';
            this.showLoginForm = false;
            this.showDataButtons = true;
        })
        .catch(error => {
            console.error('Login error:', error);
            this.error = this.parseErrorMessage(error);
        })
        .finally(() => {
            this.isLoading = false;
        });
    }

    // Handle get users
    handleGetUsers() {
        this.isLoading = true;
        this.error = '';
        this.resetTables();
        
        getAllUsers()
        .then(result => {
            this.logApiCall('getAllUsers', result);
            this.users = result;
            this.showUserTable = true;
        })
        .catch(error => {
            console.error('Get Users error:', error);
            this.error = this.parseErrorMessage(error);
        })
        .finally(() => {
            this.isLoading = false;
        });
    }

    // Handle get categories
    handleGetCategories() {
        this.isLoading = true;
        this.error = '';
        this.resetTables();
        
        fetchAllCategories()
        .then(result => {
            this.logApiCall('fetchAllCategories', result);
            this.categories = result;
            this.showCategoryTable = true;
        })
        .catch(error => {
            console.error('Get Categories error:', error);
            this.error = this.parseErrorMessage(error);
        })
        .finally(() => {
            this.isLoading = false;
        });
    }
    handleGetProducts() {
        this.isLoading = true;
        this.error = '';
        this.resetTables();
        
        getAllProducts()
            .then(result => {
                this.products = result;
                this.showProductTable = true;
            })
            .catch(error => {
                this.error = error.body?.message || error.message || 'Failed to load products';
            })
            .finally(() => {
                this.isLoading = false;
            });
    }


    // Handle back to login
    handleBackToLogin() {
        this.resetTables();
        this.showLoginForm = true;
        this.successMessage = '';
    }

    resetTables() {
        this.showUserTable = false;
        this.showCategoryTable = false;
        this.showProductTable = false;
        this.showDataButtons = false;
    }

    // Improved error message parsing
    parseErrorMessage(error) {
        // Handle Apex exceptions
        if (error.body) {
            return error.body.message || 
                   error.body.exceptionType + ': ' + error.body.exceptionMessage ||
                   'An unexpected error occurred';
        }
        // Handle JS errors
        return error.message || 'An unknown error occurred';
    }
}