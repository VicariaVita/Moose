import { LightningElement, wire, track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { refreshApex } from '@salesforce/apex';
import getTodoList from '@salesforce/apex/TodoController.getTodoList';
import getFilteredTodoList from '@salesforce/apex/TodoController.getFilteredTodoList';

export default class TodoList extends NavigationMixin(LightningElement) {

    @track todos = [];
    @track wiredTodos;
    @track displayed = [];

    page = 1; 
    startingRecord = 1;
    endingRecord = 0;
    pageSize = 2;
    totalRecountCount = 0;
    totalPage = 0;

    error;
    emptyState;
    // state = true;

    category = null;
    priority = null;
    completed = null;

    //@wire(getTodoList) todos;
    @wire(getFilteredTodoList, {category: '$category', priority: '$priority', completed: '$completed'})
    wiredTodos(result) {
        this.wiredTodos = result;
        if (result.data) {
            this.todos = result.data;
            this.totalRecountCount = result.data.length;
            this.totalPage = Math.ceil(this.totalRecountCount / this.pageSize);
            
            this.displayed = this.todos.slice(0,this.pageSize); 
            this.endingRecord = this.pageSize;

            console.log('я в результе' + this.category);
            
            this.emptyCheck();

            this.error = undefined;
        } else if (result.error) {
            this.error = result.error;
            this.todos = undefined;
        }
    }

    createNewTodo() {
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Todo__c',
                actionName: 'new'
            }
        });
        this.refresh;
    }

    handleFind(event) {
        this.todos = event.detail;
        this.pageReset();
    }

    refresh(){
        console.log('попытка рефрешнуть');
        refreshApex(this.wiredTodos);  //заходит сюда с todoItem но не выполняет
        //мб потому что не успевает увидеть апдейт?
        
        this.pageReset();
    }

    emptyCheck(){
        if (this.todos.length == 0){
            this.emptyState = true;
        } else {
            this.emptyState = false;
        }
    };

    pageReset(){
        this.emptyCheck();
        this.page = 1;
        this.startingRecord = 1;
        this.endingRecord = this.pageSize;
        this.totalRecountCount = this.todos.length;
        this.totalPage = Math.ceil(this.totalRecountCount / this.pageSize);
        console.log('я в ресете'); 
        this.displayRecordPerPage(this.page);   
    }

    previousHandler() {
        if (this.page > 1) {
            this.page = this.page - 1;
            this.displayRecordPerPage(this.page);
        }
    }

    nextHandler() {
        if((this.page<this.totalPage) && this.page !== this.totalPage){
            this.page = this.page + 1;
            this.displayRecordPerPage(this.page);            
        }             
    }

    displayRecordPerPage(page){

        this.startingRecord = ((page -1) * this.pageSize) ;
        this.endingRecord = (this.pageSize * page);
        this.endingRecord = (this.endingRecord > this.totalRecountCount) 
                            ? this.totalRecountCount : this.endingRecord; 

        console.log('я в пейдже'); 

        this.displayed = this.todos.slice(this.startingRecord, this.endingRecord);
        this.startingRecord = this.startingRecord + 1;
    }

    handleC(event) {
        this.category = event.detail.value;
    }
    handleP(event) {
        this.priority = event.detail.value;
    }
    handleS(event) {
        this.completed = event.detail.value;
    }

    get categories() {
        return [
            { label: 'All', value: null },
            { label: 'Today', value: 'Today' },
            { label: 'Tomorrow', value: 'Tomorrow' },
            { label: 'Later', value: 'Later' },
        ];
    }

    get priorities() {
        return [
            { label: 'All', value: null },
            { label: 'High', value: 'High' },
            { label: 'Normal', value: 'Normal' },
            { label: 'Low', value: 'Low' },
        ];
    }

    get statuses() {
        return [
            { label: 'All', value: null },
            { label: 'Done', value: true },
            { label: 'Not Completed', value: false },
        ];
    }


}