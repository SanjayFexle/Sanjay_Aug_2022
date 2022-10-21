@isTest
private class CountManager_Test {

    @testsetup static void testData(){
        List<School__c> schoolsList = new List<School__c>();
        School__c sch = new School__c(Name='Test1');
        schoolsList.add(sch);
        School__c sch2 = new School__c(Name='Test2');
        schoolsList.add(sch2);
        insert schoolsList;
        
        List<Class__c> ClassesList = new List<Class__c>();
        Class__c cls = new Class__c(Name='Test Class 1',School_Master_field__c=sch.id);
        ClassesList.add(cls);
        Class__c cls2 = new Class__c(Name='Test Class 2',School_Master_field__c=sch.id);
        ClassesList.add(cls2);
        insert ClassesList;
        
		List<Student__c> StudentsList = new List<Student__c>();
        Student__c stu = new Student__c(School_Lookup__c=sch.Id,Name='Test Student',Class_Lookup__c=cls.Id);
        StudentsList.add(stu);
        Student__c stu2 = new Student__c(School_Lookup__c=sch.Id,Name='Test Student2',Class_Lookup__c=cls.Id);
        StudentsList.add(stu2);
        Student__c stu3 = new Student__c(School_Lookup__c=sch.Id,Name='Test Student3',Class_Lookup__c=cls2.Id);
        StudentsList.add(stu3);
        Insert StudentsList;
    }
    
    @istest static void check1(){
        Test.startTest();
        CountManager.updateNumberOfStudentsDetails('Test1');
        Test.stopTest();
        
        School__c numberOfStudents = [Select Number_of_Students__c  FROM School__c WHERE Name=:'Test1']; 
        System.assertEquals(3,numberOfStudents.Number_of_Students__c);      
        
		
    }
    
	@istest static void check1_2(){
        
        Test.startTest();
        CountManager.updateNumberOfStudentsDetails('Test2');
        Test.stopTest();
        
        School__c numberOfStudents = [Select Number_of_Students__c  FROM School__c WHERE Name=:'Test2']; 
        System.assertEquals(Null,numberOfStudents.Number_of_Students__c);      
		
    }
        
    @istest static void check2(){
        
        School__c schoolId = [Select Id  FROM School__c WHERE Name=:'Test2']; 
        
        Test.startTest();
        CountManager.StudentDetailsUpdateWithAggregrateQueryV5(schoolId.Id);        
        Test.stopTest();    

        School__c numberOfStudents = [Select Number_of_Students__c  FROM School__c WHERE Name=:'Test2']; 

        System.assertEquals( 0, numberOfStudents.Number_of_Students__c);

    }
    
    
    
    @istest static void check2_1(){
        //Best practise by Dhruv sir 
        School__c schoolId2 = [Select Id,Number_of_Students__c  FROM School__c WHERE Name=:'Test1']; 
		
        Test.startTest();
        CountManager.StudentDetailsUpdateWithAggregrateQueryV5(schoolId2.Id); 
        Test.stopTest();
        
        School__c numberOfStudents2 = [Select Number_of_Students__c  FROM School__c WHERE Name=:'Test1']; 
        System.assertEquals(3, numberOfStudents2.Number_of_Students__c);
        
    }
    
    @istest static void check3(){
        
        School__c schoolDetails = [Select ID FROM School__c WHERE Name=:'Test1']; 
        
        Test.startTest();
        CountManager.updateNumberOfClassDetails(schoolDetails.Id);
        Test.stopTest();
        
        School__c numberOfClasses = [Select Number_of_classes__c  FROM School__c WHERE Name=:'Test1']; 
        System.assertEquals(2, numberOfClasses.Number_of_classes__c);      

    }
    
    @istest static void check4(){
        
        Test.startTest();
        CountManager.updateNumberOfStudentsDetailsV2('Test1');
        Test.stopTest();
        
        School__c numberOfStudents = [Select Number_of_Students__c  FROM School__c WHERE Name=:'Test1']; 
        System.assertEquals(3, numberOfStudents.Number_of_Students__c);      

    }
    
    @istest static void check4_2(){
        Test.startTest();
        CountManager.updateNumberOfStudentsDetailsV2('Test2');        
        Test.stopTest();
        
        School__c numberOfStudents = [Select Number_of_Students__c  FROM School__c WHERE Name=:'Test2']; 
        System.assertEquals(0, numberOfStudents.Number_of_Students__c);      

        
    }
    
    @istest static void check5(){
        School__c schoolDetails = [Select ID FROM School__c WHERE Name=:'Test1']; 
        
        Test.startTest();
        CountManager.updateNumberOfClassDetailsV3(schoolDetails.Id);
        Test.stopTest();
        
        School__c numberOfClasses = [Select Number_of_classes__c  FROM School__c WHERE Name=:'Test1']; 
        System.assertEquals(2, numberOfClasses.Number_of_classes__c);      
    }
    
    
    
    @istest static void check5_2(){
        School__c schoolDetails = [Select ID FROM School__c WHERE Name=:'Test2']; 

        Test.startTest();
        CountManager.updateNumberOfClassDetailsV3(schoolDetails.Id);
        Test.stopTest();
        
        School__c numberOfClasses = [Select Number_of_classes__c  FROM School__c WHERE Name=:'Test2']; 
        System.assertEquals(0, numberOfClasses.Number_of_classes__c);      

    }
    
    @istest static void check6(){
        Test.startTest();
        CountManager.updateNumberOfStudentsDetailsv4('Test1'); //numberOfStudent = 3 
        Test.stopTest();
        
        School__c numberOfStudents = [Select Number_of_Students__c  FROM School__c WHERE Name=:'Test1']; 
        System.assertEquals(3,numberOfStudents.Number_of_Students__c);      	
    }   
}