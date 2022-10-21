public class updateSchoolAccordingClass {
    public static void doCheckSchoolRelatedToclass(Map<id,Student__c> mapofs){
        List<Class__c> clsList = [Select ID , Name ,School_Master_field__c,School_Master_field__r.Name From CLass__c where id in : mapofs.keyset()];
        if(clsList.size()>0){
            for(Class__c cls : clsList){
                for(Student__c stu : mapofs.values())
                {
                    if(stu.Class_Lookup__c==cls.Id){
                    	stu.School_Lookup__c=cls.School_Master_field__c;    
                    }
                    
                }
            }
        }
    }

}