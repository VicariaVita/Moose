public with sharing class SingletonHandler {
    private static Boolean isInstantiated = false;

    public SingletonHandler(List<Corporation__c> corps) {
        if (isInstantiated) return;
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
    }
}
