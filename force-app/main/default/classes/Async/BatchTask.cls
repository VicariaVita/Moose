public with sharing class BatchTask implements Database.Batchable<sObject> {

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT Task.Account.Owner.Name, Task.Account.Id FROM TASK WHERE Is_Synced__c = false'
        );
    }

    public void execute(Database.BatchableContext bc, List<Task> tasks){

        Set<Account> accounts = new Set<Account>();

        for (Task current : tasks){
            current.Account_Owner__c = current.Account.Owner.Name;
            current.Is_Synced__c = TRUE;
            current.Account.Updated_By_Task__c = true;
            accounts.add(current.Account);
        }
        update tasks;
        update new List<Account>(accounts);
    }

    public void finish(Database.BatchableContext bc){
        System.debug('task batch finished');
    }
}
