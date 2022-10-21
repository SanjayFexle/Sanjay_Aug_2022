public class playingWithSharingConcept {  
    public List<School__c> schools{get;set;}  
      
    // default constructor  
    public playingWithSharingConcept (){  
        schools = new List<School__c>();  
   }  
      
    // create getAccounts() method to get account records   
    public void getAccounts() {  
        schools = [select Id, Name From School__c WHERE OwnerId= :UserInfo.getUserID()];  
    }  
   
}