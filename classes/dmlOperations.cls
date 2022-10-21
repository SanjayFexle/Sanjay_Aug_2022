public class dmlOperations {
    public void dml(Integer n){
        List<Student__c> studentList = new List<Student__c>(); 
        for(Integer i=1;i<=n;i++ ){
    		Student__c koiNaam = new Student__c();
            koiNaam.Name= 'Fexle 00'+i;
			koiNaam.Father_Name__c='f'+i;
            
			studentList.add(koiNaam);            
        }
        System.debug(studentList);
        System.debug(studentList.size());
        Insert studentList;
        
    }
    
    public void dele(){
        Student__c s = [Select Name From Student__c WHere Name Like 'Fexle%'];
		Delete s;
	
    }
}