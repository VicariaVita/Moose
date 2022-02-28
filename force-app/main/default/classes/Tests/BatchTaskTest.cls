@IsTest
private class BatchTaskTest {

    @testSetup
    static void setup() {

        Profile profile = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        User user = new User(Alias = 'mausUser', Email='newuser@testorg.com',
           EmailEncodingKey='UTF-8', LastName='mausUser', LanguageLocaleKey='en_US',
           LocaleSidKey='en_US', ProfileId = profile.Id,
           TimeZoneSidKey='America/Los_Angeles', UserName='mausUser@testorg.com');
        
        System.runAs(user) {
            Account account = new Account(Name = 'test Account');
            insert account;
            List<Task> tasks = new List<Task>();
            for (Integer i = 0; i < 5; i++){
                tasks.add(new Task(Subject = 'test task' + i, WhatId = account.Id, Is_Synced__c = False));
            }
            insert tasks;
        }
    }

    @IsTest
    static void runBatchTaskTest(){
        
        Test.startTest();
        Database.executeBatch(new BatchTask());
        Test.stopTest();

        Account account = [SELECT Updated_By_Task__c, Account.Owner.Name FROM Account LIMIT 1];
        System.assert(account.Updated_By_Task__c);
        for (Task task : [SELECT Account_Owner__c, Is_Synced__c FROM Task]){
            System.assertEquals(account.Owner.Name, task.Account_Owner__c);
            System.assert(task.Is_Synced__c);
        }
    }
}
