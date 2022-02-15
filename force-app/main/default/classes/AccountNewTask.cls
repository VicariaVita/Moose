public with sharing class AccountNewTask {
  
  @InvocableMethod(label='Task for new Account')
  public static void newAccountTask(List<Account> accounts) {
    
    Task[] tasks = new List<Task>();

    for (Account account : accounts){
      tasks.add(new Task(
        subject = 'Negotiations with ' + account.Name,
        whatId = account.Id
      ));
    }
    insert tasks;
  }
}