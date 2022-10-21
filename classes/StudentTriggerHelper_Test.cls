/*
 * Purpose         :   Test Class for "StudentTriggerHelper" apex class 
 * 
 * Created Date    :   Oct/16/2022
 * 
 * Created By       :  	Sanjay Rawat
 * 
 * Current Version :   v1.0
*/

@isTest(seeAllData=False)
private without sharing class StudentTriggerHelper_Test {
    @testSetup 
    private static void TestData(){
        TestDataFactory.createListOfStudentsCLassesSchoolsTestData();
        
        List<Student__c> studenstList = new List<Student__c>();
        
        //new Student insert in School 3 
        for(Class__c cls : [SELECT Id FROM Class__c 
                            WHERE Id!=Null LIMIT 1 OFFSET 2])
        {
        	Student__c stu = new Student__c();
            stu.Name='Sanjay';
            stu.Class_Lookup__c=cls.Id;
            studenstList.add(stu);
        }            
        Insert studenstList;
        System.debug('#####'+studenstList);
        
        
        //Existing student classUpdate
        List<Student__c> studenstList2 = new List<Student__c>();
        List<Class__c> clsList = new List<Class__c>();
        
        for(Class__c cls : [Select ID , Name ,School_Master_field__c 
                            FROM CLass__c WHERE Id!=Null Limit 1])
        {
            clsList.add(cls);
        }
        for(Student__c studentFind : [SELECT Id,Name,Class_Lookup__c FROM Student__c 
                            WHERE Name!=Null LIMIT 1 OFFSET 3])
        {
            System.debug('#####'+studentFind.Name);
            studentFind.Class_Lookup__c= clsList[0].Id;
            studenstList2.add(studentFind);
        }
        Update studenstList2; 
    }
    
    @isTest(seeAllData=False)
    private static void newStudentInsertSchoolWillUpdateIfClassMention_Test()
    {	
        Test.startTest();
        String sName = 'Sanjay';
     	String checkName;
     	
        for(School__c  schData : [SELECT ID ,(SELECT ID,Name FROM Students__r ) FROM School__c] )
        {
            if(schData.Students__r.size()==1)
            {	
               checkName=  schData.Students__r[0].Name ;
            }
        }
     	System.assertEquals(sName, checkName);
        Test.stopTest();
    }
    
    @isTest(seeAllData=False)
    private static void studentUpdateSchoolFieldAsPerClass_Test()
    {	
        Test.startTest();
        Integer numberOfStudents ;
		For(class__c clsCheckNumberOfStudent : [Select ID , (Select ID FROM Students__r ) 
                                             FROM Class__c 
                                             WHERE id!=Null LIMIT 1])
        {
          numberOfStudents = clsCheckNumberOfStudent.Students__r.size();
        }
        
        System.assertEquals(3,numberOfStudents);
        Test.stopTest();
        /*
        for(Class__c cls : [Select ID , Name ,School_Master_field__c ,(Select ID From Students__r)
                            FROM CLass__c WHERE Id!=Null ])
        {
            System.debug('#####'+cls.Students__r.size());
        }
    	*/
    }
    
    @isTest(seeAllData=False)
    private static void updateNoOfStudentsDetails_Test()
    {	
        Test.startTest();
        List<School__c> sch = [Select Id , Number_of_Students__c FROM School__c LIMIT 3];
        System.assertEquals(5,sch[0].Number_of_Students__c);
        System.assertEquals(1,sch[1].Number_of_Students__c);
        System.assertEquals(0,sch[2].Number_of_Students__c);
     	Test.stopTest();
    }
}