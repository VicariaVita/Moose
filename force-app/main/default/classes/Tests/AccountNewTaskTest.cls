@IsTest
private class AccountNewTaskTest {

    @IsTest
    static void newTaskCreationTest() {
        Account account = new Account(name = 'test Acc');
        insert account;

        Test.startTest();
        AccountNewTask.newAccountTask(new List<Account>{account});
        Test.stopTest();

        Task task = [SELECT Subject FROM Task WHERE WhatId = :account.Id];
        System.assertEquals('Negotiations with test Acc', task.Subject);
    }
}
