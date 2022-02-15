public with sharing class AccountUpdateUser {

  @InvocableMethod(label='Random New Task User of Account')
  public static void updateUserTask(List<Account> accounts) {
    
    List<Task> tasksToUpdate = new List<Task>();

    Set<Id> ids = new Set<Id>(new Map<Id, Account>(accounts).keySet());

    Task[] tskNewArray = [SELECT Id, WhatId FROM Task WHERE WhatId IN : ids];

    Map<Id, List<Task>> taskMap = new Map<Id, List<Task>>();
    for (Task task : tskNewArray){
      if (taskMap.containsKey(task.WhatId)){
        taskMap.get(task.WhatId).add(task);
      } else {
        taskMap.put(task.WhatId, new List<Task>{task});
      }
    }

    for (Id id : taskMap.keySet()){
      if (taskMap.get(id).size() > 3) {
        putRandomUser(taskMap.get(Id));
        tasksToUpdate.addAll(taskMap.get(Id));
      }
    }

    if (tasksToUpdate != null) {
      update tasksToUpdate;
    }
  }


  private static List<Task> putRandomUser(List<Task> tasks){
    Integer count = [SELECT COUNT() FROM User WHERE Isactive = TRUE];
    Integer rand = Math.floor(Math.random() * count).intValue();
    User randUser = [SELECT Name FROM User
      WHERE Isactive = TRUE LIMIT 1 OFFSET :rand];

    for (Task curTask : tasks) {
      curTask.OwnerId = randUser.Id;
    }
    return tasks;
  }
}