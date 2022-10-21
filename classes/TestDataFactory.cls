/*
 * Purpose         :   Test TestDataFactory for Schools-Classes-Students Data 
 * 
 * Created Date    :   Oct/16/2022
 * 
 * Created By       :  	Sanjay Rawat
 * 
 * Current Version :   v1.0
*/


@isTest(seeAllData=False)
Public without sharing class TestDataFactory {
    /*
     * public static final String OBJECT_NAME_SCHOOL = 'School__c';
     * public static final String OBJECT_NAME_CLASS = 'Class__c';
     * public static final String OBJECT_NAME_STUDENT = 'Student__c';
*/
	@testSetup    
    Public static void createListOfStudentsCLassesSchoolsTestData()
    {	List<School__c> schoolsList = (List<School__c>)SmartFactory.createSObjectList(Constants.OBJECT_NAME_SCHOOL, false, 5);
        insert schoolsList;
     
     	List<Class__c> classesList = (List<Class__c>)SmartFactory.createSObjectList(Constants.OBJECT_NAME_CLASS, false, 5);
     	integer count =0;
         for(class__c cls : classesList )
         {
             if(count!=0 && count!=1 )
             {
                 cls.School_Master_field__c=schoolsList[1].Id;
             }else
             {
				cls.School_Master_field__c=schoolsList[0].Id;                 
             }
             count++;
         }
     	insert classesList;
     
    	List<Student__c> studentsList = (List<Student__c>)SmartFactory.createSObjectList(Constants.OBJECT_NAME_STUDENT, false, 5);
     	integer studentCounter = 0;
         for(Student__c stu : studentsList)
         {
             if(studentCounter!=0 && studentCounter!=1 )
             {
                stu.Class_Lookup__c=classesList[1].Id;
             }else
             {
				stu.Class_Lookup__c=classesList[0].Id;                 
             }
             studentCounter++;
         }
        insert studentsList; 
     
    }
    
    @isTest(seeAllData=False)
    private static void TestData_Test()
    {	//TestDataFactory data double check
        List<School__c> schools = [SELECT ID from School__c WHERE id!=Null];
        System.assertEquals(5, schools.size());
        
        List<Class__c> cls = [SELECT ID from Class__c WHERE id!=Null];
        System.assertEquals(5, cls.size());
        
        
        List<Student__c> students = [SELECT ID from Student__c WHERE id!=Null];
        System.assertEquals(5, students.size());
    }

}