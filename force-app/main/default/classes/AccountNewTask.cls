public with sharing class AccountNewTask {
  
  @InvocableMethod(label='Task for new Account')
  public static void newAccountTask(List<Account> acc) {
    insert new Task(
      subject = 'Negotiations with ' + acc[0].Name, whatId = acc[0].Id);
  }
}
