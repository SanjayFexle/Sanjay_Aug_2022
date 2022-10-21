/**
*
*  Purpose          :	Batch Class for when student attendance is less than 75 Email Status Field update and Sent respective mail.
*
*  Created Date     :  	Oct/19/2022
*
*  Created By       :  	Sanjay Rawat
*
*  Revision Logs    :  	V_1.0 - Created
*
**/

public class Batch_studentAttendanceLess75 implements Database.Batchable<sObject>
{
   public Database.QueryLocator start(Database.BatchableContext bc) 
   {
        return Database.getQueryLocator(
            [SELECT ID,Name,Email_Status__c,Student_Attendance__c FROM Student__c 
            WHERE Student_Attendance__c<75 and Email_Status__c!=True]);
   }
    public void execute(Database.BatchableContext bc, List<Student__c> students)
    {
        List<Student__c> studentsList = new List<Student__c>();
        for (Student__c stu : students) 
        {
            stu.Email_Status__c=True;
            studentsList.add(stu);
        }
        update studentsList;
    }
    public void finish(Database.BatchableContext bc)
    {
       List<String> namesList = new List<String>();
        for(Student__c stu : [SELECT ID,Name,Email_Status__c,Student_Attendance__c FROM Student__c 
                              WHERE Student_Attendance__c<75 and Email_Status__c!=True ])
        {
           namesList.add(stu.Name);
            //System.debug(stu.Name);
        }
        //System.debug(namesList);
           Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
           String[] toAddresses = new String[] {'sanjay.rawat@fexle.com'};
           mail.setToAddresses(toAddresses);
           mail.setSubject('Student Attendance Notification');
           mail.setPlainTextBody
           ('Attendance is Less than 75% Records name is '+ namesList );
           Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
	}
}