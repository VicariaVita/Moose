public with sharing class SingletonHandler {
    private static SingletonHandler instance;
    private static Boolean isInstantiated = false;
    //public List<Corporation__c> corps;

    //public void setCorps(List<Corporation__c> input){this.corps = input;}

    public static SingletonHandler getInstance(List<Corporation__c> corps) {
        if (instance == null && !isInstantiated) {
            System.debug('creating NEW instance');
            instance = new SingletonHandler(corps);
            //isInstantiated = true; //this doesn't do anything
        }
        System.debug(instance + ' ' + isInstantiated);
        return instance;
    }

    private SingletonHandler(List<Corporation__c> corps) {
        Director__c[] assignedDirectors =
            [SELECT Id FROM Director__c
            WHERE Id IN (SELECT Director__c FROM Corporation__c)
        ];

        for (Corporation__c corp : corps){
            for (Director__c director : assignedDirectors){
                if (corp.Director__c == director.Id){
                    System.debug('reached error');
                    corp.addError('This director already assigned to other Corp');
                }
            }
            Director__c director = new Director__c(Id = corp.Director__c, Is_Assigned__c = true);
            System.debug('singleton about to update director');
            isInstantiated = true; // GAME CHANGER
            update director;
        }
        //вызвать тут гетинстанс
    }
}
