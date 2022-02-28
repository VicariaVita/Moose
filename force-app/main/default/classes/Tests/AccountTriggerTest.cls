@IsTest
private class AccountTriggerTest {
    
    @testSetup
    static void setup() {
        Account account = new Account(Name = 'test Account', BillingStreet = 'this street');        
        insert account;
        Contact contact = new Contact(LastName = 'test Contact', AccountId = account.Id);
        insert contact;
        
        account.BillingStreet = 'that street';
    }

    @IsTest
    static void createAccountChangeAdress() {
        
        Test.startTest();
        update account;
        Test.stopTest();

        contact = [SELECT Is_Synced__c, Processed_By_Queue__c FROM Contact WHERE Id = :contact.Id];
        System.assertEquals(contact.Processed_By_Queue__c, TRUE);
        System.assertEquals(contact.Is_Synced__c, FALSE);
    }
}
