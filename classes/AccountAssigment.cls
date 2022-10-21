public class AccountAssigment {
    
    public static void contactDetails(Account AccountInformation){
        List<Contact> conList = new List<Contact>();
        
        List<Account> Acc = [SELECT Id ,Name,Contact_Details__c FROM Account WHERE Id=:AccountInformation.ID];
        for(Account accountWithContactDeatils : Acc){
        	
		    String contactNames = accountWithContactDeatils.Contact_Details__c;    
            if(contactNames!=Null){
                List<String> contactSplit = contactNames.split('\n');
                for( String str : contactSplit){
                    contact con = new contact();
                    con.FirstName= str.substringBetween('First Name =', ',');    
                    con.LastName= str.substringBetween('Last Name =', ',');    
                    con.Email=str.substringAfter('Email =');
                    conList.add(con);
                    }
            }
        }    
		if(!conList.isEmpty()){
            Insert conList;    
        }
    }
}