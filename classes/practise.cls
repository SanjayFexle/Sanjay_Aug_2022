public class practise {
    public static void method(){
        String FullName = 'First Name = Dhruv, Last Name = Chouhan, Email = dhruv@test.com';
        String Fname = FullName.substringBetween('First Name =', ',');
        String Lname = FullName.substringBetween('Last Name =', ',');
        String Email = FullName.substringAfter('Email =');
        
        System.debug(Fname);
        System.debug(Lname);
		System.debug(Email);

    }

}