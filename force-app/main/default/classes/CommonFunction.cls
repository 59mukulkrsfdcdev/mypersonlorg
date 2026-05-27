public class CommonFunction
{
	public void Addition(integer x, integer y)
    {
        system.debug('Addition result is ..........'+(x+y));
	}
    public void Subtraction(integer x, integer y)
    {
        system.debug('Subtraction result is...'+ (x-y));
        
    }
    public void Multiply(integer x, integer y)
    {
        system.debug('Multiplication result is ..'+ (x*y));
	}
    public void Division(integer x, integer y)
    {
        if(y>0)
        {
            system.debug('Division result is....'+ (x/y));
        }
        else
        {
            system.debug('Division Operation cannot be performed');
        }
    }
    public void Concatenate(String s1, String s2)
    {
        System.debug('Concatation result is....'+ (s1+s2));
    }
    public void CheckEquals(String s1, String s2)
    {
        if(s1== s2)
        {
            system.debug('Both String are equals');
        }
        else
        {
            System.debug('String are not equal');
        }
	}
    public void CheckEqualsWithCase(String s1, String s2)
    {
        if(s1.equals(s2))
        {
            System.debug('String are equals --- Binary comparison');
        }
        else
        {
            system.debug('String are not equals....Binary Comparision');
        }
    }
    public void GetStringLength(String s)
    {
     System.debug('String length is ..'+ s.length());   
    }
}