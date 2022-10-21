/**
*
*  Purpose          :	Class for Trigger on Account object.
*
*  Created Date     :  	10/10/2022
*
*  Created By       :  	Sanjay Rawat
*
*  Revision Logs    :  	V_1.0 - Created
*
**/
public without sharing class AccountTriggerHelper {
    
    //Insert Case
    public static void createNewContactIfContactFieldPopulate(List<Account> accountsList, Map<Id, Account> mapOfOldAccounts)
    {	
        List<Account> newAccounts = new List<Account>();
        if(accountsList!=Null){
            for(Account acc : accountsList){
                newAccounts.add(acc);
            }
        }
        
        List<Contact> conList = new List<Contact>();
        if(newAccounts.size()>0)
        {
            for(Account accountWithContactDeatils : accountsList)
            {
                String contactNames = accountWithContactDeatils.Contact_Details__c;    
                if(accountsList!=null)
                {
                    List<String> contactSplit = contactNames.split('\n');
                    System.debug(contactSplit);
                    for(String str : contactSplit)
                    {
                        contact con = new contact();
                        con.FirstName= str.substringBetween('First Name =', ',');    
                        con.LastName= str.substringBetween('Last Name =', ',');    
                        con.Email=str.substringAfter('Email =');
                        conList.add(con);
                     }
                }
            }
        }
       	    
		if(!conList.isEmpty()){
            
            Insert conList;    
        }
    }
    
    //Update Case
    public static void contactNewCreateOrDeleteByReferenceOnAccountField(List<Account> accountsList, Map<Id, Account> mapOfOldAccounts)
    {	//old account version with field details
        Map<id,Account> mapOfAccounts = new Map<id,Account>(); 
        if(accountsList!=Null && mapOfOldAccounts!=Null)
        {
            for(Account acc : mapOfOldAccounts.values())
            {
                mapOfAccounts.put(acc.id,acc);
            }
        }
        
        Map<id,contact> mapOfConatacts = new Map<id,contact>(); 
        List<contact> newContactList = new List<contact>(); 
        if(mapOfAccounts.size()>0)
        {
            for(Account accountWithContactDeatils : mapOfAccounts.values())
            {
                String contactNames = accountWithContactDeatils.Contact_Details__c;    
                if(accountWithContactDeatils.Contact_Details__c!=null)
                {
                    List<String> contactSplit = contactNames.split('\n');
                    System.debug(contactSplit);
                    for(String str : contactSplit)
                    {
                        contact con = new contact();
                        con.FirstName= str.substringBetween('First Name =', ',');    
                        con.LastName= str.substringBetween('Last Name =', ',');    
                        con.Email=str.substringAfter('Email =');
                        newContactList.add(con);
                        mapOfConatacts.put(con.id, con);
                     }
                }
            }
        }
        System.debug(newContactList);
        List<contact> newContactListInsert = new List<contact>(); 
        if(newContactList.size()>0){
            for(contact conta : newContactList){
                
            }
            
        }
        System.debug(newContactListInsert);
        
        
    }
}