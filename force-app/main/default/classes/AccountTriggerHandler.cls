public with sharing class AccountTriggerHandler{

    public static void afterInsert(List<Account> accounts){
        //System.enqueueJob(new AccountQueueCallout(accounts)); // вопрос

        Set<Id> ids = new Set<Id>(new Map<Id, Account>(accounts).keySet());
        futureCallout(ids);
    }

    public static void afterUpdate(Map<Id,Account> newMap, Map<Id,Account> oldMap){
        
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
        Contact[] contacts = [SELECT Id FROM Contact WHERE Contact.AccountId IN :accountIds];

        for (Contact current : contacts){
            current.Is_Synced__c = false;
            current.Processed_By_Future__c = true;
        }
        update contacts;

    }

    @future (callout = true)
    public static void futureCallout(Set<Id> accountIds){
        List<Account> accountsNew = [SELECT Id, Name FROM Account WHERE Id IN :accountIds];
        for (Account account : accountsNew){
            Account toGo = account.clone();
            String id = AccountCallouts.createAccount(toGo).getBody();
            account.InregrationId__c = id;
        }
        update accountsNew;
    }
}
