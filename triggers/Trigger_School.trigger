/**
*
*  Purpose          :	Trigger on School object.
*
*  Created Date     :  	Oct/12/2022
*
*  Created By       :  	Sanjay Rawat
*
*  Revision Logs    :  	V_1.0 - Created
*
**/
trigger Trigger_School on School__c (before update) 
{
    try 
    {
        if(Utilities.BypassAllTriggers) 
          return;
        
        if(Trigger.isBefore) 
        {
            if(Trigger.isUpdate)
            {
                SchoolTriggerHelper.updateNoOfClassesDetailsInBeforeCase(Trigger.new, Trigger.oldMap);
                //SchoolTriggerHelper.updateNoOfStudentDetailsInBeforeCase(Trigger.new, Trigger.oldMap);
                SchoolTriggerHelper.updateNoOfStudentDetailsInBeforeCaseWithAggregrateQuery(Trigger.new, Trigger.oldMap);
           }
        }
        if(Trigger.isAfter) 
        {
            if(Trigger.isUpdate)
            {
                //SchoolTriggerHelper.updateNoOfStudentsDetails(trigger.new, trigger.oldMap);
                //SchoolTriggerHelper.updateNoOfClassesDetails(trigger.new, trigger.oldMap);
            }
        }
    }
    catch(Exception e)
    {
        integer i=0;
        if(Trigger.isDelete)
            Trigger.Old[i].addError(e.getMessage());
        else
            Trigger.New[i].addError(e.getMessage());
    } 
}