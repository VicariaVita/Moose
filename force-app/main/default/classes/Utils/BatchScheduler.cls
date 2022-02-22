public with sharing class BatchScheduler implements Schedulable {
    public void execute(SchedulableContext ctx) {
        
        Database.executeBatch(new BatchTask());

        Database.executeBatch(new BatchContact());

    }

    private void testingScheduler(){
        BatchScheduler scheduler = new BatchScheduler();

        String cycle = '0 30 * * * ?'; // every half - hour!!
        //String cycle = '0 0 22 ? * 6L'; // last Friday of every month at 10 PM.

        System.schedule('Schedule contact & task batches', cycle, scheduler);
    }
}