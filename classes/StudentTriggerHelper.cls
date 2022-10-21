/**
*
*  Purpose          :	Helper Class for Trigger on Student object.
*
*  Created Date     :  	09/30/2022
*
*  Created By       :  	Abhinav Sharma
*
*  Revision Logs    :  	V_1.0 - Created
*
**/

public without sharing class StudentTriggerHelper 
{
    //Method by Abhinav sir
    public static void updateNoOfStudentsDetails(List<Student__c> students, Map<Id, Student__c> mapOfOldStudents) 
    {
        Set<Id> setOfParentSchools = new Set<Id>();
        for(Student__c std : students != null ? students : mapOfOldStudents.values()) 
        {
            if(std.School_Lookup__c != null) 
            {
                setOfParentSchools.add(std.School_Lookup__c);
            }
        }
        
        if(setOfParentSchools.size() > 0) 
        {
            //An additional query because trigger.new is a read only collection in case of after event
            Map<Id, School__c> mapOfSchools = new Map<Id, School__c>();
            for(School__c sch : [SELECT ID, Number_of_Students__c 
                                 FROM School__c
                                 WHERE ID IN : setOfParentSchools
                                ]) 
            {
                mapOfSchools.put(sch.Id, sch);
            }
            if(mapOfSchools.values().size() > 0) 
            {
                CountsManager.doCalculationForNoOfStudents(mapOfSchools);        
            }
        }
    }
    
    //Method by Sanjay Rawat 
    //this Method will call when new Student is created and class is also mention Accoording to class School field will popolate.    
    public static void newStudentInsertSchoolWillUpdateIfClassMention(List<Student__c> newStudentsList)
    {
        System.debug(newStudentsList);
        Set<Id> clsIds = new  Set<Id>();
        if(newStudentsList!=Null && newStudentsList.size()>0)
        {
            for(Student__c stu : newStudentsList)
            {    
                if(stu.Class_Lookup__c!=Null)
                {
                    clsIds.add(stu.Class_Lookup__c);
                }
             }
        }
        
        List<Class__c> clsList = [SELECT ID,School_Master_field__c FROM Class__c WHERE ID In : clsIds];
        
        if(clsList.size()>0)
        {
            for(Class__c cls : clsList)
            {
                for(Student__c stu : newStudentsList)
                {
                    if(stu.Class_Lookup__c==cls.Id)
                    {
                    	stu.School_Lookup__c=cls.School_Master_field__c;    
                    }
                }
            }
        }
    }
    	
    //Method by Sanjay Rawat  
    //this Method will call when Student class is updated by new class and Accoording to new class School field will popolate.    
    public static void studentUpdateSchoolFieldAsPerClass (List<Student__c> newStudentsList, Map<Id, Student__c> mapOfOldStudents){
        
    Set<Id> clsId = new Set<Id>();
        if(newStudentsList!=Null && mapOfOldStudents!=Null)
        {
            for(Student__c stu : newStudentsList){            
        // if(stu.Class_Lookup__c!=Null && (mapOfOldStudents == Null) || (mapOfOldStudents != Null && stu.Class_Lookup__c != mapOfOldStudents.get(stu.id).Class_Lookup__c)){
           if(stu.Class_Lookup__c!=Null && stu.Class_Lookup__c!=mapOfOldStudents.get(stu.Id).Class_Lookup__c){         
                    clsId.add(stu.Class_Lookup__c);
                }
            }    
        }
        Map<Id,Class__c> clsMap = new  Map<Id,Class__c>([Select ID , Name ,School_Master_field__c FROM CLass__c WHERE Id in : clsid]);
        /*    
        Map<Id,Class__c> clsMap = new  Map<Id,Class__c>();
        if(clsId!=null)
        {
        	for(Class__c cls : [Select ID , Name ,School_Master_field__c FROM CLass__c WHERE Id in : clsid])
            {
                clsMap.put(cls.Id,cls);
            }
        }
        */
        if(clsMap.size()>0)
        {
            for(Student__c stu : newStudentsList)
            {
		        if(clsMap.containsKey(stu.Class_Lookup__c)) //new student ABC class ==  ABC class - ABC school
                {
               		stu.School_Lookup__c=clsMap.get(stu.Class_Lookup__c).School_Master_field__c;
                }
            }
        }    
    }
    
    /*
	//this Method will call when new Student is created and class is also mention Accoording to class School field will popolate.But work in After case    
    public static void updateClassWhenStudentIsInsertInAfterCase(List<Student__c> students){
        Set<Id> studentsId = new  Set<Id>();
        if(students.size()>0 ){
            for(Student__c stu : students){    
            	studentsId.add(stu.Id);
             }
        }
        List<Student__c> studentList = new List<Student__c>();
        if(studentsId.size()>0){
            for(Student__c stu : [SELECT Id,Class_Lookup__c,Class_Lookup__r.School_Master_field__c 
                                  FROM Student__c 
                                  WHERE ID IN : studentsId])
            {	
                stu.School_Lookup__c=stu.Class_Lookup__r.School_Master_field__c;
                studentList.add(stu);
            }
        }
        if(studentList.size()>0){
        	update studentList;    
        }
    }
    */
    
    //Method by Sanjay Rawat 
    //if student name and father name is same than duplicalate error show
    public static void duplicateStudentRecordCheckByStudentNameAndFatherName(List<Student__c> newStudentsList,Map<Id, Student__c> mapOfOldStudents)
    {
    	Map<Id,Student__c> mapOfNewStudentsRecordWithId = new Map<Id,Student__c>();
        if(newStudentsList!=Null || mapOfOldStudents!=Null )
        {
            for(Student__c stu : newStudentsList)
            {
                if(stu.Name!=Null && stu.Father_Name__c!=Null || 
                   (stu.Name!=mapOfOldStudents.get(stu.Id).Name || stu.Father_Name__c!=mapOfOldStudents.get(stu.Id).Father_Name__c )){
                	mapOfNewStudentsRecordWithId.put(stu.Id,stu);    
                }
            }
        }
		
        if(mapOfNewStudentsRecordWithId.size()>0)
        {
            for(Student__c checkStu : mapOfNewStudentsRecordWithId.values())
            {
                integer checkDuplicate = [Select Count() From Student__c WHERE (Name =: checkStu.Name AND Father_Name__c=: checkStu.Father_Name__c) ];
                if(checkDuplicate>0)
                {
                    checkStu.addError('Duplicate record found cannot save this record because same Student Name and Father Name Record Found');
                	
            	}
            }
        }        
    }
   
}