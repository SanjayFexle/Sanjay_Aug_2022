public class Apex2 {
    public static String Exam(Integer e ,Integer h ,Integer m){
        String s;
        Integer average= (e+h+m)/3;
        
        if(average<36)
            s='Fail';
        else if(average>=36 && average <60)
        	s='3 Division';
        else if(average>=60 && average <75)
            s='2 Division';
        else if(average>=75 && average <90)
            s='1 Division';
        else if(average>=90)
            s='Merit';
        
        return s;
    }

}