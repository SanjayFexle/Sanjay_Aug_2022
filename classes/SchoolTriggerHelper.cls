/**
*
*  Purpose          :	Helper Class for Trigger on School object.
*
*  Created Date     :  	Oct/12/2022
*
*  Created By       :  	Sanjay Rawat
*
*  Revision Logs    :  	V_1.0 - Created
*
**/
public without sharing class SchoolTriggerHelper 
{
    
    public static void updateNoOfClassesDetailsInBeforeCase(List<School__c> schools, Map<Id, School__c> mapOfOldSchools) 
    {
        Set<Id> setOfSchoolsIds = new Set<Id>();
        for(School__c sch : schools)
        {
            setOfSchoolsIds.add(sch.Id);
        }
        if(setOfSchoolsIds.size() > 0) 
        {
            //Map to hold the school record Id as a key and then upto recalcualted no of classes counts as value
            Map<Id, Integer> mapOfSchooldIdWithNoOfClassesCounts = new Map<Id, Integer>();
            
            for(Class__c cls : [SELECT Id, School_Master_field__c 
                                FROM Class__c 
                                WHERE School_Master_field__c IN : setOfSchoolsIds])
            {
                System.debug(cls);
                
                if(!mapOfSchooldIdWithNoOfClassesCounts.containsKey(cls.School_Master_field__c)) 
                {
                    mapOfSchooldIdWithNoOfClassesCounts.put(cls.School_Master_field__c, 1);
                }
                else 
                {
                    mapOfSchooldIdWithNoOfClassesCounts.put(cls.School_Master_field__c, (mapOfSchooldIdWithNoOfClassesCounts.get(cls.School_Master_field__c) + 1));
                }
            }
            //System.debug(mapOfSchooldIdWithNoOfClassesCounts);
            if(mapOfSchooldIdWithNoOfClassesCounts.values().size() > 0) 
            {
                for(School__c sc : schools) 
                {
                    if(mapOfSchooldIdWithNoOfClassesCounts.get(sc.Id) != null) 
                    {
                    	sc.Number_of_classes__c = mapOfSchooldIdWithNoOfClassesCounts.get(sc.Id);    
                    }
                }
            }
        }
    }    
    
    //In this case when School Field Number of Students change it will Recalculate number of Students update correct information 
    //with Parant to child Query
    public static void updateNoOfStudentDetailsInBeforeCase(List<School__c> schools, Map<Id, School__c> mapOfOldSchools) 
    {
    Set<Id> schoolsId = new Set<Id>();
        for(School__c sch : schools )
        {
            schoolsId.add(sch.id);
        }
    
    	if(schoolsId.size()>0  )
        {
            Map<Id,Integer> mapOfSchooldIdWithNoOfStudentCounts = new Map<Id,Integer>();
            for(School__c sch : [SELECT Id ,(Select ID FROM Students__r)
                                 FROM School__c
                                WHERE Id In :schoolsId ])
            {
				mapOfSchooldIdWithNoOfStudentCounts.put(sch.Id,sch.Students__r.size());                
            }
            
            if(mapOfSchooldIdWithNoOfStudentCounts.values().size()>0)
            {
                for(School__c sc : schools)
                {
                    if(mapOfSchooldIdWithNoOfStudentCounts.get(sc.Id) != Null)
                    {
                       sc.Number_of_Students__c= mapOfSchooldIdWithNoOfStudentCounts.get(sc.Id);
                    }
                }
            }
        }
    }

	//In this case when School Field Number of Students change it will Recalculate number of Students update correct information 
    //with Aggregrate Query
	public static void updateNoOfStudentDetailsInBeforeCaseWithAggregrateQuery(List<School__c> schools, Map<Id, School__c> mapOfOldSchools) 
    {
    Set<Id> schoolsId = new Set<Id>();
        for(School__c sch : schools)
        {
            schoolsId.add(sch.id);
        }
    
    	if(schoolsId.size()>0)
        {
            Map<Id,Integer> mapOfSchooldIdWithNoOfStudentCounts = new Map<Id,Integer>();
            for(AggregateResult aggr : [SELECT School_Lookup__c, count(id)StudentCount FROM Student__c 
                                                          where School_Lookup__c=: schoolsId
                                                          group by School_Lookup__c])
            {
                Id schoolId=(id)aggr.get('School_Lookup__c');
                integer numberOfStudents =(Integer)aggr.get('StudentCount');
				mapOfSchooldIdWithNoOfStudentCounts.put(schoolId,numberOfStudents);                
            }
            
            if(mapOfSchooldIdWithNoOfStudentCounts.values().size()>0)
            {
                for(School__c sc : schools)
                {
                    if(mapOfSchooldIdWithNoOfStudentCounts.get(sc.Id) != Null)
                    {
                       sc.Number_of_Students__c= mapOfSchooldIdWithNoOfStudentCounts.get(sc.Id);
                    }
            	}
        	}
        }
    }
	    
    /*
    public static void updateNoOfStudentsDetails(List<School__c> schools, Map<Id, School__c> mapOfOldSchools) 
    {
        Set<Id> setOfEligibleSchools = new Set<Id>();
        for(School__c sc : schools)
        {
            //Only execute in the case of update
            //Only execute the following logic if someone changes the value of "No of Students" field value
            if(mapOfOldSchools != null && sc.Number_of_Students__c != mapOfOldSchools.get(sc.Id).Number_of_Students__c)
            {
                setOfEligibleSchools.add(sc.Id);    
            }
        }     
        //Only execute the following logic if we will have the eligible school record(s)
        if(setOfEligibleSchools.size() > 0)
        {
            //An additional query because trigger.new is a read only collection in case of after event
            Map<Id, School__c> mapOfSchools = new Map<Id, School__c>();
            for(School__c sch : [SELECT ID, Number_of_Students__c 
                                 FROM School__c
                                 WHERE ID IN : setOfEligibleSchools
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
    
    public static void updateNoOfClassesDetails(List<School__c> schools, Map<Id, School__c> mapOfOldSchools) 
    {
        Set<Id> setOfEligibleSchools = new Set<Id>();
        for(School__c sc : schools)
        {
            //Only execute in the case of update
            //Only execute the following logic if someone changes the value of "No of Classes" field value
            if(mapOfOldSchools != null && sc.Number_of_classes__c  != mapOfOldSchools.get(sc.Id).Number_of_classes__c )
            {
                setOfEligibleSchools.add(sc.Id);    
            }
        }     
        //Only execute the following logic if we will have the eligible school record(s)
        if(setOfEligibleSchools.size() > 0)
        {
            //An additional query because trigger.new is a read only collection in case of after event
            List<School__c> listOfSchoolsToBeUpdated = [SELECT ID, Number_of_classes__c,
                                                        (SELECT ID FROM Classes__r) 
                                                        FROM School__c
                                                        WHERE ID IN : setOfEligibleSchools
                                                       ];
            if(listOfSchoolsToBeUpdated.size() > 0) 
            {
                for(School__c sch : listOfSchoolsToBeUpdated) 
                {
                    sch.Number_of_classes__c = sch.Classes__r.size();
                }
                Utilities.BypassAllTriggers = true;
                update listOfSchoolsToBeUpdated;
                Utilities.BypassAllTriggers = false;
            }
        }
    }
*/
}