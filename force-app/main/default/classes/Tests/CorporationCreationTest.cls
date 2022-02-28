@IsTest
private class CorporationCreationTest {

    @IsTest
    static void handleWithNotAssigned() {
        
        Director__c director = new Director__c(name = 'test Assigned Director');
        insert director;
        Corporation__c corp = new Corporation__c(Name = 'test Corp with director', Director__c = director.Id);
        insert corp; //нужно ли тут оборачивать старт, стоп тестами 

        Director__c directorCheck = [SELECT Is_Assigned__c FROM Director__c LIMIT 1];
        System.assertEquals(directorCheck.Is_Assigned__c, TRUE);
    }

    @IsTest(SeeAllData=true)
    static void handleWithAssigned() {
        Director__c director = [SELECT id FROM Director__c
                                WHERE Id IN (SELECT Director__c FROM Corporation__c ) LIMIT 1];
        Corporation__c corporation = new Corporation__c(Name = 'test Corp with director',
                                                        Director__c = director.Id);
        
        try {
            insert corporation;
            System.Assert(FALSE);
        } catch (Exception e){
            System.Assert(e.getMessage().contains('FIELD_CUSTOM_VALIDATION_EXCEPTION'));
        }
    }
}
