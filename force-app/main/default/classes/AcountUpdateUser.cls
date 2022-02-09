public with sharing class AcountUpdateUser {
  @InvocableMethod(label='New Task User Account')
  public static void updateUserTask(List<Account> acc) {
    Task[] tskArray = [SELECT Id FROM Task WHERE WhatId = :acc[0].Id];
    if (tskArray.size() > 3) {

      Integer count = [SELECT COUNT() FROM User WHERE Isactive = TRUE];
      Integer rand = Math.floor(Math.random() * count).intValue();
      User randUser = [SELECT Name FROM User WHERE Isactive = TRUE LIMIT 1 OFFSET :rand];

      for (Task curTask : tskArray) {
        curTask.OwnerId = randUser.Id;
      }
      
      update tskArray;
    }
  }
}
