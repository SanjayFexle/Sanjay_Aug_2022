/*
 * Purpose         :   Test Class for "ClassTriggerHelper" apex class
 * 
 * Created By      :   Sanjay Rawat
 * 
 * Created Date    :   Oct/16/2022
 * 
 * Current Version :   v1.0
 *  
*/


@isTest(seeAllData=False)
private without sharing class ClassTriggerHelper_Test {
	@testSetup    
    private static void updateClassData()
    {	
        TestDataFactory.createListOfStudentsCLassesSchoolsTestData();
     
     // Existing class school field is updating here
     List<Class__c> clsSchoolUpdated = new List<Class__c>();
        
     List<School__c> sch = [SELECT Id FROM School__c  WHERE Id!=Null LIMIT 1 OFFSET 1]; 
     
	 for(Class__c  cls : [SELECT Id ,School_Master_field__c, (SELECT ID FROM Students__r ) FROM Class__c ])
     {
        
         if(cls.Students__r.size()==2)
         {
              cls.School_Master_field__c=sch[0].Id;
              clsSchoolUpdated.add(cls);
         }
     }
     
     Update clsSchoolUpdated;
     //System.debug('#####'+clsSchoolUpdated);
    }
    
    @isTest(seeAllData=False)
    private static void TestData_Test()
    {	//TestDataFactory data double check
        Test.startTest();
        List<School__c> schools = [SELECT ID from School__c WHERE id!=Null];
        System.assertEquals(5, schools.size());
        
        List<Class__c> cls = [SELECT ID from Class__c WHERE id!=Null];
        System.assertEquals(5, cls.size());
        
        
        List<Student__c> students = [SELECT ID from Student__c WHERE id!=Null];
        System.assertEquals(5, students.size());
        Test.stopTest();
    }
    
    @isTest(seeAllData=False)
    private static void updateStudentsWithSchoolName_Test()
    {	// here we are checking after changing school in class Record ...All students record trnasfer to new school or not.
        Test.startTest();
        Integer numberOfStudents ;
		For(School__c clsCheckNumberOfStudent : [SELECT ID , (SELECT ID FROM Students__r ) 
                                             FROM School__c 
                                             WHERE id!=Null Limit 1 OFFSET 1 ]){
                        numberOfStudents = clsCheckNumberOfStudent.Students__r.size();
                                             }
        System.assertEquals(2,numberOfStudents);
        Test.stopTest();
    }


}