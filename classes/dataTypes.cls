public class dataTypes {
    
    public static void method(){
		Integer n = 5;
        System.debug(n);

		Long l=12312312;
        System.debug(l);
        
        decimal d1=4.4;
        System.debug(d1);

        Double d2=3.1333;
        System.debug(d2);        
 
        Boolean b=True;
        System.debug(b);
        
        Date da = Date.today();
        System.debug(da);
        
        Datetime da2 = Datetime.now();
        System.debug(da2);
        
        String s = 'Hello My Name is Sanjay';
        System.debug(s);
        
        Id accID = [Select ID from Account Limit 1].id;
        System.debug(accId);
		
		integer n1=100;
		integer n2=2;        
        
        integer result = n1/n2;
        System.debug(result);
        
        List<String> cityList= new List<String> ();
        List<String> myname= new List<String> {'sikar','solapur','jaipur','jodhpur'};
        Map<String,List<String>> StateList = new Map<String,List<String>>();
            StateList.put('Raj',myname);
			System.debug(StateList);            
        for(String sss : StateList.keyset()){
            if(sss.startsWith('R')){
                
                
            }
        }  
        String s1 = 'Sanjay';
		//List<String> name = s1.length();
		//for(integer check1 = 0 ; check1<name.size();check1++ ){
    	System.debug(s1.length());

    }
}