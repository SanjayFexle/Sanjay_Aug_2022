/**
*
*  Purpose          :	Helper Class for Trigger on Class object.
*
*  Created Date     :  	Oct/13/2022
*
*  Created By       :  	Abhinav Sharma
*
*  Revision Logs    :  	V_1.0 - Created
*  Revision Logs    :  	V_1.1 - Modified - Sanjay Rawat
*
**/
public without sharing class ClassTriggerHelper 
{	//Method by Abhinav Sir
    public static void updateNoOfClassesDetails(List<Class__c> classes, Map<Id, Class__c> mapOfOldClasses) 
    {
        Set<Id> setOfParentSchools = new Set<Id>();
        for(Class__c cls : classes != null ? classes : mapOfOldClasses.values()) 
        {
            if(cls.School_Master_field__c != null) 
            {
                setOfParentSchools.add(cls.School_Master_field__c);
            }
        }
        
        if(setOfParentSchools.size() > 0) 
        {
        	CountsManager.updateNoOfClassesDetails(setOfParentSchools);   
        }
    }
    
    //Method by Sanjay Rawat
  	// When class record update with new School, all related students with that class update New School data.
    public static void updateStudentsWithSchoolName(List<Class__c> classes, Map<Id, Class__c> mapOfOldClasses){
        set<id> classIds = new set<id>();
        for(Class__c cls : classes != Null ? classes : mapOfOldClasses.values())
        {
            classIds.add(cls.Id);
        }
        
        List<Student__c> studentsList = new List<Student__c>();
        if(classIds.size()>0)
        {
            for(Student__c stu : [SELECT Id, School_Lookup__c, Class_Lookup__r.School_Master_field__c
                                  FROM Student__c 
                                  WHERE Class_Lookup__c IN : classIds])
            {
                stu.School_Lookup__c= stu.Class_Lookup__r.School_Master_field__c;
                studentsList.add(stu);  
            }
        }
        
        if(studentsList.size()>0)
        {
        	update studentsList;    
        }  
    } 
}