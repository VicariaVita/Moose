public with sharing class AccountTriggerHandler{

    public static void afterUpdate(Account[] newList, Map<Id,Account> newMap, Account[] oldList, Map<Id,Account> oldMap){
        
        Set<Id> accountIds = new Set<Id>();

        for(Id accountId : newMap.keySet() ){
            if (oldMap.get(accountId).BillingStreet != newMap.get(accountId).BillingStreet){
                accountIds.add(accountId);
            }
        }
        
        if (!accountIds.isEmpty()){
            //futureContactUpdate(accountIds);

            List<Contact> contactsToUpdate = [SELECT Id FROM Contact WHERE Contact.AccountId IN : accountIds];
            System.enqueueJob(new AccountQueue(contactsToUpdate));

        }
    }

    @future
    public static void futureContactUpdate(Set<Id> accountIds){
        Contact[] contacts = [SELECT Id FROM Contact WHERE Contact.AccountId IN :accountIds]; // двоеточие слитно!

        for (Contact current : contacts){
            current.Is_Synced__c = false;
            current.Processed_By_Future__c = true;
        }
        update contacts;

    }
}
