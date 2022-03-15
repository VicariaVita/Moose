import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { deleteRecord } from 'lightning/uiRecordApi';
import { reduceErrors } from 'c/ldsUtils';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class TodoItem extends NavigationMixin(LightningElement) {
    @api todo;

    editTodo() {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: this.todo.Id,
                objectApiName: 'Todo',
                actionName: 'edit'
            }
        });
        this.tryRefresh; // как чтобы рефрешил после едита
    }

    deleteTodo(event) {
        const recordId = event.target.dataset.recordid;
        deleteRecord(recordId)
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Todo deleted',
                        variant: 'success'
                    })
                );
                this.tryRefresh; //работает только без тоста
            })
            .catch((error) => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error deleting record',
                        message: reduceErrors(error).join(', '),
                        variant: 'error'
                    })
                );
            });
    }

    tryRefresh(){
        console.log('я в рефреш ивенте чайлда');
        window.clearTimeout(this.delayTimeout);
        this.delayTimeout = setTimeout(() => {
            this.dispatchEvent(new CustomEvent('refresh'));
        }, 350);
    }
}