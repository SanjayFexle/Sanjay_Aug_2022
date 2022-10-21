/*
Purpose         :   Test Class for "SchoolTriggerHelper" apex class
Created By      :   Abhinav Sharma
Created Date    :   10/13/2022
Current Version :   v1.0
Revision Log    :   V_1.0 Created - Abhinav Sharma - 10/13/2022
Revision Log    :   V_1.0 Modified - Sanjay Rawat - ct/16/2022
*/
@isTest(seeAllData=false)
private without sharing class SchoolTriggerHelper_Test 
{  
    @testSetup 
    private static void setup() 
    {
    	TestDataFactory.createListOfStudentsCLassesSchoolsTestData();    
    }
    
    @isTest(seeAllData=false)
    private static void testNoOfClassesDetails() 
    {
        List<School__c> schools = [SELECT ID, Number_of_Classes__c, Number_of_Students__c 
                                   FROM School__c];
        System.assertEquals(5, schools.size());
        
        schools = [SELECT ID, Number_of_Classes__c  FROM School__c
                   WHERE Number_of_Classes__c = 2];
        System.assertEquals(1, schools.size());
        
        Test.startTest();
        
        schools[0].Number_of_Classes__c = 0;
        update schools;
        
        schools = [SELECT ID, Number_of_Classes__c 
                   FROM School__c
                   WHERE Number_of_Classes__c = 2
                  ];
        System.assertEquals(1, schools.size());
        Test.stopTest();
    }
    
    @isTest(seeAllData=false)
    static void testNoOfStudentDetails() 
    {
        List<School__c> schools = [SELECT ID, Number_of_Classes__c, Number_of_Students__c 
                                   FROM School__c];
        System.assertEquals(5, schools.size());
         
        schools = [SELECT ID, Number_of_Students__c,(Select Id From Students__r) FROM School__c
                   WHERE Id!=Null Limit 1 ];
        
        //System.assertEquals(1, schools.size());
        System.assertEquals(5, schools[0].Students__r.size());
        
		Test.startTest();
        
        schools[0].Number_of_Students__c = 0;
        update schools;
        
        schools = [SELECT ID, Number_of_Students__c 
                   FROM School__c
                   WHERE Number_of_Students__c = 5
                  ];
        System.assertEquals(1, schools.size());

        Test.stopTest();        
    }
}