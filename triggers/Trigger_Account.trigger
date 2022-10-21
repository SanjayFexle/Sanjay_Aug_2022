trigger Trigger_Account on Account (before insert,before Update, After Insert , After Update) 
{
    
    if(trigger.isAfter ){
        
        if(trigger.isInsert)
            {   
                AccountTriggerHelper.createNewContactIfContactFieldPopulate(Trigger.New,Trigger.oldMap);
            }
        if(trigger.isUpdate)
            {   
                AccountTriggerHelper.contactNewCreateOrDeleteByReferenceOnAccountField(Trigger.New,Trigger.oldMap);
            }
        
            
    }
        
}