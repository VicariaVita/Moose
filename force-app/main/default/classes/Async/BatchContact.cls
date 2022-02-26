public with sharing class BatchContact implements Database.Batchable<Contact> {

    //'SELECT Contact.Account.BillingAddress, Contact.Account.Id FROM Contact WHERE Is_Synced__c = false'


    public Iterable<Contact> start(Database.BatchableContext bc){
        return new ContactIterable();
    }

    public void execute(Database.BatchableContext bc, List<Contact> contacts){

        Set<Account> accounts = new Set<Account>();

        for (Contact current : contacts){
            current.MailingStreet = current.Account.BillingStreet;
            current.MailingCity = current.Account.BillingCity;
            current.MailingState = current.Account.BillingState;
            current.MailingPostalCode = current.Account.BillingPostalCode;
            current.MailingCountry = current.Account.BillingCountry;
            current.Is_Synced__c = TRUE;
            
            current.Account.Updated_By_Contact__c = true;
            accounts.add(current.Account);
        }
        update contacts;
        update new List<Account>(accounts);
    }

    public void finish(Database.BatchableContext bc){
        System.debug('contact batch finished');
    }
}
