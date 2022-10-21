/**
*
*  Purpose          :	Trigger on Student object.
*
*  Created Date     :  	Oct/12/2022
*
*  Created By       :  	Sanjay Rawat
*
*  Revision Logs    :  	V_1.0 - Created
*
**/
trigger Trigger_Student on Student__c (before Insert,before update,after insert ,after update, after delete) 
{
    try
    {
        if(Utilities.BypassAllTriggers) 
           return;
        
        if(Trigger.isAfter) 
        {	

            if(Trigger.isInsert || Trigger.isDelete)
            {
            	//StudentTriggerHelper.updateNoOfStudentsDetails(Trigger.New, Trigger.oldMap);
            }
        }
        if(Trigger.IsBefore){
            
            if(Trigger.IsInsert)
            {
                //this trigger will work for when student Record insert with class deatils update the School field in student Record
                StudentTriggerHelper.newStudentInsertSchoolWillUpdateIfClassMention(Trigger.New);
            }
            if(Trigger.Isupdate)
            {
                StudentTriggerHelper.studentUpdateSchoolFieldAsPerClass(Trigger.new, Trigger.oldMap);
            }
            
            if(Trigger.IsInsert || Trigger.Isupdate)
            {
                //StudentTriggerHelper.duplicateStudentRecordCheckByStudentNameAndFatherName(Trigger.New,Trigger.oldMap);
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