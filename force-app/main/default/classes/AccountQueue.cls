public with sharing class AccountQueue implements Queueable{
    private List<Contact> contacts;
    
    public AccountQueue(Contact[] contacts) {
        this.contacts = contacts;
    }

    public void execute(QueueableContext context){

        for (Contact current : contacts){
            current.Is_Synced__c = false;
            current.Processed_By_Queue__c = true;
        }
        update contacts;
    }
}
