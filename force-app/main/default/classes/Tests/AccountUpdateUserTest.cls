@IsTest
private class AccountUpdateUserTest {

    @IsTest
    static void newUserAssignmentTest() {
        List<Task> testTasks = new List<Task>();
        Account account = new Account(Name = 'test Account');
        insert account;
        for(Integer i = 0; i < 4; i++) {
            testTasks.add(new Task(Subject = 'test Task', WhatId = account.Id));
        }
        insert testTasks;

        Test.startTest();
        AccountUpdateUser.updateUserTask(new List<Account>{account});
        Test.stopTest();

        List<Task> checkTasks = [SELECT OwnerId FROM Task];
        for(Task task : checkTasks) {
            System.assertEquals(checkTasks[0].OwnerId, Task.OwnerId);
        }
    }
}
