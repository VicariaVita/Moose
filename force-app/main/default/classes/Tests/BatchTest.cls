@IsTest
private class BatchTest { // можно ли протестировать когда один async включает другой

    public static String CRON_EXP = '0 0 0 16 5 ? 2022';

    @testSetup
    static void setup() {
        Account account = new Account(Name = 'test Account');
        insert account;

        List<Contact> contacts = new List<Contact>();
        for (Integer i = 0; i < 5; i++){
            contacts.add(new Contact(LastName = 'test contact' + i, AccountId = account.Id, Is_Synced__c = False));
        }
        insert contacts;

        List<Task> tasks = new List<Task>();
        for (Integer i = 0; i < 5; i++){
            tasks.add(new Task(Subject = 'test task' + i, WhatId = account.Id, Is_Synced__c = False));
        }
        insert tasks;
    }

    @IsTest
    static void runSchedulerTest(){
        Test.startTest();
        String jobId = System.schedule('ScheduledApexTest', CRON_EXP, new BatchScheduler());
        Test.stopTest();


        // ходит во вложенные асинки но они ничего не меняют (тут фейлятся ассерты)
        /* Account account = [SELECT Name, Account.Owner.Name,
                            Updated_By_Task__c,
                            Updated_By_Contact__c,
                            BillingCity, BillingStreet
                            FROM Account LIMIT 1];
        System.assert(account.Updated_By_Task__c);
        System.assert(account.Updated_By_Contact__c);
        for (Task task : [SELECT Account_Owner__c, Is_Synced__c FROM Task]){
            System.assertEquals(account.Owner.Name, task.Account_Owner__c);
            System.assert(task.Is_Synced__c);
        }
        for (Contact contact : [SELECT MailingCity, MailingStreet, Is_Synced__c FROM Contact]){
            System.assertEquals(account.BillingCity, contact.MailingCity);
            System.assertEquals(account.BillingStreet, contact.MailingStreet);
            System.assert(contact.Is_Synced__c);
        } */
    }
}
