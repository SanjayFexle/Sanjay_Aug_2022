/*
 * CreatedBy : Sanjay Rawat
 * CreatedDate : Sep/07/2022
 * Description : Apex class for showing dynamic way to populate in collection
 * Version : dynamicWayToDealWithCollecctionsV2

*/
public class dynamicWayToDealWithCollecctionsDemo {
    public static Map<String,Map<String,List<Student__c>>> method1(){
        
        Map<String,Map<String,List<Student__c>>> mainMap = new Map<String,Map<String,List<Student__c>>>(); 
        
        List<Student__c> sList = [SELECT Id, Name, Class_Lookup__c,Class_Lookup__r.Name ,
                                  School_Lookup__c,School_Lookup__r.Name 
                                  FROM Student__c];
        for(Student__c s : sList){
            if(mainMap.containsKey(s.School_Lookup__r.Name)){//school Name check
                if(mainMap.get(s.School_Lookup__r.Name).containsKey(s.Class_Lookup__r.Name)){ //If school Name Find ,class name check
                    mainMap.get(s.School_Lookup__r.Name).get(s.Class_Lookup__r.Name).add(s); //if SchoolName & class Name Find than listOfstudents update
                }//2 if end
                else{
                    mainMap.get(s.School_Lookup__r.Name).put(s.Class_Lookup__r.Name,new List<Student__c>{s});
                }
            }//1 if end
            else{
                Map<String, List<Student__c>> classMap = new Map<String, List<Student__c>>();
                if(classMap.get(s.Class_Lookup__r.Name)==Null){
                    classMap.put(s.Class_Lookup__r.Name,new List <Student__c> ());
                }
                classMap.get(s.Class_Lookup__r.Name).add(s);
                mainMap.put(s.School_Lookup__r.Name,classMap);
            }
        }//for loop ending
        
       
        
    return mainMap;    
    }
}