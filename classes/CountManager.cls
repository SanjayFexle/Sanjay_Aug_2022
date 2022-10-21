/**
		CreatedBy : Sanjay Rawat
		CreatedDate : Sep/05/2022
		Description : Apex class for count of Number of students and classes & update in School objects Fields.
		Version : CountsManager_V001(Child to Parent)
		Version : CountsManager_V002(Parent to child with Direct Approach)
		Version : CountsManager_V003(Parent to child via DML operation)
		Version : CountsManager_V004(Parent to child with Map collection)
		Version : CountsManager_V005(Aggregrate query)
		
**/

public class CountManager {
    public static void updateNumberOfStudentsDetails(String schoolName){
        
        
        List<Student__c> studentsList=[SELECT Id, Name, School_Lookup__c,School_Lookup__r.Name 
                                       FROM Student__c WHERE School_Lookup__r.Name =: schoolName];
        
        Integer Studentscount = studentsList.size();
        //System.debug(Studentscount);
        
        List<School__c> schoolListForStudents=[Select Id,Name FROM School__c WHERE Name=:schoolName];
        if(studentsList.isEmpty()){
            System.debug('Unable to find out a school for given name'); 
        }
        else{
            
            List<School__c> storeDataofStudent= new List<School__c>();
            for( School__c sch: schoolListForStudents){
 				School__c sobj = new School__c(id=sch.Id,Number_of_Students__c=Studentscount);
                System.debug(schoolName +' number of Students are ' + Studentscount);
                storeDataofStudent.add(sobj);
             }
            update storeDataofStudent;
        }        
    }
    
	public static void updateNumberOfClassDetails(Id SchoolId){
        
        List<Class__c> classList=[SELECT Id, Name, School_Master_field__c, School_Master_field__r.Name FROM Class__c 
                                    WHERE  School_Master_field__r.ID=: SchoolId];
        
        Integer classCount = classList.size();
        //System.debug(classCount);
        List<School__c> schoolListForClasses=[Select Id,Name FROM School__c WHERE Id=:SchoolId];
        
        if(classList.isEmpty()){
            System.debug('Unable to find out a school for given name'); 
        }
        else{
            
            List<School__c> storeDataofClass= new List<School__c>();
            for( School__c sch: schoolListForClasses){
 				School__c sobj = new School__c(id=sch.Id,Number_of_classes__c =classCount);
                System.debug(sch.Name +' number of class are ' + classCount);
                storeDataofClass.add(sobj);
                
             }
            update storeDataofClass;
        }        
    }
    
    // Parent to child with Direct Approach
    public static void updateNumberOfStudentsDetailsV2(String schoolName){
        List<School__c> schoolWithStudentsList = [SELECT ID, Name ,(Select Name from Students__r) FROM School__c 
                                                  WHERE Name =: schoolName];
        
        if(schoolWithStudentsList.isEmpty()){
            System.debug('Unable to find out a school for given name');
        }else{
             for(School__c s :schoolWithStudentsList ){
                 
                    s.Number_of_Students__c = s.Students__r.size();    
                }
        		Update schoolWithStudentsList;
        }
    }
    
    // Parent to child via DML operation
    public static void updateNumberOfClassDetailsV3(Id schoolId){
        List<School__c> schoolWithClassList = [SELECT ID, Name ,Number_of_classes__c,(Select Name from classes__r) FROM School__c  
                                               WHERE Id =: schoolId];
        if(!schoolWithClassList.isEmpty()){
            List<School__c> schoolNoOfCLass= new List<School__c>();
            for(School__c schWithclasses: schoolWithClassList){
                School__c schObj = new School__c();
                schobj.id= schWithclasses.Id;
                schobj.Number_of_classes__c=schWithclasses.classes__r.size();
                schoolNoOfCLass.add(schObj);
                //System.debug(schWithclasses.classes__r.size());
            }
            if(schoolNoOfCLass.size()>0){
            	Update schoolNoOfCLass;    
            }
            
        }
        else if( schoolWithClassList.size()==0){
            System.debug('Unable to find out a school for given Id');
        }
    }
    
    // Parent to child with Map collection
    public static void updateNumberOfStudentsDetailsv4(String schoolName){
        Map<Id,Integer> mainMap = new Map<Id,Integer>();
        
        List<School__c> schoolDetailsWithStudents = [Select ID,Name,(Select Name From Students__r) From School__c  Where Name =: schoolName ]; 
        
        //System.debug(schoolDetailsWithStudents.size());
        if(!schoolDetailsWithStudents.isEmpty()){
            for(School__c sch : schoolDetailsWithStudents){
                //System.debug(sch.Students__r.size());
                mainMap.put(sch.Id,sch.Students__r.size());
                
            }//inner for end 
            if(mainMap.size()>0){
                //System.debug(mainMap);
                List<School__c> finalUpdate = new List<School__c>();
                for(Id schIds : mainMap.keyset()){
                	School__c sobj = new School__c ();
                    sobj.Id=schIds;
					sobj.Number_of_Students__c= mainmap.get(schIds);
                    finalUpdate.add(sobj);
                }
                if(finalUpdate.size()>0){
                    update finalUpdate;
                }
                    
            }// inner if
            
        }//outer if
        else{
            System.debug('Unable to find out a school for given Name');
        }
        
    }//method end
	
    // Aggregrate query 
    public static void StudentDetailsUpdateWithAggregrateQueryV5(Id schoolId){
        List<School__c> check = [Select Id from School__c Where Id =:schoolId];
        
        if(check.isEmpty()){
            System.debug('Unable to find out a school for given name');
        }else{
            System.debug('School is here');
            List<AggregateResult> studentWithSchoolDetails = [SELECT School_Lookup__c, count(id)StudentCount FROM Student__c 
                                                          where School_Lookup__c=: schoolId
                                                          group by School_Lookup__c];
            
        	List<School__c> schoolRecordUpdate = new List<School__c>();
            
            if(studentWithSchoolDetails.isEmpty()){
                School__c emptysObj= new School__c(Id=schoolId,Number_of_Students__c=0);            
            	schoolRecordUpdate.add(emptysObj);
            }else if(studentWithSchoolDetails.size()>0){
                for(AggregateResult aggr : studentWithSchoolDetails){
                    
                    System.debug('Number of Student in School '+(Integer)aggr.get('StudentCount'));
                    
                    School__c Sobj= new School__c(Id=(id)aggr.get('School_Lookup__c'),Number_of_Students__c=(Integer)aggr.get('StudentCount'));            
                    schoolRecordUpdate.add(Sobj);
                }
            }
            if(schoolRecordUpdate.size()>0){
            Update  schoolRecordUpdate;
            }
        }    
    }
}