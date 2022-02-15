public with sharing class BatchTask implements Database.Batchable<sObject> {

    public Database.QueryLocator start(Database.BatchableContext bc) {
        //ID id = '00T5j00000URCNKEA5';
        return Database.getQueryLocator(
            'SELECT Task.Account.Owner.Name, Task.Account.Id FROM TASK WHERE Is_Synced__c = false'
            //'SELECT Task.Account.Owner.Name, Task.Account.Id FROM TASK WHERE Id =: id'
        );
    }
    public void execute(Database.BatchableContext bc, List<Task> tasks){

        List<Account> accounts = new List<Account>();

        for (Task current : tasks){
            current.Account_Owner__c = current.Account.Owner.Name;
            current.Is_Synced__c = TRUE;
            current.Account.Updated_By_Task__c = true;
            accounts.add(current.Account);
        }
        update tasks;
        update accounts;
    }

    public void finish(Database.BatchableContext bc){
        System.debug('task batch finished');
    }
}
