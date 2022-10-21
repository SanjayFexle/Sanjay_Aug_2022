public class Assignment {
    public void method(){
        //system.debug('hello');
        
        Map<ID,Map<ID,list<Opportunity>>> oppMap = new Map<ID,Map<ID,list<Opportunity>>>();
        
        List<Opportunity> opplist = [SELECT  ID , Name ,Amount,AccountId, Account.Name FROM Opportunity];
        
        for(Opportunity opp : opplist){
            if(oppMap.containsKey(opp.AccountId)){
                if(oppMap.get(opp.AccountId).containsKey(opp.id)){
                         oppMap.get(opp.AccountId).get(opp.id).add(opp);
                 	   
                }else{
                    list<Opportunity> oppOld1 = new list<Opportunity>{opp};
                    oppMap.get(opp.AccountId).put(opp.Id,oppOld1);
                }
            }else{
                Map<ID,list<Opportunity>> oppOld = new Map<ID,list<Opportunity>>();
                if(oppOld.IsEmpty()){
                    oppOld.put(opp.id, new list<Opportunity>());
                }
                oppOld.get(opp.id).add(opp);
                oppMap.put(opp.AccountId, oppOld);
            }
        }
        System.debug(oppMap);

        List<Account> acc = [SELECT  ID,Name FROM Account Where Name ='Edge Communications'];
        for(Account accSearch : acc){
            System.debug(accSearch.Name);
           System.debug(oppMap.get(accSearch.Id));
        }
 
    }

}