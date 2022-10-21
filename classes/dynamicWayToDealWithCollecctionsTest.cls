/*
 * CreatedBy : Sanjay Rawat
 * CreatedDate : Sep/29/2022
 * Description : Test class for check dynamic way to populate in collection
 * Version : dynamicWayToDealWithCollecctionsTest

*/

@isTest
public class dynamicWayToDealWithCollecctionsTest {
	@testSetup
    static void data(){
        School__c schData = new School__c(Name='Test School');
        insert schData;
        
        Class__c classData = new Class__c(Name='Test Class',School_Master_field__c=schData.id);
        insert classData;
		
        Student__c studentData = new Student__c (Name='Test1',School_Lookup__c=schData.Id,Class_Lookup__c=classData.Id);
    	insert studentData;
        
        Student__c studentData2 = new Student__c (Name='Test2',School_Lookup__c=schData.Id,Class_Lookup__c=classData.Id);
        insert studentData2;
        
        Class__c class2 = new Class__c(Name='Test Class 2',School_Master_field__c=schData.id);
        insert class2;
                
        Student__c studentData3 = new Student__c (Name='Test3',School_Lookup__c=schData.Id,Class_Lookup__c=class2.Id);
       	insert studentData3;
        
        
        School__c schData2 = new School__c(Name='Test School 2');
        insert schData2;
        
        Class__c classData2 = new Class__c(Name='Test Class11',School_Master_field__c=schData2.id);
        insert classData2;
		
        Student__c studentData12 = new Student__c (Name='Test 11',School_Lookup__c=schData2.Id,Class_Lookup__c=classData2.Id);
    	insert studentData12;
        
        Student__c studentData13 = new Student__c (Name='Test 12 ',School_Lookup__c=schData2.Id,Class_Lookup__c=classData2.Id);
        insert studentData13;
        
        Student__c studentData14 = new Student__c (Name='Test 13',School_Lookup__c=schData2.Id,Class_Lookup__c=classData2.Id);
       	insert studentData14;
    }
    @istest
    static void check1(){
        Test.startTest();
        
        Map<String,Map<String,List<Student__c>>> mainMap = dynamicWayToDealWithCollecctions.method1();
            
        System.assertEquals('Test1', mainMap.get('Test School').get('Test Class')[0].Name);
		System.assertEquals('Test2', mainMap.get('Test School').get('Test Class')[1].Name);
		System.assertEquals('Test3', mainMap.get('Test School').get('Test Class 2')[0].Name);
        System.assertEquals('Test3', mainMap.get('Test School').get('Test Class 2')[0].Name);
		
        System.assertEquals('Test 11', mainMap.get('Test School 2').get('Test Class11')[0].Name);
		System.assertEquals('Test 12', mainMap.get('Test School 2').get('Test Class11')[1].Name);
		System.assertEquals('Test 13', mainMap.get('Test School 2').get('Test Class11')[2].Name);
        
        Test.stopTest();
    }
}