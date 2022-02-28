@IsTest
private class BatchContactTest {

    @testSetup
    static void setup() {

        Account account = new Account(Name = 'test Account',
                                    BillingStreet = 'test Street',
                                    BillingCity = 'test City');
        insert account;
        List<Contact> contacts = new List<Contact>();
        for (Integer i = 0; i < 5; i++){
            contacts.add(new Contact(LastName = 'test contact' + i, AccountId = account.Id, Is_Synced__c = False));
        }
        insert contacts;
    }

    @IsTest
    static void runBatchContactTest(){
        
        Test.startTest();
        Database.executeBatch(new BatchContact());
        Test.stopTest();

        Account account = [SELECT Updated_By_Contact__c, BillingCity, BillingStreet FROM Account LIMIT 1];
        System.assert(account.Updated_By_Contact__c);
        for (Contact contact : [SELECT MailingCity, MailingStreet, Is_Synced__c FROM Contact]){
            System.assertEquals(account.BillingCity, contact.MailingCity);
            System.assertEquals(account.BillingStreet, contact.MailingStreet);
            System.assert(contact.Is_Synced__c);

            //проверяется норм только если оба нули
            //System.assertEquals(account.BillingAddress, contact.MailingAddress);
            //тут ругается
            //System.assertEquals(account.BillingAddress.city, contact.MailingAddress.city);
        }
    }
}
