import { LightningElement } from 'lwc';
import searchTodo from '@salesforce/apex/TodoController.searchTodo';

export default class TodoSearch extends LightningElement {

    error;

    handleSearch(event) {
        window.clearTimeout(this.delayTimeout);
        const searchKey = event.target.value;
        this.delayTimeout = setTimeout(() => {
            searchTodo({ searchKey })
                .then((result) => {
                    const findEvent = new CustomEvent('find', {
                        detail: result //примитивы ДА. а как
                    });
                    this.dispatchEvent(findEvent);
                    this.error = undefined;
                })
                .catch((error) => {
                    this.error = error;
                });
        }, 350);
    }
}